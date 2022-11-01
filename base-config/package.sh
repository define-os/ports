#!/usr/bin/sh ../.package-env.sh
port='base-config'
version='1.0'
deps=""
source_code="https://github.com/define-os/ports/raw/main/base-config/base-config.tgz"
source_cd="."
use_crosscompiler=false
build() {
    :
}

install() {
    cp * $INSTALL_PATH/ -r
}
