#!/bin/bash -e

# ROOT: https://root.cern
module load gcc/9.3.0 cmake/3.19.3 python/3.9.1 mpich/3.3.2-gcc-9.3.0
mkdir -pv /nsls2/software/ap/root/build
cd /nsls2/software/ap/root/build
wget https://root.cern/download/root_v6.22.06.source.tar.gz
tar zxf root_v6.22.06.source.tar.gz
cd root-6.22.06
mkdir -pv obj /nsls2/software/ap/root/6.22.06
cd obj
cmake -DCMAKE_INSTALL_PREFIX=/nsls2/software/ap/root/6.22.06 ..
cmake --build . --target install -- -j

