#!/bin/bash -e

source base-config.sh

VER=10.4.0

BDIR=${SW}/gcc/build
IDIR=${SW}/gcc/${VER}

module purge

mkdir -pv ${BDIR}
cd ${BDIR}
${fetch} http://mirrors.concertpass.com/gcc/releases/gcc-${VER}/gcc-${VER}.tar.gz
tar zxf gcc-${VER}.tar.gz
cd gcc-${VER}
#sed -i 's/ftp/http/' contrib/download_prerequisites
#sed -i "s/.*fetch=.*/  fetch='curl -x socks5h:\/\/0:9999 -LO -u anonymous:'/" contrib/download_prerequisites
./contrib/download_prerequisites
cd ..
mkdir gcc-${VER}-default
cd gcc-${VER}-default
../gcc-${VER}/configure --prefix=${IDIR} --disable-multilib
make -j > m.o
make install > i.o
# setup modulefile before this finishes!!
module load gcc/${VER}
gcc -march=native -Q --help=target|grep march # to check default arch
