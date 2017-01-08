#!/bin/bash

cd /data/transfert/vpa_release/2.0

mkdir tmp
cp Windows/virtualplanet*windows.exe tmp/
cp /home/pch/src/vpa/Installer/Windows/DVD/* tmp/

mkisofs -R -r -l -J -quiet -Vvirtualplanet -ovirtualplanet-2.0-windows.iso tmp

rm -rf tmp
