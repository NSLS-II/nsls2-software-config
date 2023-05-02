#!/bin/bash -e

fetch='curl -x socks5h://0:9999 -O'

module purge
module prepend-path MODULEPATH /nsls2/software/ap/saturn/modulefiles

VER=3.9.13
GCCV=9.5.0
MPIF=openmpi
MPIV=4.1.4

SW=/nsls2/software/ap/saturn
SN=python

BDIR=${SW}/${SN}/build
IDIR=${SW}/${SN}/${VER}-gcc-${GCCV}-${MPIF}-${MPIV}

module load gcc/${GCCV} ${MPIF}/${MPIV}-gcc-${GCCV}
mkdir -pv ${BDIR}
cd ${BDIR}
$fetch https://www.python.org/ftp/python/$VER/Python-$VER.tgz
tar zxf Python-$VER.tgz
mkdir python-$VER-gcc-${GCCV}-${MPIF}-${MPIV}
cd python-$VER-gcc-${GCCV}-${MPIF}-${MPIV}
../Python-$VER/configure --prefix=${IDIR} --enable-shared --enable-optimizations
make -j > m.o
make install
cd ${IDIR}/bin
ln -s python3 python
ln -s pip3 pip
#yes | LD_LIBRARY_PATH=/nsls2/software/ap/python/$VER/lib ./pip install pip -U
#yes | LD_LIBRARY_PATH=/nsls2/software/ap/python/$VER/lib ./pip install wheel numpy scipy matplotlib mpi4py Cython ipython jupyter ninja meson jupyterhub sudospawner sympy PyQt5 argos ipympl
