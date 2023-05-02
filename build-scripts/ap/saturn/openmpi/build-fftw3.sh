#!/bin/bash -e

fetch='curl -L -x socks5h://0:9999 -O'

module purge
module prepend-path MODULEPATH /nsls2/software/ap/saturn/modulefiles

VER=3.3.10
GCCV=9.5.0

SW=/nsls2/software/ap/saturn
SN=fftw

BDIR=${SW}/${SN}/build
IDIR=${SW}/${SN}/${VER}

module load gcc/${GCCV}
mkdir -pv ${BDIR}
cd ${BDIR}
$fetch http://www.fftw.org/${SN}-${VER}.tar.gz
tar zxf ${SN}-$VER.tar.gz
mkdir ${SN}-$VER-gcc-${GCCV}
cd ${SN}-$VER-gcc-${GCCV}
../${SN}-$VER/configure --prefix=${IDIR}
make -j > m.o
make install

