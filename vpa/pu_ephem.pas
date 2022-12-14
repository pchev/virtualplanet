unit pu_ephem;

{$mode objfpc}{$H+}

interface

uses   u_translation, u_constant, u_util, cu_planet, u_projection, cu_tz, math,
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, Buttons, Grids, EditBtn, enhedits, IpHtml;

type

  { Tf_ephem }

  Tf_ephem = class(TForm)
    annee: TLongEdit;
    annee1: TLongEdit;
    Button1: TButton;
    Compute1: TButton;
    FileNameEdit1: TFileNameEdit;
    jour: TLongEdit;
    jour1: TLongEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    step: TLongEdit;
    mois: TLongEdit;
    mois1: TLongEdit;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    UpDown4: TUpDown;
    UpDown5: TUpDown;
    UpDown6: TUpDown;
    procedure Compute1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    Fplanet: TPlanet;
    tz: TCdCTimeZone;
    geocentric: boolean;
    procedure SetLang;
  end; 

var
  f_ephem: Tf_ephem;

implementation

{$R pu_ephem.lfm}

{ Tf_ephem }


procedure Tf_ephem.FormShow(Sender: TObject);
begin
  FileNameEdit1.FileName:=slash(PrivateDir)+trim(pla[CurrentPlanet])+'_ephem.csv';
end;

procedure Tf_ephem.SetLang;
begin
  Caption:=rsSaveEphemeri;
  label9.Caption:=rsStartDate;
  label10.Caption:=rsEndDate;
  label1.Caption:=rsSteps;
  label2.Caption:=rsHours;
  Label3.Caption:=rst_1;
  Button1.Caption:=rst_99;
  Compute1.Caption:=rst_113;
end;

procedure Tf_ephem.Compute1Click(Sender: TObject);
var startljd,endljd,stepjd,ijd: extended;
    curjd,ctime: double;
    y1,y2,m1,m2,d1,d2: integer;
    prise, pset, ptransit, azimuthrise, azimuthset, eph: string;
    jd0, st0, q, cphase, colong, hh, az, ah: double;
    v1, v2, v3, v4, v5, v6, v7, v8, v9: double;
    gpa, glibrb, gsunincl, glibrl: double;
    aa, mm, dd, i, j,s: integer;
    ecl,nutl,nuto,sunl,sunb,abe,abp, ra, Dec, dist, diam, phase, illum,pha : double;
    magn,dp,xp,yp,zp,vel,De,Ds,w1,w2,w3: double;
    rad,ded, pa, librb, sunincl, librl,tphase, nmjd, fqjd, fmjd, lqjd,lunaison: double;
    CYear, CMonth, CDay,LastDay: integer;
    f: textfile;
    buf: string;
    supconj: boolean;
const sep='","';
      b = ' ';
  function  GetJDTimeZone(jdt: double): double;
  begin
      tz.JD := jdt;
      Result  := tz.SecondsOffset / 3600;
  end;
begin
  y1     :=annee.Value;
  m1     :=mois.Value;
  d1     :=jour.Value;
  startljd := jd(y1, m1, d1, 0);
  y2     :=annee1.Value;
  m2     :=mois1.Value;
  d2     :=jour1.Value;
  endljd := jd(y2, m2, d2, 23);
  stepjd:=step.Value/24;
  if (endljd>startljd)and(stepjd>0) then begin
  AssignFile(f,FileNameEdit1.FileName);
  rewrite(f);
  buf:='"'+pla[CurrentPlanet]+sep+rst_100;
  if geocentric then buf:=buf+sep+rst_26
     else buf:=buf+sep+formatfloat(f5,ObsLatitude)+sep+formatfloat(f5,ObsLongitude)+sep+ObsTZ;
  buf:=buf+'"';
  writeln(f,buf);
  buf:='"'+rsm_51+sep+rsm_51+' TT'+sep+rsm_51+' JD'+sep+'(J2000) '+rsm_29+sep+'(J2000) '+rsm_30+sep+
       '('+rsm_51+')'+b+rsm_29+sep+'('+rsm_51+')'+b+rsm_30+sep+rsm_31+sep+rsm_36+sep+
       rsm_32+sep+rsm_35+sep+rsm_45+sep+rsCentralMerid+sep+rsm_37+sep+rsm_73+sep+rsm_74+sep+
       rsm_38+sep+rsm_39+sep+rsm_40+sep+rsm_41+sep+rsm_55+sep+rsm_42+sep+rsEphemeris+'"';
  writeln(f,buf);
  LastDay:=-1;
  ijd:=startljd;
  timezone := GetJDTimeZone(ijd);
  repeat
    djd(ijd, CYear,CMonth,CDay, CTime);
    timezone := GetJDTimeZone(ijd-timezone/24);
    dt_ut := dtminusut(CYear);
    curjd:=ijd+(DT_UT-timezone)/24;
    djd(curjd, aa, mm, dd, hh);
    st0 := 0;
    ecl:=ecliptic(curjd);
    Fplanet.SetDE(jpldir);
    Fplanet.nutation(curjd,nutl,nuto);
    Fplanet.sunecl(curjd,sunl,sunb);
    PrecessionEcl(jd2000,curjd,sunl,sunb);
    Fplanet.aberration(curjd,abe,abp);
    if CurrentPlanet<=9 then begin
      Fplanet.planet(CurrentPlanet,curjd, ra, Dec, dist, illum,phase,diam,magn,dp,xp,yp,zp,vel);
    end else begin
      Fplanet.planet(CentralPlanet[CurrentPlanet],curjd, ra, Dec, dist, illum,phase,diam,magn,dp,xp,yp,zp,vel);
      pha:=abs(phase);
      Fplanet.PlanSat(CurrentPlanet,CurrentJD, ra, Dec, dist, supconj);
      if (CurrentPlanet>=12)and((CurrentPlanet<=15)) then begin
        s:=CurrentPlanet-11;
        diam:=rad2deg*(2*D0jup[s]/km_au/dist)*3600;
        magn:=V0jup[s]+5*log10(dp*dist)+0.005*pha;
      end;
    end;
    eph:=Fplanet.eph_method;
    Fplanet.planetOrientation(curjd,curjd-dist*tlight,CurrentPlanet, pa, De,Ds,w1,w2,w3);
    sunincl:=Ds;
    if not geocentric then
    begin
      jd0 := jd(CYear, CMonth, CDay, 0.0);
      st0 := SidTim(jd0, CTime - Timezone, ObsLongitude);
      Paralaxe(st0, dist, ra, Dec, ra, Dec, q, jd2000, curjd);
      diam := diam / q;
      dist := dist * q;
    end;
    apparent_equatorial(ra,Dec,ecl,sunl,abp,abe,nutl,nuto,true);
    rad := ra;
    ded := Dec;
    mean_equatorial(ra,Dec,ecl,sunl,abp,abe,nutl,nuto);
    precession(jd2000, curjd, rad, ded);
    buf:='"';
    buf:=buf+date2str(cyear, cmonth, cday) + ' ' + timtostr(ctime);
    buf:=buf+sep+date2str(aa, mm, dd) + ' ' + timtostr(hh);
    buf:=buf+sep+formatfloat(f5,ijd-(timezone)/24);
    buf:=buf+sep+ formatfloat(f6,rad2deg * ra / 15);
    buf:=buf+sep+ formatfloat(f5,rad2deg * Dec);
    buf:=buf+sep+ formatfloat(f6,rad2deg * rad / 15);
    buf:=buf+sep+ formatfloat(f5,rad2deg * ded);
    buf:=buf+sep+ formatfloat(f5,dist);
    buf:=buf+sep+ formatfloat(f2, diam);
    buf:=buf+sep+ formatfloat(f1, phase);
    buf:=buf+sep+ formatfloat(f2, illum);
    buf:=buf+sep+ formatfloat(f2, sunincl);
    buf:=buf+sep+ formatfloat(f1,w1);
    buf:=buf+sep+ formatfloat(f1, pa);
    if not geocentric then begin
      eq2hz(st0 - rad, ded, az, ah);
      az := rmod(rad2deg * az + 180, 360);
      buf:=buf+sep+formatfloat(f3,az);
      buf:=buf+sep+formatfloat(f2,rad2deg*ah);
      if CDay<>LastDay then begin
        LastDay:=CDay;
        Fplanet.PlanetRiseSet(CurrentPlanet, jd(CYear, CMonth, CDay, 0),True, prise, ptransit, pset, azimuthrise, azimuthset, v1, v2, v3, v4, v5, v6, v7, v8, v9, j);
        buf:=buf+sep+prise;
        buf:=buf+sep+ptransit;
        buf:=buf+sep+pset;
        buf:=buf+sep+azimuthrise;
        if obslatitude > 0 then begin
          buf:=buf+sep+formatfloat(f0,90-obslatitude+rad2deg*Dec);
        end else begin
          buf:=buf+sep+formatfloat(f0,90+obslatitude-rad2deg*Dec);
        end;
        buf:=buf+sep+azimuthset;
      end else begin
         buf:=buf+sep+' '+sep+' '+sep+' '+sep+' '+sep+' '+sep+' ';
      end;
    end else begin
      buf:=buf+sep+' '+sep+' '+sep+' '+sep+' '+sep+' '+sep+' '+sep+' '+sep+' ';
    end;
    buf:=buf+sep+eph;
    buf:=buf+'"';
    writeln(f,buf);
    ijd:=ijd+stepjd;
  until ijd>endljd;
  closefile(f);
  ModalResult:=mrOK;
  end
  else ShowMessage('Invalid date range!');
end;

end.

