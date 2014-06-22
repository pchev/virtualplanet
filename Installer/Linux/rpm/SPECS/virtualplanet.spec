Summary: Virtual Planet Atlas
Name: virtualplanet
Version: 1
Release: 1
Group: Sciences/Astronomy
License: GPL
URL: http://virtualmoon.sourceforge.net
Packager: Patrick Chevalley
BuildRoot: %_topdir/%{name}
BuildArch: i386
Provides: virtualplanet libvpa404.so
Requires: gtk2 glib2 pango libjpeg libpng libsqlite3.so.0
AutoReqProv: no

%description
This software can visualize the planet aspect for every location, date and hour. 
 It permits also to study the formations with unique database of more than 9000 entries.

%files
%defattr(-,root,root)
/usr/bin/virtualplanet
/usr/lib/libvpa404.so
/usr/share/applications/virtualplanet.desktop
/usr/share/pixmaps/virtualplanet.png
/usr/share/doc/virtualplanet
/usr/share/virtualplanet

