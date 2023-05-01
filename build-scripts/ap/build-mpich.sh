#!/bin/bash -e

VER=3.3.2
#VER=3.4.3
GCCVER=9.3.0

BDIR=/nsls2/software/ap/mpich/build
IDIR=/nsls2/software/ap/mpich/${VER}-gcc-${GCCVER}

module purge
module load accelerator/path
module load gcc/${GCCVER}

#export LIBRARY_PATH=/usr/lib64:$LIBRARY_PATH
#export LD_LIBRARY_PATH=/usr/lib64:$LD_LIBRARY_PATH

mkdir -pv ${BDIR}
cd ${BDIR}
wget --backups=1 http://www.mpich.org/static/downloads/${VER}/mpich-${VER}.tar.gz
rm -rf mpich-${VER}
tar zxf mpich-${VER}.tar.gz
mkdir mpich-${VER}-gcc-${GCCVER}
cd mpich-${VER}-gcc-${GCCVER}
../mpich-${VER}/configure --prefix=${IDIR}
make -j > m.o
make install

