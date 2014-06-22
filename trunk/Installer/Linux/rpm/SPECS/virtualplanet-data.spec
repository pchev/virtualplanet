Summary: Virtual Planet Atlas - data files
Name: virtualplanet-data
Version: 1
Release: 1
Group: Sciences/Astronomy
License: GPL
URL: http://virtualmoon.sourceforge.net
Packager: Patrick Chevalley
BuildRoot: %_topdir/%{name}
BuildArch: noarch
Provides: virtualplanet-data
Requires: virtualplanet
AutoReqProv: no

%description
This software can visualize the planet aspect for every location, date and hour. 
 It permits also to study the formations with unique database of more than 9000 entries.

%files
%defattr(-,root,root)
/usr/share/virtualplanet

