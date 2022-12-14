#!/bin/bash

# install minimal data for the basic version
# must be installed after the software part

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

destdir=$1

if [ -z "$destdir" ]; then
   export destdir=/tmp/virtualplanet
fi

echo Install virtualplanet data to $destdir

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
InstData VPA_Base_JPLeph $destdir
InstData VPA_Base_Texture_Mars $destdir
InstData VPA_Base_Texture_Mercury $destdir
InstData VPA_Base_Texture_Venus $destdir
InstData VPA_Base_Texture_Jupiter $destdir
InstData VPA_Base_Texture_Io $destdir
InstData VPA_Base_Texture_Ganymede $destdir
InstData VPA_Base_Texture_Europa $destdir
InstData VPA_Base_Texture_Callisto $destdir
