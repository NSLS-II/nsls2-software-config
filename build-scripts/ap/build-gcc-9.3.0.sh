#!/bin/bash -e

mkdir -pv /nsls2/software/ap/gcc/build/
cd /nsls2/software/ap/gcc/build/
wget http://mirrors.concertpass.com/gcc/releases/gcc-9.3.0/gcc-9.3.0.tar.gz
tar zxf gcc-9.3.0.tar.gz
cd gcc-9.3.0
sed -i 's/ftp/http/' contrib/download_prerequisites
./contrib/download_prerequisites
cd ..
mkdir gcc-9.3.0-default
cd gcc-9.3.0-default
../gcc-9.3.0/configure --prefix=/nsls2/software/ap/gcc/9.3.0
make -j > m.o
make install > i.o
# setup modulefile in /nsls2/software/ap/modulefiles/gcc/9.3.0
module load gcc/9.3.0
gcc -march=native -Q --help=target|grep march # to check default arch

