#!/usr/bin/sh ../.package-env.sh
_port='busybox'
port="${_port}"
version='1.35.0'
deps=""
source_code="https://busybox.net/downloads/$_port-$version.tar.bz2"
source_cd="$_port-$version"
use_crosscompiler=true
build() {
    cp $PORTDIR/busybox.config .config
    make CONFIG_CROSS_COMPILER_PREFIX=$CROSS_COMPILER -j$(nproc)
}

install() {
    make CONFIG_PREFIX=$INSTALL_PATH install
}
