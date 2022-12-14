#!/bin/bash

# install the software 

OS_TARGET=$1
destdir=$2

if [ -z "$OS_TARGET" ]; then
   export OS_TARGET=win32
fi

if [ -z "$destdir" ]; then
   export destdir=/tmp/virtualplanet
fi

echo Install virtualplanet $OS_TARGET to $destdir

# software
install -m 755 -d $destdir
if [ $OS_TARGET = win32 ]; then
  i386-win32-strip -v -o $destdir/virtualplanet.exe vpa/vpa.exe 
  install -v -m 644 vpa/library/plan404/libplan404.dll  $destdir/
  unzip -d $destdir Installer/Windows/Data/sqlite3.zip
fi
if [ $OS_TARGET = win64 ]; then
  x86_64-win64-strip -v -o $destdir/virtualplanet.exe vpa/vpa.exe 
  install -v -m 644 vpa/library/plan404/libplan404_x64.dll  $destdir/libplan404.dll
  unzip -d $destdir Installer/Windows/Data/sqlite3_x64.zip
fi
install -v -m 644 Installer/Windows/Data/readme.txt $destdir/
install -v -m 644 Installer/Windows/Data/lisezmoi.txt $destdir/
install -v -m 644 Installer/Windows/Data/licence.txt $destdir/
install -v -m 644 Installer/Windows/Data/licence_fr.txt $destdir/

# translation
install -m 755 -d $destdir/language
install -v -m 644 vpa/language/vpa.en.po $destdir/language/
install -v -m 644 vpa/language/vpa.fr.po $destdir/language/

install -m 755 -d $destdir/data
install -v -m 644 data/country.tab $destdir/data/
install -v -m 644 data/retic.cur $destdir/data/
cp -a  data/zoneinfo $destdir/data/


