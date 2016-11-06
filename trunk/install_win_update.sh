#!/bin/bash

# install upgrade from V1 to V2 for windows

function InstData {
  pkg=$1.tgz
  ddir=$2
  tmpdir=$(mktemp -d)
  pkgz=BaseData/$pkg
  if [ ! -e $pkgz ]; then
     wget http://sourceforge.net/projects/virtualplanet/files/9-Source_Data/$pkg/download -O $pkgz
  fi
  tar xvzf $pkgz -C $tmpdir
  cp -a $tmpdir/share/virtualplanet/* $ddir/
  rm -rf $tmpdir/share/virtualplanet/*
  rmdir $tmpdir/share/virtualplanet
  rmdir $tmpdir/share
  rmdir $tmpdir
}


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

# documentation
install -m 755 -d $destdir/doc
install -v -m 644 doc/* $destdir/doc/

install -m 755 -d $destdir
install -m 755 -d $destdir/Database
install -v -m 644 Database/Mercury_Named_EN.csv $destdir/Database/
install -v -m 644 Database/Mercury_Named_FR.csv $destdir/Database/
install -v -m 644 Database/Venus_Named_EN.csv $destdir/Database/
install -v -m 644 Database/Venus_Named_FR.csv $destdir/Database/
install -v -m 644 Database/Mars_Named_EN.csv $destdir/Database/
install -v -m 644 Database/Mars_Named_FR.csv $destdir/Database/
install -v -m 644 Database/Jupiter_Named_EN.csv $destdir/Database/
install -v -m 644 Database/Jupiter_Named_FR.csv $destdir/Database/
install -v -m 644 Database/Io_Named_EN.csv $destdir/Database/
install -v -m 644 Database/Io_Named_FR.csv $destdir/Database/
install -v -m 644 Database/Ganymede_Named_EN.csv $destdir/Database/
install -v -m 644 Database/Ganymede_Named_FR.csv $destdir/Database/
install -v -m 644 Database/Europa_Named_EN.csv $destdir/Database/
install -v -m 644 Database/Europa_Named_FR.csv $destdir/Database/
install -v -m 644 Database/Callisto_Named_EN.csv $destdir/Database/
install -v -m 644 Database/Callisto_Named_FR.csv $destdir/Database/

# big data
#InstData VPA_Base_JPLeph $destdir
#InstData VPA_Base_Texture_Mars $destdir
#InstData VPA_Base_Texture_Mercury $destdir
#InstData VPA_Base_Texture_Venus $destdir
InstData VPA_Base_Texture_Jupiter $destdir
InstData VPA_Base_Texture_Io $destdir
InstData VPA_Base_Texture_Ganymede $destdir
InstData VPA_Base_Texture_Europa $destdir
InstData VPA_Base_Texture_Callisto $destdir

InstData VPA_Base_Overlay $destdir
#InstData VPA_Base_Texture_Mars_Historical $destdir
#InstData VPA_Base_Texture_Mercury_Historical $destdir
InstData VPA_Base_Texture_Jupiter_Historical $destdir
InstData VPA_Base_Texture_Io_Historical $destdir
InstData VPA_Base_Texture_Europa_Historical $destdir
InstData VPA_Base_Texture_Ganymede_Historical $destdir
InstData VPA_Base_Texture_Callisto_Historical $destdir

#InstData VPA_Ext_Texture_Mercury $destdir 
#InstData VPA_Ext_Texture_Venus $destdir
#InstData VPA_Ext_Texture_Mars $destdir
InstData VPA_Ext_Texture_Mars_Shaded $destdir
InstData VPA_Ext_Texture_Mercury_LowIncidence $destdir 

