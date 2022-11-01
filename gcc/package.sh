#!/usr/bin/env -S bash ../.package-env.sh
port='gcc'
version='11.2.0'
deps=()
source_code="https://ftp.gnu.org/gnu/$port/$port-$version/$port-$version.tar.xz"
source_cd="$port-$version"
use_crosscompiler=true
build() {
    wget https://ftp.gnu.org/gnu/mpfr/mpfr-4.1.0.tar.xz https://ftp.gnu.org/gnu/mpc/mpc-1.2.1.tar.gz https://ftp.gnu.org/gnu/gmp/gmp-6.2.1.tar.xz
    tar xf mpfr-4.1.0.tar.xz
    tar xf mpc-1.2.1.tar.gz
    tar xf gmp-6.2.1.tar.xz
    mv mpfr-4.1.0 mpfr
    mv mpc-1.2.1 mpc
    mv gmp-6.2.1 gmp
    case $(uname -m) in
        x86_64)
            sed -e '/m64=/s/lib64/lib/' \
                -i.orig gcc/config/i386/t-linux64
        ;;
    esac
    mkdir build
    cd build

    ../configure --prefix=$INSTALL_PATH  \
        --enable-languages=c,c++         \
        --disable-multilib               \
        --disable-bootstrap
    make -j$(nproc)
}

install() {
    make install
    ln -svr $INSTALL_PATH/bin/cpp $INSTALL_PATH/lib
}