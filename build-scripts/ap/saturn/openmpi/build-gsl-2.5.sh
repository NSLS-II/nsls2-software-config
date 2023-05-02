#!/bin/bash -e

fetch='curl -x socks5h://0:9999 -O'

module purge
module prepend-path MODULEPATH /nsls2/software/ap/saturn/modulefiles

VER=2.5
GCCV=9.5.0

SW=/nsls2/software/ap/saturn
SN=gsl

BDIR=${SW}/${SN}/build
IDIR=${SW}/${SN}/${VER}

module load gcc/${GCCV}
mkdir -pv ${BDIR}
cd ${BDIR}
$fetch https://mirrors.sarata.com/gnu/gsl/gsl-${VER}.tar.gz
tar zxf gsl-$VER.tar.gz
mkdir gsl-$VER-gcc-${GCCV}
cd gsl-$VER-gcc-${GCCV}
../gsl-$VER/configure --prefix=${IDIR}
make -j > m.o
make install
