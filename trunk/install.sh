#!/bin/bash

# install the software 

destdir=$1

if [ -z "$destdir" ]; then
   export destdir=/tmp/virtualplanet
fi

echo Install virtualplanet to $destdir

# software
install -m 755 -d $destdir
install -m 755 -d $destdir/bin
install -m 755 -d $destdir/share
install -m 755 -d $destdir/share/applications
install -m 755 -d $destdir/share/doc
install -m 755 -d $destdir/share/doc/virtualplanet
install -m 755 -d $destdir/share/pixmaps
install -m 755 -d $destdir/share/icons
install -m 755 -d $destdir/share/icons/hicolor
install -m 755 -d $destdir/share/icons/hicolor/48x48
install -m 755 -d $destdir/share/icons/hicolor/48x48/apps

install -v -m 755 -s vpa/vpa  $destdir/bin/virtualplanet
install -v -m 644 Installer/Linux/vpa/share/applications/virtualplanet.desktop $destdir/share/applications/virtualplanet.desktop
install -v -m 644 Installer/Linux/vpa/share/pixmaps/virtualplanet.png $destdir/share/pixmaps/virtualplanet.png
install -v -m 644 Installer/Linux/vpa/share/pixmaps/virtualplanet.png $destdir/share/icons/hicolor/48x48/apps/virtualplanet.png
install -v -m 644 Installer/Linux/vpa/share/doc/virtualplanet/changelog $destdir/share/doc/virtualplanet/changelog
install -v -m 644 Installer/Linux/vpa/share/doc/virtualplanet/copyright $destdir/share/doc/virtualplanet/copyright


