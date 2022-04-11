#!/bin/bash -e

# Better get someone to get/get this for you:
# git clone https://gitlab.cern.ch/IRIS/IW2D.git

module load accelerator/path gcc/9.3.0

VER=2021.10.06

BDIR=/nsls2/software/ap/IW2D/build
IDIR=/nsls2/software/ap/IW2D/${VER}
EXTLIBDIR=/nsls2/software/ap/IW2D/${VER}/extlib

mkdir -pv ${BDIR}
cd ${BDIR}



GMPVER=6.2.1

cd ${BDIR}
wget https://gmplib.org/download/gmp/gmp-${GMPVER}.tar.xz
tar xf gmp-${GMPVER}.tar.xz
cd gmp-${GMPVER}
./configure --prefix=${EXTLIBDIR}
make -j
make install



MPFRVER=4.1.0

cd ${BDIR}
wget https://www.mpfr.org/mpfr-current/mpfr-${MPFRVER}.tar.xz
tar xf mpfr-${MPFRVER}.tar.xz
cd mpfr-${MPFRVER}
./configure --prefix=${EXTLIBDIR} --with-gmp-lib=${EXTLIBDIR} --with-gmp-include=${EXTLIBDIR} --disable-thread-safe
make -j
make install


mkdir -pv ${EXTLIBDIR}/ALGLIB
cd ${EXTLIBDIR}/ALGLIB
wget https://www.alglib.net/translator/re/alglib-2.6.0.mpfr.zip
unzip alglib-2.6.0.mpfr.zip
cd mpfr
chmod +x build
./build gcc "-fPIC"


cd ${IDIR}
unzip ~dhidas/software/IW2D_mirror-master.zip
cd IW2D_mirror-master/ImpedanceWake2D
cp Makefile_local_GMP_MPFR Makefile
make -f Makefile \
  PATH_ALGLIB=${EXTLIBDIR}/ALGLIB/mpfr/out \
  PATH_GMP=${EXTLIBDIR} \
  PATH_MPFR=${EXTLIBDIR} \
  PATH_GMP_LIB=${EXTLIBDIR}/lib \
  PATH_GMP_INC=${EXTLIBDIR}/include \
  PATH_MPFR_LIB=${EXTLIBDIR}/lib \
  PATH_MPFR_INC=${EXTLIBDIR}/include

