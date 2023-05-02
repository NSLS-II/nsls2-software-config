#!/bin/bash -e

fetch='curl -x socks5h://0:9999 -O'

module prepend-path MODULEPATH /nsls2/software/ap/saturn/modulefiles

VER=4.1.4
GCCV=9.5.0

module load gcc/${GCCV}

SW=/nsls2/software/ap/saturn
SN=openmpi

BDIR=${SW}/${SN}/build
IDIR=${SW}/${SN}/${VER}-gcc-${GCCV}

mkdir -pv ${BDIR}
cd ${BDIR}

${fetch} https://download.open-mpi.org/release/open-mpi/v${VER:0:3}/openmpi-${VER}.tar.gz
tar zxf openmpi-${VER}.tar.gz

mkdir ${SN}-${VER}-gcc-${GCCV}
cd ${SN}-${VER}-gcc-${GCCV}
../openmpi-${VER}/configure --prefix=${IDIR} > c.o
make all -j > m.o
make install > i.o


