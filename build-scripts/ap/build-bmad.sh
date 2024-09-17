#!/bin/bash -e

# https://wiki.classe.cornell.edu/ACC/ACL/OffsiteDoc#DistDownload
# https://github.com/bmad-sim/bmad-ecosystem/releases

module purge
#module load accelerator/path gcc/9.3.0 mpich/3.3.2-gcc-9.3.0 python/3.9.1 cmake/3.19.3 ncurses/6.2 hdf5/1.12.0
module load accelerator/path gcc/9.3.0 python/3.9.1 cmake/3.19.3 ncurses/6.2


# new setup from github
#ver=20231010-0
ver=20231221-0
ver=20231223-0



mkdir -pv /nsls2/software/ap/bmad/
cd /nsls2/software/ap/bmad/

wget --backups=1 https://github.com/bmad-sim/bmad-ecosystem/releases/download/${ver}/bmad_dist.tar.gz
tar zxf bmad_dist.tar.gz
cd bmad_dist_${ver}
export DIST_BASE_DIR=`pwd`
#export ACC_ROOT_DIR=`pwd`
### edit util/dist_source_me, add echo hi in last line of func: func_echo_fortran
source ${DIST_BASE_DIR}/util/dist_source_me || echo asdasd
echo "after sourceme 0"
ulimit -S -c 0
ulimit -S -s 10240 # Remove this line when using a Mac
ulimit -d unlimited


sed -i 's/ping -c.*/echo hi\\/' util/acc_build_common

mv util/dist_prefs util/dist_prefs.orig
cat <<EOF > util/dist_prefs
export DIST_F90_REQUEST="gfortran"
export ACC_PLOT_PACKAGE="plplot"
export ACC_PLOT_DISPLAY_TYPE="X"
export ACC_ENABLE_OPENMP="Y"
export ACC_ENABLE_MPI="Y"
export ACC_FORCE_BUILTIN_MPI="N"
export ACC_ENABLE_GFORTRAN_OPTIMIZATION="Y"
export ACC_ENABLE_SHARED="Y"
export ACC_ENABLE_SHARED_ONLY="N"
export ACC_ENABLE_FPIC="Y"
export ACC_ENABLE_PROFILING="N"
export ACC_SET_GMAKE_JOBS="48"
export ACC_CONDA_BUILD="N"
export ACC_CONDA_PATH="${CONDA_PREFIX}"
export ACC_USE_MACPORTS="N"
EOF
echo "moving along"

source ${DIST_BASE_DIR}/util/dist_source_me || echo asdasd
echo "after sourceme 1"
#export DIST_UTIL=`pwd`/util
./util/dist_build_production
echo "after build production"
source ${DIST_BASE_DIR}/util/dist_source_me || echo asdasd
./util/dist_build_debug
echo "after build debug"

cd $DIST_BASE_DIR
source ${DIST_BASE_DIR}/util/dist_source_me || echo asdasd
git clone https://github.com/bmad-sim/pytao.git
cd pytao
python setup.py install --prefix=$DIST_BASE_DIR/tao/python

echo "done"
