#!/bin/bash

# install data
# must be installed after the software and data part

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

echo Install virtualplanet data2 to $destdir

install -m 755 -d $destdir

# big data
InstData VPA_Ext_Texture_Mercury $destdir 
InstData VPA_Ext_Texture_Venus $destdir
InstData VPA_Ext_Texture_Mars $destdir
InstData VPA_Ext_Texture_Mars_Shaded $destdir
