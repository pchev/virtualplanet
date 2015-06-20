#!/bin/bash 

# script to build virtualplanet on a Mac OS X system

version=1.0

unset make_darwin_i386
make_darwin_i386=1
unset make_darwin_ppc
#make_darwin_ppc=1

basedir=/Volumes/Data/tmp/virtualplanet  # Be sure this is set to a non existent directory, it is removed after the run!
builddir=$basedir/Virtual_Planet_Atlas

if [[ -n $1 ]]; then
  configopt="fpc=$1"
fi
if [[ -n $2 ]]; then
  configopt=$configopt" lazarus=$2"
fi

unset make_debug
unset pro
unset basic
unset updname
pro=1
#if [[ -n $3 ]]; then
#  if [[ $3 == basic ]]; then basic=1; fi
#  if [[ $3 == pro ]]; then pro=1; fi
#fi
if [[ $basic ]]; then
  echo make basic
  updname=_basic
  outdir='BASIC';
fi
if [[ $pro ]]; then
  echo make pro
  updname=_pro
  outdir='PRO';
fi

if [[ -z $updname ]]; then
  echo "Syntaxe : daily_build.sh freepascal_path lazarus_path [basic|pro]"
  exit 1;
fi

wd=`pwd`
mkdir $wd/$outdir

# check if new revision since last run
read lastrev <last.build
lang=LANG
LANG=C
currentrev=`svn info . | grep Revision: | sed 's/Revision: //'`
LANG=$lang
if [[ $upd ]]; then
  echo $lastrev ' - ' $currentrev
  if [[ $lastrev -eq $currentrev ]]; then
    echo Already build at revision $currentrev
    exit 4
  fi
fi

# delete old files
  deldir=$outdir; 
  rm $deldir/virtualplanet*.dmg
  rm $deldir/virtualplanet-bin*.tgz
  rm -rf $basedir

# make i386 Mac version
if [[ $make_darwin_i386 ]]; then
  ./configure $configopt prefix=$builddir target=i386-darwin
  if [[ $? -ne 0 ]]; then exit 1;fi
  make clean
  make 
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install_data
  if [[ $? -ne 0 ]]; then exit 1;fi
  if [[ $pro ]]; then
     make install_data2
     if [[ $? -ne 0 ]]; then exit 1;fi
  fi 
  # pkg
    cp Installer/Mac/virtualplanet.packproj $basedir
    cd $basedir
    freeze -v virtualplanet.packproj
    if [[ $? -ne 0 ]]; then exit 1;fi
    hdiutil create -anyowners -volname virtualplanet$updname-$version-macosx-i386 -imagekey zlib-level=9 -format UDZO -srcfolder ./build virtualplanet$updname-$version-macosx-i386.dmg
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv virtualplanet*.dmg $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi
  if [[ $make_debug ]]; then  
    #debug
    cd $wd
    mkdir $basedir/debug
    cp vpa/vpa $basedir/debug/
    cd $basedir/debug/
    if [[ $? -ne 0 ]]; then exit 1;fi
    tar cvzf virtualplanet$updname-bin-macosx-i386-debug-$currentrev.tgz *
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv virtualplanet$updname-bin-*.tgz $wd/$outdir/
    if [[ $? -ne 0 ]]; then exit 1;fi
  fi

  cd $wd
  rm -rf $basedir
fi

# make ppc Mac version
if [[ $make_darwin_ppc ]]; then
  echo I not have a ppc system to test so you may have some work to do!
  #./configure $configopt prefix=$builddir target=ppc-darwin
fi

# store revision 
  echo $currentrev > last.build


