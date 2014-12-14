Summary: Virtual Planet Atlas - data files
Name: virtualplanet-data
Version: 1
Release: 1
Group: Sciences/Astronomy
License: GPL
URL: http://ap-i.net/vpa
Packager: Patrick Chevalley
BuildRoot: %_topdir/%{name}
BuildArch: noarch
Provides: virtualplanet-data
Requires: virtualplanet
AutoReqProv: no

%description
This software can visualize the planet aspect for every location, date and hour. 
 It permits also to study the formations with a unique database.

%files
%defattr(-,root,root)
/usr/share/virtualplanet

