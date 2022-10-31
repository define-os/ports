#!/usr/bin/env bash

packagesdb="/usr/ports/packages.db"
deps=()

. $@

#HELPERS
recreate_dir() {
    [ -d $1 ] && rm -rf $1
    mkdir $1
}

#CODE
install_deps() {
    for dep in "${deps[@]}"; do
        echo "$port - $dep"
    done
}
prepare_dirs() {
    recreate_dir "build"
}

download_source() {
    wget $source_code -O $port-$version.tar.xz
    cd build
    tar xf ../$port-$version.tar.xz
}
install_deps
prepare_dirs
echo $(basename $PWD)
echo $(basename $0)
#download_source
