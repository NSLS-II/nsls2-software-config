#!/bin/bash -e

# Julia
mkdir -pv /nsls2/software/ap/julia/build
cd /nsls2/software/ap/julia/build
wget https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.5-linux-x86_64.tar.gz
wget https://julialang-s3.julialang.org/bin/linux/x64/1.5/julia-1.5.3-linux-x86_64.tar.gz
cd ..
tar zxf build/julia-1.0.5-linux-x86_64.tar.gz
tar zxf build/julia-1.5.3-linux-x86_64.tar.gz
mv julia-1.0.5 1.0.5
mv julia-1.5.3 1.5.3

