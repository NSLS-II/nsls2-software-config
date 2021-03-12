#!/bin/bash -e

# apache ant
# https://ant.apache.org/manual/install.html
module load accelerator/path gcc/9.3.0 jdk/1.8.0_281
mkdir -pv /nsls2/software/ap/apache-ant/build
cd /nsls2/software/ap/apache-ant/build
wget https://mirrors.ocf.berkeley.edu/apache//ant/source/apache-ant-1.10.9-src.tar.gz
tar zxf apache-ant-1.10.9-src.tar.gz
cd apache-ant-1.10.9
sh build.sh -Ddist.dir=/nsls2/software/ap/apache-ant/1.10.9 dist
