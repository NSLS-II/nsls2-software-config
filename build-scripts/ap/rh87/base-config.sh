#!/bin/bash -e

SW=/nsls2/software/ap/rh87

module prepend-path MODULEPATH ${SW}/modulefiles

fetch="curl -O -L"
#export ALL_PROXY=socks5://localhost:9999
export ftp_proxy="http://proxy.sdcc.bnl.local:3128"
export http_proxy="http://proxy.sdcc.bnl.local:3128"
export https_proxy="http://proxy.sdcc.bnl.local:3128"


