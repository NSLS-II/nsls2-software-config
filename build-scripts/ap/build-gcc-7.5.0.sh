#!/bin/bash -e

# sbatch -t 12:00:00 --exclusive -J build-gcc --wrap=./build-gcc-7.5.0.sh

module purge

ver=7.5.0

mkdir -pv /nsls2/software/ap/gcc/build/
cd /nsls2/software/ap/gcc/build/
wget http://mirrors.concertpass.com/gcc/releases/gcc-${ver}/gcc-${ver}.tar.gz
tar zxf gcc-${ver}.tar.gz
cd gcc-${ver}
sed -i 's/ftp/http/' contrib/download_prerequisites
./contrib/download_prerequisites
cd ..
mkdir gcc-${ver}-default
cd gcc-${ver}-default
../gcc-${ver}/configure --prefix=/nsls2/software/ap/gcc/${ver}
make -j > m.o
make install > i.o
# setup modulefile in /nsls2/software/ap/modulefiles/gcc/${ver}
module load accelerator/path gcc/${ver}
gcc -march=native -Q --help=target|grep march # to check default arch

