#!/usr/bin/sh ../.package-env.sh
port='libuv'
version='1.44.2'
deps="make libtool automake autoconf"
source_code="https://dist.$port.org/dist/v${version}/${port}-v${version}.tar.gz"
source_cd="$port-v${version}"
use_crosscompiler=true
build() {
    sh autogen.sh
    ./configure --prefix=$PREFIX --disable-static
    make -j$(nproc)
}

install() {
    make DESTDIR=$INSTALL_PATH install
}
