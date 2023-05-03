#!/usr/bin/sh ../.package-env.sh
port='tcc'
version='29ae3ed'
commit_long="4d5b83eec43598d6cd7949bccb41c8083"
deps=""
source_code="http://repo.or.cz/tinycc.git/snapshot/$version$commit_long.tar.gz"
source_cd="$port-$version"
use_crosscompiler=true
build() {
    mkdir build
    cd build

    ../configure --prefix=$PREFIX
    make -j$(nproc)
}

install() {
    make DESTDIR=$INSTALL_PATH install 
    ln -svr $INSTALL_PATH/bin/tcc $INSTALL_PATH/bin/gcc
}
