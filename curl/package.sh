#!/usr/bin/sh ../.package-env.sh
port='curl'
version='7_86_0'
deps="make autoconf libressl"
source_code="https://github.com/$port/$port/archive/refs/tags/$port-$version.tar.xz"
source_cd="$port-$port-${version}"
use_crosscompiler=true
build() {
    ./buildconf
    ./configure --prefix=$PREFIX --disable-static --with-openssl
    make -j$(nproc)
}

install() {
    make DESTDIR=$INSTALL_PATH install
}
