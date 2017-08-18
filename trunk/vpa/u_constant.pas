unit u_constant;
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
 Type and constant declaration
}
{$mode objfpc}{$H+}
interface

uses
     dynlibs, Classes, Controls, Graphics;


const crlf = chr(10)+chr(13);
      cpyr = '(c)';//chr($a9)+chr($c2);  // ©
      VPAversion = '2.5';
      VersionName = 'VPA';
      vpacpy = 'Copyright '+cpyr+' 2017 Christian Legrand, Patrick Chevalley';
      vpaurl='http://ap-i.net/avp';
      vpaurlfr='http://ap-i.net/avp/fr/start';
      RefGRSLon=250.0;
      RefGRSdrift=16.5;
      RefGRSY=2016;
      RefGRSM=7;
      RefGRSD=1;
      jd2000 =2451545.0 ;
      jd1950 =2433282.4235;
      jd1900 =2415020.3135;
      km_au = 149597870.691 ;
      clight = 299792.458 ;
      tlight = km_au/clight/3600/24;
      maxpla = 15;
      REplanet: array [1..maxpla] of single = (2439.7,6051.8,0,3396.19,71492,60268,25559,24764,1187,0,0,1829.4,1562.6,2631.2,2410.3);  // planet equatorial radius Km
      RPplanet: array [1..maxpla] of single = (2439.7,6051.8,0,3376.20,66854,54364,24973,24341,1187,0,0,1815.7,1559.5,2631.2,2410.3);  // planet polar radius Km
      footpermeter = 0.3048;
      secday=3600*24;
      eps2000 = 23.43928111111111111111; // 23d 26m 21.412s
      sineps2k = 0.39777699580107953216;
      coseps2k = 0.917482131494378454;
      deg2rad = pi/180;
      rad2deg = 180/pi;
      pi2 = 2*pi;
      pi4 = 4*pi;
      pid2 = pi/2;
      minarc = deg2rad/60;
      secarc = deg2rad/3600;
      musec  = deg2rad/3600/1000000; // 1 microarcsec for rounding test
      DefaultPrtRes = 300;
      LightDist=1000;
      cameradist=2000;
      crRetic = 5;
      ox=36; oy=36; os=1500; px=0.95467; py=0.95467; //image 1500x1500, lune 1432x1432
      nummessage = 75;
      MaxLabel=500;
      InitialSprite=1000;
      AbsoluteMaxSprite=5000;
      Label3dSize=1;
      maxfocbase=1900;
      abek = secarc*20.49552;  // aberration constant
      maxlevel = 6;

      nJPL_DE = 7;
      JPL_DE: array [1..nJPL_DE] of integer = (423, 421, 422, 405, 406, 403, 200);

      // Paper size
      PaperNumber=9;
      PaperName : array[1..PaperNumber] of string=('A5','A4','A3', 'A2', 'A1', 'A0',  'Letter','Legal','Tabloid');
      PaperWidth: array[1..PaperNumber] of single=(5.83,8.27,11.69, 16.54,23.39,33.11, 8.5,     8.5,    11.0);
      PaperHeight:array[1..PaperNumber] of single=(8.27,11.69,16.54,23.39,33.11,46.81, 11.0,    14.0,   17.0);

      greek : array[1..2,1..24]of string=(('Alpha','Beta','Gamma','Delta','Epsilon','Zeta','Eta','Theta','Iota','Kappa','Lambda','Mu','Nu','Xi','Omicron','Pi','Rho','Sigma','Tau','Upsilon','Phi','Chi','Psi','Omega'),
              ('alp','bet','gam','del','eps','zet','eta','the','iot','kap','lam','mu','nu','xi','omi','pi','rho','sig','tau','ups','phi','chi','psi','ome'));
      greeksymbol : array[1..2,1..24]of string=(('alp','bet','gam','del','eps','zet','eta','the','iot','kap','lam','mu','nu','xi','omi','pi','rho','sig','tau','ups','phi','chi','psi','ome'),
                  ('a','b','g','d','e','z','h','q','i','k','l','m','n','x','o','p','r','s','t','u','f','c','y','w'));
      greekUTF8 : array[1..24] of word =($CEB1,$CEB2,$CEB3,$CEB4,$CEB5,$CEB6,$CEB7,$CEB8,$CEB9,$CEBA,$CEBB,$CEBC,$CEBD,$CEBE,$CEBF,$CF80,$CF81,$CF83,$CF84,$CF85,$CF86,$CF87,$CF88,$CF89);
      pla: array[1..32] of string =
        ('Mercury ', 'Venus   ', '*       ', 'Mars    ', 'Jupiter ',
        'Saturn  ', 'Uranus  ', 'Neptune ', 'Pluto   ', 'Sun     ', 'Moon    ',
        'Io      ', 'Europa  ', 'Ganymede', 'Callisto', 'Mimas   ', 'Enceladus',
        'Tethys  ', 'Dione   ',
        'Rhea    ', 'Titan   ', 'Hyperion', 'Iapetus ', 'Miranda ', 'Ariel   ',
        'Umbriel ', 'Titania ',
        'Oberon  ', 'Phobos  ', 'Deimos  ', 'Sat.Ring', 'E.Shadow');
      // the same but always with English name
      epla: array[1..32] of string =
        ('Mercury ', 'Venus   ', '*       ', 'Mars    ', 'Jupiter ',
        'Saturn  ', 'Uranus  ', 'Neptune ', 'Pluto   ', 'Sun     ', 'Moon    ',
        'Io      ', 'Europa  ', 'Ganymede', 'Callisto', 'Mimas   ', 'Enceladus',
        'Tethys  ', 'Dione   ',
        'Rhea    ', 'Titan   ', 'Hyperion', 'Iapetus ', 'Miranda ', 'Ariel   ',
        'Umbriel ', 'Titania ',
        'Oberon  ', 'Phobos  ', 'Deimos  ', 'Sat.Ring', 'E.Shadow');
      CentralPlanet: array[1..32]of integer=(1,2,3,4,5,6,7,8,9,10,11,5,5,5,5,6,6,6,6,6,6,6,6,7,7,7,7,7,4,4,6,3);
      V0mar: array [1..2] of double = (11.80, 12.89);
      V0jup: array [1..8] of double = (-1.68, -1.41, -2.09, -1.05,7.4,9.0,12.4,10.8);
      V0sat: array [1..19] of double = (3.30, 2.10, 0.60, 0.80, 0.10, -1.28, 4.63, 1.50, 6.7,4.9,6.1,8.8,9.1,9.4,9.5,6.2,6.9,12,13);
      V0ura: array [1..18] of double = (3.60, 1.45, 2.10, 1.02, 1.23,11.4,11.1,10.3,9.5,9.8,8.8,8.3,9.8,9.4,7.5,15,15,15);
      V0nep: array [1..8] of double = (-1.22, 4.0,10.0,9.1,7.9,7.6,7.3,5.6);
      V0plu: array [1..1] of double = (1.0);
      D0mar: array [1..2] of double = (11, 6);
      D0jup: array [1..8] of double = (1821, 1565, 2634, 2403,125,58,10,20);
      D0sat: array [1..19] of double = (199, 249, 530, 560, 764, 2575, 143, 718, 110,97,69,16,15,15,18.5,74,55,10,4);
      D0ura: array [1..18] of double = (236, 581, 585, 789, 761,13,16,22,33,29,42,55,29,34,77,5,5,5);
      D0nep: array [1..8] of double = (1350, 170,29,40,74,79,104,218);
      D0plu: array [1..1] of double = (605);
      blank15='               ';
      blank=' ';
      tab=#09;
      deftxt = '?';
      f0='0';
      f1='0.0';
      f1s='0.#';
      f2='0.00';
      f3='0.000';
      f4='0.0000';
      f5='0.00000';
      f6='0.000000';
      dateiso='yyyy"-"mm"-"dd"T"hh":"nn":"ss.zzz';
      HistoricalDir='Historical';
      nOptionalFeature= 16;
      OptionalFeatureCheck: array[1..nOptionalFeature]of string=(
                      'Apollo/ACOSTA_A15.jpg',
                      'ApolloMapping/ABBOT_A17.jpg',
                      'BestOfAmateurs/AGRIPPA_WIRTHS.jpg',
                      'Best_Pic_du_Midi/Archimedes_T1MPDM.jpg',
                      'Clementine/ABBOT_CLEM.jpg',
                      'Kaguya/ALPETRAGIUS_KAGUYA.jpg',
                      'CLA/ABBOT_D2.jpg',
                      'LAC_LM/ABENEZRA_LAC96.jpg',
                      'Lopam/ABBOT.jpg',
                      'Probes/ALPETRAGIUS_R9.jpg',
                      'Textures/Airbrush_no_albedo/L1/0.jpg',
                      'Textures/Clementine/L3/0.jpg',
                      'Textures/Lopam/L1/0.jpg',
                      'Textures/Bumpmap/wacdem.txt',
                      'Textures/Change/L3/0.jpg',
                      'Textures/WAC/L3/0.jpg'
                      );

      URL_GRS =  'http://jupos.privat.t-online.de/rGrs.htm';

{$ifdef linux}
      DefaultHome='~/';
      DefaultPrivateDir='~/.virtualplanet';
      Defaultconfigfile='~/.virtualplanet/vpa.rc';
      SharedDir='../share/virtualplanet';
      DefaultTmpDir='tmp';
      DefaultCdC='skychart';
      DefaultCdCconfig='~/.skychart/skychart.ini';
{$endif}
{$ifdef darwin}
      DefaultHome='~/';
      DefaultPrivateDir='~/.virtualplanet';
      Defaultconfigfile='~/.virtualplanet/vpa.rc';
      SharedDir='/usr/share/virtualplanet';
      DefaultTmpDir='tmp';
      DefaultCdC='skychart.app/Contents/MacOS/skychart';
      DefaultCdCconfig='~/.skychart/skychart.ini';
{$endif}
{$ifdef mswindows}
      DefaultPrivateDir='virtualplanet';
      Defaultconfigfile='vpa.rc';
      SharedDir='.\';
      DefaultTmpDir='tmp';
      DefaultCdC='skychart.exe';
      DefaultCdCconfig='Skychart\skychart.ini';
{$endif}

type
     double6 = array[1..6] of double;
     Pdouble6 = ^double6;

type
  TDBInfo = class(TObject)
    dbnum: integer;
  end;

type
  TLongSystem = (E360,E180,W360,W180);

// external library
const
{$ifdef linux}
      lib404   = 'libpasplan404.so.1';
{$endif}
{$ifdef darwin}
      lib404   = 'libplan404.dylib';
{$endif}
{$ifdef mswindows}
      lib404 = 'libplan404.dll';
{$endif}

// libplan404
const
jdmin404 = 625673.5;
jdmax404 = 2816787.5;
type
     TPlanetData = record
        JD : double;
         l : double ;
         b : double ;
         r : double ;
         x : double ;
         y : double ;
         z : double ;
         ipla : integer;
     end;
     PPlanetData = ^TPlanetData;
     TPlan404=Function( pla : PPlanetData):integer; cdecl;
var Plan404 : TPlan404;
    Plan404lib: TLibHandle;

// pseudo-constant only here
Var  Splashversion, compile_time, compile_version: string;
     BinDir, Homedir, Appdir, PrivateDir, SampleDir, DBdir, TempDir, ZoneDir, HelpDir,CdCdir,jpldir : string;
     Photlun,DatLun,WebLun,CdC,PrtName, transmsg : String;
     ObsLatitude,ObsLongitude,ObsAltitude : double;
     ObsTZ,ObsCountry: string;
     ObsTemperature,ObsPressure,ObsRefractionCor,ObsHorizonDepression : Double;
     TimeZone,DT_UT,ObsRoCosPhi,ObsRoSinPhi,CurrentJD : double;
     CurYear,CurrentMonth,CurrentDay : integer;
     CurrentTime,TimeBias,CurrentST,DT_UT_val,CurrentSunH,CurrentMoonH,CurrentMoonIllum,diam : Double;
     PlanetParalaxe: boolean;
     GRSL,GRSLE,GRSLongitude,GRSDailydrift,GRSjd: double;
     ForceConfig, Configfile, CdCconfig, language, uplanguage : string;
     ldeg,lmin,lsec : string;
     PrinterResolution: integer;
     AsMultiTexture : Boolean;
     Firstsearch: boolean;
     DisplayIs32bpp: Boolean;
     ThemePath:string ='data/Themes';
     LinuxDesktop: integer = 0;  // FreeDesktop=0, KDE=1, GNOME=2, Other=3
     Params : TStringList;
     OptionalFeatureName: array[1..nOptionalFeature]of string;
     de_folder: string;
     de_type, de_year: integer;
     CurrentPlanet: integer;
     PlanetInstalled: array [1..maxpla] of boolean;
     LongSystem: array[1..maxpla] of TLongSystem;
{$ifdef darwin}
     OpenFileCMD:string = 'open';   //
{$else}
     OpenFileCMD:string = 'xdg-open';   // default FreeDesktop.org
{$endif}
     // to move to pu_moon properties:
     labelcenter,showlabel,showmark: boolean;
     CurrentEyepiece,marksize, CurrentCCD: integer;
     marklabelcolor, markcolor, SpriteColor: Tcolor;

// Text formating constant
const
     html_h        = '<HTML><body bgcolor="#FFFFFF" text="#000000">';
     html_h_nv     = '<HTML><body bgcolor="#000000" text="#C03030">';
     htms_h        = '</body></HTML>';
     html_ffx      = '<font face="fixed">';
     htms_f        = '</font>';
     html_b        = '<b>';
     htms_b        = '</b>';
     html_h2       = '<font size="+2"><b>';
     htms_h2       = '</b></font><br>';
     html_p        = '<p>';
     htms_p        = '</p>';
     html_br       = '<br>';
     html_sp       = '&nbsp;';
     html_pre      = '<pre>';
     htms_pre      = '</pre>';


type
  TPlanData = record
    l: double;
    b: double;
    r: double;
    x: double;
    y: double;
    z: double;
  end;

implementation

end.

