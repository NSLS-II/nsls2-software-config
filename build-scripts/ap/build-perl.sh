#!/bin/bash -e

ver=5.34.0

module load accelerator/path gcc/9.3.0

mkdir -pv /nsls2/software/ap/perl/build
mkdir -pv /nsls2/software/ap/perl/${ver}
cd /nsls2/software/ap/perl/build
rm -f perl-${ver}.tar.gz
wget --no-check-certificate https://www.cpan.org/src/5.0/perl-${ver}.tar.gz
tar -xzf perl-${ver}.tar.gz
cd perl-${ver}
./Configure -des -Dprefix=/nsls2/software/ap/perl/${ver}
make -j
make test
make install
