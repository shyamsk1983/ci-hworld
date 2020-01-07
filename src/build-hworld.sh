#!/bin/bash
echo "building hworld in $1"
pushd $1
echo "compiling using g++"
g++ hworld.cpp -o hworldoutput_1 -x 'none'
echo "zipping output"
tar -czvf output.tar.gz hworldoutput_1
echo "make build folder"
mkdir $1/build
echo "copy output.tar.gz to build folder"
cp ./output.tar.gz $1/build/
echo "build-hworld.sh completed"
