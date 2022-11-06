#!/bin/bash

# script to build virtualplanet on a Linux system

version=2.5

arch=$(arch)
unset extratarget

# adjuste here the target you want to crossbuild
# You MUST crosscompile Freepascal and Lazarus for this targets! 

unset make_debug
unset make_linux32
unset make_linux64
unset make_linux_data
unset make_win32
if [[ $arch == x86_64 ]]; then 
   make_linux64=1
   make_linux_data=1
   make_win32=1
   extratarget=",x86_64-linux"
fi
if [[ $arch == i686 ]]; then 
   make_linux32=1
fi

builddir=/tmp/virtualplanet  # Be sure this is set to a non existent directory, it is removed after the run!
export WINEPREFIX=~/.wine
innosetup="C:\Program Files\Inno Setup 6\ISCC.exe"  # Install under Wine from http://www.jrsoftware.org/isinfo.php
wine_build="Z:\tmp\virtualplanet" # Change to match builddir, Z: is defined in ~/.wine/dosdevices


if [[ -n $1 ]]; then
  configopt="fpc=$1"
fi
if [[ -n $2 ]]; then
  configopt=$configopt" lazarus=$2"
fi
if [[ -z $configopt ]]; then
  echo "Syntaxe : buildpkg.sh freepascal_path lazarus_path"
  exit 1;
fi

outdir='PROG';

wd=`pwd`
mkdir $wd/$outdir

# delete old files
  deldir=$outdir; 
  rm $deldir/virtualplanet*.tgz
  rm $deldir/virtualplanet*.deb
  rm $deldir/virtualplanet*.rpm
  rm $deldir/virtualplanet*.zip
  rm $deldir/virtualplanet*.exe
  rm $deldir/bin-*.zip
  rm $deldir/bin-*.bz2
  rm -rf $builddir
  
currentrev=$(git rev-list --count --first-parent HEAD)

# make Linux i386 version
if [[ $make_linux32 ]]; then 
  ./configure $configopt prefix=$builddir target=i386-linux$extratarget
  if [[ $? -ne 0 ]]; then exit 1;fi
  make CPU_TARGET=i386 OS_TARGET=linux clean
  make CPU_TARGET=i386 OS_TARGET=linux
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install
  if [[ $? -ne 0 ]]; then exit 1;fi
  # tar
  cd $builddir
  tar cvzf virtualplanet-$version-linux_i386.tgz --owner=root --group=root *
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv virtualplanet*.tgz $wd/$outdir/
  if [[ $? -ne 0 ]]; then exit 1;fi
  # deb
    cd $wd
    rsync -a --exclude=.svn Installer/Linux/debian $builddir
    cd $builddir
    mkdir debian/virtualplanet/usr/
    mv bin debian/virtualplanet/usr/
    mv share debian/virtualplanet/usr/
    cd debian
    sed -i "/Version:/ s/1/$version/" virtualplanet/DEBIAN/control
    fakeroot dpkg-deb --build virtualplanet .
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv virtualplanet*.deb $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi
  # rpm
    cd $wd
    rsync -a --exclude=.svn Installer/Linux/rpm $builddir
    cd $builddir
    mkdir rpm/virtualplanet
    mkdir rpm/virtualplanet/usr
    mv debian/virtualplanet/usr/* rpm/virtualplanet/usr/
    cd rpm
    sed -i "/Version:/ s/1/$version/"  SPECS/virtualplanet.spec
    sed -i "/Release:/ s/1/1/" SPECS/virtualplanet.spec
    setarch i386 fakeroot rpmbuild  --buildroot "$builddir/rpm/virtualplanet" --define "_topdir $builddir/rpm/" -bb SPECS/virtualplanet.spec
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv RPMS/i386/virtualplanet*.rpm $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi
  if [[ $make_debug ]]; then 
  #debug
    cd $wd
    mkdir $builddir/debug
    cp vpa/vpa $builddir/debug/virtualplanet
    cd $builddir/debug/
    tar cvzf virtualplanet-bin-linux_i386-debug-$currentrev.tgz --owner=root --group=root *
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv virtualplanet-bin-*.tgz $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi
  fi
  cd $wd
  rm -rf $builddir
fi

# make Linux x86_64 version
if [[ $make_linux64 ]]; then 
  ./configure $configopt prefix=$builddir target=x86_64-linux
  if [[ $? -ne 0 ]]; then exit 1;fi
  make CPU_TARGET=x86_64 OS_TARGET=linux clean
  make CPU_TARGET=x86_64 OS_TARGET=linux
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install
  if [[ $? -ne 0 ]]; then exit 1;fi
  # tar
  cd $builddir
  tar cvzf virtualplanet-$version-linux_x86_64.tgz --owner=root --group=root *
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv virtualplanet*.tgz $wd/$outdir/
  if [[ $? -ne 0 ]]; then exit 1;fi
  # deb
    cd $wd
    rsync -a --exclude=.svn Installer/Linux/debian $builddir
    cd $builddir
    mkdir debian/virtualplanet64/usr/
    mv bin debian/virtualplanet64/usr/
    mv share debian/virtualplanet64/usr/
    cd debian
    sed -i "/Version:/ s/1/$version/" virtualplanet64/DEBIAN/control
    fakeroot dpkg-deb --build virtualplanet64 .
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv virtualplanet*.deb $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi
  # rpm
    cd $wd
    rsync -a --exclude=.svn Installer/Linux/rpm $builddir
    cd $builddir
    mkdir rpm/virtualplanet
    mkdir rpm/virtualplanet/usr
    mv debian/virtualplanet64/usr/* rpm/virtualplanet/usr/
    cd rpm
    sed -i "/Version:/ s/1/$version/"  SPECS/virtualplanet64.spec
    sed -i "/Release:/ s/1/1/" SPECS/virtualplanet64.spec
    fakeroot rpmbuild  --buildroot "$builddir/rpm/virtualplanet" --define "_topdir $builddir/rpm/" -bb SPECS/virtualplanet64.spec
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv RPMS/x86_64/virtualplanet*.rpm $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi
  if [[ $make_debug ]]; then
  #debug
    cd $wd
    mkdir $builddir/debug
    cp vpa/vpa $builddir/debug/virtualplanet
    cd $builddir/debug/
    tar cvzf virtualplanet-bin-linux_x86_64-debug-$currentrev.tgz --owner=root --group=root *
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv virtualplanet-bin-*.tgz $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi
  fi
  cd $wd
  rm -rf $builddir
fi

# make Linux Data for both architectures
if [[ $make_linux_data ]]; then 
  ./configure $configopt prefix=$builddir
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install_data
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install_data2
  if [[ $? -ne 0 ]]; then exit 1;fi
  # tar
    cd $builddir
    tar cvzf virtualplanet-data-$version-linux_all.tgz --owner=root --group=root *
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv virtualplanet*.tgz $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi
    cd $wd
  # deb
    cd $wd
    rsync -a --exclude=.svn Installer/Linux/debian $builddir
    cd $builddir
    mkdir debian/virtualplanet-data/usr/
    mv share debian/virtualplanet-data/usr/
    cd debian
    sed -i "/Version:/ s/1/$version/" virtualplanet-data/DEBIAN/control
    fakeroot dpkg-deb --build virtualplanet-data .
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv virtualplanet-data*.deb $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi
  # rpm
    cd $wd
    rsync -a --exclude=.svn Installer/Linux/rpm $builddir
    cd $builddir
    mkdir rpm/virtualplanet-data
    mkdir rpm/virtualplanet-data/usr
    mv debian/virtualplanet-data/usr/* rpm/virtualplanet-data/usr/
    cd rpm
    sed -i "/Version:/ s/1/$version/"  SPECS/virtualplanet-data.spec
    sed -i "/Release:/ s/1/1/" SPECS/virtualplanet-data.spec
    fakeroot rpmbuild  --buildroot "$builddir/rpm/virtualplanet-data" --define "_topdir $builddir/rpm/" -bb SPECS/virtualplanet-data.spec
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv RPMS/noarch/virtualplanet*.rpm $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi

  cd $wd
  rm -rf $builddir
fi

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
  make install_win
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install_win_data
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install_win_data2
  if [[ $? -ne 0 ]]; then exit 1;fi
  # zip
    cd $builddir/virtualplanet/Data
    zip -r  virtualplanet-$version-$currentrev-windows.zip *
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv virtualplanet*.zip $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi
  # exe
    cd $builddir
    sed -i "/AppVerName/ s/V1/V$version/" virtualplanet.iss
    sed -i "/OutputBaseFilename/ s/-windows/-$version-windows/" virtualplanet.iss
    wine "$innosetup" "$wine_build\virtualplanet.iss"
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv $builddir/virtualplanet*.exe $wd/$outdir/

  if [[ $make_debug ]]; then
    #debug
    cd $wd
    mkdir $builddir/debug
    cp vpa/vpa.exe $builddir/debug/virtualplanet.exe
    cd $builddir/debug/
    zip virtualplanet-bin-windows_i386-debug-$currentrev.zip *
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv virtualplanet-bin-*.zip $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi
  fi
  cd $wd
  rm -rf $builddir
fi

