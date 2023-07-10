#!/bin/bash -e

source base-config.sh

module purge

VER=3.11.1 # Default version
#VER=3.9.1
#VER=3.9.16
GCCV=10.4.0
MPIF=mpich
MPIV=4.0.3

SN=python

BDIR=${SW}/${SN}/build
IDIR=${SW}/${SN}/${VER}

module load gcc/${GCCV} ${MPIF}/${MPIV}
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

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${IDIR}/lib
yes | ./pip install pip -U
yes | ./pip install wheel numpy scipy matplotlib mpi4py Cython ipython jupyter ninja meson jupyterhub==1.4.2 "jupyter-server<2.0.0" sudospawner batchspawner sympy PyQt5 argos ipympl
