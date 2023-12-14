#!/bin/bash -e

# Get the location of zip file from someone in email or the web.

module purge
module load accelerator/path gcc/9.3.0

NAME=ECHO3D_v1_4      LOCAL=true
#NAME=ECHO3D_beta03    LOCAL=false
#NAME=ECHO3D_beta04    LOCAL=false
mkdir -pv /nsls2/software/ap/echo3d/build
cd /nsls2/software/ap/echo3d/build

if [[ "$LOCAL" = true ]]
then
  unzip ~/software/${NAME}.zip
else
  wget https://www.desy.de/fel-beam/s2e/data/${NAME}.zip
  unzip ${NAME}.zip
fi

VER=`echo '' | ./${NAME}/Codes/Linux_Intel/ECHO3D | head -1 | grep -oP 'ver \K\d+.\d+.\d+'`
echo "installing version ${VER}"
mv ${NAME} /nsls2/software/ap/echo3d/${VER}
rm -rf __MACOSX
