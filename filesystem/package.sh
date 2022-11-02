#!/usr/bin/sh ../.package-env.sh
port='filesystem'
version='1.0'
deps=""
source_code="https://github.com/define-os/ports/raw/main/empty.tgz"
source_cd="."
use_crosscompiler=false
build() {
    :
}

install() {
    for dir in dev proc sys tmp run lib usr/{{s,}bin,lib} mnt boot; do
        mkdir $INSTALL_PATH/$dir -p
    done
    for dir in {s,}bin lib; do
         ln -s ../usr/$dir  $INSTALL_PATH/$dir
    done
}
