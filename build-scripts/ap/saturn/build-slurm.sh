#!/bin/bash -e

# Find the tag you want (latest?) here:
# https://github.com/SchedMD/slurm/tags

source base-config.sh

#TAG=20-11-8-1
TAG=22-05-5-1

module purge
module load gcc/9.5.0

SN=slurm

BDIR=${SW}/${SN}/build
IDIR=${SW}/${SN}/${TAG}
ETCDIR=${SW}/${SN}/etc

mkdir -pv ${BDIR}
mkdir -pv ${ETCDIR}
cd ${BDIR}

if [ ! -d slurm ]; then
  git clone https://github.com/SchedMD/slurm.git
fi
cd slurm
git checkout master
git pull
git checkout tags/slurm-$TAG

./configure --prefix=${IDIR} --sysconfdir=${ETCDIR} --enable-debug --enable-x11

make -j 
make install
