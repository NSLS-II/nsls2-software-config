#!/bin/bash -e

source base-config.sh

module purge

VER=3.3.10
GCCV=9.5.0

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

