#!/bin/bash -e

fetch='curl -x socks5h://0:9999 -L -O'

module purge
module prepend-path MODULEPATH /nsls2/software/ap/saturn/modulefiles

VER=1.1.1l
GCCV=9.5.0

SW=/nsls2/software/ap/saturn
SN=openssl

BDIR=${SW}/${SN}/build
IDIR=${SW}/${SN}/${VER}-gcc-${GCCV}

module load gcc/${GCCV} 
mkdir -pv ${BDIR}
cd ${BDIR}

$fetch https://www.openssl.org/source/openssl-${VER}.tar.gz
tar zxf openssl-${VER}.tar.gz
cd openssl-${VER}
./config --prefix=${IDIR} > c.o
make -j > m.o
make install > i.o

