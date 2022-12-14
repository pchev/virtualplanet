unit u_projection;
{
Copyright (C) 2002 Patrick Chevalley

http://www.ap-i.net
pch@ap-i.net

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
}
{
 Projection functions
}
{$mode objfpc}{$H+}
interface
uses u_constant, u_util,
     Math, SysUtils, Graphics;

Function AngularDistance(ar1,de1,ar2,de2 : Double) : Double;
function PositionAngle(ac,dc,ar,de:double):double;
function Jd(annee,mois,jour :INTEGER; Heure:double):double;
PROCEDURE Djd(jd:Double;VAR annee,mois,jour:INTEGER; VAR Heure:double);
function SidTim(jd0,ut,long : double): double;
procedure Paralaxe(SideralTime,dist,ar1,de1 : double; var ar,de,q: double; jdcoord,jdnow : double);
PROCEDURE PrecessionFK4(ti,tf : double; VAR ari,dei : double);
PROCEDURE Precession(ti,tf : double; VAR ari,dei : double);
procedure PrecessionEcl(ti,tf : double; VAR l,b : double);
PROCEDURE Eq2Hz(HH,DE : double ; VAR A,h : double);
Procedure Ecl2Eq(l,b,e: double; var ar,de : double);
Procedure Eq2Ecl(ar,de,e: double; var l,b: double);
Procedure int4(y1,y2,y3:double; var n: integer; var x1,x2,xmax,ymax: double);
function ecliptic(j:double):double;
procedure nutationMe(j:double; var nutl,nuto:double);
procedure aberrationMe(j:double; var abe,abp:double);
procedure apparent_equatorial(var ra,de:double; ecl,sunl,abp,abe,nutl,nuto: double; aberration:boolean=true);
procedure mean_equatorial(var ra,de:double; ecl,sunl,abp,abe,nutl,nuto: double);

implementation

Function AngularDistance(ar1,de1,ar2,de2 : Double) : Double;
var s1,s2,c1,c2,c3: extended;
begin
s1:=0;s2:=0;c1:=0;c2:=0;
try
if (ar1=ar2) and (de1=de2) then result:=0.0
else begin
    sincos(de1,s1,c1);
    sincos(de2,s2,c2);
    c3:=(s1*s2)+(c1*c2*cos((ar1-ar2)));
    if abs(c3)<=1 then
       result:=double(arccos(c3))
    else
       result:=pi2;
end;    
except
  result:=pi2;
end;
end;

function PositionAngle(ac,dc,ar,de:double):double;
var hh,s1,s2,s3,c1,c2,c3 : extended;
begin
s1:=0;s2:=0;s3:=0;c1:=0;c2:=0;c3:=0;
    hh := (ac-ar) ;
    sincos(dc,s1,c1);
    sincos(de,s2,c2);
    sincos(hh,s3,c3);
    result:= pi+arctan2((c2*s3) , (-c1*s2+s1*c2*c3) );
end;

function Jd(annee,mois,jour :INTEGER; Heure:double):double;
var u,u0,u1,u2 : double;
	gregorian : boolean;
begin
if annee*10000+mois*100+jour >= 15821015 then gregorian:=true else gregorian:=false;
u:=annee;
if mois<3 then u:=u-1;
u0:=u+4712;
u1:=mois+1;
if u1<4 then u1:=u1+12;
result:=floor(u0*365.25)+floor(30.6*u1+0.000001)+jour+heure/24-63.5;
if gregorian then begin
   u2:=floor(abs(u)/100)-floor(abs(u)/400);
   if u<0 then u2:=-u2;
   result:=result-u2+2;
   if (u<0)and((u/100)=floor(u/100))and((u/400)<>floor(u/400)) then result:=result-1;
end;
end;

PROCEDURE Djd(jd:Double;VAR annee,mois,jour:INTEGER; VAR Heure:double);
var u0,u1,u2,u3,u4 : double;
	gregorian : boolean;
begin
u0:=jd+0.5;
if int(u0)>=2299161 then gregorian:=true else gregorian:=false;
u0:=jd+32082.5;
if gregorian then begin
   u1:=u0+floor(u0/36525)-floor(u0/146100)-38;
   if jd>=1830691.5 then u1:=u1+1;
   u0:=u0+floor(u1/36525)-floor(u1/146100)-38;
end;
u2:=floor(u0+123);
u3:=floor((u2-122.2)/365.25);
u4:=floor((u2-floor(365.25*u3))/30.6001);
mois:=round(u4-1);
if mois>12 then mois:=mois-12;
jour:=round(u2-floor(365.25*u3)-floor(30.6001*u4));
annee:=round(u3+floor((u4-2)/12)-4800);
heure:=(jd-floor(jd+0.5)+0.5)*24;
end;

function SidTim(jd0,ut,long : double): double;
 VAR t,te: double;
BEGIN
 t:=(jd0-2451545.0)/36525;
 te:=100.46061837 + 36000.770053608*t + 0.000387933*t*t - t*t*t/38710000;
 result := deg2rad*Rmod(te - long + 1.00273790935*ut*15,360) ;
END ;

procedure Paralaxe(SideralTime,dist,ar1,de1 : double; var ar,de,q: double; jdcoord,jdnow: double);
var
   sinpi,H,a,b,d : double;
const
     desinpi = 4.26345151e-5;
begin
// AR, DE may be standard epoch but paralaxe is to be computed with coordinates of the date.
precession(jdcoord,jdnow,ar1,de1);
H:=(SideralTime-ar1);
//rde:=de1;
sinpi:=desinpi/dist;
a := cos(de1)*sin(H);
b := cos(de1)*cos(H)-ObsRoCosPhi*sinpi;
d := sin(de1)-ObsRoSinPhi*sinpi;
q := sqrt(a*a+b*b+d*d);
ar:=SideralTime-arctan2(a,b);
de:=double(arcsin(d/q));
precession(jdnow,jdcoord,ar,de);
end;

PROCEDURE PrecessionFK4(ti,tf : double; VAR ari,dei : double);
var i1,i2,i3,i4,i5,i6,i7 : double ;
   BEGIN
      I1:=(TI-2415020.3135)/36524.2199 ;
      I2:=(TF-TI)/36524.2199 ;
      I3:=deg2rad*((1.8E-2*I2+3.02E-1)*I2+(2304.25+1.396*I1))*I2/3600.0 ;
      I4:=deg2rad*I2*I2*(7.91E-1+I2/1000.0)/3600.0+I3 ;
      I5:=deg2rad*((2004.682-8.35E-1*I1)-(4.2E-2*I2+4.26E-1)*I2)*I2/3600.0 ;
      I6:=COS(DEI)*SIN(ARI+I3) ;
      I7:=COS(I5)*COS(DEI)*COS(ARI+I3)-SIN(I5)*SIN(DEI) ;
      DEI:=double(ArcSIN(SIN(I5)*COS(DEI)*COS(ARI+I3)+COS(I5)*SIN(DEI))) ;
      ARI:=double(ARCTAN2(I6,I7)) ;
      ARI:=ARI+I4   ;
      ARI:=RMOD(ARI+pi2,pi2);
   END  ;

PROCEDURE Precession(ti,tf : double; VAR ari,dei : double);  // ICRS
var i1,i2,i3,i4,i5,i6,i7 : double ;
   BEGIN
   if abs(ti-tf)<0.01 then exit;
      I1:=(TI-2451545.0)/36525 ;
      I2:=(TF-TI)/36525;
      I3:=deg2rad*((2306.2181+1.39656*i1-1.39e-4*i1*i1)*i2+(0.30188-3.44e-4*i1)*i2*i2+1.7998e-2*i2*i2*i2)/3600 ;
      I4:=deg2rad*((2306.2181+1.39656*i1-1.39e-4*i1*i1)*i2+(1.09468+6.6e-5*i1)*i2*i2+1.8203e-2*i2*i2*i2)/3600 ;
      I5:=deg2rad*((2004.3109-0.85330*i1-2.17e-4*i1*i1)*i2-(0.42665+2.17e-4*i1)*i2*i2-4.1833e-2*i2*i2*i2)/3600 ;
      I6:=COS(DEI)*SIN(ARI+I3) ;
      I7:=COS(I5)*COS(DEI)*COS(ARI+I3)-SIN(I5)*SIN(DEI) ;
      i1:=(SIN(I5)*COS(DEI)*COS(ARI+I3)+COS(I5)*SIN(DEI));
      if i1>1 then i1:=1;
      if i1<-1 then i1:=-1;
      DEI:=double(ArcSIN(i1));
      ARI:=double(ARCTAN2(I6,I7)) ;
      ARI:=ARI+I4;
      ARI:=RMOD(ARI+pi2,pi2);
   END  ;

procedure PrecessionEcl(ti,tf : double; VAR l,b : double);  // l,b in radian !
var i1,i2,i3,i4,i5,i6,i7,i8 : double ;
begin
i1:=(ti-2451545.0)/36525 ;
i2:=(tf-ti)/36525;
i3:=deg2rad*(((47.0029-0.06603*i1+0.000598*i1*i1)*i2+(-0.03302+0.000598*i1)*i2*i2+0.000060*i2*i2*i2)/3600);
i4:=deg2rad*((174.876384*3600+3289.4789*i1+0.60622*i1*i1-(869.8089+0.50491*i1)*i2+0.03536*i2*i2)/3600);
i5:=deg2rad*(((5029.0966+2.22226*i1-0.000042*i1*i1)*i2+(1.11113-0.000042*i1)*i2*i2-0.000006*i2*i2*i2)/3600);
i6:=cos(i3)*cos(b)*sin(i4-l)-sin(i3)*sin(b);
i7:=cos(b)*cos(i4-l);
i8:=cos(i3)*sin(b)+sin(i3)*cos(b)*sin(i4-l);
l:=i5+i4-arctan2(i6,i7);
b:=double(arcsin(i8));
l:=rmod(l+pi2,pi2);
end;

PROCEDURE Eq2Hz(HH,DE : double ; VAR A,h : double);
var l1,d1,h1 : double;
BEGIN
l1:=deg2rad*ObsLatitude;
d1:=DE;
h1:=HH;
h:= double(arcsin( sin(l1)*sin(d1)+cos(l1)*cos(d1)*cos(h1) ));
A:= double(arctan2(sin(h1),cos(h1)*sin(l1)-tan(d1)*cos(l1)));
A:=Rmod(A+pi2,pi2);
{ refraction meeus91 15.4 }
h1:=rad2deg*h;
if h1>-1 then h:=double(minvalue([pid2,h+deg2rad*ObsRefractionCor*(1.02/tan(deg2rad*(h1+10.3/(h1+5.11))))/60]))
         else h:=h+deg2rad*ObsRefractionCor*0.64658062088*(h1+90)/89;
END ;

Procedure Ecl2Eq(l,b,e: double; var ar,de : double);
begin
ar:=double(arctan2(sin(l)*cos(e)-tan(b)*sin(e),cos(l)));
de:=double(arcsin(sin(b)*cos(e)+cos(b)*sin(e)*sin(l)));
end;

Procedure Eq2Ecl(ar,de,e: double; var l,b: double);
begin
l:=double(arctan2(sin(ar)*cos(e)+tan(de)*sin(e),cos(ar)));
b:=double(arcsin(sin(de)*cos(e)-cos(de)*sin(e)*sin(ar)));
end;

procedure int4(y1,y2,y3:double; var n: integer; var x1,x2,xmax,ymax: double);
var a, b, c, d, dx: double;
begin
n:=0;
a:=(y1+y3)/2-y2;
b:=(y3-y1)/2;
c:=y2;
xmax:=-b/(2*a);
ymax:=(a*xmax+b)*xmax+c;
d:=b*b-4.0*a*c;
if (d>0) then begin
   dx:=sqrt(d)/abs(a)/2;
   x1:=xmax-dx;
   x2:=xmax+dx;
   if (abs(x1)<=1) then inc(n);
   if (abs(x2)<=1) then inc(n);
   if (x1<-1) then x1:=x2;
end;
end;

function ecliptic(j:double):double;
var u : double;
begin
{meeus91 21.3}
u:=(j-jd2000)/3652500;
result:=eps2000 +(
        -4680.93*u
        -1.55*u*u
        +1999.25*intpower(u,3)
        -51.38*intpower(u,4)
        -249.67*intpower(u,5)
        -39.05*intpower(u,6)
        +7.12*intpower(u,7)
        +27.87*intpower(u,8)
        +5.79*intpower(u,9)
        +2.45*intpower(u,10)
        )/3600;
result:=deg2rad*result;
end;

procedure nutationMe(j:double; var nutl,nuto:double);
var t,om,me,mas,mam,al : double;
begin
t:=(j-jd2000)/36525;
// high precision. using meeus91 table 21.A
//longitude of the asc.node of the Moon's mean orbit on the ecliptic
om:=deg2rad*(125.04452-1934.136261*t+0.0020708*t*t+t*t*t/4.5e+5);
//mean elongation of the Moon from Sun
me:=deg2rad*(297.85036+445267.11148*t-0.0019142*t*t+t*t*t/189474);
//mean anomaly of the Sun (Earth)
mas:=deg2rad*(357.52772+35999.05034*t-1.603e-4*t*t-t*t*t/3e+5);
//mean anomaly of the Moon
mam:=deg2rad*(134.96298+477198.867398*t+0.0086972*t*t+t*t*t/56250);
//Moon's argument of latitude
al:=deg2rad*(93.27191+483202.017538*t- 0.0036825*t*t+t*t*t/327270);
//periodic terms for the nutation in longitude.The unit is 0".0001.
nutl:=secarc*((-171996-174.2*t)*sin(1*om)
                +(-13187-1.6*t)*sin(-2*me+2*al+2*om)
                +(-2274-0.2*t)*sin(2*al+2*om)
                +(2062+0.2*t)*sin(2*om)
                +(1426-3.4*t)*sin(1*mas)
                +(712+0.1*t)*sin(1*mam)
                +(-517+1.2*t)*sin(-2*me+1*mas+2*al+2*om)
                +(-386-0.4*t)*sin(2*al+1*om)
                -301*sin(1*mam+2*al+2*om)
                +(217-0.5*t)*sin(-2*me-1*mas+2*al+2*om)
                -158*sin(-2*me+1*mam)
                +(129+0.1*t)*sin(-2*me+2*al+1*om)
                +123*sin(-1*mam+2*al+2*om)
                +63*sin(2*me)
                +(63+0.1*t)*sin(1*mam+1*om)
                -59*sin(2*me-1*mam+2*al+2*om)
                +(-58-0.1*t)*sin(-1*mam+1*om)
                -51*sin(1*mam+2*al+1*om)
                +48*sin(-2*me+2*mam)
                +46*sin(-2*mam+2*al+1*om)
                -38*sin(2*me+2*al+2*om)
                -31*sin(2*mam+2*al+2*om)
                +29*sin(2*mam)
                +29*sin(-2*me+1*mam+2*al+2*om)
                +26*sin(2*al)
                -22*sin(-2*me+2*al)
                +21*sin(-1*mam+2*al+1*om)
                +(17-0.1*t)*sin(2*mas)
                +16*sin(2*me-1*mam+1*om)
                -16*sin(-2*me+2*mas+2*al+2*om)
                -15*sin(1*mas+1*om)
                -13*sin(-2*me+1*mam+1*om)
                -12*sin(-1*mas+1*om)
                +11*sin(2*mam-2*al)
                -10*sin(2*me-1*mam+2*al+1*om)
                -8*sin(2*me+1*mam+2*al+2*om)
                +7*sin(1*mas+2*al+2*om)
                -7*sin(-2*me+1*mas+1*mam)
                -7*sin(-1*mas+2*al+2*om)
                -7*sin(2*me+2*al+1*om)
                +6*sin(2*me+1*mam)
                +6*sin(-2*me+2*mam+2*al+2*om)
                +6*sin(-2*me+1*mam+2*al+1*om)
                -6*sin(2*me-2*mam+1*om)
                -6*sin(2*me+1*om)
                +5*sin(-1*mas+1*mam)
                -5*sin(-2*me-1*mas+2*al+1*om)
                -5*sin(-2*me+1*om)
                -5*sin(2*mam+2*al+1*om)
                +4*sin(-2*me+2*mam+1*om)
                +4*sin(-2*me+1*mas+2*al+1*om)
                +4*sin(1*mam-2*al)
                -4*sin(-1*me+1*mam)
                -4*sin(-2*me+1*mas)
                -4*sin(1*me)
                +3*sin(1*mam+2*al)
                -3*sin(-2*mam+2*al+2*om)
                -3*sin(-1*me-1*mas+1*mam)
                -3*sin(1*mas+1*mam)
                -3*sin(-1*mas+1*mam+2*al+2*om)
                -3*sin(2*me-1*mas-1*mam+2*al+2*om)
                -3*sin(3*mam+2*al+2*om)
                -3*sin(2*me-1*mas+2*al+2*om));
nutl:=nutl*0.0001;
// periodic terms for the nutation in obliquity
nuto:=secarc*((92025+8.9*t)*cos(1*om)
                +(5736-3.1*t)*cos(-2*me+2*al+2*om)
                +(977-0.5*t)*cos(2*al+2*om)
                +(-895+0.5*t)*cos(2*om)
                +(54-0.1*t)*cos(1*mas)
                -7*cos(1*mam)
                +(224-0.6*t)*cos(-2*me+1*mas+2*al+2*om)
                +200*cos(2*al+1*om)
                +(129-0.1*t)*cos(1*mam+2*al+2*om)
                +(-95+0.3*t)*cos(-2*me+-1*mas+2*al+2*om)
                -70*cos(-2*me+2*al+1*om)
                -53*cos(-1*mam+2*al+2*om)
                -33*cos(1*mam+1*om)
                +26*cos(2*me+-1*mam+2*al+2*om)
                +32*cos(-1*mam+1*om)
                +27*cos(1*mam+2*al+1*om)
                -24*cos(-2*mam+2*al+1*om)
                +16*cos(2*me+2*al+2*om)
                +13*cos(2*mam+2*al+2*om)
                -12*cos(-2*me+1*mam+2*al+2*om)
                -10*cos(-1*mam+2*al+1*om)
                 -8*cos(2*me-1*mam+1*om)
                 +7*cos(-2*me+2*mas+2*al+2*om)
                 +9*cos(1*mas+1*om)
                 +7*cos(-2*me+1*mam+1*om)
                 +6*cos(-1*mas+1*om)
                 +5*cos(2*me-1*mam+2*al+1*om)
                 +3*cos(2*me+1*mam+2*al+2*om)
                 -3*cos(1*mas+2*al+2*om)
                 +3*cos(-1*mas+2*al+2*om)
                 +3*cos(2*me+2*al+1*om)
                 -3*cos(-2*me+2*mam+2*al+2*om)
                 -3*cos(-2*me+1*mam+2*al+1*om)
                 +3*cos(2*me-2*mam+1*om)
                 +3*cos(2*me+1*om)
                 +3*cos(-2*me-1*mas+2*al+1*om)
                 +3*cos(-2*me+1*om)
                 +3*cos(2*mam+2*al+1*om));
nuto:=nuto*0.0001;
end;

procedure aberrationMe(j:double; var abe,abp:double);
var t : double;
begin
t:=(j-jd2000)/36525;
abe:=0.016708617-4.2037e-5*t-1.236e-7*t*t;
abp:=deg2rad*(102.93735+1.71953*t+4.6e-4*t*t);
end;

procedure apparent_equatorial(var ra,de:double; ecl,sunl,abp,abe,nutl,nuto: double; aberration:boolean=true);
var da,dd,l,b: double;
    cra,sra,cde,sde,ce,se,cp,sp,cls,sls: extended;
begin
cra:=0;sra:=0;cde:=0;sde:=0;ce:=0;se:=0;cp:=0;sp:=0;cls:=0;sls:=0;l:=0;b:=0;
sincos(ra,sra,cra);
sincos(de,sde,cde);
sincos(ecl,se,ce);
sincos(sunl,sls,cls);
sincos(abp,sp,cp);
// nutation
if abs(de)<(89.99*deg2rad) then begin    // meeus91 22.1
   da:=nutl*(ce+se*sra*(sde/cde))-nuto*(cra*(sde/cde));
   dd:=nutl*se*cra+nuto*sra;
   ra:=ra+da;
   de:=de+dd;
end else begin
   Eq2Ecl(ra,de,ecl,l,b);
   l:=l+nutl;
   b:=b+nuto;
   Ecl2Eq(l,b,ecl,ra,de);
end;
if aberration then begin
//aberration
//meeus91 22.3
da:=-abek*(cra*cls*ce+sra*sls)/cde + abe*abek*(cra*cp*ce+sra*sp)/cde;
dd:=-abek*(cls*ce*((se/ce)*cde-sra*sde)+cra*sde*sls) + abe*abek*(cp*ce*((se/ce)*cde-sra*sde)+cra*sde*sp);
ra:=ra+da;
de:=de+dd;
end;
end;

procedure mean_equatorial(var ra,de:double; ecl,sunl,abp,abe,nutl,nuto: double);
var da,dd,l,b: double;
    cra,sra,cde,sde,ce,se,cp,sp,cls,sls: extended;
begin
cra:=0;sra:=0;cde:=0;sde:=0;ce:=0;se:=0;cp:=0;sp:=0;cls:=0;sls:=0;l:=0;b:=0;
sincos(ra,sra,cra);
sincos(de,sde,cde);
sincos(ecl,se,ce);
sincos(sunl,sls,cls);
sincos(abp,sp,cp);
// nutation
if abs(de)<(89.99*deg2rad) then begin    // meeus91 22.1
   da:=nutl*(ce+se*sra*(sde/cde))-nuto*(cra*(sde/cde));
   dd:=nutl*se*cra+nuto*sra;
   ra:=ra-da;
   de:=de-dd;
end else begin
   Eq2Ecl(ra,de,ecl,l,b);
   l:=l-nutl;
   b:=b-nuto;
   Ecl2Eq(l,b,ecl,ra,de);
end;
//aberration
//meeus91 22.3
da:=-abek*(cra*cls*ce+sra*sls)/cde + abe*abek*(cra*cp*ce+sra*sp)/cde;
dd:=-abek*(cls*ce*(tan(ecl)*cde-sra*sde)+cra*sde*sls) + abe*abek*(cp*ce*(tan(ecl)*cde-sra*sde)+cra*sde*sp);
ra:=ra-da;
de:=de-dd;
end;

end.

