#!/bin/bash

mkdir tmp
cp virtualplanet*windows.exe tmp/
cp /home/pch/src/vpa/build/Installer/Windows/DVD/* tmp/

mkisofs -R -r -l -J -quiet -Vvirtualplanet -ovirtualplanet-1.0-windows.iso tmp

#rm -rf tmp
