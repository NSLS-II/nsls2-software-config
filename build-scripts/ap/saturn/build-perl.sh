#!/bin/bash -e

source base-config.sh

module purge

VER=5.34.0
GCCV=9.5.0

SN=perl

BDIR=${SW}/${SN}/build
IDIR=${SW}/${SN}/${VER}

module load gcc/${GCCV} 
mkdir -pv ${BDIR}

cd ${BDIR}
$fetch -k https://www.cpan.org/src/5.0/perl-${VER}.tar.gz
tar -xzf perl-${VER}.tar.gz
cd perl-${VER}
./Configure -des -Dprefix=${IDIR}
make 
#make test
make install
