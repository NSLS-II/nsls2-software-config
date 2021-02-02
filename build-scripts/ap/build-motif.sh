#!/bin/bash -e

# motif, needed by elegant
# https://motif.ics.com/motif/downloads
# https://sourceforge.net/projects/motif/
mkdir -pv /nsls2/software/ap/motif/build
cd /nsls2/software/ap/motif/build
ver=2.3.8
wget -O motif-$ver.tgz https://sourceforge.net/projects/motif/files/latest/download
tar zxf motif-$ver.tgz
cd motif-$ver/
sed -i '1s/^/%option main\n/' tools/wml/wmluiltok.l
alias yacc='bison -y'
YACC='bison -y' ./configure --prefix=/nsls2/software/ap/motif/$ver
make -j > m.o
make install
