#!/usr/bin/env -S sh ../.package-env.sh
port='musl'
version='1.2.3'
deps=()
source_code="https://musl.libc.org/releases/$port-$version.tar.gz"
source_cd="$port-$version"
source_name="$port"
use_crosscompiler=true
build() {
    ./configure --prefix=$INSTALL_PATH
    make -j$(nproc)
}

install() {
    make install
}
