#!/usr/bin/env -S sh ../.package-env.sh
_port='busybox'
port="${_port}-static"
version='1.35.0'
deps=()
source_code="https://busybox.net/downloads/$_port-$version.tar.bz2"
source_cd="$_port-$version"
use_crosscompiler=true
build() {
    cp $PORTDIR/busybox.config .config
    make -j$(nproc)
}

install() {
    make CONFIG_PREFIX=$INSTALL_PATH install
}
