#!/bin/bash -e

# The top attempt in the end did not work because of type definitions.
# Second one is just downloading the binary (duh)

# hdfview
# https://portal.hdfgroup.org/display/support/HDFView+3.1.2
# https://bitbucket.hdfgroup.org/projects/HDFVIEW/repos/hdfview/browse/docs/Build_HDFView.txt?at=97418aee355d00f0e758a91756322faf1ca8dcd3&raw

###### # Didn't quite work
###### module load accelerator/path gcc/9.3.0 jdk/1.8.0_281 apache-ant/1.10.9 mpich/3.3.2-gcc-9.3.0 hdf5/1.12.0
###### mkdir -pv /nsls2/software/ap/hdf5view/build
###### cd /nsls2/software/ap/hdf5view/build
###### wget https://support.hdfgroup.org/ftp/HDF5/releases/HDF-JAVA/hdfview-3.1.2/src/hdfview-3.1.2.tar.gz
###### tar zxf hdfview-3.1.2.tar.gz
###### cd hdfview-3.1.2/
###### HDFLIBS=/nsls2/software/ap/hdf4/4.2.15 HDF5LIBS=$HDF5ROOT ant -Ddist.dir=/nsls2/software/ap/hdfview/3.1.2 run
###### wget https://support.hdfgroup.org/ftp/HDF5/releases/HDF-JAVA/hdfview-3.1.2/bin/HDFViewApp-3.1.2-centos7_64.tar.gz


# are we having fun yet kids?
mkdir -pv /nsls2/software/ap/hdf5view/build
cd /nsls2/software/ap/hdf5view/build
wget https://support.hdfgroup.org/ftp/HDF5/releases/HDF-JAVA/hdfview-3.1.2/bin/HDFViewApp-3.1.2-centos7_64.tar.gz
tar zxf HDFViewApp-3.1.2-centos7_64.tar.gz
mv HDFView ../3.1.2

