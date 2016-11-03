#!/bin/bash

# install data 
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

echo Install virtualplanet data2 to $destdir

install -m 755 -d $destdir
install -m 755 -d $destdir/share
install -m 755 -d $destdir/share/virtualplanet


# big data
#InstData VPA_Base_Bumpmap $destdir
InstData VPA_Base_Overlay $destdir
InstData VPA_Base_Texture_Mars_Historical $destdir
InstData VPA_Base_Texture_Mercury_Historical $destdir
InstData VPA_Base_Texture_Jupiter_Historical $destdir
InstData VPA_Base_Texture_Io_Historical $destdir
InstData VPA_Base_Texture_Europa_Historical $destdir
InstData VPA_Base_Texture_Ganymede_Historical $destdir
InstData VPA_Base_Texture_Callisto_Historical $destdir

