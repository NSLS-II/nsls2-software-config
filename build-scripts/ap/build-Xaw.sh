#!/bin/bash -e


# Xaw
# This was needed to build texlive
mkdir -pv /nsls2/software/ap/Xaw/build
cd /nsls2/software/ap/Xaw/build
wget https://www.x.org/releases/individual/lib/libXaw-1.0.13.tar.gz
tar zxf libXaw-1.0.13.tar.gz
libXaw-1.0.13/
./configure --prefix=/nsls2/software/ap/Xaw/1.0.13
make -j > m.o
make install
