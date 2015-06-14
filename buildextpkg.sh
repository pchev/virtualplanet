#!/bin/bash

# script to build extra texture for virtualplanet on a Linux system

version=1.0

arch=$(arch)
unset extratarget

# adjuste here the target you want to crossbuild
# You MUST crosscompile Freepascal and Lazarus for this targets! 

if [[ $arch == x86_64 ]]; then 
   extratarget=",x86_64-linux"
fi
unset make_linux_data
make_linux_data=1
unset make_win32
make_win32=1

outdir='EXT'

builddir=/tmp/virtualplanet  # Be sure this is set to a non existent directory, it is removed after the run!
innosetup="C:\Program Files\Inno Setup 5\ISCC.exe"  # Install under Wine from http://www.jrsoftware.org/isinfo.php
wine_build="Z:\tmp\virtualplanet" # Change to match builddir, Z: is defined in ~/.wine/dosdevices

if [[ -n $1 ]]; then
  configopt="fpc=$1"
fi
if [[ -n $2 ]]; then
  configopt=$configopt" lazarus=$2"
fi

wd=`pwd`
mkdir $wd/$outdir

# delete old files
  deldir=$outdir; 

  rm $deldir/virtualplanet*.tgz
  rm $deldir/virtualplanet*.deb
  rm $deldir/virtualplanet*.rpm
  rm $deldir/virtualplanet*.zip
  rm $deldir/virtualplanet*.exe
  rm -rf $builddir


# make Linux Data for both architectures
if [[ $make_linux_data ]]; then 
  ./configure $configopt prefix=$builddir
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install_data3
  if [[ $? -ne 0 ]]; then exit 1;fi
  # tar
    cd $builddir
    tar cvzf virtualplanet-extra-$version-linux_all.tgz --owner=root --group=root *
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv virtualplanet-extra*.tgz $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi
    cd $wd
  # deb
    cd $wd
    rsync -a --exclude=.svn Installer/Linux/debian $builddir
    cd $builddir
    mv share debian/virtualplanet-extra/usr/
    cd debian
    sed -i "/Version:/ s/1/$version/" virtualplanet-extra/DEBIAN/control
    fakeroot dpkg-deb --build virtualplanet-extra .
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv virtualplanet-extra*.deb $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi
  # rpm
    cd $wd
    rsync -a --exclude=.svn Installer/Linux/rpm $builddir
    cd $builddir
    mv debian/virtualplanet-extra/usr/* rpm/virtualplanet-extra/usr/
    cd rpm
    sed -i "/Version:/ s/1/$version/"  SPECS/virtualplanet-extra.spec
    sed -i "/Release:/ s/1/1/" SPECS/virtualplanet-extra.spec
    fakeroot rpmbuild  --buildroot "$builddir/rpm/virtualplanet-extra" --define "_topdir $builddir/rpm/" -bb SPECS/virtualplanet-extra.spec
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv RPMS/noarch/virtualplanet-extra*.rpm $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi

  cd $wd
  rm -rf $builddir
fi

# make Windows i386 version
if [[ $make_win32 ]]; then 
  cd $wd
  rsync -a --exclude=.svn Installer/Windows/* $builddir
  ./configure $configopt prefix=$builddir/virtualplanet/Data target=i386-win32$extratarget
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install_win_data3
  if [[ $? -ne 0 ]]; then exit 1;fi
  # zip
    cd $builddir/virtualplanet/Data
    zip -r  virtualplanet-extra-$version-$currentrev-windows.zip *
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv virtualplanet-extra*.zip $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi
  # exe
    cd $builddir
    cp $builddir/Data/*.txt $builddir/virtualplanet/Data/
    sed -i "/AppVerName/ s/V1/V$version/" virtualplanet.iss
    sed -i "/OutputBaseFilename/ s/-windows/-extra-$updname-$version-windows/" virtualplanet.iss
    wine "$innosetup" "$wine_build\virtualplanet.iss"
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv $builddir/virtualplanet*.exe $wd/$outdir/

  cd $wd
  rm -rf $builddir
fi

