#!/bin/bash -e

source base-config.sh

module purge

VER=2.5
GCCV=9.5.0

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
