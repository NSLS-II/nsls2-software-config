#!/bin/bash -e

module purge
module load accelerator/path gcc/9.3.0

VER=3.11.0

BASE=/nsls2/software/ap/lapack
BDIR=${BASE}/build

mkdir -pv ${BDIR}
cd ${BDIR}

wget --backups=1 https://github.com/Reference-LAPACK/lapack/archive/refs/tags/v${VER}.tar.gz
cd ${BASE}
tar zxf ${BDIR}/v${VER}.tar.gz
mv lapack-${VER} ${VER}
cd ${VER}
cp make.inc.example make.inc
make -j > m.0
make -j lapackelib > me.o

