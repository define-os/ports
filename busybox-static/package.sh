#!/usr/bin/sh ../.package-env.sh
_port='busybox'
port="${_port}-static"
version='1.35.0'
deps=""
source_code="https://busybox.net/downloads/$_port-$version.tar.bz2"
source_cd="$_port-$version"
use_crosscompiler=true
build() {
    cp $PORTDIR/busybox.config .config
    make CROSS_COMPILE=$CROSS_COMPILE -j$(nproc)
}

install() {
    make CONFIG_PREFIX=$INSTALL_PATH install
    mkdir $INSTALL_PATH/usr
    mkdir $INSTALL_PATH/usr/ports
    for dir in dev proc sys tmp run lib etc usr usr/ports; do
	mkdir $INSTALL_PATH/$dir
    done
    for dir in {s,}bin lib; do
	 ln -s ../$dir  $INSTALL_PATH/usr/$dir
    done
}
