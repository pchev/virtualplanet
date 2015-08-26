#!/bin/bash

# install the software

destdir=$1

if [ -z "$destdir" ]; then
   export destdir=/tmp/virtualplanet
fi

echo Install virtualplanet to $destdir

# software
install -m 755 -d $destdir
install -m 755 -d $destdir/virtualplanet.app
install -m 755 -d $destdir/virtualplanet.app/Contents
install -m 755 -d $destdir/virtualplanet.app/Contents/MacOS
install -m 755 -d $destdir/virtualplanet.app/Contents/Resources
install -v -m 644 Installer/Mac/virtualplanet/virtualplanet.app/Contents/Info.plist $destdir/virtualplanet.app/Contents/
install -v -m 644 Installer/Mac/virtualplanet/virtualplanet.app/Contents/PkgInfo $destdir/virtualplanet.app/Contents/
install -v -m 644 Installer/Mac/virtualplanet/virtualplanet.app/Contents/Resources/virtualplanet.icns $destdir/virtualplanet.app/Contents/Resources/

install -v -m 755 -s vpa/vpa  $destdir/virtualplanet.app/Contents/MacOS/virtualplanet
install -v -m 755 vpa/library/plan404/libplan404.dylib  $destdir/libplan404.dylib
install -v -m 644 Installer/Mac/virtualplanet/licence.txt $destdir/
install -v -m 644 Installer/Mac/virtualplanet/readme.txt $destdir/

# translation
install -m 755 -d $destdir/language
install -v -m 644 vpa/language/vpa.en.po $destdir/language/
install -v -m 644 vpa/language/vpa.fr.po $destdir/language/

install -m 755 -d $destdir/data
install -v -m 644 data/country.tab $destdir/data/
install -v -m 644 data/retic.cur $destdir/data/


