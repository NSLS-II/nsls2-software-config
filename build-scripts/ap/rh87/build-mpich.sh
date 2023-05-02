#!/bin/bash -e

module purge
source base-config.sh

VER=4.0.3
GCCV=10.4.0

module load gcc/${GCCV}

SN=mpich

BDIR=${SW}/${SN}/build
IDIR=${SW}/${SN}/${VER}

mkdir -pv ${BDIR}
cd ${BDIR}

${fetch} http://www.mpich.org/static/downloads/${VER}/mpich-${VER}.tar.gz
rm -rf mpich-${VER}
tar zxf mpich-${VER}.tar.gz
mkdir mpich-${VER}-gcc-${GCCV}
cd mpich-${VER}-gcc-${GCCV}
../mpich-${VER}/configure --prefix=${IDIR} FFLAGS=-fallow-argument-mismatch FCFLAGS=-fallow-argument-mismatch
#../mpich-${VER}/configure --prefix=${IDIR}
make -j > m.o
make install


