#!/usr/bin/sh ../.package-env.sh
port='libressl'
version='3.6.1'
deps="make autoconf automake libtool"
source_code="https://github.com/$port-portable/portable/archive/refs/tags/v$version.tar.gz"
source_cd="portable-$version"
source_name="$port"
use_crosscompiler=true
build() {
    ./autogen.sh
    ./configure --prefix=$PREFIX
    make -j$(nproc)
}

install() {
    make DESTDIR=$INSTALL_PATH install
}
