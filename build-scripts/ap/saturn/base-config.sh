#!/bin/bash -e

module prepend-path MODULEPATH /home/software/modulefiles
fetch="curl -x socks5h://0:9999 -O -L"
export http_proxy=socks5://localhost:9999
export https_proxy=socks5://localhost:9999
export ALL_PROXY=socks5://localhost:9999

SW=/home/software
