#!/bin/bash

mkdir tmp
mkdir tmp/DEB
mkdir tmp/RPM

cp virtualplanet*deb tmp/DEB/
cp virtualplanet*rpm tmp/RPM/
cp /home/pch/src/vpa/build/Installer/Linux/DVD/* tmp/

mkisofs -R -r -l -J -quiet -Vvirtualplanet -ovirtualplanet-1.0-linux.iso tmp

rm -rf tmp
