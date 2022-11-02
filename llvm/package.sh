#!/usr/bin/sh ../.package-env.sh
port='llvm'
version='15.0.3'
deps="make cmake"
source_code="https://github.com/$port/$port-project/archive/refs/tags/${port}org-$version.tar.gz"
source_cd="$port-$version"
source_name="$port"
use_crosscompiler=true
build() {
    mkdir build
    cmake -DLLVM_ENABLE_PROJECTS="clang;lld;compiler-rt" \
    -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind;llvm-libgcc" \
    -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" \
    ../llvm
    make -j$(nproc)
}

install() {
    make DESTDIR=$INSTALL_PATH install
}
