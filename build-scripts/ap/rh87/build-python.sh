#!/bin/bash -e

source base-config.sh

module purge

#VER=3.11.1 # Default version
#VER=3.9.1
VER=3.9.16
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
#${fetch} https://files.pythonhosted.org/packages/8d/59/b4572118e098ac8e46e399a1dd0f2d85403ce8bbaad9ec79373ed6badaf9/PySocks-1.7.1-py3-none-any.whl
#yes | LD_LIBRARY_PATH=${IDIR}/lib ./pip install PySocks-1.7.1-py3-none-any.whl
#rm -f PySocks-1.7.1-py3-none-any.whl
yes | LD_LIBRARY_PATH=${IDIR}/lib ./pip install pip -U
yes | LD_LIBRARY_PATH=${IDIR}/lib ./pip install wheel numpy scipy matplotlib mpi4py Cython ipython jupyter ninja meson jupyterhub==1.4.2 "jupyter-server<2.0.0" sudospawner batchspawner sympy PyQt5 argos ipympl
#yes | LD_LIBRARY_PATH=${IDIR}/lib pip install git+https://github.com/unlhcc/jupyter-duoauthenticator.git
