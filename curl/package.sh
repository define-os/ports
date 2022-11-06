#!/usr/bin/sh ../.package-env.sh
port='curl'
version='7_86_0'
deps="make autoconf libressl"
source_code="https://github.com/$port/$port/archive/refs/tags/$port-$version.tar.gz"
source_cd="$port-$port-${version}"
use_crosscompiler=true
build() {
    ./buildconf
    ARGS=""
    [ -f "/usr/lib/libssl.so" ] && ARGS="--with-openssl"
    ./configure --prefix=$PREFIX --disable-static --with-sysroot=$INSTALL_PATH $ARGS
    make -j$(nproc)
}

install() {
    make DESTDIR=$INSTALL_PATH install
}
