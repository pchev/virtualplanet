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

# documentation
install -m 755 -d $destdir/share/virtualplanet/doc
install -v -m 644 doc/* $destdir/share/virtualplanet/doc/

# database
install -m 755 -d $destdir/share/virtualplanet/Database
install -v -m 644 Database/Mercury_Named_EN.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Mercury_Named_FR.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Venus_Named_EN.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Mars_Named_EN.csv $destdir/share/virtualplanet/Database/
install -v -m 644 Database/Mars_Named_FR.csv $destdir/share/virtualplanet/Database/

# big data
InstData VPA_Base_JPLeph $destdir
InstData VPA_Base_Texture_Mars $destdir
InstData VPA_Base_Texture_Mercury $destdir
InstData VPA_Base_Texture_Venus $destdir

