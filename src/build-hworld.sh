#!/bin/bash
echo "building hworld in $1"
pushd $1
g++ hworld.cpp -o hworldoutput_1 -x 'none'
tar -czvf output.tar.gz hworldoutput_1
mkdir ../build
cp ./output.tar.gz ../build/
echo "build completed"
