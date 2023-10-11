#!/bin/bash -e

# Might be useful: https://www3.aps.anl.gov/forums/elegant/viewtopic.php?t=891

source base-config.sh

module purge

MPIF=mpich
MPIV=4.0.3
GCCV=10.4.0

module purge
module load gcc/${GCCV} ${MPIF}/${MPIV} perl/5.36.0 python/3.11.1


#export EV=2022.2.0 SDDSV=5.3 SDDSEV=5.2 OAGV=1.27.1
#export EV=2023.1.0 SDDSV=5.3 SDDSEV=5.2 OAGV=1.27.1
#export EV=2023.2.0 SDDSV=5.4 SDDSEV=5.4 OAGV=1.28
export EV=2023.3.0 SDDSV=5.5 SDDSEV=5.4 OAGV=1.28
export BASE=${SW}
export EBASE=${BASE}/elegant/$EV-gcc-${GCCV}-${MPIF}-${MPIV}
export EBUILD=${BASE}/elegant/build/$EV

# Make build dir and download all needed files to it
mkdir -pv $EBUILD
cd $EBUILD
$fetch https://epics.anl.gov/download/base/baseR3.14.12.8.tar.gz # https://epics.anl.gov/download/base/index.php
$fetch https://ops.aps.anl.gov/downloads/elegant.${EV}.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
$fetch https://epics.anl.gov/download/extensions/extensionsTop_20120904.tar.gz # https://epics.anl.gov/extensions/configure/index.php
$fetch https://ops.aps.anl.gov/downloads/SDDS.${SDDSV}.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
$fetch https://ops.aps.anl.gov/downloads/oag.apps.configure.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
$fetch https://ops.aps.anl.gov/downloads/SDDSepics.${SDDSEV}.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
$fetch https://ops.aps.anl.gov/downloads/elegant.${EV}.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
$fetch https://github.com/Reference-LAPACK/lapack/archive/refs/tags/v3.9.0.tar.gz # http://www.netlib.org/lapack/
$fetch -k http://www.netlib.org/blas/blas-3.8.0.tgz # http://www.netlib.org/blas/
$fetch https://ops.aps.anl.gov/downloads/oag.${OAGV}.tar.gz # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
$fetch https://ops.aps.anl.gov/downloads/defns.rpn # https://www.aps.anl.gov/Accelerator-Operations-Physics/Software
$fetch https://ops.aps.anl.gov/downloads/elegantExamples.tar.gz

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


## LAPACK
#ulimit -s unlimited
#cd $EBASE
#tar zxf $EBUILD/v3.9.0.tar.gz
#cd lapack-3.9.0/
#cp make.inc.example make.inc
#make -j
#cd CBLAS
#make -j
#cd ..
#cp *.a  ../epics/extensions/lib/linux-x86_64/
#cp LAPACKE/include/*h CBLAS/include/cblas.h ../epics/extensions/include
#echo "done LAPACK"
#
## BLAS
#cd $EBASE
#tar zxf $EBUILD/blas-3.8.0.tgz
#cd BLAS-3.8.0/
#make
#cp blas_LINUX.a ../epics/extensions/lib/linux-x86_64/libblas.a
#echo "done BLAS"




# Modify makefiles to see special GSL libs
cd $EBASE/epics/extensions/src/SDDS
echo 'PROD_SYS_LIBS += tirpc' >> SDDSaps/Makefile

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
#sed -i '/^SYSGSL =.*/a $(GSL_DIR)/lib/libgsl.a \\\n$(GSL_DIR)/lib/libgsl.so \\' Makefile.OAG
#sed -i '/^SYSGSL =.*/a $(GSL_DIR)/lib/libgsl.a \\\n$(GSL_DIR)/lib/libgsl.so \\' elegantTools/Makefile.OAG
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
#sed -i -n '/ifeq (\$(EPICS_HOST_ARCH),linux-x86_64)/{:a;N;/endif\nendif/!ba;N;s/.*\n/##REPLACEMENT\nifeq (\$(EPICS_HOST_ARCH),linux-x86_64)\nOAGTCL =\$(notdir \$(wildcard \$(TCL_INCLUDE)\/tcl.h))\nTCL_INC = \$(TCL_INCLUDE)\nTCL_LIB = \$(TCL_LIBRARY)\nendif\n/};p' ca/Makefile
#sed -i -n '/ifeq (\$(EPICS_HOST_ARCH),linux-x86_64)/{:a;N;/endif\nendif/!ba;N;s/.*\n/##REPLACEMENT\nifeq (\$(EPICS_HOST_ARCH),linux-x86_64)\nOAGTCL =\$(notdir \$(wildcard \$(TCL_INCLUDE)\/tcl.h))\nTCL_INC = \$(TCL_INCLUDE)\nTCL_LIB = \$(TCL_LIBRARY)\nendif\n/};p' os/Makefile
#sed -i -n '/ifeq (\$(EPICS_HOST_ARCH),linux-x86_64)/{:a;N;/endif\nendif/!ba;N;s/.*\n/##REPLACEMENT\nifeq (\$(EPICS_HOST_ARCH),linux-x86_64)\nOAGTCL =\$(notdir \$(wildcard \$(TCL_INCLUDE)\/tcl.h))\nTCL_INC = \$(TCL_INCLUDE)\nTCL_LIB = \$(TCL_LIBRARY)\nendif\n/};p' rpn/Makefile
#sed -i -n '/ifeq (\$(EPICS_HOST_ARCH),linux-x86_64)/{:a;N;/endif\nendif/!ba;N;s/.*\n/##REPLACEMENT\nifeq (\$(EPICS_HOST_ARCH),linux-x86_64)\nOAGTCL =\$(notdir \$(wildcard \$(TCL_INCLUDE)\/tcl.h))\nTCL_INC = \$(TCL_INCLUDE)\nTCL_LIB = \$(TCL_LIBRARY)\nendif\n/};p' sdds/Makefile
make
./installExtensions -location ../../../lib/linux-x86_64
echo "done OAG Tcl/Tk"

# Copy defns file to release area
cp $EBUILD/defns.rpn $EBASE

# Configure oag
cd $EBASE/oag/apps/bin/linux-x86_64
ln -s ${TCL_BIN}/tclsh oagtclsh
ln -s ${TCL_BIN}/wish oagwish


# copy examples
cd $EBASE
tar zxf $EBUILD/elegantExamples.tar.gz


echo "done"
# motif: Need to add to start of wmluitok.l
# %option main
# YACC="bison -y" ./configure --prefix=/asdasd
