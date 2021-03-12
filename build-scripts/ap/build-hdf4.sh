#!/bin/bash -e

# hdf4
# https://support.hdfgroup.org/ftp/HDF/releases/
module load accelerator/path gcc/9.3.0 jdk/15.0.2
mkdir -pv /nsls2/software/ap/hdf4/build
cd /nsls2/software/ap/hdf4/build
wget https://support.hdfgroup.org/ftp/HDF/releases/HDF4.2.15/src/hdf-4.2.15.tar.gz
tar zxf hdf-4.2.15.tar.gz
cd hdf-4.2.15
./configure --prefix=/nsls2/software/ap/hdf4/4.2.15 --enable-java
make -j > m.o
make install
