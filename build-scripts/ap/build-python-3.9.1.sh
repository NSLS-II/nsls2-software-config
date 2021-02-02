#!/bin/bash -e

# Python 3.9
# Needs ncurses built correctly, a bit painful to figure out
module load gcc/9.3.0 ncurses/6.2 mpich/3.3.2-gcc-9.3.0
mkdir -pv /nsls2/software/ap/python/build
cd /nsls2/software/ap/python/build
wget https://www.python.org/ftp/python/3.9.1/Python-3.9.1.tgz
tar zxf Python-3.9.1.tgz
mkdir python-3.9.1-gcc-9.3.0
cd python-3.9.1-gcc-9.3.0
../Python-3.9.1/configure --prefix=/nsls2/software/ap/python/3.9.1 --enable-shared --enable-optimizations
make -j > m.o
make install
cd /nsls2/software/ap/python/3.9.1/bin
ln -s python3 python
ln -s pip3 pip
pip install --yes numpy scipy matplotlib mpi4py Cython
