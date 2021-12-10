#!/bin/bash -e

VER=16.13.1

mkdir -pv /nsls2/software/ap/nodejs/build
cd /nsls2/software/ap/nodejs/build
wget https://nodejs.org/dist/v${VER}/node-v${VER}-linux-x64.tar.xz
cd ..
tar xf build/node-v${VER}-linux-x64.tar.xz
mv node-v${VER}-linux-x64 ${VER}

