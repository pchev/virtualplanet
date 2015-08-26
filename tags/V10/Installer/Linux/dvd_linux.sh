#!/bin/bash

cd /data/transfert/vpa_release/1.0

mkdir tmp
mkdir tmp/DEB
mkdir tmp/RPM

cp virtualplanet*deb tmp/DEB/
cp virtualplanet*rpm tmp/RPM/
cp /home/pch/src/vpa/Installer/Linux/DVD/* tmp/

mkisofs -R -r -l -J -quiet -Vvirtualplanet -ovirtualplanet-1.0-linux.iso tmp

rm -rf tmp
