#!/bin/bash -e

fetch='curl -L -x socks5h://0:9999 -O'
http_proxy=https://relay.nsls2.bnl.local:3128
https_proxy=https://relay.nsls2.bnl.local:3128

# This one taken from rpm

# nedit
# https://pkgs.org/download/nedit
mkdir -pv /nsls2/software/ap/saturn/nedit/build
cd /nsls2/software/ap/saturn/nedit/build
${fetch} https://download-ib01.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/n/nedit-5.7-7.el8.x86_64.rpm
rpm2cpio nedit-5.7-7.el8.x86_64.rpm | cpio -idmv
mkdir ../5.7-7
mv usr/* ../5.7-7/
rmdir usr

