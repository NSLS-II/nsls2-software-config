module purge
module load accelerator/path gcc/9.3.0 cuda/11.4.1 openmpi/3.1.6-gcc-9.3.0 cmake/3.19.3
mkdir -pv /nsls2/software/ap/gromacs-swaxs/build
chgrp -R nsls2software /nsls2/software/ap/gromacs-swaxs
cd /nsls2/software/ap/gromacs-swaxs/build
git clone https://gitlab.com/cbjh/gromacs-swaxs.git gromacs-swaxs


cmake -j $(nproc) -DGMX_BUILD_OWN_FFTW=ON -DGMX_SIMD=AVX2_256 -DCMAKE_INSTALL_PREFIX=/nsls2/software/ap/gromacs-swaxs/2021.08.23 -DGMX_MPI=ON -DGMX_GPU=cuda -S "gromacs-swaxs" -B "gromacs-swaxs-build"
cmake --build "gromacs-swaxs-build" --target install -j $(nproc)
