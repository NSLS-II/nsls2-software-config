#!/bin/bash -e 

# madx
ver=5.08.00
mkdir -pv /nsls2/software/ap/madx/$ver/bin
mkdir -pv /nsls2/software/ap/madx/$ver/doc
cd /nsls2/software/ap/madx/$ver/bin
wget http://madx.web.cern.ch/madx/releases/last-rel/madx-linux64-gnu
wget http://madx.web.cern.ch/madx/releases/last-rel/numdiff-linux64-gnu
mv madx-linux64-gnu madx
mv numdiff-linux64-gnu numdiff
chmod +x madx numdiff
cd ../doc
wget http://madx.web.cern.ch/madx/releases/last-rel/madxuguide.pdf

