#!/bin/bash 

# Script to make the full source tar for release

version=1.0
#pkg=trunk
pkg=tags/V10
repo=http://svn.code.sf.net/p/virtualplanet/code

builddir=/tmp/virtualplanet-src  # Be sure this is set to a non existent directory, it is removed after the run!

wd=`pwd`

verdir=virtualplanet-$version-src

mkdir -p $builddir
cd $builddir

# export sources
svn export $repo/$pkg $verdir

# tar files
tar cvJf $verdir.tar.xz $verdir

mv $verdir.tar.xz $wd/

cd $wd
rm -rf $builddir

