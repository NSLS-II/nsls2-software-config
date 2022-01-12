#!/bin/bash -e

ver=3.10.0

# Python $ver
# Needs ncurses built correctly, a bit painful to figure out

module load accelerator/path gcc/9.3.0 ncurses/6.2 mpich/3.3.2-gcc-9.3.0 openssl/1.1.1l
mkdir -pv /nsls2/software/ap/python/build
cd /nsls2/software/ap/python/build
rm -f Python-$ver.tgz
wget https://www.python.org/ftp/python/$ver/Python-$ver.tgz
tar zxf Python-$ver.tgz
sed -i '/# socket line above, and edit the OPENSSL variable:/a OPENSSL='"${OPENSSL_DIR}"'\n_ssl _ssl.c -I$(OPENSSL)/include -L$(OPENSSL)/lib -l:libssl.a -Wl,--exclude-libs,libssl.a -l:libcrypto.a -Wl,--exclude-libs,libcrypto.a' Python-$ver/Modules/Setup
mkdir python-$ver-gcc-9.3.0
cd python-$ver-gcc-9.3.0
../Python-$ver/configure --prefix=/nsls2/software/ap/python/$ver --with-openssl=${OPENSSL_DIR} --enable-shared --enable-optimizations
make -j > m.o
make install
cd /nsls2/software/ap/python/$ver/bin
ln -s python3 python
ln -s pip3 pip
yes | LD_LIBRARY_PATH=/nsls2/software/ap/python/$ver/lib ./pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org pip wheel setuptools --upgrade
yes | LD_LIBRARY_PATH=/nsls2/software/ap/python/$ver/lib ./pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org numpy scipy matplotlib mpi4py Cython ipython jupyter ninja meson jupyterhub sudospawner PyQt5 argos
