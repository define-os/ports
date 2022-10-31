#!/usr/bin/env bash

#packagesdb="/usr/ports/packages.db"
packagesdb="../packages.db"

PORTDIR=$PWD
INSTALL_PATH="/usr/local"

deps=()

. $@

#HELPERS
init_db(){
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

err() {
    echo "[ERROR] $2"
    exit $1
}
log() {
    echo "[LOG] $1"
}

#ERRORS
installed_error() {
    err 1 "Package '$port': installed"
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
#CODE
install_deps() {
    for dep in "${deps[@]}"; do
        if [ -z "$(get_package_in_db $dep)" ]; then
            cd "${PORTDIR}/../$dep"
            ./package.sh
        fi
    done
    cd $PORTDIR
}
prepare_dirs() {
    recreate_dir "build"
}
download_source() {
    wget $source_code -O $port-$version.tar.xz
    cd build
    tar xf ../$port-$version.tar.xz
}

init_db
[ -n "$(get_package_in_db $port)" ] && installed_error
log "Preparing to build $port"
install_deps
prepare_dirs
echo "$port $version" >> $packagesdb
download_source || source_download_error
log "Building $port"
build || build_error
log "Installing $port"
install || install_error
log "Finish!"