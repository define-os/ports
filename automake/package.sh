#!/usr/bin/sh ../.package-env.sh
port='automake'
version='1.16.5'
deps="make"
source_code="https://ftp.gnu.org/gnu/$port/$port-$version.tar.xz"
source_cd="$port-${version}"
use_crosscompiler=true
build() {
    ./configure --prefix=$PREFIX --disable-static
    make -j$(nproc)
}

install() {
    make DESTDIR=$INSTALL_PATH install
}
