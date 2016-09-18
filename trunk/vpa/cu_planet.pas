unit cu_planet;
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
 Planet computation component.
}
{$mode objfpc}{$H+}
interface

uses
  uDE, cu_plansat,
  u_translation, u_constant, u_util, u_projection,
  Classes, Sysutils, passql, pasmysql, passqlite, Forms, Math;

type bool20=array[1..20] of boolean;

type
  TPlanet = class(TComponent)
  private
    { Private declarations }
    LockPla,LockDB : boolean;
    SolT0,XSol,YSol,ZSol : double;
    jdnew,jdchart:double;
    Feph_method: string;
    smsg:Tstrings;
    SolAstrometric, SolBarycenter : boolean;
    CurrentStep,CurrentPlanet,n_com,n_ast : integer;
  protected
    { Protected declarations }
  public
    { Public declarations }
     constructor Create(AOwner:TComponent); override;
     destructor  Destroy; override;
     procedure SetDE(folder:string);
     function load_de(t: double): boolean;
     Procedure Plan(ipla: integer; t: double ; var p: TPlanData);
     Procedure Planet(ipla : integer; t0 : double ; var alpha,delta,distance,illum,phase,diameter,magn,dp,xp,yp,zp,vel : double);
     Procedure SunRect(t0 : double ; astrometric : boolean; var x,y,z : double;barycenter:boolean=true);
     Procedure Sun(t0 : double; var alpha,delta,dist,diam : double);
     Procedure SunEcl(t0 : double ; var l,b : double);
     procedure PlanSat(isat:integer; jde:double; var alpha,delta,distance: double; var supconj:boolean);
     Function MarSat(jde,lighttime,xp,yp,zp : double; var xsat,ysat : double20; var supconj: bool20):integer;
     Function JupSat(jde,lighttime,xp,yp,zp : double; smallsat: boolean; var xsat,ysat : double20; var supconj: bool20):integer;
     Function SatSat(jde,lighttime,xp,yp,zp : double; smallsat: boolean; var xsat,ysat : double20; var supconj : array of boolean):integer;
     Function UraSat(jde,lighttime,xp,yp,zp : double; smallsat: boolean; var xsat,ysat : double20; var supconj : array of boolean):integer;
     Function NepSat(jde,lighttime,xp,yp,zp : double; smallsat: boolean; var xsat,ysat : double20; var supconj : array of boolean):integer;
     Function PluSat(jde,lighttime,xp,yp,zp : double; var xsat,ysat : double20; var supconj : array of boolean):integer;
     Procedure SatRing(jde : double; var P,a,b,be : double);
     Function JupGRS(lon,drift,jdref,jdnow: double):double;
     Procedure Moon(t0 : double; var alpha,delta,dist,dkm,diam,phase,illum : double);
     Procedure MoonIncl(Lar,Lde,Sar,Sde : double; var incl : double);
     Function MoonMag(phase:double):double;
     Function MoonPhase(k: double):double;
     Procedure MoonPhases(year:double; var nm,fq,fm,lq : double);
     Procedure PlanetOrientation(jde:double; ipla:integer; var P,De,Ds,w1,w2,w3 : double);
     Procedure MoonOrientation(jde,ra,dec,d:double; var P,llat,lats,llong : double);
     procedure PlanetRiseSet(pla:integer; jd0:double; AzNorth:boolean; var thr,tht,ths,tazr,tazs: string; var jdr,jdt,jds,rar,der,rat,det,ras,des:double ; var i: integer);
     procedure PlanetAltitude(pla: integer; jd0,hh:double; var har,sina: double);
     procedure nutation(j:double; var nutl,nuto:double);
     procedure aberration(j:double; var abe,abp: double );
     property eph_method: string read Feph_method;
  end;

implementation

uses LCLProc;

constructor TPlanet.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 lockpla:=false;
 lockdb:=false;
 Feph_method:='';
 de_type:=0;
 de_year:=-999999;
end;

destructor TPlanet.Destroy;
begin
try
// if satxyok then dlclose(satxylib);
 if de_created then close_de_file;
 inherited destroy;
except
debugln('error destroy '+name);
end;
end;

Procedure TPlanet.Plan(ipla: integer; t: double ; var p: TPlanData);
var v2: Array_5D;
    pl :TPlanetData;
    x,y,z,qr: double;
begin
if load_de(t) then begin    // use jpl DE-
  Calc_Planet_de(t, ipla, v2,true,12,false);
  p.x:=v2[0];
  p.y:=v2[1];
  p.z:=v2[2];
  // rotate equatorial to ecliptic
  x:=p.x;
  y:= coseps2k*p.y + sineps2k*p.z;
  z:= -sineps2k*p.y + coseps2k*p.z;
  // convert to polar
  p.r:=sqrt(x*x+y*y+z*z);
  p.l:=arctan2(y,x);
  if (p.l<0) then p.l:=p.l+2*pi;
  qr:=sqrt(x*x+y*y);
  if qr<>0 then p.b:=arctan(z/qr);
  Feph_method:='DE'+inttostr(de_type);
end
else if (t>jdmin404)and(t<jdmax404) then begin               // use Plan404
  pl.ipla:=ipla;
  pl.JD:=t;
  Plan404(addr(pl));
  p.x:=pl.x;
  p.y:=pl.y;
  p.z:=pl.z;
  p.l:=pl.l;
  p.b:=pl.b;
  p.r:=pl.r;
  Feph_method:='plan404';
end else begin
  p.x:=0;
  p.y:=0;
  p.z:=0;
  p.l:=0;
  p.b:=0;
  p.r:=0;
  Feph_method:='';
end;
end;

Procedure TPlanet.Planet(ipla : integer; t0 : double ; var alpha,delta,distance,illum,phase,diameter,magn,dp,xp,yp,zp,vel : double);
const
      sa : array[1..9] of double =(0.38709893,0.72333199,1.00000011,1.52366231,5.20336301,9.53707032,19.19126393,30.06896348,39.48168677);
      s0 : array[1..9] of double =(3.34,8.41,0,4.68,98.47,83.33,34.28,36.56,1.57);
      V0 : array[1..9] of double =(-0.42,-4.40,0,-1.52,-9.40,-8.88,-7.19,-6.87,-1.0);

var  v1: double6;
     w : array[1..3] of double;
     tjd,t : double;
     pl :TPlanData;
     lt,rt,dt,lp,rp,lsol,pha,qr,xt,yt,zt : double;
begin
if (ipla<1) or (ipla=3) or (ipla>9) then exit;
// always do this computation for phase sign
  // Earth position
  Plan(3,t0-tlight,pl);
  lt:=pl.l; rt:=pl.r;
  xt:=pl.x; yt:=pl.y; zt:=pl.z;
  dt:=rt;
  // planet position
  Plan(ipla,t0,pl);
  lp:=pl.l; rp:=pl.r;
  dp:=rp;
 // get distance for light time correction
 xt:=pl.x-xt;
 yt:=pl.y-yt;
 zt:=pl.z-zt;
 distance:=sqrt(xt*xt+yt*yt+zt*zt);
 // planet using light correction
 tjd:=t0;
 SunRect(tjd,false,v1[1],v1[2],v1[3]);
 dt:=sqrt(v1[1]*v1[1]+v1[2]*v1[2]+v1[3]*v1[3]);
 t:=tjd-distance*tlight;
 Plan(ipla,t,pl);
 w[1]:=pl.x+v1[1];
 w[2]:=pl.y+v1[2];
 w[3]:=pl.z+v1[3];
 alpha:=arctan2(w[2],w[1]);
 if (alpha<0) then alpha:=alpha+2*pi;
 qr:=sqrt(w[1]*w[1]+w[2]*w[2]);
 if qr<>0 then delta:=arctan(w[3]/qr);
 xp:=pl.x;
 yp:=pl.y;
 zp:=pl.z;
 // velocity
 vel:=42.1219*sqrt(1/dp-1/(2*sa[ipla]));
{
  illuminated fraction
  correct the phase sign with the difference of longitude with the sun.
}
 qr:=(2*dp*distance);
 if qr<>0 then phase:=(dp*dp+distance*distance-dt*dt)/qr //=cos(phase)
          else phase:=1;
 if abs(phase)>1 then phase:=sgn(phase);
 illum:=(1+phase)/2;
 phase:=radtodeg(arccos(phase));
 // lt and lp must be computed!
 lsol:=rmod(pi4+pi+lt,pi2); // be sure to obtain a positive value
 lp:=rmod(lp+pi2,pi2);
 lp:=rmod(lsol-lp+pi2,pi2);
 if (lp>0)and(lp<=pi) then phase:=-phase;
{
  apparent diameter
}
 if distance<>0 then diameter:=2*s0[ipla]/distance;
{
  magnitude
}
magn:=V0[ipla]+5*log10(dp*distance); {meeus91 40. }
pha:=abs(phase);
case ipla of
    1 : magn:=magn+pha*(0.0380+pha*(-0.000273+pha*2e-6));
    2 : magn:=magn+pha*(0.0009+pha*(0.000239-pha*6.5e-7));
    4 : magn:=magn+0.016*pha;
    5 : magn:=magn+0.005*pha;
    6 : magn:=magn+0.044*pha;
end;
end;

Procedure TPlanet.SunRect(t0 : double ; astrometric : boolean; var x,y,z : double;barycenter:boolean=true);
var p :TPlanetData;
    planet_arr: Array_5D;
    tjd : double;
    i,sol : integer;
begin
if (t0=SolT0)and(astrometric=Solastrometric)and(SolBarycenter=barycenter) then begin
   x:=XSol;
   y:=YSol;
   z:=ZSol;
   end
else begin
if astrometric then tjd:=t0-tlight
               else tjd:=t0;
if load_de(tjd) then begin    // use jpl DE-
  if barycenter then sol:=12
     else sol:=11;
  Calc_Planet_de(tjd, sol, planet_arr,true,3,false);
  x:=planet_arr[0];
  y:=planet_arr[1];
  z:=planet_arr[2];
  Feph_method:='DE'+inttostr(de_type);
end
else if (t0>jdmin404)and(t0<jdmax404) then begin    // use Plan404
     p.ipla:=3;
     p.JD:=tjd;
     i:=Plan404(addr(p));
     if (i<>0) then exit;
     x:=-p.x;
     y:=-p.y;
     z:=-p.z;
     Feph_method:='plan404';
end else begin
  x:=0;
  y:=0;
  z:=0;
  Feph_method:='';
end;
// save result for repetitive call
SolBarycenter:=barycenter;
Solastrometric:=astrometric;
SolT0:=t0;
XSol:=x;
YSol:=y;
ZSol:=z;
end;
end;

Procedure TPlanet.Sun(t0 : double; var alpha,delta,dist,diam : double);
var x,y,z,qr : double;
begin
  SunRect(t0,false,x,y,z,true);
  dist:=sqrt(x*x+y*y+z*z);
  alpha:=arctan2(y,x);
  if (alpha<0) then alpha:=alpha+pi2;
  qr:=sqrt(x*x+y*y);
  if qr<>0 then delta:=arctan(z/qr);
  if dist<>0 then diam:=2*959.63/dist;
end;

Procedure TPlanet.SunEcl(t0 : double ; var l,b : double);
var x1,y1,z1,x,y,z,qr : double;
begin
SunRect(t0,false,x1,y1,z1,true);
// rotate equatorial to ecliptic
x:=x1;
y:= coseps2k*y1 + sineps2k*z1;
z:= -sineps2k*y1 + coseps2k*z1;
// convert to polar
l:=arctan2(y,x);
if (l<0) then l:=l+2*pi;
qr:=sqrt(x*x+y*y);
if qr<>0 then b:=arctan(z/qr);
end;

function to360(x:double):double;
begin
result:=rmod(x+3600000000,360);
end;

Procedure TPlanet.PlanetOrientation(jde:double; ipla:integer; var P,De,Ds,w1,w2,w3 : double);
// Report of the IAU Working Group on Cartographic
// Coordinates and Rotational Elements: 2009
// + 2011 Erratum
const VP : array[1..15,1..4] of double = (
          (281.0097,-0.0328,61.4143,-0.0049), //mercure
          (272.76,0,67.16,0),             //venus
          (0,-0.641,90,-0.557),           //earth
          (317.68143,-0.1061,52.88650,-0.0609), //mars
          (268.056595,-0.006499,64.495303,0.002413), //jupiter
          (40.589,-0.036,83.537,-0.004),  //saturn
          (257.311,0,-15.175,0),          //uranus
          (299.36,0.70,43.46,-0.51),      //neptune !
          (132.993,0,-6.163,0),           //pluto
          (286.13,0,63.87,0),             //sun
          (0,0,0,0),                      //moon not computed here
          (268.05,-0.009,64.50,0.003),    //Io
          (268.08,-0.009,64.51,0.003),    //Europa
          (268.20,-0.009,64.57,0.003),    //Ganymede
          (268.72,-0.009,64.83,0.003));   //Callisto
      W : array[1..15,1..2] of double =(
          (329.5469,6.1385025),
          (160.20,-1.4813688),
          (190.147,360.9856235),
          (176.630,350.89198226),
          (67.1,877.90003539),   //System I
          (227.2037,844.3),      //System I
          (203.81,-501.1600928),
          (253.18,536.3128492),
          (302.695,56.3625225),
          (84.176,14.1844000),  //sun
          (0,0),                //moon not computed here
          (200.39,203.4889538), //Io
          (36.022,101.3747235), //Europa
          (44.064,50.3176081),  //Ganymede
          (259.51,21.5710715)); //Callisto
var d,T,N,a0,d0,l0,b0,r0,l1,b1,r1,x,y,z,del,eps,als,des,u,v,al,dl,f,th,k,i : double;
    M1,M2,M3,M4,M5,Ja,Jb,Jc,Jd,Je,J1,J2,J3,J4,J5,J6,J7,J8 : double;
    pl :TPlanData;
begin
d := (jde-jd2000);
T := d/36525;
if ipla=10 then begin  // sun
  th:=(jde-2398220)*360/25.38;
  i:=deg2rad*7.25;
  k:=deg2rad*(73.6667+1.3958333*(jde-2396758)/36525);
  Plan(3,jde,pl);
  PrecessionEcl(jd2000,jde,pl.l,pl.b);
  l0:=pl.l+pi;
  eps := deg2rad*(23.439291111 - 0.0130042 * T - 1.64e-7 * T*T + 5.036e-7 *T*T*T);
  x:=arctan(-cos(l0)*tan(eps));
  y:=arctan(-cos(l0-k)*tan(i));
  P:=rad2deg*(x+y);
  De:=rad2deg*(arcsin(sin(l0-k)*sin(i)));
  n:=arctan2(-sin(l0-k)*cos(i),-cos(l0-k));
  w1:=to360(rad2deg*n-th);
end else begin
if ipla=8 then N:=cos(deg2rad*(357.85+52.316*T))   // Neptune
          else N:=T;
// coordinates of the pole
d0:=deg2rad*(VP[ipla,3]+VP[ipla,4]*N);
if ipla=8 then N:=sin(deg2rad*(357.85+52.316*T))
          else N:=T;
a0:=deg2rad*(VP[ipla,1]+VP[ipla,2]*N);
if ipla=5 then begin                        //jupiter
  Ja:=deg2rad*(99.360714+4850.4046*T);
  Jb:=deg2rad*(175.895369+1191.9605*T);
  Jc:=deg2rad*(300.323162+262.5475*T);
  Jd:=deg2rad*(114.012305+6070.2476*T);
  Je:=deg2rad*(49.511251+64.3000*T);
  a0:=a0+0.000117*sin(Ja)+0.000938*sin(Jb)+0.001432*sin(Jc)+0.000030*sin(Jd)+0.002150*sin(Je);
  d0:=d0+0.000050*cos(Ja)+0.000404*cos(Jb)+0.000617*cos(Jc)-0.000013*cos(Jd)+0.000926*cos(Je);
end;
if (ipla>=12)and(ipla<=15) then begin
  J1:=deg2rad*(73.32+91472.9*T);
  J2:=deg2rad*(24.62+45137.2*T);
  J3:=deg2rad*(283.90+4850.7*T);
  J4:=deg2rad*(355.80+1191.3*T);
  J5:=deg2rad*(119.90+262.1*T);
  J6:=deg2rad*(229.80+64.3*T);
  J7:=deg2rad*(352.25+2382.6*T);
  J8:=deg2rad*(113.35+6070.0*T);
end;
if ipla=12 then begin    // Io
  a0:=a0+0.094*sin(J3)+0.024*sin(J4);
  d0:=d0+0.040*cos(J3)+0.011*cos(J4);
end;
if ipla=13 then begin    // Europa
  a0:=a0+1.086*sin(J4)+0.060*sin(J5)+0.015*sin(J6)+0.009*sin(J7);
  d0:=d0+0.468*cos(J4)+0.026*cos(J5)+0.007*cos(J6)+0.002*cos(J7);
end;
if ipla=14 then begin    // Ganymede
  a0:=a0-0.037*sin(J4)+0.431*sin(J5)+0.091*sin(J6);
  d0:=d0-0.016*cos(J4)+0.186*cos(J5)+0.039*cos(J6);
end;
if ipla=15 then begin    // Callisto
  a0:=a0-0.068*sin(J5)+0.590*sin(J6)+0.010*sin(J8);
  d0:=d0-0.029*cos(J5)+0.254*cos(J6)-0.004*cos(J8);
end;
precession(jd2000,jde,a0,d0);
// rotation
w1:=W[ipla,1]+W[ipla,2]*d;
if ipla=1 then begin
  M1:=deg2rad*(174.791086+4.092335*d);
  M2:=deg2rad*(349.582171+8.184670*d);
  M3:=deg2rad*(164.373257+12.277005*d);
  M4:=deg2rad*(339.164343+16.369340*d);
  M5:=deg2rad*(153.955429+20.461675*d);
  w1:=w1+0.00993822*sin(M1)-0.00104581*sin(M2)-0.00010280*sin(M3)-0.00002364*sin(M4)-0.00000532*sin(M5);
end;
if ipla=8 then w1:=w1-0.48*N;  // N=sin(..)
if ipla=5 then begin
   w2:=43.3+870.27003539*d;
   w3:=284.95+870.5360000*d;
end else if ipla=6 then begin
    w2:=105.4857+812.0*d;
    w3:=38.90+810.7939024*d;
end else begin
   w2:=-999;
   w3:=-999;
end;
if ipla=12 then begin    // Io
  w1:=w1-0.085*sin(J3)-0.022*sin(J4);
end;
if ipla=13 then begin    // Europa
  w1:=w1-0.980*sin(J4)-0.054*sin(J5)-0.014*sin(J6)-0.008*sin(J7);
end;
if ipla=14 then begin    // Ganymede
  w1:=w1+0.033*sin(J4)-0.389*sin(J5)-0.082*sin(J6);
end;
if ipla=15 then begin    // Callisto
  w1:=w1+0.061*sin(J5)-0.533*sin(J6)-0.009*sin(J8);
end;
// view from Earth
Plan(3,jde,pl);
PrecessionEcl(jd2000,jde,pl.l,pl.b);
l0:=pl.l; b0:=pl.b; r0:=pl.r;
Plan(CentralPlanet[ipla],jde,pl);
PrecessionEcl(jd2000,jde,pl.l,pl.b);
l1:=pl.l; b1:=pl.b; r1:=pl.r;
x := r1 * cos(b1) * cos(l1) - r0 * cos(l0);
y := r1 * cos(b1) * sin(l1) - r0 * sin(l0);
z := r1 * sin(b1) - r0 * sin(b0);
del := sqrt( x*x + y*y + z*z);
Plan(CentralPlanet[ipla],jde-del*tlight,pl);
PrecessionEcl(jd2000,jde,pl.l,pl.b);
l1:=pl.l; b1:=pl.b; r1:=pl.r;
x := r1 * cos(b1) * cos(l1) - r0 * cos(l0);
y := r1 * cos(b1) * sin(l1) - r0 * sin(l0);
z := r1 * sin(b1) - r0 * sin(b0);
del := sqrt( x*x + y*y + z*z);
eps := deg2rad*(23.439291111 - 0.0130042 * T - 1.64e-7 * T*T + 5.036e-7 *T*T*T);
als:=arctan2(cos(eps)*sin(l1)-sin(eps)*tan(b1),cos(l1));
des:=arcsin(cos(eps)*sin(b1)+sin(eps)*cos(b1)*sin(l1));
Ds:=rad2deg*(arcsin(-sin(d0)*sin(des)-cos(d0)*cos(des)*cos(a0-als)));
u:=y*cos(eps)-z*sin(eps);
v:=y*sin(eps)+z*cos(eps);
al:=arctan2(u,x);
dl:=arctan(v/sqrt(x*x+u*u));
f:=rad2deg*(arctan2(sin(d0)*cos(dl)*cos(a0-al)-sin(dl)*cos(d0),cos(dl)*sin(a0-al)));
De:=rad2deg*(arcsin(-sin(d0)*sin(dl)-cos(d0)*cos(dl)*cos(a0-al)));
w1:=to360((w1-f-del*tlight*W[ipla,2])*sgn(W[ipla,2]));
if ipla=5 then begin
   w2:=to360(w2-f-del*tlight*870.27003539);
   w3:=to360(w3-f-del*tlight*870.5360000);
end;
if ipla=6 then begin
   w2:=to360(w2-f-del*tlight*812.0);
   w3:=to360(w3-f-del*tlight*810.7939024);
end;
P:=to360(rad2deg*(arctan2(cos(d0)*sin(a0-al),sin(d0)*cos(dl)-cos(d0)*sin(dl)*cos(a0-al))));
end;
end;

Procedure TPlanet.MoonOrientation(jde,ra,dec,d:double; var P,llat,lats,llong : double);
var lp,l,b,f,om,w,T,a,i,lh,bh,e,v,x,y,l0 {,cel,sel,asol,dsol} : double;
    pl :TPlanData;
begin
{ P: position angle  (degree)
  llat: libration latitude (degree)
  llong: libration longitude  (degree)
  lats:  sun inclination (degree) }
T := (jde-2451545)/36525;
e:=deg2rad*23.4392911;
eq2ecl(ra,dec,e,lp,b);
// libration
F:=93.2720993+483202.0175273*t-0.0034029*t*t-t*t*t/3526000+t*t*t*t/863310000;
om:=125.0445550-1934.1361849*t+0.0020762*t*t+t*t*t/467410-t*t*t*t/60616000;
w:=lp-deg2rad*om;
i:=deg2rad*1.54242;
l:=lp;
a:=rad2deg*(arctan2(sin(w)*cos(b)*cos(i)-sin(b)*sin(i),cos(w)*cos(b)));
llong:=to360(a-F);
if llong>180 then llong:=llong-360;
llat:=arcsin(-sin(w)*cos(b)*sin(i)-sin(b)*cos(i));
// position
Plan(3,jde-tlight,pl);
PrecessionEcl(jd2000,jde,pl.l,pl.b);
l0:=rad2deg*(pl.l)-180;
lh:=l0+180+(d/pl.r)*rad2deg*cos(b)*sin(pl.l-pi-l);
bh:=(d/pl.r)*pl.b;
w:=deg2rad*(lh-om);
lats:=rad2deg*(arcsin(-sin(w)*cos(bh)*sin(i)-sin(bh)*cos(i)));
v:=deg2rad*(om);
x:=sin(i)*sin(v);
y:=sin(i)*cos(v)*cos(e)-cos(i)*sin(e);
w:=arctan2(x,y);
P:=rad2deg*(arcsin(sqrt(x*x+y*y)*cos(ra-w)/cos(llat)));
llat:=rad2deg*(llat);
end;

Function TPlanet.JupGRS(lon,drift,jdref,jdnow: double):double;
begin
result:=rmod(360000+lon+(jdnow-jdref)*drift,360);
end;

procedure TPlanet.PlanSat(isat:integer; jde:double; var alpha,delta,distance: double; var supconj:boolean);
var ipl,ix:integer;
    pra,pdec,dist,illum,phase,diam,magn,rp,xp,yp,zp,vel: double;
    satx,saty,satz,xs,ys,zs,x,y,z,d1,d2,qr,lighttime : double;
begin
case isat of
   12..15 : begin ipl:=5; ix:=isat-11; end;
   16..23 : begin ipl:=6; ix:=isat-15; end;
   24..28 : begin ipl:=7; ix:=isat-23; end;
   29..30 : begin ipl:=4; ix:=isat-28; end;
   33     : begin ipl:=6; ix:=9; end;
   34..35 : begin ipl:=8; ix:=isat-33; end;
   36     : begin ipl:=9; ix:=1; end;
   37..40 : begin ipl:=5; ix:=isat-36+4; end;
   41..50 : begin ipl:=6; ix:=isat-40+9; end;
   51..63 : begin ipl:=7; ix:=isat-50+5; end;
   64..69 : begin ipl:=8; ix:=isat-63+2; end;
   else ipl:=0;
end;
if ipl<>0 then begin
   Planet(ipl,jde,pra,pdec,dist,illum,phase,diam,magn,rp,xp,yp,zp,vel);
   lighttime:=dist*tlight;
   case ipl of
      4: MarSatOne(jde-lighttime,ix,satx,saty,satz);
      5: JupSatOne(jde-lighttime,ix,satx,saty,satz);
      6: SatSatOne(jde-lighttime,ix,satx,saty,satz);
      7: UraSatOne(jde-lighttime,ix,satx,saty,satz);
      8: NepSatOne(jde-lighttime,ix,satx,saty,satz);
      9: PluSatOne(jde-lighttime,ix,satx,saty,satz);
   end;
   SunRect(jde,false,xs,ys,zs);
   x:=xp+xs;
   y:=yp+ys;
   z:=zp+zs;
   d1:=sqrt(x*x+y*y+z*z);
   x:=x+satx;
   y:=y+saty;
   z:=z+satz;
   d2:=sqrt(x*x+y*y+z*z);
   alpha:=arctan2(y,x);
   if (alpha<0) then alpha:=alpha+2*pi;
   qr:=sqrt(x*x+y*y);
   if qr<>0 then delta:=arctan(z/qr);
   supconj:=(d2>d1);
   distance:=d2;
end;
end;

Function TPlanet.MarSat(jde,lighttime,xp,yp,zp : double; var xsat,ysat : double20; var supconj: bool20):integer;
var i : integer;
    xs,ys,zs,x,y,z,alpha,delta,qr,d1,d2 : double;
    xst,yst,zst : double20;
begin
result:=MarSatAll(jde-lighttime,xst,yst,zst);
if result=0 then begin
  SunRect(jde,false,xs,ys,zs);
  x:=xp+xs;
  y:=yp+ys;
  z:=zp+zs;
  d1:=sqrt(x*x+y*y+z*z);
  for i:=1 to 2 do begin
    x:=xp+xst[i]+xs;
    y:=yp+yst[i]+ys;
    z:=zp+zst[i]+zs;
    d2:=sqrt(x*x+y*y+z*z);
    alpha:=arctan2(y,x);
    if (alpha<0) then alpha:=alpha+2*pi;
    qr:=sqrt(x*x+y*y);
    if qr<>0 then delta:=arctan(z/qr);
    xsat[i]:=alpha;
    ysat[i]:=delta;
    supconj[i]:=(d2>d1);
  end;
end;
end;

Function TPlanet.JupSat(jde,lighttime,xp,yp,zp : double; smallsat: boolean; var xsat,ysat : double20; var supconj: bool20):integer;
var i,n : integer;
    xs,ys,zs,x,y,z,alpha,delta,qr,d1,d2 : double;
    xst,yst,zst : double20;
begin
if smallsat then n:=8 else n:=4;
result:=JupSatAll(jde-lighttime,smallsat, xst,yst,zst);
if result=0 then begin
  SunRect(jde,false,xs,ys,zs);
  x:=xp+xs;
  y:=yp+ys;
  z:=zp+zs;
  d1:=sqrt(x*x+y*y+z*z);
  for i:=1 to n do begin
    x:=xp+xst[i]+xs;
    y:=yp+yst[i]+ys;
    z:=zp+zst[i]+zs;
    d2:=sqrt(x*x+y*y+z*z);
    alpha:=arctan2(y,x);
    if (alpha<0) then alpha:=alpha+2*pi;
    qr:=sqrt(x*x+y*y);
    if qr<>0 then delta:=arctan(z/qr);
    xsat[i]:=alpha;
    ysat[i]:=delta;
    supconj[i]:=(d2>d1);
  end;
end;
end;

Function TPlanet.SatSat(jde,lighttime,xp,yp,zp : double; smallsat: boolean; var xsat,ysat : double20; var supconj : array of boolean):integer;
var i,n : integer;
    xs,ys,zs,x,y,z,alpha,delta,qr,d1,d2 : double;
    xst,yst,zst : double20;
begin
if smallsat then n:=19 else n:=9;
result:=SatSatAll(jde-lighttime,smallsat,xst,yst,zst);
if result=0 then begin
  SunRect(jde,false,xs,ys,zs);
  x:=xp+xs;
  y:=yp+ys;
  z:=zp+zs;
  d1:=sqrt(x*x+y*y+z*z);
  for i:=1 to n do begin
    x:=xp+xst[i]+xs;
    y:=yp+yst[i]+ys;
    z:=zp+zst[i]+zs;
    d2:=sqrt(x*x+y*y+z*z);
    alpha:=arctan2(y,x);
    if (alpha<0) then alpha:=alpha+2*pi;
    qr:=sqrt(x*x+y*y);
    if qr<>0 then delta:=arctan(z/qr);
    xsat[i]:=alpha;
    ysat[i]:=delta;
    supconj[i]:=(d2>d1);
  end;
end;
end;

Function TPlanet.UraSat(jde,lighttime,xp,yp,zp : double; smallsat: boolean; var xsat,ysat : double20; var supconj : array of boolean):integer;
var i,n : integer;
    xs,ys,zs,x,y,z,alpha,delta,qr,d1,d2 : double;
    xst,yst,zst : double20;
begin
if smallsat then n:=18 else n:=5;
result:=UraSatAll(jde-lighttime,smallsat,xst,yst,zst);
if result=0 then begin
  SunRect(jde,false,xs,ys,zs);
  x:=xp+xs;
  y:=yp+ys;
  z:=zp+zs;
  d1:=sqrt(x*x+y*y+z*z);
  for i:=1 to n do begin
    x:=xp+xst[i]+xs;
    y:=yp+yst[i]+ys;
    z:=zp+zst[i]+zs;
    d2:=sqrt(x*x+y*y+z*z);
    alpha:=arctan2(y,x);
    if (alpha<0) then alpha:=alpha+2*pi;
    qr:=sqrt(x*x+y*y);
    if qr<>0 then delta:=arctan(z/qr);
    xsat[i]:=alpha;
    ysat[i]:=delta;
    supconj[i]:=(d2>d1);
  end;
end;
end;

Function TPlanet.NepSat(jde,lighttime,xp,yp,zp : double; smallsat: boolean; var xsat,ysat : double20; var supconj : array of boolean):integer;
var i,n : integer;
    xs,ys,zs,x,y,z,alpha,delta,qr,d1,d2 : double;
    xst,yst,zst : double20;
begin
if smallsat then n:=8 else n:=2;
result:=NepSatAll(jde-lighttime,smallsat,xst,yst,zst);
if result=0 then begin
  SunRect(jde,false,xs,ys,zs);
  x:=xp+xs;
  y:=yp+ys;
  z:=zp+zs;
  d1:=sqrt(x*x+y*y+z*z);
  for i:=1 to n do begin
    x:=xp+xst[i]+xs;
    y:=yp+yst[i]+ys;
    z:=zp+zst[i]+zs;
    d2:=sqrt(x*x+y*y+z*z);
    alpha:=arctan2(y,x);
    if (alpha<0) then alpha:=alpha+2*pi;
    qr:=sqrt(x*x+y*y);
    if qr<>0 then delta:=arctan(z/qr);
    xsat[i]:=alpha;
    ysat[i]:=delta;
    supconj[i]:=(d2>d1);
  end;
end;
end;

Function TPlanet.PluSat(jde,lighttime,xp,yp,zp : double; var xsat,ysat : double20; var supconj : array of boolean):integer;
var i : integer;
    xs,ys,zs,x,y,z,alpha,delta,qr,d1,d2 : double;
    xst,yst,zst : double20;
begin
result:=PluSatAll(jde-lighttime,xst,yst,zst);
if result=0 then begin
  SunRect(jde,false,xs,ys,zs);
  x:=xp+xs;
  y:=yp+ys;
  z:=zp+zs;
  d1:=sqrt(x*x+y*y+z*z);
  for i:=1 to 1 do begin
    x:=xp+xst[i]+xs;
    y:=yp+yst[i]+ys;
    z:=zp+zst[i]+zs;
    d2:=sqrt(x*x+y*y+z*z);
    alpha:=arctan2(y,x);
    if (alpha<0) then alpha:=alpha+2*pi;
    qr:=sqrt(x*x+y*y);
    if qr<>0 then delta:=arctan(z/qr);
    xsat[i]:=alpha;
    ysat[i]:=delta;
    supconj[i]:=(d2>d1);
  end;
end;
end;

Procedure TPlanet.SatRing(jde : double; var P,a,b,be : double);
var T,i,om,l0,b0,r0,l1,b1,r1,x,y,z,del,lam,bet,sinB,eps,ceps,seps,lam0,bet0,al,de,al0,de0,j : double;
    pl :TPlanData;
begin
{ meeus 44. }
T := (jde-2451545)/36525;
i := 28.075216 - 0.012998 * T + 0.000004 *T*T;
om := 169.508470 + 1.394681 * T + 0.000412 *T*T;
j:=jde-9*0.0057755183; // aprox. light time
Plan(3,j,pl);
l0:=pl.l; b0:=pl.b; r0:=pl.r;
Plan(6,j,pl);
l1:=pl.l; b1:=pl.b; r1:=pl.r;
x := r1 * cos(b1) * cos(l1) - r0 * cos(l0);
y := r1 * cos(b1) * sin(l1) - r0 * sin(l0);
z := r1 * sin(b1) - r0 * sin(b0);
del := sqrt( x*x + y*y + z*z);
lam:=radtodeg(arctan2(y,x));
bet:=radtodeg(arctan(z/sqrt(x*x+y*y)));
sinB := sin(degtorad(i))*cos(degtorad(bet))*sin(degtorad(lam-om))-cos(degtorad(i))*sin(degtorad(bet));
be:=radtodeg(arcsin(sinB));
a:=375.35/del;
b:=a*abs(sinB);
eps := 23.439291111 - 0.0130042 * T - 1.64e-7 * T*T + 5.036e-7 *T*T*T;
ceps := cos(degtorad(eps));
seps := sin(degtorad(eps));
lam0 := degtorad(om - 90);
bet0 := degtorad(90 - i);
lam:=degtorad(lam);
bet:=degtorad(bet);
al := (arctan2(ceps*sin(lam)-seps*tan(bet),cos(lam)));
de := (arcsin(ceps*sin(bet)+seps*cos(bet)*sin(lam)));
al0 := (arctan2(ceps*sin(lam0)-seps*tan(bet0),cos(lam0)));
de0 := (arcsin(ceps*sin(bet0)+seps*cos(bet0)*sin(lam0)));
P := to360(90+radtodeg(arctan2(cos(de0)*sin(al0-al),sin(de0)*cos(de)-cos(de0)*sin(de)*cos(al0-al))));
end;

Function TPlanet.MoonMag(phase:double):double;
// The following table of lunar magnitudes is derived from relative
// intensities in Table 1 of M. Minnaert (1961),
// Phase  Frac.            Phase  Frac.            Phase  Frac.
// angle  ill.   Mag       angle  ill.   Mag       angle  ill.   Mag
//  0    1.00  -12.7        60   0.75  -11.0       120   0.25  -8.7
// 10    0.99  -12.4        70   0.67  -10.8       130   0.18  -8.2
// 20    0.97  -12.1        80   0.59  -10.4       140   0.12  -7.6
// 30    0.93  -11.8        90   0.50  -10.0       150   0.07  -6.7
// 40    0.88  -11.5       100   0.41   -9.6       160   0.03  -3.4
// 50    0.82  -11.2       110   0.33   -9.2
const mma : array[0..18]of double=(-12.7,-12.4,-12.1,-11.8,-11.5,-11.2,
                                   -11.0,-10.8,-10.4,-10.0,-9.6,-9.2,
                                   -8.7,-8.2,-7.6,-6.7,-3.4,0,0);
var i,j,k,p : integer;
begin
p:=(round(phase)+360) mod 360;
if p>180 then p:=360-p;
i:=p div 10;
k:=p-10*i;
j:=minintvalue([18,i+1]);
result:=mma[i]+((mma[j]-mma[i])*k/10);
end;

Procedure TPlanet.Moon(t0 : double; var alpha,delta,dist,dkm,diam,phase,illum : double);
{
	t0      :  julian date DT
	alpha   :  Moon RA J2000
        delta   :  Moon DEC J2000
	dist    :  Earth-Moon distance UA
	dkm     :  Earth-Moon distance Km
	diam    :  Apparent diameter (arcseconds)
	phase   :  Phase angle  (degree)
	illum	:  Illuminated percentage
}
var
   p :TPlanetData;
   q : double;
   t,sm,mm,md : double;
   w : array[1..3] of double;
   planet_arr: Array_5D;
   i : integer;
   pp : double;
begin
t0:=t0-(1.27/3600/24); // mean lighttime
if load_de(t0) then begin
   Calc_Planet_de(t0, 10, planet_arr,false,3,false);
   for i:=0 to 2 do w[i+1]:=planet_arr[i];
   dkm:=sqrt(w[1]*w[1]+w[2]*w[2]+w[3]*w[3]);
   alpha:=arctan2(w[2],w[1]);
   if (alpha<0) then alpha:=alpha+2*pi;
   pp:=sqrt(w[1]*w[1]+w[2]*w[2]);
   delta:=arctan(w[3]/pp);
   dist:=dkm/km_au;
   Feph_method:='DE'+inttostr(de_type);
end
else  if (t0>jdmin404)and(t0<jdmax404) then  begin  // use plan404
   p.JD:=t0;
   p.ipla:=11;
   Plan404(addr(p));
   dist:=sqrt(p.x*p.x+p.y*p.y+p.z*p.z);
   alpha:=arctan2(p.y,p.x);
   if (alpha<0) then alpha:=alpha+pi2;
   q:=sqrt(p.x*p.x+p.y*p.y);
   delta:=arctan(p.z/q);
   // plan404 give equinox of the date for the moon.
   precession(t0,jd2000,alpha,delta);
   dkm:=dist*km_au;
   Feph_method:='plan404';
end else begin
  Feph_method:='';
  exit;
end;
diam:=2*358482800/dkm;
t:=(t0-2415020)/36525;  { meeus 15.1 }
sm:=degtorad(358.475833+35999.0498*t-0.000150*t*t-0.0000033*t*t*t);  {meeus 30. }
mm:=degtorad(296.104608+477198.8491*t+0.009192*t*t+0.0000144*t*t*t);
md:=rmod(350.737486+445267.1142*t-0.001436*t*t+0.0000019*t*t*t,360);
phase:=180-md ;     { meeus 31.4 }
md:=degtorad(md);
phase:=rmod(phase-6.289*sin(mm)+2.100*sin(sm)-1.274*sin(2*md-mm)-0.658*sin(2*md)-0.214*sin(2*mm)-0.112*sin(md)+360,360);
illum:=(1+cos(degtorad(phase)))/2;
end;

Procedure TPlanet.MoonIncl(Lar,Lde,Sar,Sde : double; var incl : double);
{
	Lar  :  Moon RA
	Lde  :  Moon Dec
	Sar  :  Sun RA
	Sde  :  Sun Dec

	incl :  Position angle of the bright limb.
}
begin
{meeus 46.5 }
incl:=arctan2(cos(Sde)*sin(Sar-Lar),cos(Lde)*sin(Sde)-sin(Lde)*cos(Sde)*cos(Sar-Lar) );
end;


PROCEDURE Kepler(VAR E1:Double; e,m:Double; precision:double=1.0E-11);
 VAR a,b,c,qr,s0,s,z:Double;
     n: integer;
 BEGIN
{ meeus91  29.8 }
  if (e>0.97)and(abs(m)<0.55) then begin
    a:=(1-e)/(4*e+0.5);
    b:=m/(8*e+1);
    qr:=b + sign(b)*sqrt(b*b+a*a*a);
    if qr>0 then begin
      z:=power(qr,1/3);
      s0:=z-a/2;
      s:=s0 - (0.078*intpower(s0,5))/(1+e);
      E1:=m + e*(3*s-4*s*s*s);
    end
    else E1:=m;
   end
   else E1:=m;
{ meeus91  29.7 }
    n:=0;
    REPEAT
      c := (m + e*sin(E1) - E1) / (1.0 - e*cos(E1)) ;
      E1:= E1 + c ;
      inc(n);
      if n>10000 then raise exception.Create('Kepler equation not solved after 10000 loop. e='+floattostr(e)+' M='+floattostr(m));
    UNTIL ABS(c) < precision ;
 END ;
 
Procedure RectToPol(x,y : double; var r,alpha : double);
begin
r:=sqrt(x*x+y*y);
alpha:=arctan2(y,x);
end;

Procedure PrecessElem(annee : double; var i,oomi,oma : double);
var t,tau0,tau,eta,theta,theta0,i0,oma0,x,y,r,alpha,cosi : double;
const final = 2000.0;
begin
tau0:=(annee-1900)/1000;    { meeus 17. }
tau:=(final-1900)/1000;
t := tau-tau0;
eta := ((471.07-6.75*tau0+0.57*tau0*tau0)*t+(-3.37+0.57*tau0)*t*t+0.05*t*t*t)/3600;
theta0:=173.950833+(32869*tau0+56*tau0*tau0-(8694+55*tau0)*t+3*t*t)/3600;
theta:=theta0+((50256.41+222.29*tau0+0.26*tau0*tau0)*t+(111.15+0.26*tau0)*t*t+0.1*t*t*t)/3600;
i0:=i; oma0:=oma;
eta:=deg2rad*eta; theta:=deg2rad*theta; theta0:=deg2rad*theta0;
cosi:=cos(i0)*cos(eta)+sin(i0)*sin(eta)*cos(oma0-theta0);
y:=sin(i0)*sin(oma0-theta0);        { meeus 17.2 }
x:=-sin(eta)*cos(i0)+cos(eta)*sin(i0)*cos(oma0-theta0);
RectToPol(x,y,r,alpha);
i:=arcsin(r);
if cosi<0 then i:=pi-i ;
oma:=alpha+theta;
y:=-sin(eta)*sin(oma0-theta0);      { meeus 17.3 }
x:=sin(i0)*cos(eta)-cos(i0)*sin(eta)*cos(oma0-theta0);
RectToPol(x,y,r,alpha);
oomi:=oomi+alpha;
end;

Procedure TPlanet.PlanetAltitude(pla: integer; jd0,hh: double; var har,sina: double);
var jdt,ra,de,dm4,dm5,dm6,dm7,dm8,dm9,dm10,dm11,dm12,dm13: double;
begin
jdt:=jd0+(hh-TimeZone+DT_UT)/24;   // local time -> TT
case pla of
1..9: Planet(pla,jdt,ra,de,dm4,dm5,dm6,dm7,dm8,dm9,dm10,dm11,dm12,dm13);
10 :  Sun(jdt,ra,de,dm4,dm5);
11 :  Moon(jdt,ra,de,dm4,dm5,dm6,dm7,dm8);
end;
precession(jd2000,jd0,ra,de);
har:=rmod(sidtim(jd0, hh-TimeZone, Obslongitude) - ra + pi2, pi2);
sina:=(sin(deg2rad*Obslatitude) * sin(de) + cos(deg2rad*Obslatitude) * cos(de) * cos(har));
end;

procedure TPlanet.PlanetRiseSet(pla:integer; jd0:double; AzNorth:boolean; var thr,tht,ths,tazr,tazs: string; var jdr,jdt,jds,rar,der,rat,det,ras,des:double ;var i: integer);
var hr,ht,hs,h1,h2,azr,azs,dist,q,diam : double;
    ho,sinho,dt,hh,y1,y2,y3,x1,x2,x3,xmax,ymax,xmax2,ymax2,ymax0,ra,de,dm5,dm6,dm7,dm8,dm9,dm10,dm11,dm12,dm13: double;
    frise,fset,ftransit: boolean;
    n: integer;
const  na='      ';
begin
jdr:=0;jdt:=0;jds:=0;ymax0:=0;
frise := false;fset := false;ftransit := false;
case pla of
  12..15 : pla:=5; //jup sat
  16..23 : pla:=6; //sat sat ;
  24..28 : pla:=7; //ura sat ;
  29..30 : pla:=4; //mar sat ;
  31 : pla:=6; //sat ring ;
end;
case pla of
1..9: ho:=-0.5667;
10 : ho:=-0.8333;
11: begin
    Moon(jd0+(DT_UT/24),ra,de,dist,dm5,diam,dm7,dm8);
    ho:=(8.794/dist/3600)-0.5748*ObsRefractionCor-diam/2/3600-0.04;
    end;
end;
sinho:=sin(deg2rad*ho);
dt := jd0;
hh:=1;
PlanetAltitude(pla,dt,hh-1.0,x1,y1);
if x1>pi then x1:=x1-pi2;
y1:=y1-sinho;
// loop for event
while ( (hh < 25) and ( (fset=false) or (frise=false) or (ftransit=false) )) do begin
   PlanetAltitude(pla,dt,hh,x2,y2);
   if x2>pi then x2:=x2-pi2;
   y2:=y2-sinho;
   PlanetAltitude(pla,dt,hh+1.0,x3,y3);
   if x3>pi then x3:=x3-pi2;
   y3:=y3-sinho;
   int4(y1,y2,y3,n,h1,h2,xmax,ymax);
   // one rise/set
   if (n=1) then begin
      if (y1<0.0) then begin
         hr := hh + h1;
	 frise := true;
      end else begin
         hs := hh + h1;
	 fset := true;
      end;
   end;
   // two rise/set
   if (n = 2) then begin
      if (ymax < 0.0) then begin
         hr := hh + h2;
	 hs := hh + h1;
      end else begin
         hr := hh + h1;
	 hs := hh + h2;
      end;
   end;
   // transit
   if ((abs(xmax)<1) and (ymax>ymax0)) or
      ((hh<23) and (hh>1) and (abs(xmax)<1.5) and (ymax>ymax0)) //this one to correct for some imprecision in the extrema when very near to a time boundary
      then begin
         int4(x1,x2,x3,n,h1,h2,xmax2,ymax2);
         if (n=1) then begin
            ht := hh + h1;
            ymax0:=ymax;
            ftransit := true;
         end;
   end;
   y1 := y3;
   x1 := x3;
   hh:=hh+2;
end;
// format result
if (frise or fset) then begin    // rise (and/or) set and transit
   i:=0;
   if (frise) then begin       // rise
        thr:=armtostr(hr);
        jdr:=jd0+(hr-TimeZone)/24;
        case pla of
        1..9: Planet(pla,jdr+DT_UT/24,ra,de,dist,dm5,dm6,dm7,dm8,dm9,dm10,dm11,dm12,dm13);
        10 :  Sun(jdr+DT_UT/24,ra,de,dist,dm5);
        11 :  Moon(jdr+DT_UT/24,ra,de,dist,dm5,dm6,dm7,dm8);
        end;
        precession(jd2000,jd0,ra,de);
        if PlanetParalaxe then begin
           Paralaxe(SidTim(jd0,hr-TimeZone,ObsLongitude),dist,ra,de,rar,der,q,jd0,jd0);
        end else begin
           rar:=ra;
           der:=de;
        end;
        Eq2Hz(sidtim(jd0,hr-TimeZone,ObsLongitude)-ra,de,azr,dist);
        if AzNorth then Azr:=rmod(Azr+pi,pi2);
        tazr:=demtostr(rad2deg*Azr);
      end
      else begin
        thr:=na;
        tazr:=na;
      end;
   if (fset) then begin       // set
        ths:=armtostr(hs);
        jds:=jd0+(hs-TimeZone)/24;
        case pla of
        1..9: Planet(pla,jds+DT_UT/24,ra,de,dist,dm5,dm6,dm7,dm8,dm9,dm10,dm11,dm12,dm13);
        10 :  Sun(jds+DT_UT/24,ra,de,dist,dm5);
        11 :  Moon(jds+DT_UT/24,ra,de,dist,dm5,dm6,dm7,dm8);
        end;
        precession(jd2000,jd0,ra,de);
        if PlanetParalaxe then begin
           Paralaxe(SidTim(jd0,hs-TimeZone,ObsLongitude),dist,ra,de,ras,des,q,jd0,jd0);
        end else begin
           ras:=ra;
           des:=de;
        end;
        Eq2Hz(sidtim(jd0,hs-TimeZone,ObsLongitude)-ra,de,azs,dist);
        if AzNorth then Azs:=rmod(Azs+pi,pi2);
        tazs:=demtostr(rad2deg*Azs);
      end
      else begin
        ths:=na;
        tazs:=na;
      end;
   if (ftransit) then begin      // transit
        tht:=armtostr(ht);
        jdt:=jd0+(ht-TimeZone)/24;
        case pla of
        1..9: Planet(pla,jdt+DT_UT/24,ra,de,dist,dm5,dm6,dm7,dm8,dm9,dm10,dm11,dm12,dm13);
        10 :  Sun(jdt+DT_UT/24,ra,de,dist,dm5);
        11 :  Moon(jdt+DT_UT/24,ra,de,dist,dm5,dm6,dm7,dm8);
        end;
        precession(jd2000,jd0,ra,de);
        if PlanetParalaxe then begin
           Paralaxe(SidTim(jd0,ht-TimeZone,ObsLongitude),dist,ra,de,rat,det,q,jd0,jd0);
        end else begin
           rat:=ra;
           det:=de;
        end;
      end
      else begin
        tht:=na;
      end;
end else begin
   if (ftransit) then begin   // circumpolar
        i:=1;
        thr:=na;
        ths:=na;
        tazr:=na;
        tazs:=na;
        tht:=armtostr(ht);
        jdt:=jd0+(ht-TimeZone)/24;
        case pla of
        1..9: Planet(pla,jdt+DT_UT/24,ra,de,dist,dm5,dm6,dm7,dm8,dm9,dm10,dm11,dm12,dm13);
        10 :  Sun(jdt+DT_UT/24,ra,de,dist,dm5);
        11 :  Moon(jdt+DT_UT/24,ra,de,dist,dm5,dm6,dm7,dm8);
        end;
        precession(jd2000,jd0,ra,de);
        if PlanetParalaxe then begin
           Paralaxe(SidTim(jd0,ht-TimeZone,ObsLongitude),dist,ra,de,rat,det,q,jd0,jd0);
        end else begin
           rat:=ra;
           det:=de;
        end;
      end
      else begin  // not visible
        i:=2;
        thr:=na;
        ths:=na;
        tht:=na;
        tazr:=na;
        tazs:=na;
      end;
end;
end;

procedure TPlanet.SetDE(folder:string);
begin
   de_folder:=folder;
end;

function TPlanet.load_de(t: double): boolean;
var
  i: integer;
  y,ys,ye,m,d : integer;
  hour,jdstart,jdend: double;
begin
djd(t,y,m,d,hour);
if y=de_year then begin
  result:=(de_type<>0);
end else begin
  result:=false;
  de_type:=0;
  for i:=1 to nJPL_DE do begin
     if load_de_file(t,de_folder,JPL_DE[i],jdstart,jdend) then begin
       result:=true;
       de_type:=JPL_DE[i];
       break;
     end;
  end;
  if result then begin
    djd(jdstart,ys,m,d,hour);
    djd(jdend,ye,m,d,hour);
    if (y=ys)or(y=ye) then
       de_year:=MaxInt
    else
       de_year:=y;
  end
   else
    de_year:=MaxInt;
end;
end;

procedure TPlanet.nutation(j:double; var nutl,nuto:double);
var planet_arr: Array_5D;
    ok:boolean;
begin
ok:=false;
if load_de(j) then begin
  ok:=Calc_Planet_de(j, 14, planet_arr,false,0,false);
  if ok then begin
    nutl:=planet_arr[0];
    nuto:=planet_arr[1];
  end;
end;
if not ok then
  nutationMe(j,nutl,nuto);
end;

procedure TPlanet.aberration(j:double; var abe,abp: double );
var planet_arr: Array_5D;
    v,sx,sy,sz: double;
begin
  aberrationMe(j,abe,abp);
end;

Function TPlanet.MoonPhase(k: double):double;
var t,t2,t3,t4,cor,e,e2,M,Mm,f,ome,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,fr,w : double;
begin
t := k/1236.85;
t2 := t*t;
t3 := t2*t;
t4 := t3*t;
result:= 2451550.09766 + 29.530588861*k + 0.00015437*T2 - 0.000000150*T3 + 0.00000000073*T4;
e := 1 - 0.002516*T - 0.0000074*T2;
e2 := e*e;
M := deg2rad*rmod(2.5534 + 29.10535670*k - 0.0000014*T2 - 0.00000011*T3 + 360000000000,360);
Mm := deg2rad*rmod(201.5643 + 385.81693528*k + 0.0107582*T2 + 0.00001238*T3 - 0.000000058*T4 + 360000000000,360);
F  := deg2rad*rmod(160.7108 + 390.67050284*k - 0.0016118*T2 - 0.00000227*T3 + 0.00000001*T4 + 360000000000,360);
ome := deg2rad*rmod(124.7746 - 1.56375588*k + 0.0020672*T2 + 0.00000215*T3 + 360000000000,360);
A1 := deg2rad*rmod(299.77 + 0.107408*k - 0.009173*T2 + 360000000000,360);
A2 := deg2rad*rmod(251.88 + 0.016321*k + 360000000000,360);
A3 := deg2rad*rmod(251.83 + 26.651886*k + 360000000000,360);
A4 := deg2rad*rmod(349.42 + 36.412478*k + 360000000000,360);
A5 := deg2rad*rmod(84.66 + 18.206239*k + 360000000000,360);
A6 := deg2rad*rmod(141.74 + 53.303771*k + 360000000000,360);
A7 := deg2rad*rmod(207.14 + 2.453732*k + 360000000000,360);
A8 := deg2rad*rmod(154.84 + 7.306860*k + 360000000000,360);
A9 := deg2rad*rmod(34.52 + 27.261239*k + 360000000000,360);
A10 := deg2rad*rmod(207.19 + 0.121824*k + 360000000000,360);
A11 := deg2rad*rmod(291.34 + 1.844379*k + 360000000000,360);
A12 := deg2rad*rmod(161.72 + 24.198154*k + 360000000000,360);
A13 := deg2rad*rmod(239.56 + 25.513099*k + 360000000000,360);
A14 := deg2rad*rmod(331.55 + 3.592518*k + 360000000000,360);
fr := k - floor(k);
if (fr = 0) then begin //New Moon
   cor := -0.40720*sin(Mm) +
          0.17241*E*sin(M) +
          0.01608*sin(2*Mm) +
          0.01039*sin(2*F) +
          0.00739*E*sin(Mm - M) +
          -0.00514*E*sin(Mm + M) +
          0.00208*E2*sin(2*M) +
          -0.00111*sin(Mm - 2*F) +
          -0.00057*sin(Mm + 2*F) +
          0.00056*E*sin(2*Mm + M) +
          -0.00042*sin(3*Mm) +
          0.00042*E*sin(M + 2*F) +
          0.00038*E*sin(M - 2*F) +
          -0.00024*E*sin(2*Mm - M) +
          -0.00017*sin(ome) +
          -0.00007*sin(Mm + 2*M) +
          0.00004*sin(2*Mm - 2*F) +
          0.00004*sin(3*M) +
          0.00003*sin(Mm + M - 2*F) +
          0.00003*sin(2*Mm + 2*F) +
          -0.00003*sin(Mm + M + 2*F) +
          0.00003*sin(Mm - M + 2*F) +
          -0.00002*sin(Mm - M - 2*F) +
          -0.00002*sin(3*Mm + M) +
          0.00002*sin(4*Mm);
    result := result + cor;
  end
  else if ((fr = 0.25)or(fr = 0.75)) then begin //First and Last Quarter
    cor := -0.62801*sin(Mm) +
          0.17172*E*sin(M) +
          -0.01183*E*sin(Mm + M) +
          0.00862*sin(2*Mm) +
          0.00804*sin(2*F) +
          0.00454*E*sin(Mm - M) +
          0.00204*E2*sin(2*M) +
          -0.00180*sin(Mm - 2*F) +
          -0.00070*sin(Mm + 2*F) +
          -0.00040*sin(3*Mm) +
          -0.00034*E*sin(2*Mm - M) +
          0.00032*E*sin(M + 2*F) +
          0.00032*E*sin(M - 2*F) +
          -0.00028*E2*sin(Mm + 2*M) +
          0.00027*E*sin(2*Mm + M) +
          -0.00017*sin(ome) +
          -0.00005*sin(Mm - M - 2*F) +
          0.00004*sin(2*Mm + 2*F) +
          -0.00004*sin(Mm + M + 2*F) +
          0.00004*sin(Mm - 2*M) +
          0.00003*sin(Mm + M - 2*F) +
          0.00003*sin(3*M) +
          0.00002*sin(2*Mm - 2*F) +
          0.00002*sin(Mm - M + 2*F) +
          -0.00002*sin(3*Mm + M);
    result := result + cor;
    W := 0.00306 - 0.00038*E*cos(M) + 0.00026*cos(Mm) - 0.00002*cos(Mm - M) + 0.00002*cos(Mm + M) + 0.00002*cos(2*F);
    if (fr = 0.25) then //First quarter
      result := result + W
    else
      result := result - W;
  end
  else if (fr = 0.5) then begin //Full Moon
    cor := -0.40614*sin(Mm) +
          0.17302*E*sin(M) +
          0.01614*sin(2*Mm) +
          0.01043*sin(2*F) +
          0.00734*E*sin(Mm - M) +
          -0.00514*E*sin(Mm + M) +
          0.00209*E2*sin(2*M) +
          -0.00111*sin(Mm - 2*F) +
          -0.00057*sin(Mm + 2*F) +
          0.00056*E*sin(2*Mm + M) +
          -0.00042*sin(3*Mm) +
          0.00042*E*sin(M + 2*F) +
          0.00038*E*sin(M - 2*F) +
          -0.00024*E*sin(2*Mm - M) +
          -0.00017*sin(ome) +
          -0.00007*sin(Mm + 2*M) +
          0.00004*sin(2*Mm - 2*F) +
          0.00004*sin(3*M) +
          0.00003*sin(Mm + M - 2*F) +
          0.00003*sin(2*Mm + 2*F) +
          -0.00003*sin(Mm + M + 2*F) +
          0.00003*sin(Mm - M + 2*F) +
          -0.00002*sin(Mm - M - 2*F) +
          -0.00002*sin(3*Mm + M) +
          0.00002*sin(4*Mm);
    result := result + cor;
  end
  else result:=0/0;

  //Additional corrections
  cor:= 0.000325*sin(A1) +
        0.000165*sin(A2) +
        0.000164*sin(A3) +
        0.000126*sin(A4) +
        0.000110*sin(A5) +
        0.000062*sin(A6) +
        0.000060*sin(A7) +
        0.000056*sin(A8) +
        0.000047*sin(A9) +
        0.000042*sin(A10) +
        0.000040*sin(A11) +
        0.000037*sin(A12) +
        0.000035*sin(A13) +
        0.000023*sin(A14);
  result := result + cor;
end;

Procedure TPlanet.MoonPhases(year:double; var nm,fq,fm,lq : double);
var k : double;
begin
k := (year - 2000) * 12.3685;
k := floor(k);
nm := MoonPhase(k);
fq := MoonPhase(k+0.25);
fm := MoonPhase(k+0.50);
lq := MoonPhase(k+0.75);
end;

end.

