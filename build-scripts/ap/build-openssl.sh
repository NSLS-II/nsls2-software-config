#!/bin/bash -e

ver=1.1.1l

module load accelerator/path gcc/9.3.0 perl/5.34.0

mkdir -pv /nsls2/software/ap/openssl/build
cd /nsls2/software/ap/openssl/build
rm -f openssl-${ver}.tar.gz
wget --no-check-certificate https://www.openssl.org/source/openssl-${ver}.tar.gz
tar zxf openssl-${ver}.tar.gz
cd openssl-${ver}
./config --prefix=/nsls2/software/ap/openssl/${ver}
make -j > m.o
make install

