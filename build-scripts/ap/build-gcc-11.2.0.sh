#!/bin/bash -e

ver=11.2.0

mkdir -pv /nsls2/software/ap/gcc/build/
cd /nsls2/software/ap/gcc/build/
wget http://mirrors.concertpass.com/gcc/releases/gcc-$ver/gcc-$ver.tar.gz
tar zxf gcc-$ver.tar.gz
cd gcc-$ver
sed -i 's/ftp/http/' contrib/download_prerequisites
./contrib/download_prerequisites
cd ..
mkdir gcc-$ver-default
cd gcc-$ver-default
../gcc-$ver/configure --prefix=/nsls2/software/ap/gcc/$ver
make -j > m.o
make install > i.o
# setup modulefile in /nsls2/software/ap/modulefiles/gcc/$ver
module load gcc/$ver
gcc -march=native -Q --help=target|grep march # to check default arch

