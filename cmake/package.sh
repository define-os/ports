#!/usr/bin/sh ../.package-env.sh
port='cmake'
version='3.24'
deps="make libuv"
source_code="https://$port.org/files/v${version}/$port-${version}.1.tar.gz"
source_cd="$port-${version}.1"
use_crosscompiler=true
build() {
    sed -i '/"lib64"/s/64//' Modules/GNUInstallDirs.cmake
    ./bootstrap --prefix=$PREFIX     \
                --system-libs        \
                --mandir=/share/man  \
                --no-system-jsoncpp  \
                --no-system-librhash \
                --docdir=/share/doc/cmake-3.24.1
    make -j$(nproc)
}

install() {
    make DESTDIR=$INSTALL_PATH install
}
