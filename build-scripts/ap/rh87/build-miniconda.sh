#!/bin/bash -e

# https://docs.conda.io/en/latest/miniconda.html

source base-config.sh


VER=py310_23.1.0-1

SN=miniconda

BDIR=${SW}/${SN}/build
IDIR=${SW}/${SN}/${VER}

module purge

download_link=https://repo.anaconda.com/miniconda/Miniconda3-${VER}-Linux-x86_64.sh
echo ${download_link}
filename=$(basename ${download_link})

mkdir -pv ${BDIR}
cd ${BDIR}

${fetch} ${download_link}
bash ${filename} -b -p ${IDIR}

