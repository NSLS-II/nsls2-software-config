#!/bin/bash -e

fetch='curl -x socks5h://0:9999 -L -O'

module purge
module prepend-path MODULEPATH /nsls2/software/ap/saturn/modulefiles

VER=1.2.12
GCCV=9.5.0

SW=/nsls2/software/ap/saturn
SN=zlib

BDIR=${SW}/${SN}/build
IDIR=${SW}/${SN}/${VER}-gcc-${GCCV}

module load gcc/${GCCV} 
mkdir -pv ${BDIR}
cd ${BDIR}

$fetch https://zlib.net/zlib-${VER}.tar.gz
tar zxf zlib-${VER}.tar.gz
cd zlib-${VER}
./configure --prefix=${IDIR} > c.o
make  > m.o
make install > i.o

