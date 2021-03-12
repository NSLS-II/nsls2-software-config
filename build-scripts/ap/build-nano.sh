#!/bin/bash -e

# Build nano because it's simple, not that I think it's actually a real editor.
module load accelerator/path gcc/9.3.0 ncurses/6.2
mkdir -pv /nsls2/software/ap/nano/build
cd /nsls2/software/ap/nano/build
wget https://www.nano-editor.org/dist/v5/nano-5.6.1.tar.gz
tar zxf nano-5.6.1.tar.gz
cd nano-5.6.1
./configure --prefix=/nsls2/software/ap/nano/5.6.1
make -j
make install
