#!/usr/bin/sh ../.package-env.sh
port='make'
version='4.4'
deps=""
source_code="https://ftp.gnu.org/gnu/$port/$port-$version.tar.gz"
source_cd="$port-$version"
source_name="$port"
use_crosscompiler=true
build() {
    ./configure --prefix=$PREFIX --target=x86_64-pc-linux --host=x86_64-pc-linux
    ./build.sh -j$(nproc)
}

install() {
    ./make DESTDIR=$INSTALL_PATH install
}
