#!/bin/bash -e

VER=3.3.2

module purge
module load accelerator/path
module load gcc/9.3.0

mkdir -pv /nsls2/software/ap/mpich/build
cd /nsls2/software/ap/mpich/build
wget http://www.mpich.org/static/downloads/${VER}/mpich-${VER}.tar.gz
tar zxf mpich-${VER}.tar.gz
mkdir mpich-${VER}-gcc-9.3.0
cd mpich-${VER}-gcc-9.3.0
../mpich-${VER}/configure --prefix=/nsls2/software/ap/mpich/${VER}-gcc-9.3.0
make -j > m.o
make install

