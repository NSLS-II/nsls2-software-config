#!/bin/bash -e

# cmake, needed by ROOT
module load gcc/9.3.0
mkdir -pv /nsls2/software/ap/cmake/build
cd /nsls2/software/ap/cmake/build
wget https://github.com/Kitware/CMake/releases/download/v3.19.3/cmake-3.19.3.tar.gz
tar zxf cmake-3.19.3.tar.gz
cd cmake-3.19.3
./configure --prefix=//nsls2/software/ap/cmake/3.19.3
make -j > m.o
make install

