#!/bin/bash 

# script to build virtualplanet on a Mac OS X system

version=1.0

unset make_darwin_data
make_darwin_data=1

basedir=/tmp/virtualplanet  # Be sure this is set to a non existent directory, it is removed after the run!
builddir=$basedir/Virtual_Planet_Atlas

if [[ -n $1 ]]; then
  configopt="fpc=$1"
fi
if [[ -n $2 ]]; then
  configopt=$configopt" lazarus=$2"
fi

outdir='EXT'

wd=`pwd`
mkdir $wd/$outdir


# delete old files
  deldir=$outdir; 
  rm $deldir/virtualplanet-extra*.dmg
  rm -rf $basedir

# make Mac version
if [[ $make_darwin_data ]]; then
  ./configure $configopt prefix=$builddir target=i386-darwin
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install_data3
  if [[ $? -ne 0 ]]; then exit 1;fi
  # pkg
    cp Installer/Mac/virtualplanet-extra.packproj $basedir
    cd $basedir
    freeze -v virtualplanet-extra.packproj
    if [[ $? -ne 0 ]]; then exit 1;fi
    hdiutil create -megabytes 2000 -anyowners -volname virtualplanet-extra-$version-macosx -imagekey zlib-level=9 -format UDZO -srcfolder ./build virtualplanet-extra-$version-macosx.dmg
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv virtualplanet-extra*.dmg $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi

  cd $wd
  rm -rf $basedir
fi


