#!/bin/bash -e

# https://geant4-userdoc.web.cern.ch/UsersGuides/InstallationGuide/html/installguide.html
# https://github.com/Geant4/geant4/releases

VER=11.1
PAT=0
#printf -v PAT "p%02d" $PATN
TAR=v${VER}.${PAT}.tar.gz


BASEDIR=/nsls2/software/ap/geant4
SRCDIR=${BASEDIR}/build/geant4-${VER}.${PAT}
BUILDDIR=${BASEDIR}/build/geant4-${VER}.${PAT}-build
DEST=${BASEDIR}/${VER}.${PAT}

module purge
module load accelerator/path gcc/9.3.0 cmake/3.19.3 python/3.9.1 mpich/3.3.2-gcc-9.3.0


mkdir -pv ${BASEDIR}/build
cd ${BASEDIR}/build
wget https://github.com/Geant4/geant4/archive/refs/tags/${TAR}
tar zxf ${TAR}
mkdir ${BUILDDIR}
cd ${BUILDDIR}


echo "SRCDIR ${SRCDIR}"
echo "BUILDDIR ${BUILDDIR}"
echo "DEST ${DEST}"

cmake -DCMAKE_INSTALL_PREFIX=${DEST} ${SRCDIR}
cmake -DGEANT4_INSTALL_DATA=ON .

make -j8
make install
