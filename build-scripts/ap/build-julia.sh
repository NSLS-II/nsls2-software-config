#!/bin/bash -e

basever=1.6
ver=${basever}.4

# Julia
mkdir -pv /nsls2/software/ap/julia/build
cd /nsls2/software/ap/julia/build
wget https://julialang-s3.julialang.org/bin/linux/x64/${basever}/julia-${ver}-linux-x86_64.tar.gz
cd ..
tar zxf build/julia-${ver}-linux-x86_64.tar.gz
mv julia-${ver} ${ver}

