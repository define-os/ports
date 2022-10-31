#!/usr/bin/env -S bash ../.package-env.sh
port='gcc'
version='11.2.0'
deps=()
source_code="https://ftp.gnu.org/gnu/$port/$port-$version/$port-$version.tar.xz"
source_cd="$port-$version"
use_crosscompiler=true
build() {
    echo $CC
    echo $PWD
}

install() {
    :
}