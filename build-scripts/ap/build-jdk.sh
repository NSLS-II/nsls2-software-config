#!/bin/bash -e

# Builds of jdk, or more accurately, downloads
# These include some direct download links that may or may not
# work forever.

# jdk
# https://www.oracle.com/java/technologies/javase-jdk15-downloads.html
mkdir -pv /nsls2/software/ap/jdk/build
cd /nsls2/software/ap/jdk/build
wget -c --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/15.0.2%2B7/0d1cfde4252546c6931946de8db48ee2/jdk-15.0.2_linux-x64_bin.tar.gz
tar zxf jdk-15.0.2_linux-x64_bin.tar.gz
mv jdk-15.0.2 ../15.0.2
wget -c --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie"  https://download.oracle.com/otn-pub/java/jdk/8u281-b09/89d678f2be164786b292527658ca1605/jdk-8u281-linux-x64.tar.gz
tar zxf jdk-8u281-linux-x64.tar.gz
mv jdk1.8.0_281/ ../1.8.0_281
