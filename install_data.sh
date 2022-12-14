#!/bin/bash

# install minimal data for the basic version
# must be installed after the software part

function InstData {
  pkg=$1.tgz
  ddir=$2
  pkgz=BaseData/$pkg
  if [ ! -e $pkgz ]; then
     wget http://sourceforge.net/projects/virtualplanet/files/9-Source_Data/$pkg/download -O $pkgz
  fi
  tar xvzf $pkgz -C $ddir
}

destdir=$1

if [ -z "$destdir" ]; then
   export destdir=/tmp/virtualplanet
fi

echo Install virtualplanet data to $destdir

install -m 755 -d $destdir
install -m 755 -d $destdir/share
install -m 755 -d $destdir/share/virtualplanet

# translation
install -m 755 -d $destdir/share/virtualplanet/language
install -v -m 644 vpa/language/vpa.en.po $destdir/share/virtualplanet/language/
install -v -m 644 vpa/language/vpa.fr.po $destdir/share/virtualplanet/language/

install -m 755 -d $destdir/share/virtualplanet/data
install -v -m 644 data/country.tab $destdir/share/virtualplanet/data/
install -v -m 644 data/retic.cur $destdir/share/virtualplanet/data/

# documentation
install -m 755 -d $destdir/share/virtualplanet/doc
install -v -m 644 doc/* $destdir/share/virtualplanet/doc/

# database
install -m 755 -d $destdir/share/virtualplanet/Database
install -v -m 644 Database/Mercury_Named_EN.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Mercury_Named_FR.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Venus_Named_EN.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Venus_Named_FR.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Mars_Named_EN.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Mars_Named_FR.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Jupiter_Named_EN.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Jupiter_Named_FR.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Io_Named_EN.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Io_Named_FR.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Ganymede_Named_EN.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Ganymede_Named_FR.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Europa_Named_EN.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Europa_Named_FR.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Callisto_Named_EN.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Callisto_Named_FR.csv $destdir/share/virtualplanet/Database/

# big data
InstData VPA_Base_JPLeph $destdir
InstData VPA_Base_Texture_Mars $destdir
InstData VPA_Base_Texture_Mercury $destdir
InstData VPA_Base_Texture_Venus $destdir
InstData VPA_Base_Texture_Jupiter $destdir
InstData VPA_Base_Texture_Io $destdir
InstData VPA_Base_Texture_Ganymede $destdir
InstData VPA_Base_Texture_Europa $destdir
InstData VPA_Base_Texture_Callisto $destdir

