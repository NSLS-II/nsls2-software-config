#!/bin/bash -e

source base-config.sh

module purge

VER=16.13.1

SN=nodejs

BDIR=${SW}/${SN}/build
IDIR=${SW}/${SN}/${VER}

mkdir -pv ${BDIR}
cd ${BDIR}
${fetch} https://nodejs.org/dist/v${VER}/node-v${VER}-linux-x64.tar.xz

tar xf node-v${VER}-linux-x64.tar.xz
mv node-v${VER}-linux-x64 ${IDIR}

