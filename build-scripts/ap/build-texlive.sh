#!/bin/bash -e

# Latex
# https://www.tug.org/texlive/build.html
# Xaw header files were needed for this so I built the whole thing, required for this
module load gcc/9.3.0 Xaw/1.0.13
mkdir -pv /nsls2/software/ap/texlive/build
cd /nsls2/software/ap/texlive/build
wget http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2020/texlive-20200406-source.tar.xz
tar xf texlive-20200406-source.tar.xz
cd texlive-20200406-source/
TL_INSTALL_DEST=/nsls2/software/ap/texlive/20200406 ./Build
