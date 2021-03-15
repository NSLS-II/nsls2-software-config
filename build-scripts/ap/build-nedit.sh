#!/bin/bash -e

# This one taken from rpm

# nedit
# https://pkgs.org/download/nedit
mkdir -pv /nsls2/software/ap/nedit/build
cd /nsls2/software/ap/nedit/build
wget https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/n/nedit-5.7-1.el7.x86_64.rpm
rpm2cpio nedit-5.7-1.el7.x86_64.rpm | cpio -idmv
mkdir ../5.7-1
mv usr/* ../5.7-1/
rmdir usr

