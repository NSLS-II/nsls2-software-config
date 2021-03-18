#!/bin/bash -e

ver=3.9.1

# Python $ver
# Needs ncurses built correctly, a bit painful to figure out

module load accelerator/path gcc/9.3.0 ncurses/6.2 mpich/3.3.2-gcc-9.3.0
mkdir -pv /nsls2/software/ap/python/build
cd /nsls2/software/ap/python/build
wget https://www.python.org/ftp/python/$ver/Python-$ver.tgz
tar zxf Python-$ver.tgz
mkdir python-$ver-gcc-9.3.0
cd python-$ver-gcc-9.3.0
../Python-$ver/configure --prefix=/nsls2/software/ap/python/$ver --enable-shared --enable-optimizations
make -j > m.o
make install
cd /nsls2/software/ap/python/$ver/bin
ln -s python3 python
ln -s pip3 pip
yes | LD_LIBRARY_PATH=/nsls2/software/ap/python/$ver/lib ./pip install pip -U
yes | LD_LIBRARY_PATH=/nsls2/software/ap/python/$ver/lib ./pip install wheel numpy scipy matplotlib mpi4py Cython ipython jupyter ninja meson
