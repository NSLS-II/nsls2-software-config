#!/bin/bash -e

sn=R
major=4
minor=3.1
ver=$major.$minor


# Python $ver
# Needs ncurses built correctly, a bit painful to figure out

module load accelerator/path gcc/9.3.0 mpich/3.3.2-gcc-9.3.0
mkdir -pv /nsls2/software/ap/$sn/build
cd /nsls2/software/ap/$sn/build
wget --backups=1 https://archive.linux.duke.edu/cran/src/base/R-${major}/R-${ver}.tar.gz
tar zxf R-${ver}.tar.gz
cd R-${ver}
./configure --prefix=/nsls2/software/ap/$sn/$ver --with-pcre1
make -j > m.o
make install
