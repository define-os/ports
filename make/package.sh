#!/usr/bin/sh ../.package-env.sh
port='make'
version='4.4'
deps=""
source_code="https://ftp.gnu.org/gnu/$port/$port-$version.tar.gz"
source_cd="$port-$version"
source_name="$port"
use_crosscompiler=true
build() {
    args=""
    [ -f "/bin/make" ] || args="--disable-dependency-tracking"
    ./configure --prefix=$PREFIX --target=x86_64-pc-linux --host=x86_64-pc-linux $args
    [ -f "/bin/make" ] && make
    [ -f "/bin/make" ] || ./build.sh
}

install() {
    ./make DESTDIR=$INSTALL_PATH install
}
