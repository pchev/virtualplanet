#!/bin/bash

cd /Users/pch/src/vpa
mkdir mnt tmp

hdiutil attach -mountpoint mnt PRO/virtualplanet*.dmg
cp -a mnt/* tmp/
hdiutil detach mnt
hdiutil attach -mountpoint mnt EXT/virtualplanet*.dmg
cp -a mnt/* tmp/
hdiutil detach mnt

cp Installer/Mac/DVD/* tmp/

hdiutil create -anyowners -volname virtualplanet-1.0-macosx -format UDTO -srcfolder ./tmp virtualplanet-1.0-macosx.cdr
hdiutil makehybrid -o virtualplanet-1.0-macosx.iso virtualplanet-1.0-macosx.cdr -iso -joliet   

rm virtualplanet-1.0-macosx.cdr
rmdir mnt
rm -rf tmp
