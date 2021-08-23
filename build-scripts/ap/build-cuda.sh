mkdir -pv /nsls2/software/ap/cuda/build/
chgrp -R nsls2software /nsls2/software/ap/cuda/build/
cd /nsls2/software/ap/cuda/build/
chmod +x cuda_11.4.1_470.57.02_linux.run
module purger
module load accelerator/path gcc/9.3.0
srun --cpus-per-task=44 --gres=gpu:2 --qos=long -t 500 --x11 ./cuda_11.4.1_470.57.02_linux.run --silent --toolkit --toolkitpath=/nsls2/software/ap/cuda/11.4.1 --defaultroot=/nsls2/software/ap/cuda/11.4.1
