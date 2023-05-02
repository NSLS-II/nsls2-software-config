#!/bin/bash -e

fetch='curl -x socks5h://0:9999 -L -O'

module prepend-path MODULEPATH /nsls2/software/ap/saturn/modulefiles

VER=3.4.2
GCCV=9.5.0

SW=/nsls2/software/ap/saturn
SN=libffi

BDIR=${SW}/${SN}/build
IDIR=${SW}/${SN}/${VER}-gcc-${GCCV}

module load gcc/${GCCV}
mkdir -pv ${BDIR}
cd ${BDIR}
$fetch https://github.com/libffi/libffi/releases/download/v${VER}/libffi-${VER}.tar.gz
tar zxf libffi-${VER}.tar.gz
mkdir ${SN}-$VER-gcc-${GCCV}
cd ${SN}-$VER-gcc-${GCCV}
../${SN}-$VER/configure --prefix=${IDIR}
make -j > m.o
make install
