#!/bin/bash -e

# Flair: https://flair.web.cern.ch/flair/download.html
# I guess flair is just a directory to copy!?
# Follow the "Compile from source" directions near bottom for geoviewer
module load gcc/9.3.0 python/3.9.1
mkdir -pv /nsls2/software/ap/flair/build
cd /nsls2/software/ap/flair/build
wget https://flair.web.cern.ch/flair/download/flair-3.1-7.tgz
wget https://flair.web.cern.ch/flair/download/flair-geoviewer-3.1-7.tgz
tar zxf flair-3.1-7.tgz
tar zxf flair-geoviewer-3.1-7.tgz
mv flair-3.1 ../3.1-7
cd flair-geoviewer-3.1/
make -j
make install DESTDIR=/nsls2/software/ap/flair/3.1-7
