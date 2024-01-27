#!/bin/sh

git config --global --add safe.directory '*'
cmake -B build_host
cd build_host
make install
export PATH=$PATH:/opt/xmos/bin
cd ..
cmake -B build --toolchain xmos_cmake_toolchain/xs3a.cmake
cd build
make example_ffd
