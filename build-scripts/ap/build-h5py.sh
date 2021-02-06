#!/bin/bash -e

pyver=3.9.1

# h5py - parallel version: https://docs.h5py.org/en/stable/mpi.html
# https://pypi.org/project/h5py/
module load accelerator/path gcc/9.3.0 python/$pyver mpich/3.3.2-gcc-9.3.0 hdf5/1.12.0
mkdir -pv /nsls2/software/ap/hdf5/build/h5py
cd /nsls2/software/ap/hdf5/build/h5py
#wget https://files.pythonhosted.org/packages/a7/81/20d5d994c91ed8347efda90d32c396ea28254fd8eb9e071e28ee5700ffd5/h5py-3.1.0.tar.gz
rm -rf h5py-3.1.0
tar zxf h5py-3.1.0.tar.gz
cd h5py-3.1.0
export CC=mpicc
export HDF5_MPI="ON"
export HDF5_DIR=$HDF5ROOT
pip install .
