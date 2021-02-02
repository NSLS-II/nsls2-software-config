#!/bin/bash

# ncurses
# This needs to be built for later versions of python, so here we go
# https://invisible-island.net/ncurses/
# http://clfs.org/view/clfs-sysroot/arm/final-system/ncurses.html
module load gcc/9.3.0
mkdir -pv /nsls2/software/ap/ncurses/build
cd /nsls2/software/ap/ncurses/build
wget https://invisible-island.net/datafiles/release/ncurses.tar.gz # Check version after this download
tar zxf ncurses.tar.gz
cd ncurses-6.2
./configure --prefix=/nsls2/software/ap/ncurses/6.2 --with-shared --enable-widec --with-termlib
make -j > m.o
make install

