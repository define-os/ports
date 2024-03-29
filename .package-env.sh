#!/usr/bin/sh
#packagesdb="/usr/ports/packages.db"
PORTDIR=$PWD/$(dirname $@)
PREFIX="/usr"
[ "x$INSTALL_PATH" == "x" ] && INSTALL_PATH="/"
packagesdb="$INSTALL_PATH/usr/ports/packages.db"

cross_compiler_url="http://musl.cc/x86_64-linux-musl-cross.tgz"
cross_compiler_base="$PORTDIR/../x86_64-linux-musl-cross/bin/x86_64-linux-musl-"

deps=""
source_cd="."
use_crosscompiler=false

. $@

#HELPERS
init_db(){
    [ -d "$INSTALL_PATH/usr/ports" ] || mkdir $INSTALL_PATH/usr/ports -p
    touch $packagesdb
}

recreate_dir() {
    [ -d $1 ] && rm -rf $1
    mkdir $1
}

get_package_in_db() {
    local port=$1
    local version=${2:-}
    grep "$1 $2" $packagesdb -m1 | cut -f2 -d' '
}
crosscompiler_install() {
    log "installing cross compiler, Please wait..."
    [ -f "$PORTDIR/../crosscompiler.tar.xz" ] || wget $cross_compiler_url -O "$PORTDIR/../crosscompiler.tar.xz"
    [ -d "$PORTDIR/../x86_64-linux-musl-cross" ] || tar xf "$PORTDIR/../crosscompiler.tar.xz" -C "$PORTDIR/.."
    export HOSTCC="${cross_compiler_base}gcc"
    export CC="${cross_compiler_base}gcc"
    export HOSTCXX="${cross_compiler_base}g++"
    export CXX="${cross_compiler_base}g++"
    export HOSTAS="${cross_compiler_base}as"
    export AS="${cross_compiler_base}as"
    export HOSTAR="${cross_compiler_base}ar"
    export AR="${cross_compiler_base}ar"
    export HOSTLD="${cross_compiler_base}ld"
    export LD="${cross_compiler_base}ld"
    export HOSTRANLIB="${cross_compiler_base}ranlib"
    export RANLIB="${cross_compiler_base}ranlib"
    export CROSS_COMPILE="${cross_compiler_base}"
    export LD_LIBRARY_PATH="$PORTDIR/../x86_64-linux-musl-cross/x86_64-linux-musl/lib"
}

err() {
    echo "[ERROR] $2"
    exit $1
}
log() {
    echo "[LOG] $1"
}

#ERRORS
installed_error() {
    log "Package '$port': installed"
    exit 0
}
build_error() {
    err 2 "Package '$port': build"
}
install_error() {
    err 3 "Package '$port': install"
}
source_download_error() {
    err 4 "Package '$port': source code download"
}
dep_build_error() {
    err 5 "Package '$port': can't build dep $1"
}
#CODE
install_deps() {
    for dep in $deps; do
        [  "x$dep" == "x" ] && return
        if [ -z "$(get_package_in_db ${dep})" ]; then
            cd "${PORTDIR}/../$dep" 2>/dev/null || dep_build_error $dep
            ./package.sh || dep_build_error $dep
        fi
    done
    cd $PORTDIR
}
prepare_dirs() {
    recreate_dir "build"
}
download_source() {
    log "unpacking source code, Please wait..."
    [ -f "$port-$version.tar.xz" ] || wget $source_code -O $PORTDIR/$port-$version.tar.xz
    tar xf $PORTDIR/$port-$version.tar.xz -C "$PORTDIR/build"
}

init_db
[ -n "$(get_package_in_db $port)" ] && installed_error
log "Preparing to build $port"
install_deps
prepare_dirs
$use_crosscompiler && crosscompiler_install
download_source || source_download_error
cd "$PORTDIR/build/${source_cd}"
log "Building $port"
build || build_error
log "Installing $port"
install || install_error
cd $PORTDIR
echo "$port $version" >> $packagesdb
log "Finish!"
