#!/bin/bash

# install data
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

echo Install virtualplanet data3 to $destdir

install -m 755 -d $destdir

# big data
InstData VPA_Ext_Texture_Mercury $destdir 
InstData VPA_Ext_Texture_Venus $destdir
InstData VPA_Ext_Texture_Mars $destdir
InstData VPA_Ext_Texture_Mars_Shaded $destdir
