#!/bin/bash -e

source base-config.sh

VER=3.3.2
GCCV=9.5.0

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
../mpich-${VER}/configure --prefix=${IDIR}
make -j > m.o
make install


