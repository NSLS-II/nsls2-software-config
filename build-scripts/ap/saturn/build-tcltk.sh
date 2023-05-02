#!/bin/bash -e

source base-config.sh

module purge

VER=8.6.11
GCCV=9.5.0

SN=tcltk

BDIR=${SW}/${SN}/build
IDIR=${SW}/${SN}/${VER}

module load gcc/${GCCV} 
mkdir -pv ${BDIR}

cd ${BDIR}
$fetch https://prdownloads.sourceforge.net/tcl/tcl${VER}-src.tar.gz
$fetch https://downloads.sourceforge.net/project/tcl/Tcl/${VER}/tcl${VER}-src.tar.gz
tar -xzf tcl${VER}-src.tar.gz
cd tcl${VER}/unix
./configure --prefix=${IDIR}
make -j > m.o
make install
cd ${IDIR}/bin
ln -s tclsh8.6 tclsh

# Make sure you have modulefile setup already for tcltk for tk build
module load tcltk/${VER}
cd ${BDIR}
$fetch https://prdownloads.sourceforge.net/tcl/tk${VER}-src.tar.gz
$fetch https://downloads.sourceforge.net/project/tcl/Tcl/${VER}/tk${VER}-src.tar.gz
tar zxf tk${VER}-src.tar.gz
cd tk${VER}/unix
./configure --prefix=${IDIR} --with-tcl=${IDIR}/lib
make -j > m.o
make install
cd ${IDIR}/bin
ln -s wish8.6 wish
