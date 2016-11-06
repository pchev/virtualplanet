#!/bin/bash

# script to build virtualplanet Win upgrade on a Linux system

version=2.0

arch=$(arch)
unset extratarget

# adjuste here the target you want to crossbuild
# You MUST crosscompile Freepascal and Lazarus for this targets! 

unset make_debug
unset make_linux32
unset make_linux64
unset make_linux_data
unset make_win32

make_win32=1
extratarget=",x86_64-linux"
outdir=WINUPD
updname=_upgrade

builddir=/tmp/virtualplanet  # Be sure this is set to a non existent directory, it is removed after the run!
innosetup="C:\Program Files\Inno Setup 5\ISCC.exe"  # Install under Wine from http://www.jrsoftware.org/isinfo.php
wine_build="Z:\tmp\virtualplanet" # Change to match builddir, Z: is defined in ~/.wine/dosdevices

if [[ -n $1 ]]; then
  configopt="fpc=$1"
fi
if [[ -n $2 ]]; then
  configopt=$configopt" lazarus=$2"
fi
if [[ -z $updname ]]; then
  echo "Syntaxe : daily_build.sh freepascal_path lazarus_path [basic|pro]"
  exit 1;
fi

wd=`pwd`
mkdir $wd/$outdir

# delete old files
  deldir=$outdir; 
  rm $deldir/virtualplanet*.exe
  rm -rf $builddir

# make Windows i386 version
if [[ $make_win32 ]]; then 
  cd $wd/data
  ./mkzoneinfo.sh
  cd $wd
  rsync -a --exclude=.svn Installer/Windows/* $builddir
  ./configure $configopt prefix=$builddir/virtualplanet/Data target=i386-win32$extratarget
  if [[ $? -ne 0 ]]; then exit 1;fi
  make OS_TARGET=win32 CPU_TARGET=i386 clean
  make OS_TARGET=win32 CPU_TARGET=i386
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install_win_update
  if [[ $? -ne 0 ]]; then exit 1;fi
  # zip
    cd $builddir/virtualplanet/Data
    zip -r  virtualplanet$updname-$version-windows.zip *
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv virtualplanet*.zip $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi
  # exe
    cd $builddir
    sed -i "/AppVerName/ s/V1/V$version/" virtualplanet.iss
    sed -i "/OutputBaseFilename/ s/-windows/$updname-$version-windows/" virtualplanet.iss
    wine "$innosetup" "$wine_build\virtualplanet.iss"
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv $builddir/virtualplanet*.exe $wd/$outdir/

  cd $wd
  rm -rf $builddir
fi

