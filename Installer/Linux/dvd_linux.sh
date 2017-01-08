#!/bin/bash

cd /data/transfert/vpa_release/2.0

mkdir tmp
mkdir tmp/DEB
mkdir tmp/RPM

cp Linux/deb/virtualplanet*deb tmp/DEB/
cp Linux/rpm/virtualplanet*rpm tmp/RPM/
cp /home/pch/src/vpa/Installer/Linux/DVD/* tmp/

mkisofs -R -r -l -J -quiet -Vvirtualplanet -ovirtualplanet-2.0-linux.iso tmp

rm -rf tmp
