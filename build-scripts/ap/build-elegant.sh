#!/bin/bash -e

# Might be useful: https://www3.aps.anl.gov/forums/elegant/viewtopic.php?t=891

MPIF=mpich
MPIV=3.3.2
#MPIF=openmpi
#MPIV=3.1.5
GCCV=9.3.0

module purge
module load accelerator/path gcc/${GCCV} ${MPIF}/${MPIV}-gcc-${GCCV} python/3.9.1 motif/2.3.8 tcltk/8.6.11

#export EV=2020.5.0
#export EV=2021.2.0
#export EV=2021.3.0
#export EV=2021.4.0
#export EV=2022.1.0
#export EV=2022.2.0
#export EV=2023.1.0 SDDSV=5.3 SDDSEV=5.2 OAGV=1.27.1
#export EV=2023.2.0 SDDSV=5.4 SDDSEV=5.4 OAGV=1.28
#export EV=2023.3.0 SDDSV=5.5 SDDSEV=5.4 OAGV=1.28
export EV=2023.4.0 SDDSV=5.6 SDDSEV=5.6 OAGV=1.28
export EBASE=/nsls2/software/ap/elegant/$EV-gcc-${GCCV}-${MPIF}-${MPIV}_2
export EBUILD=/nsls2/software/ap/elegant/build/$EV

# Make build dir and download all needed files to it
mkdir -pv $EBUILD
cd $EBUILD
wget --no-check-certificate --backups=1 https://epics.anl.gov/download/base/baseR3.14.12.8.tar.gz # https://epics.anl.gov/download/base/index.php
wget --backups=1 https://ops.aps.anl.gov/downloads/elegant.${EV}.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
wget --no-check-certificate --backups=1 https://epics.anl.gov/download/extensions/extensionsTop_20120904.tar.gz # https://epics.anl.gov/extensions/configure/index.php
wget --backups=1 https://ops.aps.anl.gov/downloads/SDDS.${SDDSV}.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
wget --backups=1 https://ops.aps.anl.gov/downloads/oag.apps.configure.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
wget --backups=1 https://ops.aps.anl.gov/downloads/SDDSepics.${SDDSEV}.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
wget --backups=1 https://ops.aps.anl.gov/downloads/elegant.${EV}.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
#wget --backups=1 https://github.com/Reference-LAPACK/lapack/archive/v3.9.0.tar.gz # http://www.netlib.org/lapack/
#wget --backups=1 --no-check-certificate http://www.netlib.org/blas/blas-3.8.0.tgz # http://www.netlib.org/blas/
wget --backups=1 https://ops.aps.anl.gov/downloads/oag.${OAGV}.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
wget --backups=1 https://ops.aps.anl.gov/downloads/defns.rpn # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software

echo "done wget"

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
tar zxf $EBUILD/SDDS.${SDDSV}.tar.gz
cd epics/extensions/configure
make
cd ../src/SDDS/tiff
make
cd ../png
make
cd ..
make
cd python
PYTHON3=1 make
cd ..

echo "done SDDS"

# OAG
cd $EBASE
tar zxf $EBUILD/oag.apps.configure.tar.gz
tar zxf $EBUILD/SDDSepics.${SDDSEV}.tar.gz
tar zxf $EBUILD/elegant.${EV}.tar.gz

####### LAPACK
######cd $EBASE
######tar zxf $EBUILD/v3.9.0.tar.gz
######cd lapack-3.9.0/
######cp make.inc.example make.inc
######make
######cp liblapack.a  librefblas.a  libtmglib.a ../epics/extensions/lib/linux-x86_64/
######echo "done LAPACK"
######
####### BLAS
######cd $EBASE
######tar zxf $EBUILD/blas-3.8.0.tgz
######cd BLAS-3.8.0/
######make
######cp blas_LINUX.a ../epics/extensions/lib/linux-x86_64/libblas.a
######echo "done BLAS"

# OAG Apps
cd $EBASE/oag/apps/configure
echo EPICS_BASE=$EBASE/epics/base >> RELEASE
cd ../src/physics/
make
cd ../xraylib/
make
echo "done OAG Apps"

# Elegant
cd $EBASE/oag/apps/src/elegant
export PATH=$PATH:$EBASE/epics/extensions/bin/linux-x86_64
make
cd elegantTools
make
echo "done elegant"

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
echo "done Pelegant"

# OAG Tcl/Tk
cd $EBASE
tar zxf $EBUILD/oag.${OAGV}.tar.gz
cd oag/apps/src/tcltklib
make
cd ../pem
make
cd ../tcltkinterp/extensions
sed -i -n '/ifeq (\$(EPICS_HOST_ARCH),linux-x86_64)/{:a;N;/endif\nendif/!ba;N;s/.*\n/##REPLACEMENT\nifeq (\$(EPICS_HOST_ARCH),linux-x86_64)\nOAGTCL =\$(notdir \$(wildcard \$(TCL_INCLUDE)\/tcl.h))\nTCL_INC = \$(TCL_INCLUDE)\nTCL_LIB = \$(TCL_LIBRARY)\nendif\n/};p' ca/Makefile
sed -i -n '/ifeq (\$(EPICS_HOST_ARCH),linux-x86_64)/{:a;N;/endif\nendif/!ba;N;s/.*\n/##REPLACEMENT\nifeq (\$(EPICS_HOST_ARCH),linux-x86_64)\nOAGTCL =\$(notdir \$(wildcard \$(TCL_INCLUDE)\/tcl.h))\nTCL_INC = \$(TCL_INCLUDE)\nTCL_LIB = \$(TCL_LIBRARY)\nendif\n/};p' os/Makefile
sed -i -n '/ifeq (\$(EPICS_HOST_ARCH),linux-x86_64)/{:a;N;/endif\nendif/!ba;N;s/.*\n/##REPLACEMENT\nifeq (\$(EPICS_HOST_ARCH),linux-x86_64)\nOAGTCL =\$(notdir \$(wildcard \$(TCL_INCLUDE)\/tcl.h))\nTCL_INC = \$(TCL_INCLUDE)\nTCL_LIB = \$(TCL_LIBRARY)\nendif\n/};p' rpn/Makefile
sed -i -n '/ifeq (\$(EPICS_HOST_ARCH),linux-x86_64)/{:a;N;/endif\nendif/!ba;N;s/.*\n/##REPLACEMENT\nifeq (\$(EPICS_HOST_ARCH),linux-x86_64)\nOAGTCL =\$(notdir \$(wildcard \$(TCL_INCLUDE)\/tcl.h))\nTCL_INC = \$(TCL_INCLUDE)\nTCL_LIB = \$(TCL_LIBRARY)\nendif\n/};p' sdds/Makefile
make
./installExtensions -location ../../../lib/linux-x86_64
echo "done OAG Tcl/Tk"

# Copy defns file to release area
cp $EBUILD/defns.rpn $EBASE

# Configure oag
cd $EBASE/oag/apps/bin/linux-x86_64
ln -s ${TCL_BIN}/tclsh oagtclsh
ln -s ${TCL_BIN}/wish oagwish


echo "done"
# motif: Need to add to start of wmluitok.l
# %option main
# YACC="bison -y" ./configure --prefix=/asdasd
