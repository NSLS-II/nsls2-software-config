#!/bin/bash -e

# Latex
# https://www.tug.org/texlive/build.html
# Xaw header files were needed for this so I built the whole thing, required for this
module load accelerator/path gcc/9.3.0
mkdir -pv /nsls2/software/ap/texlive/build
cd /nsls2/software/ap/texlive/build
wget http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2020/install-tl-unx.tar.gz
tar zxf install-tl-unx.tar.gz
cd install-tl-20200406

cat <<EOF > texlive.profile
TEXDIR /nsls2/software/ap/texlive/20200406
TEXMFCONFIG ~/.texlive2020/texmf-config
TEXMFHOME ~/texmf
TEXMFLOCAL /nsls2/software/ap/texlive/20200406/texmf-local
TEXMFSYSCONFIG /nsls2/software/ap/texlive/20200406/texmf-config
TEXMFSYSVAR /nsls2/software/ap/texlive/20200406/texmf-var
TEXMFVAR ~/.texlive2020/texmf-var
EOF

./install-tl -profile texlive.profile


