#!/bin/bash -e

# Find the tag you want (latest?) here:
# https://github.com/SchedMD/slurm/tags

#TAG=21-08-2-1
TAG=20-11-8-1

module purge

mkdir -pv /nsls2/software/ap/slurm/build
cd /nsls2/software/ap/slurm/build
if [ ! -d slurm ]; then
  git clone git://github.com/SchedMD/slurm.git
fi
cd slurm
#git pull
git checkout tags/slurm-$TAG

./configure --prefix=/nsls2/software/ap/slurm/$TAG --sysconfdir=/etc/slurm --enable-debug --enable-x11 > c.o

make -j > m.o
make install > i.o
