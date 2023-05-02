#!/bin/bash -e

source base-config.sh

VER=7.2
MAJOR=$(echo ${VER} | cut -d. -f1)

BDIR=${SW}/gcc/build
IDIR=${SW}/gcc/${VER}

module purge

module load gcc/10.4.0

mkdir -pv ${BDIR}
cd ${BDIR}
${fetch} https://www.nano-editor.org/dist/v${MAJOR}/nano-${VER}.tar.gz
tar zxf nano-${VER}.tar.gz
cd nano-${VER}
./configure --prefix=${IDIR}
make -j
make install
