#!/bin/bash -e

# https://confluence.hdfgroup.org/display/support/HDF5+1.14.0

source base-config.sh

module purge
module load gcc/9.5.0 mpich/4.0.3 python/3.11.1

MAJOR=1.14
MINOR=0
VER=${MAJOR}.${MINOR}

SN=hdf5

BDIR=${SW}/${SN}/build
IDIR=${SW}/${SN}/${VER}

download_link=https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-${MAJOR}/hdf5-${VER}/src/hdf5-${VER}.tar.gz
echo ${download_link}
filename=$(basename ${download_link})
foldername=$(basename ${filename} .tar.gz)

mkdir -pv ${BDIR}
cd ${BDIR}

${fetch} ${download_link}
tar zxf ${filename}
cd ${foldername}
CC=`which mpicc` ./configure --enable-parallel --enable-shared --prefix=${IDIR}
make -j > m.o
make install



