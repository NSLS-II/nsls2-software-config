#!/bin/bash -e

# Might be useful: https://www3.aps.anl.gov/forums/elegant/viewtopic.php?t=891

module load gcc/9.3.0 mpich/3.3.2-gcc-9.3.0 python/3.9.1 motif/2.3.8

export EV=2020.5.0
export EBASE=/nsls2/software/ap/elegant/$EV-gcc-9.3.0-mpich-3.3.2
export EBUILD=/nsls2/software/ap/elegant/build/$EV

# Make build dir and download all needed files to it
mkdir -pv $EBUILD
cd $EBUILD
wget https://epics.anl.gov/download/base/baseR3.14.12.8.tar.gz # https://epics.anl.gov/download/base/index.php
wget https://ops.aps.anl.gov/downloads/elegant.2020.5.0.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
wget https://epics.anl.gov/download/extensions/extensionsTop_20120904.tar.gz # https://epics.anl.gov/extensions/configure/index.php
wget https://ops.aps.anl.gov/downloads/SDDS.5.0.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
wget https://ops.aps.anl.gov/downloads/oag.apps.configure.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
wget https://ops.aps.anl.gov/downloads/SDDSepics.5.0.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
wget https://ops.aps.anl.gov/downloads/elegant.2020.5.0.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
wget https://github.com/Reference-LAPACK/lapack/archive/v3.9.0.tar.gz # http://www.netlib.org/lapack/
wget http://www.netlib.org/blas/blas-3.8.0.tgz # http://www.netlib.org/blas/
wget https://ops.aps.anl.gov/downloads/oag.1.26.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
wget https://ops.aps.anl.gov/downloads/defns.rpn # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software


# Make dest dir
mkdir -pv $EBASE/epics

# Unpack epics base
cd $EBASE/epics
tar zxf $EBUILD/baseR3.14.12.8.tar.gz
mv base-3.14.12.8/ base
export HOST_ARCH=linux-x86_64
export EPICS_HOST_ARCH=linux-x86_64
cd base/configure
echo CROSS_COMPILER_TARGET_ARCHS= >> CONFIG
echo SHARED_LIBRARIES=NO >> CONFIG

# Add here CC, CCC, CXX, FC, etc to point to compilers (uncommented)
#sed -i '/^COMMANDLINE_LIBRARY = READLINE/d' os/CONFIG_SITE.Common.linux-x86_64
echo CC=$CC >> os/CONFIG_SITE.Common.linux-x86_64
echo CCC=$CXX >> os/CONFIG_SITE.Common.linux-x86_64
echo CXX=$CXX >> os/CONFIG_SITE.Common.linux-x86_64
echo FC=$FC >> os/CONFIG_SITE.Common.linux-x86_64
cd ..
make

# Upzip extension base
cd $EBASE/epics
tar zxf $EBUILD/extensionsTop_20120904.tar.gz

# Build SDDS
cd $EBASE
tar zxf $EBUILD/SDDS.5.0.tar.gz
cd epics/extensions/configure
make
cd ../src/SDDS/tiff
make
cd ../png
make
cd ../python
PYTHON3=1 make
cd ..
make

# OAG
cd $EBASE
tar zxf $EBUILD/oag.apps.configure.tar.gz
tar zxf $EBUILD/SDDSepics.5.0.tar.gz
tar zxf $EBUILD/elegant.2020.5.0.tar.gz

# LAPACK
cd $EBASE
tar zxf $EBUILD/v3.9.0.tar.gz
cd lapack-3.9.0/
cp make.inc.example make.inc
make
cp liblapack.a  librefblas.a  libtmglib.a ../epics/extensions/lib/linux-x86_64/

# BLAS
cd $EBASE
tar zxf $EBUILD/blas-3.8.0.tgz
cd BLAS-3.8.0/
make
cp blas_LINUX.a ../epics/extensions/lib/linux-x86_64/libblas.a

# OAG Apps
cd $EBASE/oag/apps/configure
echo EPICS_BASE=$EBASE/epics/base >> RELEASE
cd ../src/physics/
make
cd ../xraylib/
make

# Elegant
cd $EBASE/oag/apps/src/elegant
export PATH=$PATH:$EBASE/epics/extensions/bin/linux-x86_64
make
cd elegantTools
make

# Pelegant
cd $EBASE/epics/extensions/src/SDDS/SDDSlib
make clean
make MPI=1
cd ../pgapack
make clean
make
cd $EBASE/oag/apps/src/elegant
make clean
make Pelegant

# OAG Tcl/Tk
cd $EBASE
tar zxf $EBUILD/oag.1.26.tar.gz
cd oag/apps/src/tcltklib
make
cd ../pem
make
cd ../tcltkinterp/extensions
make
./installExtensions -location ../../../lib/linux-x86_64

# Copy defns file to release area
cp $EBUILD/defns.rpn $EBASE

# Configure oag
cd $EBASE/oag/apps/bin/linux-x86_64
ln -s /usr/bin/tclsh oagtclsh
ln -s /usr/bin/wish oagwish




# motif: Need to add to start of wmluitok.l
# %option main
# YACC="bison -y" ./configure --prefix=/asdasd
