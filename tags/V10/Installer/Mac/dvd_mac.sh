#!/bin/bash

mkdir tmp
cp -a virtualplanet*.pkg tmp/
cp /Users/pch/sources/vpa/Installer/Mac/DVD/* tmp/

hdiutil create -anyowners -volname virtualplanet-1.0-macosx -format UDTO -srcfolder ./tmp virtualplanet-1.0-macosx.cdr
hdiutil makehybrid -o virtualplanet-1.0-macosx.iso virtualplanet-1.0-macosx.cdr -iso -joliet   

#rm -rf tmp
