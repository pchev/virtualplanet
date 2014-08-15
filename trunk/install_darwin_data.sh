#!/bin/bash

# install minimal data for the basic version
# must be installed after the software part

function InstData {
  pkg=$1.tgz
  ddir=$2
  tmpdir=$(mktemp -d -t tmp)
  pkgz=BaseData/$pkg
  if [ ! -e $pkgz ]; then
     curl -L -o $pkgz http://sourceforge.net/projects/virtualplanet/files/9-Source_Data/$pkg/download
  fi
  tar xvzf $pkgz -C $tmpdir
  cp -R -p $tmpdir/share/virtualplanet/* $ddir/
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
install -m 755 -d $destdir
install -m 755 -d $destdir/doc
install -v -m 644 doc/* $destdir/doc/


# database
install -m 755 -d $destdir/Database
install -v -m 644 Database/Mercury_Named_EN.csv $destdir/Database/
install -v -m 644 Database/Mercury_Named_FR.csv $destdir/Database/
install -v -m 644 Database/Venus_Named_EN.csv $destdir/Database/
install -v -m 644 Database/Mars_Named_EN.csv $destdir/Database/


# big data
InstData VPA_Base_JPLeph $destdir
InstData VPA_Base_Texture_Mars $destdir
InstData VPA_Base_Texture_Mars_Historical $destdir
InstData VPA_Base_Texture_Mercury $destdir
InstData VPA_Base_Texture_Mercury_Historical $destdir
InstData VPA_Base_Texture_Venus $destdir
