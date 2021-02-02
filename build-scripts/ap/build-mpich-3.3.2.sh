#!/bin/bash -e

module load gcc/9.3.0
mkdir -pv /nsls2/software/ap/mpich/build
cd /nsls2/software/ap/mpich/build
wget http://www.mpich.org/static/downloads/3.3.2/mpich-3.3.2.tar.gz
tar zxf mpich-3.3.2.tar.gz
mkdir mpich-3.3.2-gcc-9.3.0
cd mpich-3.3.2-gcc-9.3.0
../mpich-3.3.2/configure --prefix=/nsls2/software/ap/mpich/3.3.2-gcc-9.3.0
make -j > m.o
make install

