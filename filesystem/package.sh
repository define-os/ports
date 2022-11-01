#!/usr/bin/sh ../.package-env.sh
port='filesystem'
version='1.0'
deps=""
source_code="https://github.com/define-os/ports/raw/main/empty.tgz"
source_cd="."
use_crosscompiler=true
build() {
    :
}

install() {
    for dir in dev proc sys tmp run lib etc usr usr/ports; do
        mkdir $INSTALL_PATH/$dir
    done
    for dir in {s,}bin lib; do
         ln -s ../$dir  $INSTALL_PATH/usr/$dir
    done
}
