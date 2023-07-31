#!/bin/bash -e

source base-config.sh

module purge

SN=R
MAJOR=4
MINOR=3.1
VER=${MAJOR}.${MINOR}
GCCV=10.4.0


BDIR=${SW}/${SN}/build
IDIR=${SW}/${SN}/${VER}

module load gcc/${GCCV}
mkdir -pv ${BDIR}
cd ${BDIR}
$fetch https://archive.linux.duke.edu/cran/src/base/R-${MAJOR}/R-${VER}.tar.gz
tar zxf R-${VER}.tar.gz
mkdir ${SN}-$VER-gcc-${GCCV}
cd ${SN}-$VER-gcc-${GCCV}
../${SN}-$VER/configure --prefix=${IDIR}
make -j > m.o
make install

