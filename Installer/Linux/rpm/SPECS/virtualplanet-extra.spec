Summary: Virtual Planet Atlas - extra data files
Name: virtualplanet-extra
Version: 1
Release: 1
Group: Sciences/Astronomy
License: GPL
URL: http://ap-i.net/avp
Packager: Patrick Chevalley
BuildRoot: %_topdir/%{name}
BuildArch: noarch
Provides: virtualplanet-extra
Requires: virtualplanet-data
AutoReqProv: no

%description
This software can visualize the planet aspect for every location, date and hour. 
 It permits also to study the formations with a unique database.

%files
%defattr(-,root,root)
/usr/share/virtualplanet

