Summary: Virtual Planet Atlas
Name: virtualplanet
Version: 1
Release: 1
Group: Sciences/Astronomy
License: GPL
URL: http://ap-i.net/avp
Packager: Patrick Chevalley
BuildRoot: %_topdir/%{name}
BuildArch: i386
Provides: virtualplanet
Requires: libpasastro gtk2 glib2 pango libjpeg libpng libsqlite3.so.0
AutoReqProv: no

%description
This software can visualize the planet aspect for every location, date and hour. 
 It permits also to study the formations with a unique database

%files
%defattr(-,root,root)
/usr/bin/virtualplanet
/usr/share/applications/virtualplanet.desktop
/usr/share/pixmaps/virtualplanet.png
/usr/share/icons/hicolor/48x48/apps/virtualplanet.png
/usr/share/doc/virtualplanet


