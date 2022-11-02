#!/usr/bin/sh ../.package-env.sh
port='linux'
version='5.15.67'
deps="make"
source_code="https://cdn.kernel.org/pub/$port/kernel/v5.x/$port-$version.tar.xz"
source_cd="$port-$version"
use_crosscompiler=true
build() {
    cp $PORTDIR/linux.config .config
    make -j$(nproc)
}

install() {
    make DESTDIR=$INSTALL_PATH install
}
