#!/bin/bash -e

# tcl because of elegant
module load accelerator/path gcc/9.3.0
mkdir -pv /nsls2/software/ap/tcltk/build
cd /nsls2/software/ap/tcltk/build
wget https://prdownloads.sourceforge.net/tcl/tcl8.6.11-src.tar.gz
tar zxf tcl8.6.11-src.tar.gz
cd tcl8.6.11/unix
./configure --prefix=/nsls2/software/ap/tcltk/8.6.11
make -j > m.o
make install
cd /nsls2/software/ap/tcltk/8.6.11/bin
ln -s tclsh8.6 tclsh

# Make sure you have modulefile setup already for tcltk for tk build
module load accelerator/path gcc/9.3.0 tcltk/8.6.11
mkdir -pv /nsls2/software/ap/tcltk/build
cd /nsls2/software/ap/tcltk/build
wget https://prdownloads.sourceforge.net/tcl/tk8.6.11.1-src.tar.gz
tar zxf tk8.6.11.1-src.tar.gz
cd tk8.6.11/unix/
./configure --prefix=/nsls2/software/ap/tcltk/8.6.11 --with-tcl=/nsls2/software/ap/tcltk/8.6.11/lib
make -j > m.o
make install
cd /nsls2/software/ap/tcltk/8.6.11/bin
ln -s wish8.6 wish
