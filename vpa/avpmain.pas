unit avpmain;

{$MODE delphi}
{$H+}

{
Copyright (C) 2003 Patrick Chevalley

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
interface

uses
{$ifdef mswindows}
  Windows, Registry, ShlObj,
{$endif}
{$IFDEF LCLgtk}
  GtkProc,
{$endif}
{$IFDEF LCLgtk2}
  Gtk2Proc,
{$endif}    GLScene, u_translation_database, u_translation, u_constant, u_util,
cu_planet, u_projection, cu_tz, pu_planet, LCLIntf, Forms, StdCtrls, ExtCtrls,
Graphics, Grids, mlb2, PrintersDlgs, Printers, Controls, Messages, SysUtils,
Classes, Dialogs, FileUtil, ComCtrls, Menus, Buttons, dynlibs, BigIma, EnhEdits,
IniFiles, passql, passqlite, Math, CraterList, LResources, EditBtn, IpHtml,
UniqueInstance, GLViewer, GLLCLViewer;

type

  { Tf_avpmain }

  Tf_avpmain = class(TForm)
    BitBtn37: TBitBtn;
    Button12: TButton;
    Button13: TButton;
    Button21: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    ComboBox2: TComboBox;
    ComboBox6: TComboBox;
    GRSDateEdit: TDateEdit;
    Desc1:   TIpHtmlPanel;
    FilePopup: TPopupMenu;
    DoNotRemove: TGLSceneViewer;
    GRS: TFloatEdit;
    GRSdrift: TFloatEdit;
    HelpPopup: TPopupMenu;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label27: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label7: TLabel;
    LabelIncl: TLabel;
    LabelAltitude: TLabel;
    Label5: TLabel;
    FullScreen1: TMenuItem;
    DecreaseFont1: TMenuItem;
    IncreaseFont1: TMenuItem;
    GRSPanel: TPanel;
    SelectJupiter: TMenuItem;
    Menuwebpage: TMenuItem;
    SelectPlanet1: TMenuItem;
    SelectMercury: TMenuItem;
    SelectVenus: TMenuItem;
    SelectMars: TMenuItem;
    SaveEphem: TMenuItem;
    PanelRot: TPanel;
    PanelPlanet: TPanel;
    PanelPlanet2: TPanel;
    PrintDialog1: TPrintDialog;
    Quitter1: TMenuItem;
    PageControl1: TPageControl;
    Position: TTabSheet;
    Panel1:  TPanel;
    Button1: TButton;
    Button2: TButton;
    Ephemerides: TTabSheet;
    Panel4:  TPanel;
    Label6:  TLabel;
    Label9:  TLabel;
    jour:    TLongEdit;
    mois:    TLongEdit;
    annee:   TLongEdit;
    RadioGroup2: TRadioGroup;
    seconde: TLongEdit;
    minute:  TLongEdit;
    heure:   TLongEdit;
    Button4: TButton;
    Button5: TButton;
    Apropos1: TMenuItem;
    SpeedButton7: TSpeedButton;
    Splitter1: TSplitter;
    GridButton: TToolButton;
    Splitter2: TSplitter;
    StartTimer: TTimer;
    ResizeTimer: TTimer;
    SetFPSTimer: TTimer;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    TrackBar6: TTrackBar;
    TrackBar7: TTrackBar;
    TrackBar8: TTrackBar;
    ZoomTimer: TTimer;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    UpDown4: TUpDown;
    UpDown5: TUpDown;
    UpDown6: TUpDown;
    CentralMeridian: TTabSheet;
    Reglage: TTabSheet;
    TrackBar2: TTrackBar;
    Label8:  TLabel;
    TrackBar3: TTrackBar;
    Label11: TLabel;
    TrackBar4: TTrackBar;
    Label12: TLabel;
    Bevel1:  TBevel;
    Label14: TLabel;
    ComboBox1: TComboBox;
    Button3: TSpeedButton;
    Button6: TSpeedButton;
    Button7: TSpeedButton;
    Button8: TSpeedButton;
    EphTimer1: TTimer;
    Panel5:  TPanel;
    ListBox1: TListBox;
    RadioGroup1: TRadioGroup;
    Aide2:   TMenuItem;
    StringGrid1: TStringGrid;
    PopupMenu1: TPopupMenu;
    Position1: TMenuItem;
    Centre1: TMenuItem;
    Zoom1:   TMenuItem;
    x11:     TMenuItem;
    x21:     TMenuItem;
    x41:     TMenuItem;
    Outils:  TTabSheet;
    Bevel4:  TBevel;
    Label23: TLabel;
    Button11: TButton;
    Edit1:   TEdit;
    Edit2:   TEdit;
    Label24: TLabel;
    Label25: TLabel;
    Distance1: TMenuItem;
    CartesduCiel1: TMenuItem;
    Imprimer1: TMenuItem;
    Enregistrersous1: TMenuItem;
    Voisinage1: TMenuItem;
    BMP1:    TMenuItem;
    SaveDialog1: TSaveDialog;
    JPG1:    TMenuItem;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Selectiondimprimante1: TMenuItem;
    Memo2:   TMemo;
    PopupMenu2: TPopupMenu;
    Copy1:   TMenuItem;
    SelectAll1: TMenuItem;
    StatusBar1: TStatusBar;
    N1:      TMenuItem;
    N2:      TMenuItem;
    N3:      TMenuItem;
    ControlBar1: TPanel;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton8: TToolButton;
    ToolBar1: TToolBar;
    Label10: TLabel;
    TrackBar1: TTrackBar;
    ToolButton9: TToolButton;
    ToolButton5: TToolButton;
    ToolButton10: TToolButton;
    Edit3:   TEdit;
    Edit4:   TEdit;
    Label1:  TLabel;
    Label2:  TLabel;
    Label3:  TLabel;
    ToolButton3: TToolButton;
    Notes:   TTabSheet;
    Memo1:   TMemo;
    Panel7:  TPanel;
    notes_name: TLabel;
    Button15: TButton;
    Notes1:  TMenuItem;
    Panel8:  TPanel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    TrackBar5: TTrackBar;
    GroupBox2: TGroupBox;
    Rotation1: TMenuItem;
    N5seconde1: TMenuItem;
    Stop1:   TMenuItem;
    N10seconde1: TMenuItem;
    N1seconde1: TMenuItem;
    N02seconde1: TMenuItem;
    N05seconde1: TMenuItem;
    EastWest1: TMenuItem;
    GroupBox3: TGroupBox;
    Label4:  TLabel;
    ComboBox4: TComboBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    OverlayCaption1: TMenuItem;
    OverlayCaption2: TMenuItem;
    dbm:     TLiteDB;
    NewWindowButton: TToolButton;
    PhaseButton: TToolButton;
    Button10: TButton;
    N4:      TMenuItem;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    ToolButton11: TToolButton;
    RemoveMark1: TMenuItem;
    CheckBox8: TCheckBox;
    ImageList1: TImageList;
    ToolButton12: TToolButton;
    procedure BitBtn37Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button3MouseLeave(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure FullScreen1Click(Sender: TObject);
    procedure GridButtonClick(Sender: TObject);
    procedure Desc1HotClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DecreaseFont1Click(Sender: TObject);
    procedure GRSChange(Sender: TObject);
    procedure GRSDateEditChange(Sender: TObject);
    procedure GRSdriftChange(Sender: TObject);
    procedure IncreaseFont1Click(Sender: TObject);
    procedure MenuwebpageClick(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure Configuration1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ResizeTimerTimer(Sender: TObject);
    procedure SaveEphemClick(Sender: TObject);
    procedure SelectPlanet(Sender: TObject);
    procedure SetFPSTimerTimer(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure Splitter2Moved(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton8Click(Sender: TObject);
    procedure Apropos1Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure Button3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Button3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Button6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Button7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Button8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure EphTimer1Timer(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Aide2Click(Sender: TObject);
    procedure Position1Click(Sender: TObject);
    procedure TrackBar6Change(Sender: TObject);
    procedure TrackBar7Change(Sender: TObject);
    procedure TrackBar8Change(Sender: TObject);
    procedure x21Click(Sender: TObject);
    procedure x41Click(Sender: TObject);
    procedure Button12MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Button13MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Button11Click(Sender: TObject);
    procedure Distance1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CartesduCiel1Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure BMP1Click(Sender: TObject);
    procedure JPG1Click(Sender: TObject);
    procedure Selectiondimprimante1Click(Sender: TObject);
    procedure Imprimer1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure x81Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure UpdNotesClick(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Notes1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure Stop1Click(Sender: TObject);
    procedure N5seconde1Click(Sender: TObject);
    procedure N10seconde1Click(Sender: TObject);
    procedure N1seconde1Click(Sender: TObject);
    procedure N02seconde1Click(Sender: TObject);
    procedure N05seconde1Click(Sender: TObject);
    procedure EastWest1Click(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure OverlayCaption1Click(Sender: TObject);
    procedure NewWindowButtonClick(Sender: TObject);
    procedure PhaseButtonClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure RemoveMark1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure ZoomTimerTimer(Sender: TObject);
  private
    UniqueInstance1: TCdCUniqueInstance;
    planet1, planet2, activeplanet : TF_planet;
    CursorImage1: TCursorImage;
    tz: TCdCTimeZone;
    ima: TBigImaForm;
    ToolsWidth: integer;
    FullScreen: boolean;
    lockzoombar,notexture,TextureBW: boolean;
    texturenone: TStringList;
    texturefiles: array[1..maxpla]of TStringList;
    SplitSize: single;
    nutl,nuto,abe,abp,sunl,sunb,ecl:double;
    firstuse,CanCloseDatlun,CanClosePhotlun,CanCloseWeblun,CanCloseCDC,StartDatlun,StartWeblun,StartPhotlun,StartCDC: boolean;
    Desctxt: string;
    {$ifdef windows}
    savetop,saveleft,savewidth,saveheight: integer;
    {$endif}
    procedure OpenCDC(objname,otherparam:string);
    procedure OtherInstance(Sender : TObject; ParamCount: Integer; Parameters: array of String);
    procedure InstanceRunning(Sender : TObject);
    procedure SetLang1;
    procedure SetLang;
    procedure InitObservatoire;
    procedure GetAppDir;
    function GetTimeZone(sdt: Tdatetime): double;
    function GetJDTimeZone(jdt: double): double;
    procedure ReadParam(first:boolean=true);
    procedure SetObs(param: string);
    procedure Readdefault;
    procedure SaveDefault;
    procedure UpdCentralMeridian(range:double=20; fromequator:boolean=false);
    procedure AddToList(buf: string);
    procedure GetDetail(row: TResultRow; memo: Tmemo);
    procedure GetHTMLDetail(row: TResultRow; var txt: string);
    procedure RefreshDetail;
    procedure GetNotes(n: string);
    procedure InitDate;
    procedure SetJDDate;
    procedure GetMsg(Sender: TObject; msgclass:TplanetMsgClass; value: String);
    procedure IdentLB(l, b, w: single);
    procedure ShowImg(desc, nom: string; forceinternal: boolean);
    procedure SetDate(param: string);
    procedure SetDescText(const Value: string);
    procedure SetZoomBar;
    procedure GetSkychartInfo;
    procedure SetActiveplanet(mf: Tf_planet);
    procedure SetPlanet(p:integer);
    procedure planetClickEvent(Sender: TObject; Button: TMouseButton;
                     Shift: TShiftState; X, Y: Integer;
                     Onplanet: boolean; Lon, Lat: Single);
    procedure planetMoveEvent(Sender: TObject; X, Y: Integer;
                     Onplanet: boolean; Lon, Lat: Single);
    procedure planetMeasureEvent(Sender: TObject; m1,m2,m3,m4: string);
    public
    autolabelcolor: Tcolor;
    lastx, lasty, lastyzoom, MaxSprite: integer;
    LastIma, startx, starty, saveimagesize: integer;
    LeftMargin, PrintTextWidth, clickX, clickY: integer;
    PrintEph, PrintDesc, phaseeffect, PrintChart: boolean;
    wheelstep, EphStep, fov, searchl,
    searchb, markx, marky, flipx, rotstep, lunaison: double;
    ra, Dec, rag2000,deg2000, dist, dkm, phase, illum, pa, sunincl, parallacticangle, currentmeridian,
    by, bxpos, dummy: double;
    editrow, notesrow, rotdirection, searchpos,BumpMethod: integer;
    dbedited: boolean;
    SkipIdent, geocentric, FollowNorth, ZenithOnTop, notesok, notesedited,
    shortdesc, BumpMipmap: boolean;
    lockmove, lockrepeat, saveimagewhite, skipresize,skiporient, skiprot: boolean;
    searchtext, imac1, imac2, imac3: string;
    helpprefix, markname, currentname, currentid: string;
    appname, pofile: string;
    num_bl: integer;
    bldb: array[1..20] of string;
    CameraOrientation, PoleOrientation, startl, startb, startxx, startyy: double;
    curx, cury: double;
    LabelDensity, phaseoffset, gridspacing: integer;
    perfdeltay: double;
    ddeparam, currenttexture, currentselection: string;
    overlayname: array[1..maxpla] of string;
    overlaytr: array[1..maxpla] of single;
    showoverlay: array[1..maxpla] of boolean;
    wantbump: array[1..maxpla] of boolean;
    CielHnd: Thandle;
    lockchart: boolean;
    StartedByDS: boolean;
    distancestart: boolean;
    param:  TStringList;
    imgdir: array of array[0..2] of string;
    LONGIN, LATIN, WIDEKM, LENGHTKM, FNAME, INTERESTN, DIAMINST, wordformat: integer;
    overlayhi, overlayimg: Tbitmap;
    zoom:   double;
    useDBN: integer;
    currentl, currentb: double;
    searchlist: TStringList;
    compresstexture,antialias : boolean;
    ForceBumpMapSize: integer;
    LastScopeTracking: double;
    UseComputerTime: boolean;
    procedure Init;
    Procedure InitNotes;
    procedure LoadOverlay(fn: string; transparent: single);
    procedure GetLabel(Sender: TObject);
    procedure GetSprite(Sender: TObject);
    function SearchAtPos(l, b, w: double): boolean;
    procedure ListObject(delta: double);
    procedure SetFullScreen;
    procedure RefreshplanetImage;
    function SearchName(n: string; center: boolean): boolean;
    Procedure SelectMedirian;
    function FormatLongitude(l:double):string;
    function LongitudeSystemName:string;
  end;

var
  f_avpmain:   Tf_avpmain;
  dbnotes: TMlb2;
  Fplanet: TPlanet;

implementation

{$R avpmain.lfm}

uses
  config, splashunit, pu_ephem,
  fmsg, dbutil, LCLProc;

procedure Tf_avpmain.SetLang1;
var
  section: string;
  inifile:      Tmeminifile;
const
  deftxt = '?';
  blank  = '        ';
  b      = ' ';
begin
  language := '';
  inifile := Tmeminifile.Create(ConfigFile);
  with inifile do
  begin
    section := 'default';
    language     := ReadString(section, 'lang_po_file', language);
  end;
  inifile.Free;
  chdir(appdir);
  language:=u_translation.translate(language,'en');
  uplanguage:=UpperCase(language);
  u_translation_database.translate(language,'en');
  ldeg     := rsdegree;
  lmin     := rsminute;
  lsec     := rssecond;
  transmsg := rstranslator;
  Caption  := rstitle;
end;

procedure Tf_avpmain.SetLang;
var
  buf: string;
const
  deftxt = '?';
  blank  = '        ';
  b      = ' ';
begin
  wordformat := 0;
    wordformat := strtointdef(rsformat, wordformat);
    ldeg     := rsdegree;
    lmin     := rsminute;
    lsec     := rssecond;
    transmsg := rstranslator;
    Caption  := rstitle;
    helpprefix := rshelp_prefix;
    ToolButton1.Caption := rst_1;
    quitter1.Caption := rst_2;
    ToolButton2.Caption := rst_3;
    label10.Caption := rst_4;
    zoom1.Caption := label10.Caption;
    ToolButton9.Hint:=rst_31+' 1:1';
    toolbutton5.hint := rst_5;
    centre1.Caption := toolbutton5.hint;
    Position.Caption := rst_6;
    Position1.Caption := Position.Caption;
    Ephemerides.Caption := rst_7;
    SaveEphem.Caption:=rsSaveEphemeri;
    Button1.Caption := rst_10;
    Button2.Caption := rst_11;
    Label9.Caption := rsm_51;
    Label6.Caption := rsm_50;
    toolbutton8.Caption := rst_15;
    aide2.Caption := toolbutton8.Caption;
    Menuwebpage.Caption:=rsVPAWebPage;
    Apropos1.Caption := rst_16;
    Button5.Caption := rst_17;
    Button4.Caption := rst_113;
    Label14.Caption := rst_32;
    Label8.Caption := rst_33;
    Label11.Caption := rst_34;
    Label12.Caption := rst_35;
    Label16.Caption := rst_36;
    Label13.Caption := rst_37;
    CentralMeridian.Caption := rsCentralMerid;
    RadioGroup1.Caption := rst_46;
    RadioGroup1.Items[0] := rst_47;
    RadioGroup1.Items[1] := rst_19;
    Reglage.Caption  := rst_55;
    RadioGroup1.ItemIndex := 0;
    CartesduCiel1.Caption := rst_56;
    Outils.Caption   := rst_63;
    label40.Caption  := b + rst_64 + b;
    Button12.Caption := rst_65;
    Button13.Caption := rst_66;
    RadioGroup2.Caption := rst_67;
    RadioGroup2.Items[0]:=rst_72;
    RadioGroup2.Items[1]:=rst_73;
    CheckBox1.Caption := rst_68;
    checkbox4.Caption:=rsLocalZenithO;
    distance1.Caption := rst_69;
    FullScreen1.Caption:=rsFullScreen;
    ToolButton13.Hint:=rsFullScreen;
    label23.Caption  := b + distance1.Caption + b;
    label24.Caption  := rst_70;
    label25.Caption  := rst_71;
    CheckBox2.Caption := rst_74;
    Enregistrersous1.Caption := rst_78;
    Imprimer1.Caption := rst_79;
    ToolButton10.hint := rst_81;
    Voisinage1.Caption := ToolButton10.hint;
    Selectiondimprimante1.Caption := rst_82;
    selectall1.Caption := rst_84;
    copy1.Caption    := rst_85;
    DecreaseFont1.Caption:=rsDecreaseFont;
    IncreaseFont1.Caption:=rsIncreaseFont;
    button15.Caption := rst_114;
    Notes.Caption    := rst_115;
    Notes1.Caption   := Notes.Caption;
    label3.Caption   := rst_116;
    groupbox2.Caption := rst_125;
    label1.Caption   := rst_153;
    label2.Caption   := rst_154;
    PhaseButton.hint := rst_176;
    ToolButton4.hint := rst_177;
    ToolButton6.hint := rst_178;
    RemoveMark1.Caption := rst_180;
    CheckBox8.Caption := rst_182;
    Toolbutton12.hint := rsShowLabels;
    GridButton.Hint:=rsShowGrid;
    ToolButton14.Hint:=rsShowScale;
    Toolbutton3.hint := rst_134;
    NewWindowButton.hint := rst_166;
    Button21.Caption:=rsDefault;
    imac1 := rst_30;
    imac2 := rst_8;
    imac3 := rst_9;
    num_bl:=nrsb;
    bldb[1] := rsb_1;
    bldb[2] := rsb_2;
    bldb[3] := rsb_3;
    bldb[4] := rsb_4;
    bldb[5] := rsb_5;
    bldb[6] := rsb_6;
    bldb[7] := rsb_7;
    bldb[8] := rsb_8;
    bldb[9] := rsb_9;
    if f_ephem<>nil then f_ephem.Setlang;
    Label7.Caption:=rsMinimalLengt;
    SelectPlanet1.Caption:=rsPlanetSelect;
    pla[1]:=rsMercury;
    pla[2]:=rsVenus;
    pla[4]:=rsMars;
    pla[5]:=rsJupiter;
    pla[6]:=rsSaturn;
    pla[7]:=rsUranus;
    pla[8]:=rsNeptune;
    pla[9]:=rsPluto;
    SelectMercury.Caption:=pla[1];
    SelectVenus.Caption:=pla[2];
    SelectMars.Caption:=pla[4];
end;

procedure Tf_avpmain.InitObservatoire;
var
  u, p: double;
const
  ratio = 0.99664719;
  H0    = 6378140.0;
begin
  p := degtorad(ObsLatitude);
  u := arctan(ratio * tan(p));
  ObsRoSinPhi := ratio * sin(u) + (ObsAltitude / H0) * sin(p);
  ObsRoCosPhi := cos(u) + (ObsAltitude / H0) * cos(p);
  ObsRefractionCor := 1;
end;

function Tf_avpmain.GetTimeZone(sdt: Tdatetime): double;
begin
    tz.Date := sdt;
    Result  := tz.SecondsOffset / 3600;
end;

function  Tf_avpmain.GetJDTimeZone(jdt: double): double;
begin
    tz.JD := jdt;
    Result  := tz.SecondsOffset / 3600;
end;

procedure Tf_avpmain.Readdefault;
var
  inif:    TMemIniFile;
  section: string;
  DefaultTexture:string;
  i,j,k:    integer;
  smooth:  integer;
  labf: TFont;
begin
  timezone := 0;
  Obslatitude := 48.86;
  Obslongitude := -2.33;
  ObsCountry:='FR';
  ObsTZ    := 'Europe/Paris';
  Obsaltitude := 0;
  phaseeffect := True;
  geocentric := False;
  wheelstep := 1.05;
  marklabelcolor := clYellow;
  markcolor := clRed;
  spritecolor:=clRed;
  autolabelcolor := clWhite;
  labelcenter := True;
  shortdesc:=true;
  showlabel := True;
  showmark := True;
  currentselection := '';
  lockmove := False;
  LabelDensity := 400;
  gridspacing:=15;
  marksize := 5;
  saveimagesize := 0;
  saveimagewhite := False;
  lastima  := 0;
  currentmeridian := -999;
  fov      := 45;
  CameraOrientation := 0;
  PoleOrientation := 0;
  FollowNorth := False;
  ZenithOnTop := False;
  flipx    := 1;
  LeftMargin := 10;
  PrintTextWidth := 700;
  PrintChart := True;
  PrintEph := True;
  PrintDesc := True;
  rotdirection := -1;
  rotstep  := 1;
  smooth   := 360;
  LongSystem[1]:=E360;
  LongSystem[2]:=W360;
  LongSystem[4]:=W360;
  LongSystem[5]:=W360;
  LongSystem[6]:=W360;
  LongSystem[7]:=W360;
  LongSystem[8]:=W360;
  GRSlongitude:=208.0;
  GRSjd:=jd(2014,1,31,0);
  GRSDailydrift:=16.5/365.25;
  for k:=1 to maxpla do  begin
    wantbump[k] := false;
    showoverlay[k] := False;
    case k of
       1: DefaultTexture:='Messenger';
       2: DefaultTexture:='Magellan';
       4: DefaultTexture:='Viking_Color';
       5: DefaultTexture:='Hubble2016'
       else DefaultTexture:='NONE';
    end;
    for j:=0 to 5 do begin
      texturefiles[k][j]:=DefaultTexture;
    end;
  end;
  inif := Tmeminifile.Create(ConfigFile);
  firstuse := (not inif.SectionExists('default'));
  BumpMethod:=0;
  BumpMipmap:= true;
  with inif do
  begin
    section     := 'images';
    saveimagesize := ReadInteger(section, 'SaveImageSize', saveimagesize);
    saveimagewhite := ReadBool(section, 'SaveImageWhite', saveimagewhite);
    section    := 'Print';
    LeftMargin := ReadInteger(section, 'LeftMargin', LeftMargin);
    PrintTextWidth := ReadInteger(section, 'PrintTextWidth', PrintTextWidth);
    PrintChart := ReadBool(section, 'PrintChart', PrintChart);
    PrintEph   := ReadBool(section, 'PrintEph', PrintEph);
    PrintDesc  := ReadBool(section, 'PrintDesc', PrintDesc);
    section    := 'default';
    pofile     := ReadString(section, 'lang_po_file', '');
    UseComputerTime := ReadBool(section, 'UseComputerTime', UseComputerTime);
    compresstexture := ReadBool(section, 'compresstexture', compresstexture);
    antialias := ReadBool(section, 'antialias', antialias);
    ForceBumpMapSize := ReadInteger(section, 'ForceBumpMapSize', ForceBumpMapSize);
    Obslatitude  := ReadFloat(section, 'Obslatitude', Obslatitude);
    Obslongitude := ReadFloat(section, 'Obslongitude', Obslongitude);
    ObsCountry  := ReadString(section, 'ObsCountry', ObsCountry);
    ObsTZ := ReadString(section, 'ObsTZ', ObsTZ);
    tz.TimeZoneFile := ZoneDir + StringReplace(ObsTZ, '/', PathDelim, [rfReplaceAll]);
    if UseComputerTime then
      timezone := gettimezone(now)
    else
    begin
      CurrentJD := ReadFloat(section, 'CurrentJD', CurrentJD);
      dt_ut     := ReadFloat(section, 'dt_ut', dt_ut);
      timezone := GetJDTimeZone(CurrentJD);
    end;
    CurrentPlanet := ReadInteger(section, 'CurrentPlanet', CurrentPlanet);
    for k:=1 to maxpla do LongSystem[k] := TLongSystem(ReadInteger(section, 'LongSystem_'+IntToStr(k), ord(LongSystem[k])));
    cameraorientation := ReadFloat(section, 'CameraOrientation', CameraOrientation);
    phaseeffect  := ReadBool(section, 'PhaseEffect', phaseeffect);
    for k:=1 to maxpla do wantbump[k]  := ReadBool(section, 'BumpMap_'+IntToStr(k), wantbump[k]);
    ShowLabel    := ReadBool(section, 'ShowLabel', ShowLabel);
    ShowMark     := ReadBool(section, 'ShowMark', ShowMark);
    MarkLabelColor   := ReadInteger(section, 'LabelColor', MarkLabelColor);
    MarkColor    := ReadInteger(section, 'MarkColor', MarkColor);
    spritecolor:=markcolor;
    AutolabelColor := ReadInteger(section, 'AutolabelColor', AutolabelColor);
    gridspacing := ReadInteger(section, 'GridSpacing', gridspacing);
    LabelDensity := ReadInteger(section, 'LabelDensity', LabelDensity);
    marksize     := ReadInteger(section, 'MarkSize', marksize);
    labelcenter  := ReadBool(section, 'LabelCenter', labelcenter);
    FollowNorth  := ReadBool(section, 'FollowNorth', FollowNorth);
    ZenithOnTop  := ReadBool(section, 'ZenithOnTop', ZenithOnTop);
    CheckBox2.Checked := ReadBool(section, 'Mirror', False);
    GridButton.Down:= ReadBool(section, 'Grid', False);
    PoleOrientation := ReadFloat(section, 'PoleOrientation', PoleOrientation);
    ToolsWidth:=ReadInteger(section, 'ToolsWidth', ToolsWidth);
    if ToolsWidth<100 then ToolsWidth:=100;
    PageControl1.Width:=ToolsWidth;
    i := ReadInteger(section, 'Top', 10);
    if (i >= -10) and (i < screen.Height - 30) then
        Top := i
    else
        Top := 0;
    i := ReadInteger(section, 'Left', 0);
    if (i >= -10) and (i < screen.Width - 20) then
      Left := i
    else
      Left := 0;
    i := screen.Height - 100;
    i   := minintvalue([i, ReadInteger(section, 'Height', i)]);
    if (i >= 200) then
      Height := i;
    i := screen.Width - 100;
    i := minintvalue([i, ReadInteger(section, 'Width', i)]);
    if (i >= 200) then
      Width := i;
    if ReadBool(section, 'Maximized', False) then
      windowstate := wsMaximized;
    notexture := ReadBool(section, 'notexture', notexture);
    TextureBW := ReadBool(section, 'TextureBW', TextureBW);
    for k:=1 to maxpla do
     for j:=0 to 5 do
      texturefiles[k][j] := ReadString(section, 'texturefile_'+IntToStr(k)+'_'+IntToStr(j), texturefiles[k][j]);

    labf:=TFont.Create;
   // labf:=planet1.LabelFont;
    labf.Assign(planet1.LabelFont);
    labf.Name := ReadString(section, 'LabelFontName', labf.Name);
    labf.Size := ReadInteger(section, 'LabelFontSize', labf.Size);
    labf.Style:=[];
    if ReadBool(section, 'LabelFontBold', false) then labf.Style:=labf.Style+[fsBold];
    if ReadBool(section, 'LabelFontItalic', false) then labf.Style:=labf.Style+[fsItalic];
    planet1.LabelFont:=labf;
//    labf.Free;
    Desc1.DefaultFontSize:=ReadInteger(section, 'DescFontSize', Desc1.DefaultFontSize);
    for k:=1 to maxpla do begin
      overlayname[k] := ReadString(section, 'overlayname_'+IntToStr(k), '');
      overlaytr[k]  := ReadFloat(section, 'overlaytr_'+IntToStr(k), 0);
      showoverlay[k] := ReadBool(section, 'showoverlay_'+IntToStr(k), showoverlay[k]);
    end;
    planet1.AmbientColor := ReadInteger(section, 'AmbientLight', planet1.AmbientColor);
    planet1.DiffuseColor := ReadInteger(section, 'DiffuseLight', planet1.DiffuseColor);
    planet1.SpecularColor :=ReadInteger(section, 'SpecularLight', planet1.SpecularColor);
    smooth := ReadInteger(section, 'Smooth', smooth);
    i := ReadInteger(section, 'ListCount', 0);
    if i > 0 then
      for j := 0 to i do
      begin
        combobox1.Items.add(ReadString(section, 'List_' + IntToStr(j), ''));
      end;
  end;
  inif.Free;
  chdir(appdir);
  InitObservatoire;
  planet1.GLSphereplanet.Slices := smooth;
  planet1.GLSphereplanet.Stacks := smooth div 2;
end;

procedure Tf_avpmain.SaveDefault;
var
  inif: TMemIniFile;
  i,k:    integer;
  section: string;
begin
  inif := Tmeminifile.Create(ConfigFile);
  try
    section := 'default';
    with inif do
    begin
      if not (ValueExists(section, 'Install_Dir')) then
        WriteString(section, 'Install_Dir', appdir);
      WriteString(section, 'lang_po_file', Language);
      WriteBool(section, 'compresstexture', compresstexture);
      WriteBool(section, 'antialias', antialias);
      WriteInteger(section, 'ForceBumpMapSize', ForceBumpMapSize);
      WriteInteger(section, 'CurrentPlanet', CurrentPlanet);
      for k:=1 to maxpla do WriteInteger(section, 'LongSystem_'+IntToStr(k), ord(LongSystem[k]));
      WriteFloat(section, 'CameraOrientation', CameraOrientation);
      WriteInteger(section, 'useDBN', useDBN);
      for k:=1 to maxpla do begin
        WriteString(section, 'overlayname_'+IntToStr(k), overlayname[k]);
        WriteFloat(section, 'overlaytr_'+IntToStr(k), overlaytr[k]);
        WriteBool(section, 'showoverlay_'+IntToStr(k), showoverlay[k]);
      end;
      WriteBool(section, 'notexture', notexture);
      WriteBool(section, 'TextureBW', TextureBW);
      for k:=1 to maxpla do
        for i := 0 to 5 do
          WriteString(section, 'texturefile_'+IntToStr(k)+'_'+IntToStr(i), texturefiles[k][i]);
      WriteFloat(section, 'Obslatitude', Obslatitude);
      WriteFloat(section, 'Obslongitude', Obslongitude);
      WriteString(section, 'ObsCountry', ObsCountry);
      WriteString(section, 'ObsTZ', ObsTZ);
      WriteBool(section, 'UseComputerTime', UseComputerTime);
      WriteFloat(section, 'CurrentJD', CurrentJD);
      WriteFloat(section, 'dt_ut', dt_ut);
      WriteBool(section, 'PhaseEffect', phaseeffect);
      for k:=1 to maxpla do WriteBool(section, 'BumpMap_'+IntToStr(k), wantbump[k]);
      WriteBool(section, 'ShowLabel', ShowLabel);
      WriteBool(section, 'ShowMark', ShowMark);
      WriteInteger(section, 'LabelColor', MarkLabelColor);
      WriteInteger(section, 'MarkColor', MarkColor);
      WriteInteger(section, 'AutolabelColor', AutolabelColor);
      WriteInteger(section, 'LabelDensity', LabelDensity);
      WriteInteger(section, 'GridSpacing', gridspacing);
      WriteInteger(section, 'MarkSize', marksize);
      WriteBool(section, 'LabelCenter', labelcenter);
      WriteBool(section, 'FollowNorth', FollowNorth);
      WriteBool(section, 'ZenithOnTop', ZenithOnTop);
      WriteBool(section, 'Mirror', CheckBox2.Checked);
      WriteBool(section, 'Grid', GridButton.Down);
      WriteFloat(section, 'PoleOrientation', PoleOrientation);
      WriteInteger(section, 'ToolsWidth', ToolsWidth);
      WriteInteger(section, 'Top', Top);
      WriteInteger(section, 'Left', Left);
      WriteInteger(section, 'Height', Height);
      WriteInteger(section, 'Width', Width);
      WriteBool(section, 'Maximized', (windowstate = wsMaximized));
      WriteString(section, 'LabelFontName', planet1.LabelFont.Name);
      WriteInteger(section, 'LabelFontSize', planet1.LabelFont.Size);
      WriteBool(section, 'LabelFontBold', fsBold in planet1.LabelFont.Style);
      WriteBool(section, 'LabelFontItalic', fsItalic in planet1.LabelFont.Style);
      WriteInteger(section, 'DescFontSize', Desc1.DefaultFontSize);
      WriteInteger(section, 'AmbientLight', planet1.AmbientColor);
      WriteInteger(section, 'DiffuseLight', planet1.DiffuseColor);
      WriteInteger(section, 'SpecularLight', planet1.SpecularColor);
      WriteInteger(section, 'Smooth',   planet1.GLSphereplanet.Slices);
      WriteInteger(section, 'ListCount', combobox1.Items.Count - 1);
      for i := 0 to combobox1.Items.Count - 1 do
      begin
        WriteString(section, 'List_' + IntToStr(i), combobox1.Items.Strings[i]);
      end;
      section := 'images';
      WriteInteger(section, 'SaveImageSize', saveimagesize);
      WriteBool(section, 'SaveImageWhite', saveimagewhite);
      section := 'Print';
      WriteInteger(section, 'LeftMargin', LeftMargin);
      WriteInteger(section, 'PrintTextWidth', PrintTextWidth);
      WriteBool(section, 'PrintChart', PrintChart);
      WriteBool(section, 'PrintEph', PrintEph);
      WriteBool(section, 'PrintDesc', PrintDesc);
      inif.UpdateFile;
    end;
  finally
    inif.Free;
  end;
end;

function Tf_avpmain.FormatLongitude(l:double):string;  // input l is E360 in degree
var lf: double;
begin
  case LongSystem[CurrentPlanet] of
     E360: lf:=rmod(l+720,360);
     E180: lf:=rmod(l+720,360)-180;
     W360: lf:=rmod(720-l,360);
     W180: lf:=rmod(720-l,360)-180;
  end;
  result:=DEmToStr(lf);
end;

function Tf_avpmain.LongitudeSystemName:string;
begin
  case LongSystem[CurrentPlanet] of
     E360: result:=rsEast0360;
     E180: result:=rsEast180180;
     W360: result:=rsWest0360;
     W180: result:=rsWest180180;
  end;
end;

procedure Tf_avpmain.GetLabel(Sender: TObject);
var lmin,lmax,bmin,bmax: single;
    w, wmin, l1, b1: single;
    IsPUN:    boolean;
    cmd,nom, pun:  string;
    j: integer;
const wfact: array[1..9] of single = (1,10,1,5,1,1,1,1,1);
begin
// Labels
  if showlabel then
  begin
  // get search boundaries
    Tf_planet(Sender).GetBounds(lmin,lmax,bmin,bmax);
  // minimal feature size
    LabelDensity := maxintvalue([100, LabelDensity]);
    if (Tf_planet(Sender).Zoom >= 30) and (Tf_planet(Sender).Zoom >= (Tf_planet(Sender).ZoomMax-5)) then
      wmin := -1
    else
      wmin := MinValue([200.0, LabelDensity / (Tf_planet(Sender).Zoom * Tf_planet(Sender).Zoom)]);
    cmd:='select NAME,LONGIN,LATIN,LENGTHKM,WIDEKM,PUN from planet' +
      ' where PLANETN = ' + inttostr(CurrentPlanet);
    cmd:=cmd+' and (';
    if lmin<0 then
       cmd:=cmd+' LONGIN > '+formatfloat(f2, rad2deg*(lmin+pi2))+' or ';
    if lmax>pi2 then
       cmd:=cmd+' LONGIN < '+formatfloat(f2, rad2deg*(lmax-pi2))+' or ';
    cmd:=cmd+' (LONGIN > '+formatfloat(f2, rad2deg*lmin) + ' and LONGIN < ' + formatfloat(f2, rad2deg*lmax)+') )';
    cmd:=cmd+' and LATIN > ' + formatfloat(f2, rad2deg*bmin) +
      ' and LATIN < ' + formatfloat(f2, rad2deg*bmax) +
      ' and (LENGTHKM=0 or LENGTHKM>=' + formatfloat(f2, (wmin * wfact[CurrentPlanet]) / 2.5) + ')' +
      ' ;';
    dbm.Query(cmd);
    for j := 0 to dbm.RowCount - 1 do
    begin
      l1 := dbm.Results[j].Format[1].AsFloat;
      b1 := dbm.Results[j].Format[2].AsFloat;
      w  := dbm.Results[j].Format[3].AsFloat;
      if w < (wmin * wfact[CurrentPlanet]) then
        continue;
      nom := trim(dbm.Results[j][0]);
      pun := trim(dbm.Results[j][5]);
      IsPUN:=(nom=pun);
      nom:=capitalize(nom);
      Tf_planet(Sender).AddLabel(deg2rad*l1,deg2rad*b1,nom,IsPUN);
     end;
  end;
end;

procedure Tf_avpmain.GetSprite(Sender: TObject);
var lmin,lmax,bmin,bmax: single;
    l1, b1: single;
    j: integer;
begin
// Mark selection
  if (currentselection<>'') then
  begin
    // get search boundaries
    Tf_planet(Sender).GetBounds(lmin,lmax,bmin,bmax);
    dbm.Query('select LONGIN,LATIN from planet where ' + currentselection +
      ' and LONGIN > ' + formatfloat(f2, rad2deg*lmin) +
      ' and LONGIN < ' + formatfloat(f2, rad2deg*lmax) +
      ' and LATIN > ' + formatfloat(f2, rad2deg*bmin) +
      ' and LATIN < ' + formatfloat(f2, rad2deg*lmax) +
      ' ORDER BY WIDEKM DESC ' + ' ;');
    for j := 0 to dbm.RowCount - 1 do
    begin
      l1 := dbm.Results[j].Format[0].AsFloat;
      b1 := dbm.Results[j].Format[1].AsFloat;
      Tf_planet(Sender).AddSprite(deg2rad*l1,deg2rad*b1);
    end;
  end;
end;

procedure Tf_avpmain.InitDate;
var
  y, m, d, h, n, s, ms: word;
begin
  decodedate(now, y, m, d);
  decodetime(now, h, n, s, ms);
  timezone   := gettimezone(now);
  timezone   := gettimezone(now-timezone);
  annee.Value := y;
  mois.Value := m;
  jour.Value := d;
  heure.Value := h;
  minute.Value := n;
  seconde.Value := s;
  updown1.position := y;
  updown2.position := m;
  updown3.position := d;
  updown4.position := h;
  updown5.position := n;
  updown6.position := s;
  dt_ut      := dtminusut(y);
  CurYear    := y;
  CurrentMonth := m;
  CurrentDay := d;
  Currenttime := h + n / 60 + s / 3600;
  CurrentJD  := jd(CurYear, CurrentMonth, CurrentDay, Currenttime - timezone + DT_UT);
end;

procedure Tf_avpmain.SetJDDate;
var
  y, m, d: integer;
  h, n, s, ms: word;
  hh: double;
begin
  djd(CurrentJD - (DT_UT / 24) + 1e-8, y, m, d, hh);
  if hh>23.9999 then hh:=24.0;
  decodetime(hh / 24, h, n, s, ms);
  timezone := GetJDTimeZone(CurrentJD);
  djd(CurrentJD + (timezone / 24) - (DT_UT / 24) + 1e-8, y, m, d, hh);
  decodetime(hh / 24, h, n, s, ms);
  annee.Value  := y;
  mois.Value   := m;
  jour.Value   := d;
  heure.Value  := h;
  minute.Value := n;
  seconde.Value := s;
  updown1.position := y;
  updown2.position := m;
  updown3.position := d;
  updown4.position := h;
  updown5.position := n;
  updown6.position := s;
  CurYear      := y;
  CurrentMonth := m;
  CurrentDay   := d;
  Currenttime  := h + n / 60 + s / 3600;
end;

procedure Tf_avpmain.SetDate(param: string);
var
  buf: string;
  p, yy, mm, dd, h, m, s: integer;
begin
  buf := trim(param);
  p   := pos('-', buf);
  if p = 0 then
    exit;
  yy  := StrToInt(trim(copy(buf, 1, p - 1)));
  buf := copy(buf, p + 1, 999);
  p   := pos('-', buf);
  if p = 0 then
    exit;
  mm  := StrToInt(trim(copy(buf, 1, p - 1)));
  buf := copy(buf, p + 1, 999);
  p   := pos('T', buf);
  if p = 0 then
    exit;
  dd  := StrToInt(trim(copy(buf, 1, p - 1)));
  buf := copy(buf, p + 1, 999);
  p   := pos(':', buf);
  if p = 0 then
    exit;
  h   := StrToInt(trim(copy(buf, 1, p - 1)));
  buf := copy(buf, p + 1, 999);
  p   := pos(':', buf);
  if p = 0 then
    exit;
  m     := StrToInt(trim(copy(buf, 1, p - 1)));
  buf   := copy(buf, p + 1, 999);
  s     := StrToInt(trim(buf));
  CurYear := yy;
  CurrentMonth := mm;
  CurrentDay := dd;
  CurrentTime := h + m / 60 + s / 3600;
  dt_ut := dtminusut(CurYear);
  CurrentJD := jd(CurYear, CurrentMonth, CurrentDay, Currenttime - timezone + DT_UT);
  SetJDDate;
end;

procedure Tf_avpmain.SetObs(param: string);
var
  buf: string;
  p:   integer;
  s, la, lo: double;
begin
  p := pos('LAT:', param);
  if p = 0 then
    exit;
  buf := copy(param, p + 4, 999);
  p   := pos('d', buf);
  la  := strtofloat(copy(buf, 1, p - 1));
  s   := sgn(la);
  buf := copy(buf, p + 1, 999);
  p   := pos('m', buf);
  la  := la + s * strtofloat(copy(buf, 1, p - 1)) / 60;
  buf := copy(buf, p + 1, 999);
  p   := pos('s', buf);
  la  := la + s * strtofloat(copy(buf, 1, p - 1)) / 3600;
  p   := pos('LON:', param);
  if p = 0 then
    exit;
  buf := copy(param, p + 4, 999);
  p   := pos('d', buf);
  lo  := strtofloat(copy(buf, 1, p - 1));
  s   := sgn(lo);
  buf := copy(buf, p + 1, 999);
  p   := pos('m', buf);
  lo  := lo + s * strtofloat(copy(buf, 1, p - 1)) / 60;
  buf := copy(buf, p + 1, 999);
  p   := pos('s', buf);
  lo  := lo + s * strtofloat(copy(buf, 1, p - 1)) / 3600;
  p   := pos('TZ:', param);
  if p > 0 then
  begin
    buf := copy(param, p + 3, 999);
    p   := pos('h', buf);
    if p = 0 then
      Timezone := strtofloat(trim(buf))
    else
      Timezone := strtofloat(copy(buf, 1, p - 1));
  end;
  Obslatitude  := la;
  Obslongitude := lo;
  InitObservatoire;
  CurrentJD := jd(CurYear, CurrentMonth, CurrentDay, Currenttime - timezone + DT_UT);
end;

procedure Tf_avpmain.ReadParam(first:boolean=true);
var
  i:    integer;
  buf:  string;
  x, y: double;
begin
  try
    i := 0;
    while i <= param.Count - 1 do
    begin
      if param[i] = '-o' then
      begin    // observatory
        Inc(i);
        buf := trim(StringReplace(param[i], '"', '', [rfReplaceAll]));
        setobs(buf);
      end
      else if param[i] = '-d' then
      begin    // date
        Inc(i);
        buf := trim(StringReplace(param[i], '"', '', [rfReplaceAll]));
        setdate(buf);
      end
      else if param[i] = '-c' then
      begin   // center coordinates
        Inc(i);
        buf := trim(StringReplace(param[i], '"', '', [rfReplaceAll]));
        x   := strtofloat(buf);
        Inc(i);
        buf := trim(StringReplace(param[i], '"', '', [rfReplaceAll]));
        y   := strtofloat(buf);
        planet1.CenterAt(deg2rad*x, deg2rad*y);
      end
      else if param[i] = '-z' then
      begin   // zoom , to use instead of obsolete -f
        Inc(i);
        buf := trim(StringReplace(param[i], '"', '', [rfReplaceAll]));
        x   := strtofloat(buf);
        planet1.zoom:=x;
      end
      else if param[i] = '-n' then
      begin  // center object
        Inc(i);
        buf := trim(StringReplace(param[i], '"', '', [rfReplaceAll]));
        Firstsearch := True;
        SearchName(buf, True);
      end
      else if param[i] = '-s' then
      begin   // mark selection
        Inc(i);
        currentselection := trim(StringReplace(param[i], '"', '', [rfReplaceAll]));
        if currentselection = '*' then
          currentselection := '';
      end
      else if param[i] = '-3d' then
      begin     // full globe
        ToolButton3.Down := True;
        ToolButton3Click(nil);
      end
      else if param[i] = '-r' then
      begin   // full globe at give rotation
        Inc(i);
        buf := trim(StringReplace(param[i], '"', '', [rfReplaceAll]));
        x   := strtofloat(buf);
        if x <> 0 then
        begin
          ToolButton3.Down := True;
          ToolButton3Click(nil);
          planet1.CenterAt(deg2rad*x, 0);
        end;
      end
      else if (param[i]='-nd')and first then
      begin
        CanCloseDatlun:=false;  // when started by datlun do not close datlun on exit!
      end
      else if (param[i]='-np')and first then
      begin
        CanClosePhotlun:=false;  // when started by photlun do not close photlun on exit!
      end
      else if (param[i]='-ns')and first then
      begin
        CanCloseCDC:=false;  // when started by skychart do not close skychart on exit!
      end
      else if param[i]='-quit' then
      begin
        Close;  // close current instance
      end
      else if param[i] = '--' then
      begin   // last parameter
        break;
      end;
      Inc(i);
    end;
  except
    on E: Exception do begin
    {$ifdef trace_debug}
      debugln('Exception ReadParam '+E.Message);
    {$endif}
    end;

  end;
end;

procedure Tf_avpmain.GetAppDir;
var
  buf: string;
  inif: TMeminifile;
{$ifdef darwin}
  i:      integer;
{$endif}
{$ifdef mswindows}
  PIDL:   PItemIDList;
  Folder: array[0..MAX_PATH] of char;
{$endif}
begin
{$ifdef darwin}
  appdir := getcurrentdir;
  if (not directoryexists(slash(appdir) + slash('Textures'))) then
  begin
    appdir := ExtractFilePath(ParamStr(0));
    i      := pos('.app/', appdir);
    if i > 0 then
    begin
      appdir := ExtractFilePath(copy(appdir, 1, i));
    end;
  end;
{$else}
  appdir     := getcurrentdir;
  if not DirectoryExists(slash(appdir)+slash('Textures')) then begin
     appdir:=ExtractFilePath(ParamStr(0));
  end;
{$endif}
  privatedir := DefaultPrivateDir;
{$ifdef unix}
  appdir     := expandfilename(appdir);
  bindir     := slash(appdir);
  privatedir := expandfilename(PrivateDir);
  configfile := expandfilename(Defaultconfigfile);
  CdCconfig  := ExpandFileName(DefaultCdCconfig);
{$endif}
{$ifdef mswindows}
  buf:='';
  SHGetSpecialFolderLocation(0, CSIDL_LOCAL_APPDATA, PIDL);
  SHGetPathFromIDList(PIDL, Folder);
  buf:=systoutf8(Folder);
  buf:=trim(buf);
  buf:=SafeUTF8ToSys(buf);
  if buf='' then begin  // old windows version
     SHGetSpecialFolderLocation(0, CSIDL_APPDATA, PIDL);
     SHGetPathFromIDList(PIDL, Folder);
     buf:=trim(Folder);
  end;
  if buf='' then begin
     MessageDlg('Unable to create '+privatedir,
               mtError, [mbAbort], 0);
     Halt;
  end;
  privatedir := slash(buf) + privatedir;
  configfile := slash(privatedir) + Defaultconfigfile;
  CdCconfig  := slash(buf) + DefaultCdCconfig;
{$endif}

  if fileexists(configfile) then begin
    inif:=TMeminifile.create(configfile);
    try
    buf:=inif.ReadString('default','Install_Dir',appdir);
    if Directoryexists(slash(buf)+slash('Textures')) then appdir:=noslash(buf);
    finally
     inif.Free;
    end;
  end;
  if not directoryexists(privatedir) then
    CreateDir(privatedir);
  if not directoryexists(privatedir) then
    forcedirectories(privatedir);
  if not directoryexists(privatedir) then
  begin
    privatedir := appdir;
  end;
  Tempdir := slash(privatedir) + DefaultTmpDir;
  if not directoryexists(TempDir) then
    CreateDir(TempDir);
  if not directoryexists(TempDir) then
    forcedirectories(TempDir);
  DBdir := Slash(privatedir) + 'database';
  if not directoryexists(DBdir) then
    CreateDir(DBdir);
  if not directoryexists(DBdir) then
    forcedirectories(DBdir);
  // Be sur the Textures directory exists
  if (not directoryexists(slash(appdir) + slash('Textures'))) then
  begin
    // try under the current directory
    buf := GetCurrentDir;
    if (directoryexists(slash(buf) + slash('Textures'))) then
      appdir := buf
    else
    begin
      // try under the program directory
      buf := ExtractFilePath(ParamStr(0));
      if (directoryexists(slash(buf) + slash('Textures'))) then
        appdir := buf
      else
      begin
        // try share directory under current location
        buf := ExpandFileName(slash(GetCurrentDir) + SharedDir);
        if (directoryexists(slash(buf) + slash('Textures'))) then
          appdir := buf
        else
        begin
          // try share directory at the same location as the program
          buf := ExpandFileName(slash(ExtractFilePath(ParamStr(0))) + SharedDir);
          if (directoryexists(slash(buf) + slash('Textures'))) then
            appdir := buf
          else
          begin
            MessageDlg('Could not found the application Textures directory.' +
              crlf + 'Please try to reinstall the program at a standard location.',
              mtError, [mbAbort], 0);
            Halt;
          end;
        end;
      end;
    end;
  end;
 {$ifndef darwin}
  if not FileExists(slash(bindir)+ExtractFileName(ParamStr(0))) then begin
     bindir := slash(ExtractFilePath(ParamStr(0)));
     if not FileExists(slash(bindir)+ExtractFileName(ParamStr(0))) then begin
        bindir := slash(ExpandFileName(slash(appdir) + slash('..')+slash('..')+'bin'));
        if not FileExists(slash(bindir)+ExtractFileName(ParamStr(0))) then begin
           bindir:='';
        end;
     end;
  end;
 {$endif}
  helpdir := slash(appdir) + slash('doc');
  jpldir  := slash(appdir)+slash('data')+'jpleph';
  // Be sure zoneinfo exists in standard location or in vma directory
  ZoneDir  := slash(appdir) + slash('data') + slash('zoneinfo');
  buf      := slash('') + slash('usr') + slash('share') + slash('zoneinfo');
  if (FileExists(slash(buf) + 'zone.tab')) then
    ZoneDir := slash(buf)
  else
  begin
    buf := slash('') + slash('usr') + slash('lib') + slash('zoneinfo');
    if (FileExists(slash(buf) + 'zone.tab')) then
      ZoneDir := slash(buf)
    else
    begin
      if (not FileExists(slash(ZoneDir) + 'zone.tab')) then
      begin
        MessageDlg('zoneinfo directory not found!' + crlf +
          'Please install the tzdata package.' + crlf +
          'If it is not installed at a standard location create a logical link zoneinfo in virtualplanet data directory.',
          mtError, [mbAbort], 0);
        Halt;
      end;
    end;
  end;
end;

procedure Tf_avpmain.UpdCentralMeridian(range:double=20; fromequator:boolean=false);
var
  i,s,n: integer;
  l1, l2: double;
  buf, cmd:    string;
begin
  listbox1.Clear;
  l1 := rad2deg*activeplanet.CentralMeridian - range;
  l2 := rad2deg*activeplanet.CentralMeridian + range;
  CentralMeridian.Caption := rsCentralMerid;
  if (CurrentPlanet<=2)and(illum<0.5) then begin
    CentralMeridian.Caption :=rst_51;
    range:=abs(range);
    if (rad2deg*activeplanet.Phase) < 180 then begin
      l1 := activeplanet.Terminator;
      l2 := activeplanet.Terminator + range;
    end else begin
      l1 := activeplanet.Terminator - range;
      l2 := activeplanet.Terminator;
    end;
  end;
  currentmeridian := activeplanet.CentralMeridian;
  Val(trim(ComboBox2.Text),s,n);
  if n<>0 then s:=0;
  try
    listbox1.Items.BeginUpdate;
    cmd:='select NAME,LATIN from planet ' +
      ' where PLANETN = ' + inttostr(CurrentPlanet) +
      ' and longin>' + formatfloat(f2, l1) +
      ' and longin<' + formatfloat(f2, l2) +
      ' and lengthkm>=' + inttostr(s);
    if fromequator then begin
      cmd:=cmd+' order by abs(latin)';
    end else begin
      case RadioGroup1.ItemIndex of
        0: cmd:=cmd+' order by name';
        1: cmd:=cmd+' order by latin';
      end;
    end;
    dbm.Query(cmd);
    for i := 0 to dbm.rowcount - 1 do
    begin
      if fromequator then begin
        listbox1.Items.Add(dbm.Results[i][0]);
      end else begin
        case RadioGroup1.ItemIndex of
          0: listbox1.Items.Add(dbm.Results[i][0]);
          1: begin
               buf := demtostr(dbm.Results[i].format[1].AsFloat) + ' ' + dbm.Results[i][0];
               listbox1.Items.Add(buf);
             end;
        end;
      end;
    end;
  except
    on E: Exception do begin
    {$ifdef trace_debug}
      debugln('Exception UpdCentralMeridian '+E.Message);
    {$endif}
    end;
  end;
  listbox1.Items.EndUpdate;
  if listbox1.Items.Count = 0 then
     listbox1.Items.Add(rsm_27);
end;

procedure Tf_avpmain.ListObject(delta: double);
var
  l, b, deltal: double;
  i: integer;
begin
  l      := currentl;
  b      := currentb;
  deltal := delta / cos(deg2rad * b);
  with f_craterlist do
  begin
    f_craterlist.Caption := f_avpmain.ToolButton10.hint;
    craterlst.Clear;
    dbm.query('select NAME from planet ' + ' where PLANETN = ' + inttostr(CurrentPlanet) +
      ' and LONGIN > ' + formatfloat(f2, l - deltal) +
      ' and LONGIN < ' + formatfloat(f2, l + deltal) +
      ' and LATIN > ' + formatfloat(f2, b - delta) +
      ' and LATIN < ' + formatfloat(f2, b + delta) + ' ;');
    for i := 0 to dbm.RowCount - 1 do
    begin
      craterlst.items.add(dbm.Results[i][0]);
    end;
    if not f_craterlist.Visible then
      FormPos(f_craterlist, PageControl1.Clienttoscreen(point(0, 0)).x,
        PageControl1.Clienttoscreen(point(0, 0)).y);
    f_craterlist.Show;
  end;
end;

function Tf_avpmain.SearchAtPos(l, b, w: double): boolean;
var
  mindist, d, l1, b1, deltab, deltal: double;
  rec, i: integer;
begin
  mindist := 9999;
  Result  := False;
  rec     := 0;
  deltab  := 5;
  deltal  := deltab / cos(deg2rad * b);
  dbm.query('select ID,LONGIN,LATIN,LENGTHKM from planet ' + ' where PLANETN = ' + inttostr(CurrentPlanet) +
    ' and LONGIN > ' + formatfloat(f2, l - deltal) +
    ' and LONGIN < ' + formatfloat(f2, l + deltal) +
    ' and LATIN > ' + formatfloat(f2, b - deltab) +
    ' and LATIN < ' + formatfloat(f2, b + deltab) +
    ' and (LENGTHKM=0 or LENGTHKM>=' + formatfloat(f2, w) + ')' +
    ' ;');
  for i := 0 to dbm.RowCount - 1 do
  begin
    l1 := dbm.Results[i].format[1].AsFloat;
    b1 := dbm.Results[i].format[2].AsFloat;
    d  := angulardistance(deg2rad*l, deg2rad*b, deg2rad*l1, deg2rad*b1);
    if d < mindist then
    begin
      Result  := True;
      mindist := d;
      rec     := dbm.Results[i].Format[0].AsInteger;
    end;
  end;
  if Result then
  begin
    currentid := IntToStr(rec);
    dbm.query('select * from planet where ID=' + currentid + ';');
    Result := dbm.RowCount > 0;
  end;
end;

procedure Tf_avpmain.AddToList(buf: string);
var
  i: integer;
begin
  i := combobox1.Items.IndexOf(buf);
  if (i < 0) and (combobox1.Items.Count >= combobox1.DropDownCount) then
    i := combobox1.DropDownCount - 1;
  if i >= 0 then
    combobox1.Items.Delete(i);
  combobox1.Items.Insert(0, buf);
  combobox1.ItemIndex := 0;
end;

procedure Tf_avpmain.GetDetail(row: TResultRow; memo: Tmemo);
const
  b = ' ';
var
  nom, buf: string;
  i,n: integer;
  v: double;
  function GetField(fn:string):string;
  var k: integer;
  begin
    result:=trim(row.ByField[fn].AsString);
    if shortdesc then begin
      if result='?' then result:='';
      if result='??' then result:='';
      if result='???' then result:='';
      if result=rsNotAppliable then result:='';
      if result>'' then
        for k := 1 to num_bl do
        begin
          if result=bldb[k] then result:='';
        end;
    end
    else
      if result='' then result:=' ';
  end;
begin
  buf := GetField('BODY');
  memo.Lines.Add(buf);
  nom := GetField('NAME');
  memo.Lines.Add(nom);
  i := row.ByField['DBN'].AsInteger;
  if i > 99 then
  begin
    buf := rsm_75 + b + IntToStr(i) + b;
  end;
  if (GetField('PUN'))>'' then
     memo.Lines.Add('P.U.N.:' + b + GetField('PUN'));
  if (GetField('NAMETYPE'))>'' then
     memo.Lines.Add(rsNameType + b + GetField('NAMETYPE'));
  memo.Lines.Add(rsm_56 + b + GetField('TYPE'));

  //Taille
  if (GetField('LENGTHKM')>'')or(GetField('WIDEKM')>'') then begin
     memo.Lines.Add(rsm_57); //Taille
     memo.Lines.Add(rsm_17 + b + GetField('LENGTHKM') + 'x' + GetField('WIDEKM') + rsm_18);
  end;


  //Position
  if (GetField('LONGIN')>'')or(GetField('LATIN')>'')or(GetField('QUADRANT')>'')or(GetField('AREA')>'') then
     memo.Lines.Add(rsm_60+ '  ('+LongitudeSystemName+')'); //Position
  buf:=GetField('LONGIN');
  if  buf > '' then begin
     Val(buf,v,n);
     if n=0 then memo.Lines.Add(rsm_10 + b + FormatLongitude(v));
  end;
  buf:=GetField('LATIN');
  if  buf > '' then begin
     Val(buf,v,n);
     if n=0 then memo.Lines.Add(rsm_11 + b + DEmToStr(v));
  end;
  if GetField('QUADRANT') > '' then
     memo.Lines.Add(rsm_12 + b + GetField('QUADRANT'));

  //Origine
  memo.Lines.Add(rsm_62); //Origine
  if GetField('NAMEDETAIL') > '' then
     memo.Lines.Add(rsm_63 + b + GetField('NAMEDETAIL'));
  if (trim(GetField('WORK') + GetField('NATIONALITY')) > '') and
    (trim(GetField('CENTURYC') + GetField('COUNTRY')) > '') then
  begin
    case wordformat of
      0: memo.Lines.Add(GetField('CENTURYC') + b +
          GetField('NATIONALITY') + b + GetField('WORK') + b +
          rsm_2 + b + GetField('COUNTRY'));
      1: memo.Lines.Add(GetField('WORK') + b +
          GetField('NATIONALITY') + b + rsm_1 + b + GetField('CENTURYC') +
          b + rsm_2 + b + GetField('COUNTRY'));
      2: memo.Lines.Add(GetField('NATIONALITY') + b +
          GetField('WORK') + b + GetField('CENTURYC') + b +
          rsm_2 + b + GetField('COUNTRY'));
    end;
    if (GetField('BIRTHPLACE')>'')or((GetField('BIRTHDATE')>'')) then
       memo.Lines.Add(rsm_3 + b + GetField('BIRTHPLACE') + b + rsm_4 +
            b + GetField('BIRTHDATE'));
    if (GetField('DEATHPLACE')>'')or((GetField('DEATHDATE')>'')) then
       memo.Lines.Add(rsm_5 + b + GetField('DEATHPLACE') + b + rsm_4 +
            b + GetField('DEATHDATE'));
  end;
  if GetField('FACTS')>'' then
    memo.Lines.Add(rsm_64 + b + GetField('FACTS'));
  if GetField('NAMEORIGIN')>'' then
     memo.Lines.Add(rsm_6 + b + GetField('NAMEORIGIN'));

  // IAU information
    memo.Lines.Add('IAU information:');
    if GetField('Feature_Name')<>'' then
       memo.Lines.Add('IAU_FEATURE_NAME:' + b + GetField('Feature_Name'));
    if GetField('Clean_Feature_Name')<>'' then
       memo.Lines.Add('IAU_CLEAN_FEATURE_NAME:' + b + GetField('Clean_Feature_Name'));
    if GetField('Feature_ID')<>'' then
       memo.Lines.Add('IAU_FEATURE_ID:' + b + GetField('Feature_ID'));
    if GetField('Diameter')<>'' then
       memo.Lines.Add('IAU_DIAMETER:' + b + GetField('Diameter'));
    if GetField('Center_Latitude')<>'' then
       memo.Lines.Add('IAU_CENTER_LATITUDE:' + b + GetField('Center_Latitude'));
    if GetField('Center_Longitude')<>'' then
       memo.Lines.Add('IAU_CENTER_LONGITUDE:' + b + GetField('Center_Longitude'));
    if GetField('Northern_Latitude')<>'' then
       memo.Lines.Add('IAU_NORTHERN_LATITUDE:' + b + GetField('Northern_Latitude'));
    if GetField('Southern_Latitude')<>'' then
       memo.Lines.Add('IAU_SOUTHERN_LATITUDE:' + b + GetField('Southern_Latitude'));
    if GetField('Eastern_Longitude')<>'' then
       memo.Lines.Add('IAU_EASTERN_LONGITUDE:' + b + GetField('Eastern_Longitude'));
    if GetField('Western_Longitude')<>'' then
       memo.Lines.Add('IAU_WESTERN_LONGITUDE:' + b + GetField('Western_Longitude'));
    if GetField('Coordinate_System')<>'' then
       memo.Lines.Add('IAU_COORDINATE_SYSTEM:' + b + GetField('Coordinate_System'));
    if GetField('Continent')<>'' then
       memo.Lines.Add('IAU_CONTINENT:' + b + GetField('Continent'));
    if GetField('Ethnicity')<>'' then
       memo.Lines.Add('IAU_ETHNICITY:' + b + GetField('Ethnicity'));
    if GetField('Origin')<>'' then
       memo.Lines.Add('IAU_ORIGIN:' + b + GetField('Origin'));
    if GetField('Feature_Type')<>'' then
       memo.Lines.Add('IAU_FEATURE_TYPE:' + b + GetField('Feature_Type'));
    if GetField('Feature_Type_Code')<>'' then
       memo.Lines.Add('IAU_FEATURE_TYPE_CODE:' + b + GetField('Feature_Type_Code'));
    if GetField('Quad')<>'' then
       memo.Lines.Add('IAU_QUAD_NAME:' + b + GetField('Quad'));
    if GetField('Approval_Status')<>'' then
       memo.Lines.Add('IAU_APPROVAL_STATUS:' + b + GetField('Approval_Status'));
    if GetField('Approval_Date')<>'' then
       memo.Lines.Add('IAU_APPROVAL_DATE:' + b + GetField('Approval_Date'));
    if GetField('Reference')<>'' then
       memo.Lines.Add('IAU_REFERENCE:' + b + GetField('Reference'));
    if GetField('Last_Updated')<>'' then
       memo.Lines.Add('IAU_LAST_UPDATED:' + b + GetField('Last_Updated'));
    if GetField('Additional_Info')<>'' then
       memo.Lines.Add('IAU_ADDITIONAL_INFO:' + b + GetField('Additional_Info'));
end;


procedure Tf_avpmain.GetHTMLDetail(row: TResultRow; var txt: string);
const
  b     = '&nbsp;';
  t1    = '<center><font size=+1 color="#0000FF"><b>';
  t1end = '</b></font></center>';
  t2    = '<font size=+1>';
  t2end = '</font>';
  t3    = '<b>';
  t3end = '</b>';
var
  nom, txtbuf, buf: string;
  i,n: integer;
  v: double;
  function GetField(fn:string):string;
  var k: integer;
  begin
    result:=trim(row.ByField[fn].AsString);
    if shortdesc then begin
      if result='?' then result:='';
      if result='??' then result:='';
      if result='???' then result:='';
      if result=rsNotAppliable then result:='';
      if result>'' then
        for k := 1 to num_bl do
        begin
          if result=bldb[k] then result:='';
        end;
    end
    else
      if result='' then result:=' ';
  end;
begin
  txt := '<html> <body bgcolor="white">';
  buf := GetField('BODY');
  nom := GetField('NAME');
  txt  := txt + t1 +buf+ '<br>' + nom + t1end + '<br>';
  i    := row.ByField['DBN'].AsInteger;
  if i > 99 then
  begin
    txt := txt + t3 + rsm_75 + t3end + b + IntToStr(i) + b;
  end;
  if (GetField('PUN'))>'' then
     txt  := txt + t3 + 'P.U.N.:' + t3end + b + GetField('PUN') + '<br>';
  if (GetField('NAMETYPE'))>'' then
     txt  := txt + t3 + rsNameType + t3end + b + GetField('NAMETYPE') + '<br>';
  if (GetField('TYPE'))>'' then
     txt  := txt + t3 + rsm_56 + t3end + b + GetField('TYPE') + '<br>';
  txt  := txt + b + '<br>';

  //Taille
  txtbuf:='';
  if (GetField('LENGTHKM')>'')or(GetField('WIDEKM')>'') then
     txtbuf  := txtbuf + t3 + rsm_17 + t3end + b + GetField('LENGTHKM') + 'x' +
             GetField('WIDEKM') + rsm_18 + '<br>';
  if txtbuf>'' then
     txt  := txt + t2 + rsm_57 + t2end + '<br>'+txtbuf+ b + '<br>'; //Taille


  //Position
  txtbuf:='';
  buf:=GetField('LONGIN');
  if  buf > '' then begin
     Val(buf,v,n);
     if n=0 then txtbuf := txtbuf + t3 + rsm_10 + t3end + b + FormatLongitude(v) + '<br>';
  end;
  buf:=GetField('LATIN');
  if  buf > '' then begin
     Val(buf,v,n);
     if n=0 then txtbuf := txtbuf + t3 + rsm_11 + t3end + b + DEmToStr(v) + '<br>';
  end;
  if GetField('QUADRANT') > '' then
     txtbuf   := txtbuf + t3 + rsm_12 + t3end + b + GetField('QUADRANT') + '<br>';
  if txtbuf>'' then
     txt   := txt + t2 + rsm_60+ t2end + '  ('+LongitudeSystemName+')' + '<br>'+txtbuf+b + '<br>'; //Position

  //Origine
  txtbuf:='';
  if GetField('NAMEDETAIL') > '' then
     txtbuf := txtbuf + t3 + rsm_63 + t3end + b + GetField('NAMEDETAIL') + '<br>';
  if (trim(GetField('WORK') + GetField('NATIONALITY')) > '') and
    (trim(GetField('CENTURYC') + GetField('COUNTRY')) > '') then
  begin
    case wordformat of
      // english
      0: begin
        txtbuf := txtbuf + GetField('CENTURYC') + b + GetField('NATIONALITY') + b + GetField('WORK');
        if trim(GetField('COUNTRY'))>'' then txtbuf:=txtbuf + b + rsm_2 + b + GetField('COUNTRY');
        txtbuf:=txtbuf + '<br>';
      end;
      // francais, italian
      1: begin
        txtbuf := txtbuf + GetField('WORK') + b + GetField('NATIONALITY');
        if trim(GetField('CENTURYC'))>'' then txtbuf:=txtbuf + b + rsm_1 + b + GetField('CENTURYC');
        if trim(GetField('COUNTRY'))>'' then txtbuf:=txtbuf + b + rsm_2 + b + GetField('COUNTRY');
        txtbuf:=txtbuf + '<br>';
      end;
      // russian
      2: begin
        txtbuf := txtbuf + GetField('NATIONALITY') + b + GetField('WORK') + b + GetField('CENTURYC');
        if trim(GetField('COUNTRY'))>'' then txtbuf:=txtbuf + b + rsm_2 + b + GetField('COUNTRY');
        txtbuf:=txtbuf + '<br>';
      end;
    end;
    if (GetField('BIRTHPLACE')>'')or((GetField('BIRTHDATE')>'')) then
       txtbuf := txtbuf + t3 + rsm_3 + t3end + b + GetField('BIRTHPLACE') + b +
                 rsm_4 + b + GetField('BIRTHDATE') + '<br>';
    if (GetField('DEATHPLACE')>'')or((GetField('DEATHDATE')>'')) then
       txtbuf := txtbuf + t3 + rsm_5 + t3end + b + GetField('DEATHPLACE') + b +
                 rsm_4 + b + GetField('DEATHDATE') + '<br>';
  end;
  if GetField('FACTS')<>'' then
     txtbuf := txtbuf + t3 + rsm_64 + t3end + b + GetField('FACTS') + '<br>';
  if GetField('NAMEORIGIN')<>'' then
     txtbuf   := txtbuf + t3 + rsm_6 + t3end + b + GetField('NAMEORIGIN') + '<br>';
  if txtbuf>'' then
     txt := txt + t2 + rsm_62 + t2end + '<br>'+txtbuf+ b + '<br>'; //Origine

  // IAU information
  txtbuf:='';
  if GetField('Feature_Name')<>'' then begin
     txtbuf   := txtbuf + t3 + 'IAU_FEATURE_NAME:' + t3end + b + GetField('Feature_Name') + '<br>'
  end;
  if GetField('Clean_Feature_Name')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_CLEAN_FEATURE_NAME:' + t3end + b + GetField('Clean_Feature_Name') + '<br>';
  if GetField('Feature_ID')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_FEATURE_ID:' + t3end + b + GetField('Feature_ID') + '<br>';
  if GetField('Diameter')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_DIAMETER:' + t3end + b + GetField('Diameter') + '<br>';
  if GetField('Center_Latitude')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_CENTER_LATITUDE:' + t3end + b + GetField('Center_Latitude') + '<br>';
  if GetField('Center_Longitude')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_CENTER_LONGITUDE:' + t3end + b + GetField('Center_Longitude') + '<br>';
  if GetField('Northern_Latitude')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_NORTHERN_LATITUDE:' + t3end + b + GetField('Northern_Latitude') + '<br>';
  if GetField('Southern_Latitude')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_SOUTHERN_LATITUDE:' + t3end + b + GetField('Southern_Latitude') + '<br>';
  if GetField('Eastern_Longitude')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_EASTERN_LONGITUDE:' + t3end + b + GetField('Eastern_Longitude') + '<br>';
  if GetField('Western_Longitude')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_WESTERN_LONGITUDE:' + t3end + b + GetField('Western_Longitude') + '<br>';
  if GetField('Coordinate_System')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_COORDINATE_SYSTEM:' + t3end + b + GetField('Coordinate_System') + '<br>';
  if GetField('Continent')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_CONTINENT:' + t3end + b + GetField('Continent') + '<br>';
  if GetField('Ethnicity')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_ETHNICITY:' + t3end + b + GetField('Ethnicity') + '<br>';
  if GetField('Origin')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_ORIGIN:' + t3end + b + GetField('Origin') + '<br>';
  if GetField('Feature_Type')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_FEATURE_TYPE:' + t3end + b + GetField('Feature_Type') + '<br>';
  if GetField('Feature_Type_Code')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_FEATURE_TYPE_CODE:' + t3end + b + GetField('Feature_Type_Code') + '<br>';
  if GetField('Quad')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_QUAD_NAME:' + t3end + b + GetField('Quad') + '<br>';
  if GetField('Approval_Status')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_APPROVAL_STATUS:' + t3end + b + GetField('Approval_Status') + '<br>';
  if GetField('Approval_Date')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_APPROVAL_DATE:' + t3end + b + GetField('Approval_Date') + '<br>';
  if GetField('Reference')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_REFERENCE:' + t3end + b + GetField('Reference') + '<br>';
  if GetField('Last_Updated')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_LAST_UPDATED:' + t3end + b + GetField('Last_Updated') + '<br>';
  if GetField('Additional_Info')<>'' then
     txtbuf   := txtbuf + t3 + 'IAU_ADDITIONAL_INFO:' + t3end + b + GetField('Additional_Info') + '<br>';
  if txtbuf>'' then
     txt := txt + t2 + 'IAU information:' + t2end + '<br>'+txtbuf+ b + '<br>';

  txt   := txt + '</body></html>';
  statusbar1.Panels[0].Text := rsm_10 + GetField('LONGIN');
  statusbar1.Panels[1].Text := rsm_11 + GetField('LATIN');
  Addtolist(nom);
end;

procedure Tf_avpmain.GetNotes(n: string);
begin
  if notesedited then UpdNotesClick(nil);
  notes_name.Caption := n;
  memo1.Clear;
  notesok     := False;
  notesedited := False;
  notesrow    := -1;
  dbnotes.GoFirst;
  notesok := dbnotes.MatchData('NAME', '=', trim(uppercase(n)));
  if not notesok then
    notesok := dbnotes.SeekData('NAME', '=', trim(uppercase(n)));
  if notesok then
  begin
    notesrow    := dbnotes.GetPosition;
    memo1.Text  := dbnotes.GetData('NOTES');
    notesedited := False;
  end;
end;

procedure Tf_avpmain.Memo1Change(Sender: TObject);
begin
  notesedited := True;
end;

procedure Tf_avpmain.UpdNotesClick(Sender: TObject);
var
  nom: string;
begin
  notesedited := False;
  if notesok then
  begin
    dbnotes.Go(notesrow);
    dbnotes.SetData('NOTES', memo1.Text);
  end
  else
  begin
    nom := uppercase(trim(notes_name.Caption));
    if nom = '' then
      exit;
    dbnotes.Gofirst;
    notesok := dbnotes.MatchData('NAME', '>=', nom);
    if not notesok then
      notesok := dbnotes.SeekData('NAME', '>=', nom);
    if not notesok then
      dbnotes.golast;
    if dbnotes.GetData('NAME') <> nom then
      dbnotes.InsertRow(not notesok);
    dbnotes.SetData('NAME', nom);
    dbnotes.SetData('NOTES', memo1.Text);
    notesrow := dbnotes.GetPosition;
    notesok  := True;
  end;
  screen.Cursor := crHourGlass;
  try
    dbnotes.SaveToCSVFile(Slash(DBdir)+'notes_'+trim(epla[CurrentPlanet])+'.csv');
  finally
    screen.Cursor := crDefault;
  end;
end;

function Tf_avpmain.SearchName(n: string; center: boolean): boolean;
var
  l, b: double;
  i:   integer;
begin
  Result := False;
  if Firstsearch then
  begin
    dbm.Query('select id,name from planet ' + ' where PLANETN = ' + inttostr(CurrentPlanet) +
      ' and NAME like "' + trim(uppercase(n)) + '%"' +
      ' order by NAME limit 100;');
    searchlist.Clear;
    for i := 0 to dbm.RowCount - 1 do
    begin
      searchlist.Add(dbm.Results[i].Format[0].AsString);
    end;
    searchpos := -1;
  end;
  Firstsearch := False;
  Inc(searchpos);
  if searchpos < searchlist.Count then
  begin
    dbm.Query('select * from planet where id=' + searchlist[searchpos]);
    if dbm.RowCount = 0 then
      exit;
    l := dbm.Results[0].ByField['LONGIN'].AsFloat;
    b := dbm.Results[0].ByField['LATIN'].AsFloat;
    currentl    := l;
    currentb    := b;
    currentid   := searchlist[searchpos];
    currentname := dbm.Results[0].ByField['NAME'].AsString;
    activeplanet.SetMark(deg2rad*currentl, deg2rad*currentb, capitalize(currentname));
    if center then begin
      if activeplanet.VisibleSideLock and (abs(currentl-rad2deg*activeplanet.CentralMeridian)>95) then begin
        ToolButton3.Down:=true;
        ToolButton3Click(nil);
      end;
      activeplanet.CenterAt(deg2rad*currentl, deg2rad*currentb);
    end;
    GetHTMLDetail(dbm.Results[0], Desctxt);
    SetDescText(Desctxt);
    GetNotes(Combobox1.Text);
    if f_craterlist.Visible then
    begin
      ToolButton10Click(nil);
    end;
    Result := True;
  end;
end;

procedure Tf_avpmain.RefreshDetail;
begin
if currentid<>'' then begin
  dbm.Query('select * from planet where id=' + currentid);
  if dbm.RowCount > 0 then begin
    GetHTMLDetail(dbm.Results[0], Desctxt);
    SetDescText(Desctxt);
  end
end;
end;

procedure Tf_avpmain.SetDescText(const Value: string);
var
  s: TStringStream;
  NewHTML: TIpHtml;
begin
  try
    s := TStringStream.Create(UTF8FileHeader+Value);
    try
      NewHTML := TIpHtml.Create; // Beware: Will be freed automatically by IpHtmlPanel1
      NewHTML.LoadFromStream(s);
    finally
      s.Free;
    end;
    Desc1.SetHtml(NewHTML);
  except
    on E: Exception do begin
    {$ifdef trace_debug}
      debugln('Exception SetDescText '+E.Message);
    {$endif}
    end;
  end;
end;

procedure Tf_avpmain.Button1Click(Sender: TObject);
begin
  Firstsearch := True;
  SearchText  := StringReplace(Combobox1.Text,'*','%',[rfReplaceAll]);
  SearchName(SearchText, True);
end;

procedure Tf_avpmain.Button2Click(Sender: TObject);
begin
  SearchName(SearchText, True);
end;

procedure Tf_avpmain.DecreaseFont1Click(Sender: TObject);
var i: integer;
begin
try
  i:=Desc1.DefaultFontSize-1;
  if i>4 then Desc1.DefaultFontSize:=i;
  SetDescText(Desctxt);
except
  on E: Exception do begin
  {$ifdef trace_debug}
    debugln('Exception DecreaseFont1Click '+E.Message);
  {$endif}
  end;
end;
end;

procedure Tf_avpmain.GRSChange(Sender: TObject);
begin
GRSlongitude:=grs.value;
end;

procedure Tf_avpmain.GRSDateEditChange(Sender: TObject);
var y,m,d: word;
begin
  DecodeDate(GRSDateEdit.Date,y,m,d);
  GRSjd:=jd(y,m,d,0);
end;

procedure Tf_avpmain.GRSdriftChange(Sender: TObject);
begin
GRSDailydrift := GRSdrift.Value/365.25;
end;

procedure Tf_avpmain.BitBtn37Click(Sender: TObject);
begin
  ExecuteFile(URL_GRS);
end;

procedure Tf_avpmain.IncreaseFont1Click(Sender: TObject);
var i:integer;
begin
try
  i:=Desc1.DefaultFontSize+1;
  if i<20 then Desc1.DefaultFontSize:=i;
  SetDescText(Desctxt);
except
  on E: Exception do begin
  {$ifdef trace_debug}
    debugln('Exception IncreaseFont1Click '+E.Message);
  {$endif}
  end;
end;
end;

procedure Tf_avpmain.MenuwebpageClick(Sender: TObject);
begin
  OpenURL(vpaurl);
end;

procedure Tf_avpmain.ComboBox1Select(Sender: TObject);
begin
  Firstsearch := True;
  SearchName(Combobox1.Text, True);
end;

procedure Tf_avpmain.Quitter1Click(Sender: TObject);
begin
  Close;
end;

procedure Tf_avpmain.RefreshplanetImage;
var
  planetrise, planetset, planettransit, azimuthrise, azimuthset, eph: string;
  jd0, st0, q, hh, az, ah,magn,dp,xp,yp,zp,vel,h: double;
  v1, v2, v3, v4, v5, v6, v7, v8, v9: double;
  De,Ds,w1,w2,w3: double;
  aa, mm, dd, i, j: integer;
  y,m,d: integer;
const
  b = ' ';
begin
  st0 := 0;
  ecl:=ecliptic(CurrentJD);
  Fplanet.SetDE(jpldir);
  Fplanet.nutation(CurrentJD,nutl,nuto);
  Fplanet.sunecl(CurrentJD,sunl,sunb);
  PrecessionEcl(jd2000,CurrentJD,sunl,sunb);
  Fplanet.aberration(CurrentJD,abe,abp);
  Fplanet.planet(CurrentPlanet,CurrentJD, ra, Dec, dist, illum,phase,diam,magn,dp,xp,yp,zp,vel);
  rag2000:=ra;
  deg2000:=dec;
  phase:=rmod(phase+360,360);
  eph:=Fplanet.eph_method;
  Fplanet.planetOrientation(CurrentJD,CurrentPlanet, pa, De,Ds,w1,w2,w3);
  w1 := rmod(360-w1+360,360); // from W360 to E360
  w2 := rmod(360-w2+360,360);
  w3 := rmod(360-w3+360,360);
  sunincl:=Ds;
  if not geocentric then
  begin
    jd0 := jd(CurYear, CurrentMonth, CurrentDay, 0.0);
    st0 := SidTim(jd0, CurrentTime - Timezone, ObsLongitude);
    Paralaxe(st0, dist, ra, Dec, ra, Dec, q, jd2000, CurrentJD);
    diam := diam / q;
    dist := dist * q;
  end;
  apparent_equatorial(ra,Dec,ecl,sunl,abp,abe,nutl,nuto,true);
  precession(jd2000, CurrentJD, ra, dec);

  if CurrentPlanet=5 then begin
    GRS.Value:=GRSLongitude;
    GRSdrift.Value:=GRSDailydrift*365.25;
    Djd(GRSjd,y,m,d,h);
    GRSDateEdit.Date:=EncodeDate(y,m,d);
    GRSL:=Fplanet.JupGRS(GRSLongitude,GRSDailydrift,GRSjd,CurrentJD);
  end;

  StatusBar1.Panels[2].Text := rsm_51 + ': ' + date2str(curyear, currentmonth, currentday) +
    '   ' + rsm_50 + ': ' + timtostr(currenttime);

  i := 0;
  Stringgrid1.Cells[0, i] := rsEphemeris;
  Stringgrid1.Cells[1, i] := eph;
  Inc(i);
  if geocentric then
  begin
    ZenithOnTop:=false;
    Stringgrid1.Cells[0, i] := rst_100 + ':';
    Stringgrid1.Cells[1, i] := rst_26;
  end
  else
  begin
    Stringgrid1.Cells[0, i] := rst_100 + ':';
    Stringgrid1.Cells[1, i] := demtostr(ObsLatitude) + ' ' + ObsLonToStr(ObsLongitude) +
      ' Tz:' + armtostr(timezone);
  end;
  Inc(i);
  Stringgrid1.Cells[0, i] := rsm_51 + ':';
  Stringgrid1.Cells[1, i] := date2str(curyear, currentmonth, currentday) +
    ' ' + timtostr(currenttime);
  djd(currentjd, aa, mm, dd, hh);
  Inc(i);
  Stringgrid1.Cells[0, i] := rsm_51 + ' (TT):';
  Stringgrid1.Cells[1, i] := date2str(aa, mm, dd) + ' ' + timtostr(hh);
  Inc(i);
  Stringgrid1.Cells[0, i] := rst_26+'(J2000) '+rsm_29;
  Stringgrid1.Cells[1, i] := arptostr(rad2deg * rag2000 / 15,1);
  Inc(i);
  Stringgrid1.Cells[0, i] := rst_26+'(J2000) '+rsm_30;
  Stringgrid1.Cells[1, i] := deptostr(rad2deg * deg2000,1);
  Inc(i);
  Stringgrid1.Cells[0, i] := '(' + rsApparent + ')' + b + rsm_29;
  Stringgrid1.Cells[1, i] := arptostr(rad2deg * ra / 15,1);
  Inc(i);
  Stringgrid1.Cells[0, i] := '(' + rsApparent + ')' + b + rsm_30;
  Stringgrid1.Cells[1, i] := deptostr(rad2deg * dec,1);
  Inc(i);
  Stringgrid1.Cells[0, i] := rsm_31;
  Stringgrid1.Cells[1, i] := FormatFloat(f3, dist) + b + rsAU;
  Inc(i);
  Stringgrid1.Cells[0, i] := rsm_36;
  Stringgrid1.Cells[1, i] := formatfloat(f1, diam) + lsec;
  Inc(i);
  Stringgrid1.Cells[0, i] := rsMagnitude;
  Stringgrid1.Cells[1, i] := formatfloat(f1, magn);
  Inc(i);
  Stringgrid1.Cells[0, i] := rsCentralMerid;
  Stringgrid1.Cells[1, i] := FormatLongitude(w1)+' (L1'+LongitudeSystemName+')';
  if CurrentPlanet=5 then begin
    Inc(i);
    Stringgrid1.Cells[0, i] := rsCentralMerid;
    Stringgrid1.Cells[1, i] := FormatLongitude(w2)+' (L2'+LongitudeSystemName+')';
    Inc(i);
    Stringgrid1.Cells[0, i] := rsCentralMerid;
    Stringgrid1.Cells[1, i] := FormatLongitude(w3)+' (L3'+LongitudeSystemName+')';
    Inc(i);
    Stringgrid1.Cells[0, i] := 'GRS longitude';
    Stringgrid1.Cells[1, i] := DEmToStr(GRSL)+' (L2'+rsWest0360+')';
  end;
  Inc(i);
  Stringgrid1.Cells[0, i] := rsPoleInclinat;
  Stringgrid1.Cells[1, i] := formatfloat(f2, De) + ldeg ;
  Inc(i);
  Stringgrid1.Cells[0, i] := rsm_32;
  Stringgrid1.Cells[1, i] := formatfloat(f1, phase) + ldeg;
  Inc(i);
  Stringgrid1.Cells[0, i] := rsm_35;
  Stringgrid1.Cells[1, i] := formatfloat(f1, illum * 100) + '%';
  Inc(i);
  Stringgrid1.Cells[0, i] := rsm_45;
  Stringgrid1.Cells[1, i] := formatfloat(f1, sunincl) + ldeg;
  Inc(i);
  Stringgrid1.Cells[0, i] := rsm_37;
  Stringgrid1.Cells[1, i] := formatfloat(f1, pa) + ldeg;
  if not geocentric then
  begin
    eq2hz(st0 - ra, dec, az, ah);
    if ZenithOnTop then parallacticangle:= rad2deg*sin(st0-ra)/((tan(deg2rad*ObsLatitude)*cos(de))-(sin(de)*cos(st0-ra)))
            else parallacticangle:=0;
    az := rmod(rad2deg * az + 180, 360);
    Inc(i);
    Stringgrid1.Cells[0, i] := rsm_73;
    Stringgrid1.Cells[1, i] := demtostr(az);
    Inc(i);
    Stringgrid1.Cells[0, i] := rsm_74;
    Stringgrid1.Cells[1, i] := demtostr(rad2deg * ah);
    Fplanet.PlanetRiseSet(CurrentPlanet, jd(CurYear, CurrentMonth, CurrentDay, 0),
      True, planetrise, planettransit, planetset, azimuthrise, azimuthset, v1, v2, v3, v4, v5, v6, v7, v8, v9, j);
    Inc(i);
    Stringgrid1.Cells[0, i] := rsm_38;
    Stringgrid1.Cells[1, i] := planetrise;
    Inc(i);
    Stringgrid1.Cells[0, i] := rsm_39;
    Stringgrid1.Cells[1, i] := planettransit;
    Inc(i);
    Stringgrid1.Cells[0, i] := rsm_40;
    Stringgrid1.Cells[1, i] := planetset;
    Inc(i);
    Stringgrid1.Cells[0, i] := rsm_41;
    Stringgrid1.Cells[1, i] := azimuthrise;
    if obslatitude > 0 then
    begin
      Inc(i);
      Stringgrid1.Cells[0, i] := rsm_55;
      Stringgrid1.Cells[1, i] := dedtostr(90 - obslatitude + rad2deg * Dec);
    end
    else
    begin
      Inc(i);
      Stringgrid1.Cells[0, i] := rsm_55;
      Stringgrid1.Cells[1, i] := dedtostr(90 + obslatitude - rad2deg * Dec);
    end;
    Inc(i);
    Stringgrid1.Cells[0, i] := rsm_42;
    Stringgrid1.Cells[1, i] := azimuthset;
  end
  else
  begin
    parallacticangle:=0;
    Inc(i);
    Stringgrid1.Cells[0, i] := b;
    Stringgrid1.Cells[1, i] := b;
    Inc(i);
    Stringgrid1.Cells[0, i] := b;
    Stringgrid1.Cells[1, i] := b;
    Inc(i);
    Stringgrid1.Cells[0, i] := b;
    Stringgrid1.Cells[1, i] := b;
    Inc(i);
    Stringgrid1.Cells[0, i] := b;
    Stringgrid1.Cells[1, i] := b;
    Inc(i);
    Stringgrid1.Cells[0, i] := b;
    Stringgrid1.Cells[1, i] := b;
    Inc(i);
    Stringgrid1.Cells[0, i] := b;
    Stringgrid1.Cells[1, i] := b;
    Inc(i);
    Stringgrid1.Cells[0, i] := b;
    Stringgrid1.Cells[1, i] := b;
    Inc(i);
    Stringgrid1.Cells[0, i] := b;
    Stringgrid1.Cells[1, i] := b;
  end;
  activeplanet.PoleIncl := deg2rad*De;
  if CurrentPlanet=5 then begin
    activeplanet.MeridianOffset:=rmod(deg2rad*GRSL+pi+pi2,pi2);
    activeplanet.CentralMeridian := deg2rad*w2;
  end else begin
    activeplanet.MeridianOffset:=0;
    activeplanet.CentralMeridian := deg2rad*w1;
  end;
  if (CurrentPlanet<=2)and(illum<0.5) then CentralMeridian.Caption :=rst_51
     else CentralMeridian.Caption := rsCentralMerid;
  if phase < 180 then
  begin
    activeplanet.Terminator := phase - 90 + w1;
  end
  else
  begin
    activeplanet.Terminator := phase - 90 + w1 - 180;
  end;
  PA:=pa-parallacticangle;
  if FollowNorth or ZenithOnTop then
  begin
    CameraOrientation := rmod(-PA + PoleOrientation + 360, 360);
    activeplanet.Orientation:=CameraOrientation;
  end;
  activeplanet.JD:=CurrentJD;
  activeplanet.PositionAngle:=deg2rad*PA;
  activeplanet.RaCentre:=ra;
  activeplanet.DeCentre:=de;
  activeplanet.Diameter:=deg2rad*diam/3600;
  activeplanet.PlanetDistance:=dist*km_au;
  activeplanet.ShowPhase:=phaseeffect;
  activeplanet.Phase:=deg2rad*phase;
  activeplanet.SunIncl:=deg2rad*sunincl;
  activeplanet.RefreshAll;
end;

procedure  Tf_avpmain.SetZoomBar;
begin
lockzoombar:=true;
trackbar1.min := 0;
trackbar1.max := round(100 * ln(activeplanet.ZoomMax));
trackbar1.position := round(100 * ln(activeplanet.Zoom));
end;

procedure  Tf_avpmain.GetMsg(Sender: TObject; msgclass:TplanetMsgClass; value: String);
begin
if Tf_planet(sender)=activeplanet then begin
  case msgclass of
  MsgZoom: begin
            value:=StringReplace(value,'FOV:',rsm_43,[]);
            statusbar1.Panels[3].Text := pla[CurrentPlanet]+blank+value+blank+LongitudeSystemName;
            statusbar1.Hint:=value;
            SetZoomBar;
           end;
  MsgPerf: begin
            Label15.Caption := rsm_44 + blank + value;
           end;
  MsgPerfWarning: begin
            statusbar1.Panels[3].Text := value;
            Label16.Caption := value;
           end;
     else  statusbar1.Panels[3].Text := value;
  end;
  end;
end;

procedure Tf_avpmain.IdentLB(l, b, w: single);
begin
  if SearchAtPos(l, b, w) then
  begin
    l := dbm.Results[0].ByField['LONGIN'].AsFloat;
    b := dbm.Results[0].ByField['LATIN'].AsFloat;
    searchl := l;
    searchb := b;
    currentl := l;
    currentb := b;
    currentname := dbm.Results[0].ByField['NAME'].AsString;
    Combobox1.Text := currentname;
    GetHTMLDetail(dbm.Results[0], Desctxt);
    SetDescText(Desctxt);
    GetNotes(Combobox1.Text);
    if f_craterlist.Visible then
    begin
      ToolButton10Click(nil);
    end;
  end
end;

procedure Tf_avpmain.SetPlanet(p:integer);
begin
if notesedited then UpdNotesClick(nil);
SetActiveplanet(planet1);
planet1.Bumpmap:=false;
CurrentPlanet:=p;
InitNotes;
planet1.texture:=texturefiles[CurrentPlanet];
planet1.GLSpherePlanet.Scale.Y:=RPplanet[CurrentPlanet]/REplanet[CurrentPlanet];
LoadOverlay(overlayname[CurrentPlanet], overlaytr[CurrentPlanet]);
{if planet1.CanBump then
   planet1.BumpPath:=slash(appdir)+slash('Bumpmap')+slash(epla[CurrentPlanet]);
if phaseeffect and wantbump[CurrentPlanet] and planet1.CanBump then
   planet1.Bumpmap:=true
else
   planet1.Bumpmap:=false;  }
GRSPanel.Visible:=(CurrentPlanet=5);
currentid := '';
RefreshplanetImage;
SelectMedirian;
end;

procedure Tf_avpmain.FormCreate(Sender: TObject);
var
  i,k: integer;
begin
//  Satellite model
//  Label18.Visible:=true;
//  ComboBox6.Visible:=true;
  DefaultFormatSettings.DecimalSeparator := '.';
  DefaultFormatSettings.ThousandSeparator:=' ';
  UniqueInstance1:=TCdCUniqueInstance.Create(self);
  UniqueInstance1.Identifier:='Virtual_planet_Atlas_vpa';
  UniqueInstance1.OnOtherInstance:=OtherInstance;
  UniqueInstance1.OnInstanceRunning:=InstanceRunning;
  UniqueInstance1.Enabled:=true;
  UniqueInstance1.Loaded;
  ToolsWidth:=340;
  {$ifdef mswindows}
  ScaleForm(self,Screen.PixelsPerInch/96);
  ToolsWidth:=round(ToolsWidth*Screen.PixelsPerInch/96);
  {$endif}
  PageControl1.ActivePageIndex:=0;
  PageControl1.Align:=alRight;
  Splitter1.Align:=alRight;
  Panelplanet2.Align:=alLeft;
  Splitter2.Align:=alLeft;
  Panelplanet.Align:=alClient;
  Splitter2.Visible:=false;
  Panelplanet2.Visible:=false;
{$ifdef darwin}
  TrackBar1.Top:=2;
  Desc1.DefaultFontSize:=12;
  ToolButton13.Visible:=false; // fullscreen
  FullScreen1.Visible:=false;
  Selectiondimprimante1.Visible:=false;
{$endif}
{$ifdef linux}
  TrackBar1.Top:=-8;
  Selectiondimprimante1.Visible:=false;
{$endif}
{$ifdef mswindows}
  TrackBar1.Top:=-2;
  CheckBox3.Visible:=true;  // antialias
{$endif}
  StartDatlun:=false;
  StartPhotlun:=false;
  StartWeblun:=false;
  StartCDC:=false;
  CanCloseDatlun:=true;
  CanCloseWeblun:=true;
  CanClosePhotlun:=true;
  CanCloseCDC:=true;
  dbedited  := False;
  perfdeltay := 0.00001;
  lockchart := False;
  StartedByDS := False;
  distancestart := False;
  zoom      := 1.2;
  useDBN    := 9;
  compresstexture := false;
  antialias := false;
  ForceBumpMapSize:=0;
  for k:=1 to maxpla do showoverlay[k] := false;
  LastScopeTracking := 0;
  UseComputerTime := True;
  GetAppDir;
  chdir(appdir);
  skipresize := True;
  skipresize := False;
  skiporient:=false;
  skiprot:=false;
  Fplanet    := TPlanet.Create(self);
  searchlist := TStringList.Create;
  param      := TStringList.Create;
  param.Clear;
  Plan404    := nil;
  Plan404lib := LoadLibrary(lib404);
  if Plan404lib <> 0 then
  begin
    Plan404 := TPlan404(GetProcAddress(Plan404lib, 'Plan404'));
  end;
  if @Plan404=nil then begin
     MessageDlg('Could not load library '+lib404+crlf
               +'Please try to reinstall the program.',
               mtError, [mbAbort], 0);
     Halt;
  end;
  tz := TCdCTimeZone.Create;
  tz.LoadZoneTab(ZoneDir+'zone.tab');
  //CurrentPlanet:=1;
  notexture:=false;
  TextureBW:=false;
  texturenone:=TStringList.Create;
  for i:=0 to 5 do texturenone.Add('NONE');
  for k:=1 to maxpla do begin
    texturefiles[k]:=TStringList.Create;
    for i:=0 to 5 do texturefiles[k].Add('');
  end;
  CurrentPlanet:=4;
  CursorImage1 := TCursorImage.Create;
  overlayhi := Tbitmap.Create;
  overlayimg := Tbitmap.Create;
 planet1:=Tf_planet.Create(Panelplanet);
 activeplanet:=planet1;
 planet1.Initialized:=false;
 planet1.planet.Align:=alClient;
 planet1.onplanetClick:=planetClickEvent;
 planet1.onplanetMove:=planetMoveEvent;
 planet1.onplanetMeasure:=planetMeasureEvent;
 planet1.onGetMsg:=GetMsg;
 planet1.onGetLabel:=GetLabel;
 planet1.onGetSprite:=GetSprite;
 planet1.PopUp:=PopupMenu1;
 planet1.TexturePath:=slash(appdir)+slash('Textures');
 planet1.OverlayPath:=slash(appdir)+slash('Overlay');
 if fileexists(slash(appdir) + slash('data') + 'retic.cur') then
  begin
    CursorImage1.LoadFromFile(slash(appdir) + slash('data') + 'retic.cur');
    Screen.Cursors[crRetic] := CursorImage1.Handle;
    planet1.GLSceneViewer1.Cursor := crRetic;
  end;
  SetLang1;
  readdefault;
  planet1.AntiAliasing:=antialias;
  planet1.ForceBumpMapSize:=ForceBumpMapSize;
  currentid := '';
  lastx     := 0;
  lasty     := 0;
  SkipIdent := False;
  dbnotes   := TMlb2.Create;
  GetSkyChartInfo;
  CheckBox8.Checked := compresstexture;
  CheckBox3.Checked := antialias;
  skiporient:=true;
  if PoleOrientation = 0 then
    RadioGroup2.ItemIndex := 0
  else begin
    RadioGroup2.ItemIndex := 1;
    RadioGroup2Click(nil);
  end;
  checkbox1.Checked := FollowNorth;
  checkbox4.Checked := ZenithOnTop;
  skiporient:=false;
  ToolButton12.Down := showlabel;
  appname := ParamStr(0);
  if paramcount > 0 then
  begin
    for i := 1 to paramcount do
    begin
      param.Add(ParamStr(i));
      if ParamStr(i) = '-safe' then
        borderstyle := bsNone; // canot set this later in formshow
    end;
  end;
end;

procedure Tf_avpmain.FormShow(Sender: TObject);
begin
// bug with tupdown size. width must be 13 on form designer
UpDown1.Width:=14;
UpDown2.Width:=14;
UpDown3.Width:=14;
UpDown4.Width:=14;
UpDown5.Width:=14;
UpDown6.Width:=14;
Application.BringToFront;
planet1.GLSceneViewer1.Camera:=nil;
StartTimer.Enabled:=true;
end;

Procedure Tf_avpmain.InitNotes;
begin
  dbnotes.Clear;
  if fileexists(Slash(DBdir)+'notes_'+trim(epla[CurrentPlanet])+'.csv') then begin
    dbnotes.LoadFromFile(Slash(DBdir)+'notes_'+trim(epla[CurrentPlanet])+'.csv')
  end else begin
    dbnotes.AddField('NAME');
    dbnotes.AddField('NOTES');
  end;
  dbnotes.GoFirst;
end;

procedure Tf_avpmain.Init;
var i: integer;
begin
try
  Setlang;
  screen.cursor := crHourGlass;
  application.ProcessMessages;
  LoadDB(dbm);
  application.ProcessMessages;
  InitNotes;
  if UseComputerTime then
    InitDate
  else
    SetJDDate;
  planet1.Init;
  planet1.BumpMethod:=TBumpMapCapability(BumpMethod);
  planet1.BumpMipmap:=BumpMipmap;
  planet1.TextureCompression:=compresstexture;
  planet1.TextureBW:=TextureBW;
  planet1.GLSpherePlanet.Scale.Y:=RPplanet[CurrentPlanet]/REplanet[CurrentPlanet];
  try
  if notexture
     then planet1.texture:=texturenone
     else planet1.texture:=texturefiles[CurrentPlanet];
  except
    on E: Exception do begin
    {$ifdef trace_debug}
      debugln('Exception init texture '+E.Message);
    {$endif}
    notexture:=true;
    planet1.texture:=texturenone;
    end;
  end;
  if planet1.CanBump then
     planet1.BumpPath:=slash(appdir)+slash('Bumpmap')+slash(epla[CurrentPlanet]);
  planet1.VisibleSideLock:=true;
  planet1.Labelcolor:=autolabelcolor;
  AsMultiTexture:=planet1.AsMultiTexture;
  planet1.SetMark(0, 0, '');
  planet1.zoom:=zoom;
  planet1.GridSpacing:=gridspacing;
  ReadParam;
  memo2.Width    := PrintTextWidth;
  label10.Left   := toolbar2.left + toolbar2.Width + 2;
  trackbar1.Left := label10.Left + label10.Width + 2;
  toolbar1.Left  := trackbar1.Left + trackbar1.Width + 2;
  Trackbar2.position := planet1.ambientColor and $FF;
  Trackbar3.position := planet1.diffuseColor and $FF;
  Trackbar4.position := planet1.specularColor and $FF;
  if planet1.GLSphereplanet.Slices = 2880 then
    Trackbar5.position := 7
  else if planet1.GLSphereplanet.Slices = 1440 then
    Trackbar5.position := 6
  else if planet1.GLSphereplanet.Slices = 720 then
      Trackbar5.position := 5
  else if planet1.GLSphereplanet.Slices = 360 then
    Trackbar5.position := 4
  else if planet1.GLSphereplanet.Slices = 180 then
    Trackbar5.position := 3
  else if planet1.GLSphereplanet.Slices = 90 then
    Trackbar5.position := 2
  else if planet1.GLSphereplanet.Slices = 45 then
    Trackbar5.position := 1
  else
    Trackbar5.position := 1;
  GRSPanel.Visible:=(CurrentPlanet=5);
  LabelAltitude.Caption:=inttostr(TrackBar6.Position) + blank + rsm_18;
  LabelIncl.Caption:=inttostr(TrackBar7.Position)+ ldeg;
  PhaseButton.Down := phaseeffect;
  LoadOverlay(overlayname[CurrentPlanet], overlaytr[CurrentPlanet]);
  Visible:=true;
  GridButtonClick(nil);
  if currentname <> '' then
  begin
    firstsearch := True;
    searchname(currentname, False);
  end;
  planet1.Mirror:=checkbox2.Checked;
  GridButton.Visible:=AsMultiTexture;
except
  on E: Exception do begin
  {$ifdef trace_debug}
    debugln('Exception Init '+E.Message);
  {$endif}
  end;
end;
screen.cursor := crDefault;
end;

Procedure Tf_avpmain.SelectMedirian;
begin
    RadioGroup1.ItemIndex := 0;
    ComboBox2.ItemIndex:=2;
    UpdCentralMeridian(20,true);
    SearchText  := trim(ListBox1.Items[0]);
    if searchtext=trim(rsm_27) then begin
      UpdCentralMeridian(40,true);
      SearchText  := trim(ListBox1.Items[0]);
    end;
    Firstsearch := True;
    SearchName(SearchText, false);
    currentmeridian := -999;
    planet1.CenterAt(99999, 99999);
  end;

procedure Tf_avpmain.StartTimerTimer(Sender: TObject);
begin
StartTimer.Enabled:=false;
screen.cursor := crHourGlass;
init;
try
  if (currentid = '') then
  begin
    // show an interesting object
    RefreshplanetImage;
    SelectMedirian;
  end;
  planet1.GLSceneViewer1.Visible:=true;
  planet1.GLSceneViewer1.Camera:=planet1.GLCamera1;
  Application.ProcessMessages;
  PhaseButtonClick(nil);
  SetZoomBar;
  planet1.Initialized:=true;
  planet1.RefreshAll;
  screen.cursor := crDefault;
if firstuse then begin
    Configuration1Click(nil);
    firstuse:=false;
end;
except
  on E: Exception do begin
  {$ifdef trace_debug}
    debugln('Exception StartTimerTimer '+E.Message);
  {$endif}
  end;
end;
screen.cursor := crDefault;
end;

procedure Tf_avpmain.Configuration1Click(Sender: TObject);
var
  reload, reloaddb, systemtimechange: boolean;
  i : integer;
  p: TPoint;
begin
  f_config:=Tf_config.Create(self);
  f_config.onPrinterDialog:=Selectiondimprimante1Click;
  f_config.tzinfo:=tz;
  f_config.LoadCountry(slash(Appdir)+slash('data')+'country.tab');
  f_config.Setlang;
  if firstuse then begin
    f_config.Caption:=rsFirstUseSett;
    f_config.PageControl1.Page[0].TabVisible:=true;
    for i:=1 to f_config.PageControl1.PageCount-1 do f_config.PageControl1.Page[i].TabVisible:=false;
  end;
  try
  activeplanet.SatelliteRotation:=0;
  p:=Point(ToolButton2.Left,ToolButton2.Top+ToolButton2.Height);
  p:=ToolBar2.ClientToScreen(p);
  try
    reload   := False;
    reloaddb := False;
    f_config.Edit1.Text := formatfloat(f2, abs(ObsLatitude));
    f_config.Edit2.Text := formatfloat(f2, abs(ObsLongitude));
    if Obslatitude >= 0 then
      f_config.ComboBox1.ItemIndex := 0
    else
      f_config.ComboBox1.ItemIndex := 1;
    if Obslongitude >= 0 then
      f_config.ComboBox2.ItemIndex := 1
    else
      f_config.ComboBox2.ItemIndex := 0;
    f_config.checkbox1.Checked := phaseeffect;
    f_config.RadioGroupLong.ItemIndex:=ord(LongSystem[CurrentPlanet]);
    f_config.checkbox5.Checked := showlabel;
    f_config.checkbox6.Checked := showmark;
    f_config.checkbox17.Checked := labelcenter;
    f_config.Shape1.Brush.Color := marklabelcolor;
    f_config.Shape2.Brush.Color := markcolor;
    f_config.Shape3.Brush.Color := autolabelcolor;
    f_config.TrackBar2.Position := -LabelDensity;
    f_config.newlang := language;
    {if wantbump[CurrentPlanet] or activeplanet.Bumpmap then
       f_config.BumpRadioGroup.ItemIndex:=1
    else }if activeplanet.Texture[0]='NONE' then
       f_config.BumpRadioGroup.ItemIndex:=1
    else
       f_config.BumpRadioGroup.ItemIndex:=0;
    f_config.BumpRadioGroup.Visible:=(activeplanet.BumpMapCapabilities<>[]);
    if saveimagesize = 0 then
      f_config.ComboBox4.ItemIndex := 0
    else
      f_config.ComboBox4.Text      := IntToStr(saveimagesize);
    f_config.CheckBox7.Checked := saveimagewhite;
    f_config.LongEdit1.Value    := LeftMargin;
    f_config.TrackBar1.Position := PrintTextWidth;
    f_config.CheckBox13.Checked := PrintChart;
    f_config.CheckBox8.Checked  := PrintEph;
    f_config.CheckBox9.Checked  := PrintDesc;
    f_config.TextureBW.Checked := activeplanet.TextureBW;
    f_config.TexturePath := activeplanet.TexturePath;
    f_config.texturefn.Assign(texturefiles[CurrentPlanet]);
    if (overlayname[CurrentPlanet]='')and(f_config.combobox5.Items.Count>0) then f_config.combobox5.Text:=f_config.combobox5.Items[0]
     else f_config.combobox5.Text := remext(overlayname[CurrentPlanet]);
    f_config.trackbar5.position := round(overlaytr[CurrentPlanet]*100);
    f_config.combobox5change(Sender);
    f_config.checkbox11.Checked := showoverlay[CurrentPlanet];
    f_config.checkbox10.Checked := GridButton.Down;
    f_config.TrackBar3.Position:=gridspacing;
    f_config.checkbox16.Checked := UseComputerTime;
    f_config.FontDialog1.Font:=activeplanet.LabelFont;
    f_config.LabelFont.Caption:=activeplanet.LabelFont.Name;
    f_config.LabelFont.Font:=activeplanet.LabelFont;
    f_config.LabelFont.Font.Color:=clWindowText;
    f_config.obstz:=ObsTZ;
    f_config.SetObsCountry(ObsCountry);
    FormPos(f_config,p.x,p.y);
    f_config.showmodal;
    if f_config.ModalResult = mrOk then
    begin
      screen.cursor := crhourglass;
      if (f_config.combobox5.Text <> remext(overlayname[CurrentPlanet])) or
        (f_config.trackbar5.position <> round(overlaytr[CurrentPlanet]*100)) or
        (f_config.TrackBar3.Position<>gridspacing) or
        (f_config.checkbox11.Checked <> showoverlay[CurrentPlanet]) then
        reload    := True;
      overlayname[CurrentPlanet] := f_config.combobox5.Text + '.jpg';
      overlaytr[CurrentPlanet]  := f_config.trackbar5.position/100;
      showoverlay[CurrentPlanet] := f_config.checkbox11.Checked;
      GridButton.Down:=f_config.checkbox10.Checked;
      gridspacing:=f_config.TrackBar3.Position;
      TextureBW:=f_config.TextureBW.Checked;
      if f_config.TextureChanged then
      begin
        activeplanet.TextureBW := TextureBW;
        texturefiles[CurrentPlanet].Assign(f_config.texturefn);
        reload := True;
      end;
      {if activeplanet=planet1 then begin
        if wantbump[CurrentPlanet]<>(f_config.BumpRadioGroup.ItemIndex=1) then reload:=true;
        wantbump[CurrentPlanet] := (f_config.BumpRadioGroup.ItemIndex=1)and(activeplanet.BumpMapCapabilities<>[]);
      end else }
      wantbump[CurrentPlanet]:=false;
      notexture:=(f_config.BumpRadioGroup.ItemIndex=1);
      LongSystem[CurrentPlanet] := TLongSystem(f_config.RadioGroupLong.ItemIndex);
      markcolor     := f_config.Shape2.Brush.Color;
      spritecolor:=markcolor;
      marklabelcolor    := f_config.Shape1.Brush.Color;
      autolabelcolor := f_config.Shape3.Brush.Color;
      LabelDensity  := abs(f_config.TrackBar2.Position);
      showlabel     := f_config.checkbox5.Checked;
      showmark      := f_config.checkbox6.Checked;
      labelcenter   := f_config.checkbox17.Checked;
      activeplanet.LabelFont:=f_config.FontDialog1.Font;
      activeplanet.Labelcolor:=autolabelcolor;
      Obslatitude := strtofloat(f_config.Edit1.Text);
      if f_config.ComboBox1.ItemIndex = 1 then
        Obslatitude := -Obslatitude;
      Obslongitude  := strtofloat(f_config.Edit2.Text);
      if f_config.ComboBox2.ItemIndex = 0 then
        Obslongitude := -Obslongitude;
      systemtimechange := UseComputerTime <> f_config.checkbox16.Checked;
      ObsCountry:=f_config.ObsCountry;
      ObsTZ := f_config.obstz;
      tz.TimeZoneFile := ZoneDir + StringReplace(ObsTZ, '/', PathDelim, [rfReplaceAll]);
      UseComputerTime := f_config.checkbox16.Checked;
      timezone := gettimezone(now);
      if systemtimechange then
      begin
        InitDate;
        reload := True;
      end;
      phaseeffect     := f_config.checkbox1.Checked;
      InitObservatoire;
      CurrentJD := jd(CurYear, CurrentMonth, CurrentDay, Currenttime - timezone + DT_UT);
      if f_config.newlang <> language then
      begin
        language:=u_translation.translate(f_config.newlang,'en');
        u_translation_database.translate(language,'en');
        uplanguage:=uppercase(language);
        SetLang;
        reloaddb := True;
      end;
      if reloaddb then begin
        LoadDB(dbm);
        firstsearch := True;
        SearchName(currentname, False);
      end;
      PhaseButton.Down     := phaseeffect;
      saveimagewhite := f_config.CheckBox7.Checked;
      val(f_config.ComboBox4.Text, saveimagesize, i);
      if i <> 0 then
        saveimagesize := 0;
      LeftMargin := f_config.LongEdit1.Value;
      PrintTextWidth := f_config.TrackBar1.Position;
      memo2.Width := PrintTextWidth;
      PrintChart := f_config.CheckBox13.Checked;
      PrintEph  := f_config.CheckBox8.Checked;
      PrintDesc := f_config.CheckBox9.Checked;
      PhaseButtonClick(nil);
      GridButtonClick(nil);
      if reload then
      begin
        application.ProcessMessages;
        LoadOverlay(overlayname[CurrentPlanet], overlaytr[CurrentPlanet]);
        if notexture
           then activeplanet.Texture:=texturenone
           else activeplanet.Texture:=texturefiles[CurrentPlanet];
        activeplanet.GridSpacing:=gridspacing;
        RefreshplanetImage;
        activeplanet.Zoom:=activeplanet.Zoom;
      end
      else
        RefreshplanetImage;
      if geocentric and CheckBox4.Checked then  CheckBox4.Checked:=false;
      SaveDefault;
      RefreshDetail;
    end;
except
    on E: Exception do begin
    {$ifdef trace_debug}
      debugln('Exception Configuration1Click '+E.Message);
    {$endif}
    end;
end;
finally
  screen.cursor := crdefault;
  FreeAndNil(f_config);
end;
end;

procedure Tf_avpmain.Splitter1Moved(Sender: TObject);
begin
 ToolsWidth:=PageControl1.Width;
 if ToolsWidth<100 then ToolsWidth:=100;
 FormResize(Sender);
end;

procedure Tf_avpmain.Splitter2Moved(Sender: TObject);
begin
if Panelplanet.Width>0 then begin
  SplitSize:=Panelplanet.Width/(Panelplanet.Width+Panelplanet2.Width);
  FormResize(Sender);
end;
end;


procedure Tf_avpmain.ToolButton12Click(Sender: TObject);
begin
 showlabel:=not showlabel;
 ToolButton12.Down := showlabel;
 activeplanet.RefreshAll;
end;

procedure Tf_avpmain.GridButtonClick(Sender: TObject);
begin
  activeplanet.ShowGrid:=GridButton.Down;
end;

procedure Tf_avpmain.ToolButton14Click(Sender: TObject);
begin
  activeplanet.ShowScale:=ToolButton14.Down;
end;

procedure Tf_avpmain.ToolButton1Click(Sender: TObject);
var p: TPoint;
begin
  activeplanet.SatelliteRotation:=0;
  p:=Point(ToolButton1.Left,ToolButton1.Top+ToolButton1.Height);
  p:=ToolBar2.ClientToScreen(p);
  FilePopup.PopUp(p.x,p.y);
end;

procedure Tf_avpmain.ToolButton8Click(Sender: TObject);
var p: TPoint;
begin
  activeplanet.SatelliteRotation:=0;
  p:=Point(ToolButton8.Left,ToolButton8.Top+ToolButton8.Height);
  p:=ToolBar2.ClientToScreen(p);
  HelpPopup.PopUp(p.x,p.y);
end;

procedure Tf_avpmain.FormResize(Sender: TObject);
var
  dx,w1,w2: integer;
begin
  if skipresize then
    exit;
  if csDestroying in ComponentState then
    exit;
  if csLoading in ComponentState then
    exit;
  if ToolsWidth<100 then ToolsWidth:=100;
  PageControl1.width:=ToolsWidth;
  if Panelplanet2.Visible then begin
    dx:=ClientWidth-Splitter2.Width;
    if not FullScreen then dx:=dx-ToolsWidth-Splitter1.Width;
    w1:=round(SplitSize*dx);
    w2:=dx-w1;
    Panelplanet.Width:=w1;
    Panelplanet2.Width:=w2;
    planet2.GLSceneViewer1.Align:=alNone;
    planet2.GLSceneViewer1.Top:=0;
    planet2.GLSceneViewer1.Align:=alClient;
  end;
  planet1.GLSceneViewer1.Align:=alNone;
  planet1.GLSceneViewer1.Top:=-0;
  planet1.GLSceneViewer1.Align:=alClient;
  planet1.RefreshAll;
  activeplanet.GetZoomInfo;
  if sender<>nil then ResizeTimer.Enabled:=true;
end;

procedure Tf_avpmain.Button5Click(Sender: TObject);
begin
  initdate;
  RefreshplanetImage;
end;

procedure Tf_avpmain.ResizeTimerTimer(Sender: TObject);
begin
ResizeTimer.Enabled:=false;
FormResize(nil);
end;

procedure Tf_avpmain.SaveEphemClick(Sender: TObject);
begin
  if f_ephem=nil then begin
     f_ephem:=Tf_ephem.Create(self);
     f_ephem.Fplanet:=Fplanet;
     f_ephem.tz:=tz;
     f_ephem.Setlang;
     f_ephem.annee.Value:=CurYear;
     f_ephem.annee1.Value:=CurYear;
     f_ephem.mois.Value:=CurrentMonth;
     f_ephem.mois1.Value:=CurrentMonth;
     f_ephem.jour.Value:=CurrentDay;
     f_ephem.jour1.Value:=CurrentDay;
  end;
  f_ephem.geocentric:=geocentric;
  FormPos(f_ephem,mouse.CursorPos.X,Mouse.CursorPos.Y);
  f_ephem.ShowModal;
end;

procedure Tf_avpmain.SelectPlanet(Sender: TObject);
begin
SetPlanet(TMenuItem(sender).Tag);
end;

procedure Tf_avpmain.Button10Click(Sender: TObject);
begin
  heure.Value      := 0;
  minute.Value     := 0;
  seconde.Value    := 0;
  updown4.position := 0;
  updown5.position := 0;
  updown6.position := 0;
  Button4Click(Sender);
end;

procedure Tf_avpmain.Button4Click(Sender: TObject);
var
  y, m, d: integer;
  h, n, s: word;
begin
  y     :=annee.Value;
  m     :=mois.Value;
  d     :=jour.Value;
  h     :=heure.Value;
  n     :=minute.Value;
  s     :=seconde.Value;
  timezone := GetJDTimeZone(jd(y, m, d, h+n/60+s/3600-timezone));
  dt_ut := dtminusut(y);
  CurYear := y;
  CurrentMonth := m;
  CurrentDay := d;
  Currenttime := h + n / 60 + s / 3600;
  CurrentJD := jd(y, m, d, Currenttime - timezone + DT_UT);
  RefreshplanetImage;
end;

procedure Tf_avpmain.TrackBar1Change(Sender: TObject);
begin
ZoomTimer.Enabled:=false;
if not lockzoombar then
   ZoomTimer.Enabled:=true;
lockzoombar:=false;
end;

procedure Tf_avpmain.ZoomTimerTimer(Sender: TObject);
begin
ZoomTimer.Enabled:=false;
activeplanet.Zoom := exp(trackbar1.position/100);
end;

procedure Tf_avpmain.EphTimer1Timer(Sender: TObject);
begin
  if lockrepeat then
    exit;
  lockrepeat := True;
  CurrentJD  := CurrentJD + EphStep;
  SetJDDate;
  RefreshplanetImage;
  EphTimer1.interval := 50;
  lockrepeat := False;
end;

procedure Tf_avpmain.Button3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  EphStep    := +1;
  lockrepeat := False;
  ephtimer1timer(Sender);
  EphTimer1.interval := 1000;
  EphTimer1.Enabled  := True;
end;

procedure Tf_avpmain.Button3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  EphTimer1.Enabled := False;
end;

procedure Tf_avpmain.Button3MouseLeave(Sender: TObject);
begin
  EphTimer1.Enabled := False;
end;

procedure Tf_avpmain.CheckBox3Click(Sender: TObject);
begin
  AntiAlias:=CheckBox3.Checked;
end;

procedure Tf_avpmain.ComboBox6Change(Sender: TObject);
begin
  case ComboBox6.ItemIndex of
  0 : activeplanet.SatelliteModel:='';
  1 : begin
      activeplanet.SatelliteModel:=slash(Appdir)+slash('Models')+'lem.3ds';
      activeplanet.SatelliteModelScale:=0.0006;
      activeplanet.SatDirection(0,0,-1);
      activeplanet.SatUp(-1,0,0);
      activeplanet.SatPos(0,0,0);
      end;
  2 : begin
      activeplanet.SatelliteModel:=slash(Appdir)+slash('Models')+'apollo.3ds';
      activeplanet.SatelliteModelScale:=0.0000007;
      activeplanet.SatDirection(1,0,0);
      activeplanet.SatPos(0.003,0,0.005);
      end;
  end;
end;

procedure Tf_avpmain.FullScreen1Click(Sender: TObject);
begin
  SetFullScreen;
end;

procedure Tf_avpmain.Button6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  EphStep    := +1 / 24;
  lockrepeat := False;
  ephtimer1timer(Sender);
  EphTimer1.interval := 1000;
  EphTimer1.Enabled  := True;
end;

procedure Tf_avpmain.Button7MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  EphStep    := -1 / 24;
  lockrepeat := False;
  ephtimer1timer(Sender);
  EphTimer1.interval := 1000;
  EphTimer1.Enabled  := True;
end;

procedure Tf_avpmain.Button8MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  EphStep    := -1;
  lockrepeat := False;
  ephtimer1timer(Sender);
  EphTimer1.interval := 1000;
  EphTimer1.Enabled  := True;
end;

procedure Tf_avpmain.ToolButton5Click(Sender: TObject);
begin
  if activeplanet.zoom = 1 then
    activeplanet.CenterAt(99999, 99999)
  else
    activeplanet.CenterMark;
end;


{$ifdef windows}
procedure Tf_avpmain.SetFullScreen;
var lPrevStyle: LongInt;
begin
FullScreen:=not FullScreen;
if FullScreen then begin
   savetop:=top;
   saveleft:=left;
   savewidth:=width;
   saveheight:=height;
   lPrevStyle := GetWindowLong(handle, GWL_STYLE);
   SetWindowLong(handle, GWL_STYLE, (lPrevStyle And (Not WS_THICKFRAME) And (Not WS_BORDER) And (Not WS_CAPTION) And (Not WS_MINIMIZEBOX) And (Not WS_MAXIMIZEBOX)));
   SetWindowPos(handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED Or SWP_NOMOVE Or SWP_NOSIZE Or SWP_NOZORDER);
   PageControl1.Visible:=false;
   Splitter1.Visible:=false;
   ControlBar1.Visible:=false;
   StatusBar1.Visible:=false;
   Position1.Visible:=false;
   Notes1.Visible:=false;
   Distance1.Visible:=false;
   FullScreen1.Caption:=rsQuitfull;
   top:=0;
   left:=0;
   skipresize:=true;
   width:=screen.Width;
   skipresize:=true;
   height:=screen.Height;
   skipresize:=false;
end else begin
   lPrevStyle := GetWindowLong(handle, GWL_STYLE);
   SetWindowLong(handle, GWL_STYLE, (lPrevStyle Or WS_THICKFRAME Or WS_BORDER Or WS_CAPTION Or WS_MINIMIZEBOX Or WS_MAXIMIZEBOX));
   SetWindowPos(handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED Or SWP_NOMOVE Or SWP_NOSIZE Or SWP_NOZORDER);
   ControlBar1.Visible:=true;
   StatusBar1.Visible:=true;
   PageControl1.Visible:=true;
   Splitter1.Visible:=true;
   Position1.Visible:=true;
   Notes1.Visible:=true;
   Distance1.Visible:=true;
   FullScreen1.Caption:=rsFullScreen;
   top:=savetop;
   left:=saveleft;
   width:=savewidth;
   height:=saveheight;
end;
end;
{$endif}

{$ifdef unix}
procedure Tf_avpmain.SetFullScreen;
begin
FullScreen:=not FullScreen;
{$IF DEFINED(LCLgtk) or DEFINED(LCLgtk2)}
  skipresize:=true;
  SetWindowFullScreen(f_avpmain,FullScreen);
  if FullScreen then begin
    PageControl1.Visible:=false;
    Splitter1.Visible:=false;
    ControlBar1.Visible:=false;
    StatusBar1.Visible:=false;
    Position1.Visible:=false;
    Notes1.Visible:=false;
    Distance1.Visible:=false;
    FullScreen1.Caption:=rsQuitfull;
  end
  else begin
    ControlBar1.Visible:=true;
    StatusBar1.Visible:=true;
    PageControl1.Visible:=true;
    Splitter1.Visible:=true;
    Position1.Visible:=true;
    Notes1.Visible:=true;
    Distance1.Visible:=true;
    FullScreen1.Caption:=rsFullScreen;
  end;
  skipresize:=false;
{$endif}
end;
{$endif}

procedure Tf_avpmain.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
//statusbar1.Panels[3].Text :='Down: '+inttostr(key);
case key of
  16  :  activeplanet.KeyEvent(mkDown,key); // Shift
  17  :  activeplanet.KeyEvent(mkDown,key); // Ctrl
  27  :  SetFullScreen; // Esc
  122 :  SetFullScreen; // F11
end;
end;

procedure Tf_avpmain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//statusbar1.Panels[3].Text :='Up: '+inttostr(key);
try
case key of
  16  :  activeplanet.KeyEvent(mkUp,key); // Shift
  17  :  activeplanet.KeyEvent(mkUp,key); // Ctrl
  107 :  if Shift=[ssCtrl] then IncreaseFont1Click(nil);   //ctrl+
  109 :  if Shift=[ssCtrl] then DecreaseFont1Click(nil);   //ctrl-
end;
except
  on E: Exception do begin
  {$ifdef trace_debug}
    debugln('Exception FormKeyUp '+E.Message);
  {$endif}
  end;
end;
end;

procedure Tf_avpmain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose := True;
end;

procedure Tf_avpmain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ok:     boolean;
begin
  try
    SaveDefault;
    if CanCloseCDC and StartCDC then OpenCDC('','--quit');
  except
    on E: Exception do begin
    {$ifdef trace_debug}
      debugln('Exception FormClose '+E.Message);
    {$endif}
    end;
  end;
end;

procedure Tf_avpmain.FormDestroy(Sender: TObject);
var i: integer;
begin
  try
    if planet2<>nil then begin
       planet2.close;
       planet2.Free;
    end;
    dbnotes.Free;
    tz.Free;
    Fplanet.Free;
    overlayimg.Free;
    overlayhi.Free;
    searchlist.Free;
    param.Free;
    for i:=1 to maxpla do texturefiles[i].Free;
    texturenone.Free;
    if CursorImage1 <> nil then
    begin
      CursorImage1.Free;
    end;
    if f_ephem<>nil then f_ephem.Free;
  except
    on E: Exception do begin
    {$ifdef trace_debug}
      debugln('Exception FormDestroy '+E.Message);
    {$endif}
    end;
  end;
end;


procedure Tf_avpmain.ShowImg(desc, nom: string; forceinternal: boolean);
var
  buf, buf1: string;
begin
  chdir(appdir);
  buf  := slash(desc) + trim(nom);
  buf1 := '';
  if fileexists(buf) then
  begin
       if ima=nil then begin
          ima:=Tbigimaform.Create(application);
          ima.toolbutton1.caption:=imac1;
          ima.toolbutton2.caption:=imac2;
          ima.toolbutton3.caption:=imac3;
       end;
       if forceinternal then ima.zoom:=0;
       ima.image1.visible:=true;
       ima.toolbar1.visible:=true;
       ima.titre:=nom;
       ima.labeltext:=buf1;
       ima.Toolbar1.hint:=buf1;
       ima.LoadImage(buf);
       ima.Init;
       ima.Show;
    end;
end;

procedure Tf_avpmain.Apropos1Click(Sender: TObject);
begin
  ToolButton8.Down := False;
  splash := Tsplash.Create(application);
  splashunit.SplashTimer := False;
  splash.Caption := stringreplace(Apropos1.Caption, '&', '', []);
  splash.VersionName   := VersionName;
  splash.Splashversion := Splashversion;
  splash.transmsg      := transmsg;
  splash.Show;
  splash.refresh;
end;

procedure Tf_avpmain.ToolButton9Click(Sender: TObject);
begin
  activeplanet.Zoom:=1;
end;

procedure Tf_avpmain.Edit1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 13 then
    button1.Click;  //Enter
end;


procedure Tf_avpmain.TrackBar5Change(Sender: TObject);
var
  i: integer;
begin
  i := Trackbar5.position;
  if i = 7 then
    i := 2880
  else if i = 6 then
      i := 1440
  else if i = 5 then
    i := 720
  else if i = 4 then
    i := 360
  else if i = 3 then
    i := 180
  else if i = 2 then
    i := 90
  else if i = 1 then
    i := 45
  else
    i := 90;
  planet1.GLSphereplanet.Slices:=i;
  planet1.GLSphereplanet.Stacks:=i div 2;
  if planet2<>nil then begin
    planet2.GLSphereplanet.Slices:=i;
    planet2.GLSphereplanet.Stacks:=i div 2;
  end;
end;

procedure Tf_avpmain.PageControl1Change(Sender: TObject);
begin
  if planet1=nil then exit;
  if (pagecontrol1.ActivePage = Reglage) then
  begin
    SetFPSTimer.Enabled:=true;
    Label15.Caption     := rsm_44 + ' 0 FPS';
  end
  else
  begin
    planet1.ShowFPS:=false;
  end;

  if pagecontrol1.ActivePage = CentralMeridian then
  begin
    if currentmeridian <> activeplanet.CentralMeridian then
      UpdCentralMeridian;
  end;

  if pagecontrol1.ActivePage = Outils then
  begin
    RadioGroup2.Invalidate;
    if activeplanet.MeasuringDistance then
      Button11.Caption      := rsm_53
    else
      Button11.Caption      := rsm_52;
  end
  else
  begin
    activeplanet.MeasuringDistance := False;
    activeplanet.SatelliteRotation:=0;
  end;
end;

procedure Tf_avpmain.SetFPSTimerTimer(Sender: TObject);
begin
  SetFPSTimer.Enabled:=false;
  planet1.ShowFPS:=true;
end;

procedure Tf_avpmain.Stop1Click(Sender: TObject);
begin
  activeplanet.SatelliteRotation:=0;
end;

procedure Tf_avpmain.EastWest1Click(Sender: TObject);
begin
  PageControl1.ActivePage:=Outils;
  rotdirection := -rotdirection;
  activeplanet.SatelliteRotation:=rotdirection*rotstep;
end;

procedure Tf_avpmain.N10seconde1Click(Sender: TObject);
begin
  PageControl1.ActivePage:=Outils;
  combobox4.ItemIndex := 0;
  rotstep := 10;
  activeplanet.SatelliteRotation:=rotdirection*rotstep;
end;

procedure Tf_avpmain.N5seconde1Click(Sender: TObject);
begin
  PageControl1.ActivePage:=Outils;
  combobox4.ItemIndex := 1;
  rotstep := 5;
  activeplanet.SatelliteRotation:=rotdirection*rotstep;
end;

procedure Tf_avpmain.N1seconde1Click(Sender: TObject);
begin
  PageControl1.ActivePage:=Outils;
  combobox4.ItemIndex := 2;
  rotstep := 1;
  activeplanet.SatelliteRotation:=rotdirection*rotstep;
end;

procedure Tf_avpmain.N05seconde1Click(Sender: TObject);
begin
  PageControl1.ActivePage:=Outils;
  combobox4.ItemIndex := 3;
  rotstep := 0.5;
  activeplanet.SatelliteRotation:=rotdirection*rotstep;
end;

procedure Tf_avpmain.N02seconde1Click(Sender: TObject);
begin
  PageControl1.ActivePage:=Outils;
  combobox4.ItemIndex := 4;
  rotstep := 0.2;
  activeplanet.SatelliteRotation:=rotdirection*rotstep;
end;

procedure Tf_avpmain.ComboBox4Change(Sender: TObject);
begin
if skiprot then exit;
  case combobox4.ItemIndex of
    0: rotstep := 10;
    1: rotstep := 5;
    2: rotstep := 1;
    3: rotstep := 0.5;
    4: rotstep := 0.2;
  end;
  activeplanet.SatelliteRotation:=rotdirection*rotstep;
end;

procedure Tf_avpmain.SpeedButton1Click(Sender: TObject);
begin
  rotdirection := 1;
  activeplanet.SatelliteRotation:=rotdirection*rotstep;
end;

procedure Tf_avpmain.SpeedButton2Click(Sender: TObject);
begin
  activeplanet.SatelliteRotation:=0;
end;

procedure Tf_avpmain.SpeedButton7Click(Sender: TObject);
begin
 activeplanet.SatelliteRotation:=rotdirection*MinSingle;
end;

procedure Tf_avpmain.SpeedButton3Click(Sender: TObject);
begin
  rotdirection := -1;
  activeplanet.SatelliteRotation:=rotdirection*rotstep;
end;

procedure Tf_avpmain.SpeedButton5Click(Sender: TObject);
begin
activeplanet.SatWest;
end;

procedure Tf_avpmain.SpeedButton4Click(Sender: TObject);
begin
activeplanet.SatEast;
end;

procedure Tf_avpmain.SpeedButton6Click(Sender: TObject);
begin
  activeplanet.SatCenter;
end;

procedure Tf_avpmain.TrackBar6Change(Sender: TObject);
begin
if skiprot then exit;
  activeplanet.SatelliteAltitude:=TrackBar6.Position;
  LabelAltitude.Caption:=inttostr(TrackBar6.Position) + blank + rsm_18;
end;

procedure Tf_avpmain.TrackBar7Change(Sender: TObject);
begin
if skiprot then exit;
  activeplanet.SatInclination:=TrackBar7.Position;
  LabelIncl.Caption:=inttostr(TrackBar7.Position)+ ldeg;
end;

procedure Tf_avpmain.TrackBar8Change(Sender: TObject);
begin
  activeplanet.SatViewDistance:=TrackBar8.Position/4;
end;

procedure Tf_avpmain.ComboBox2Change(Sender: TObject);
begin
  UpdCentralMeridian;
end;

procedure Tf_avpmain.ListBox1Click(Sender: TObject);
var
  i, p: integer;
begin
  i := listbox1.ItemIndex;
  if i >= 0 then
  begin
    Firstsearch := True;
    SearchText := listbox1.Items[i];
    if RadioGroup1.ItemIndex > 0 then begin
       p := pos(' ', SearchText) + 1;
       SearchText := copy(Searchtext, p, 999);
    end;
    SearchName(SearchText, True);
  end;
end;

procedure Tf_avpmain.GetSkychartInfo;
var
  inif: TMemIniFile;
  buf:  string;
begin
  CdCdir := '';
  // Try CdC V3
  if fileexists(CdCconfig) then
  begin
    inif := TMeminifile.Create(CdCconfig);
    try
      buf := inif.ReadString('main', 'AppDir', '');
      if DirectoryExists(buf) then
        CdCdir := buf;
    finally
      inif.Free;
    end;
    CdC := slash(CdCdir) + DefaultCdC;
    if not FileExists(CdC) then begin
       CdC :=ExpandFileName(slash(CdCdir)+slash('..')+slash('..')+slash('bin') + DefaultCdC);
       if not FileExists(CdC) then
          CartesduCiel1.Visible:=false;
    end;
    CdC:='"'+CdC+'"';
  end;
end;

procedure Tf_avpmain.CartesduCiel1Click(Sender: TObject);
begin
  OpenCdC(pla[CurrentPlanet],'--setproj=EQUAT');
end;

procedure Tf_avpmain.Aide2Click(Sender: TObject);
var
  fn: string;
begin
  fn := slash(HelpDir) + helpprefix + '_Doc_VPA.pdf';
  if not FileExists(fn) then
  begin
    fn := slash(HelpDir) + helpprefix + '_Doc_VPA.html';
    if not FileExists(fn) then
    begin
      fn := slash(HelpDir) + 'EN_Doc_VPA.pdf';
      if not FileExists(fn) then
      begin
        fn := slash(HelpDir) + 'EN_Doc_VPA.html';
      end;
    end;
  end;
  ExecuteFile(fn);
end;


procedure Tf_avpmain.Position1Click(Sender: TObject);
begin
  Pagecontrol1.ActivePage := Position;
  PageControl1Change(Sender);
  combobox1.SetFocus;
end;

procedure Tf_avpmain.OtherInstance(Sender : TObject; ParamCount: Integer; Parameters: array of String);
var i: integer;
begin
  application.Restore;
  application.BringToFront;
  if ParamCount > 0 then begin
     param.Clear;
     for i:=0 to ParamCount-1 do begin
        param.add(Parameters[i]);
     end;
     ReadParam(false);
  end;
end;

procedure Tf_avpmain.InstanceRunning(Sender : TObject);
begin
  UniqueInstance1.RetryOrHalt;
end;

procedure Tf_avpmain.Notes1Click(Sender: TObject);
begin
  Pagecontrol1.ActivePage := Notes;
  PageControl1Change(Sender);
end;

procedure Tf_avpmain.x21Click(Sender: TObject);
begin
  activeplanet.zoom:=2;
end;

procedure Tf_avpmain.x41Click(Sender: TObject);
begin
  activeplanet.zoom:=4;
end;

procedure Tf_avpmain.x81Click(Sender: TObject);
begin
  activeplanet.zoom:=8;
end;

procedure Tf_avpmain.Button12MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if shift = [ssShift] then
    CameraOrientation := CameraOrientation - 1
  else if shift = [ssAlt] then
    CameraOrientation := CameraOrientation - 90
  else
    CameraOrientation := CameraOrientation - 15;
  CameraOrientation := rmod(CameraOrientation + 360, 360);
  activeplanet.Orientation:=CameraOrientation;
  activeplanet.RefreshAll;
end;

procedure Tf_avpmain.Button13MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if shift = [ssShift] then
    CameraOrientation := CameraOrientation + 1
  else if shift = [ssAlt] then
    CameraOrientation := CameraOrientation + 90
  else
    CameraOrientation := CameraOrientation + 15;
  CameraOrientation := rmod(CameraOrientation, 360);
  activeplanet.Orientation:=CameraOrientation;
  activeplanet.RefreshAll;
end;

procedure Tf_avpmain.RadioGroup2Click(Sender: TObject);
begin
if skiporient then exit;
  case RadioGroup2.ItemIndex of
    0: PoleOrientation := 0;
    1: PoleOrientation := 180;
  end;
  ToolButton4.Down := (RadioGroup2.ItemIndex = 1);
  if FollowNorth or ZenithOnTop then
    CameraOrientation := rmod(-PA + PoleOrientation + 360, 360)
  else
    CameraOrientation := Poleorientation;
  activeplanet.Poleorientation:=Poleorientation;
  activeplanet.Orientation:=CameraOrientation;
  activeplanet.RefreshAll;
end;

procedure Tf_avpmain.ToolButton4Click(Sender: TObject);
begin
  RadioGroup2.ItemIndex := abs(RadioGroup2.ItemIndex - 1);
  ToolButton4.Down      := (RadioGroup2.ItemIndex = 1);
end;

procedure Tf_avpmain.CheckBox2Click(Sender: TObject);
begin
  ToolButton6.Down := checkbox2.Checked;
  activeplanet.Mirror:=checkbox2.Checked;
end;

procedure Tf_avpmain.ToolButton6Click(Sender: TObject);
begin
  CheckBox2.Checked := not CheckBox2.Checked;
  ToolButton6.Down  := CheckBox2.Checked;
end;

procedure Tf_avpmain.Button11Click(Sender: TObject);
begin
  activeplanet.SatelliteRotation:=0;
  activeplanet.MeasuringDistance := not activeplanet.MeasuringDistance;
  if activeplanet.MeasuringDistance then
  begin
    Button11.Caption      := rsm_53;
  end
  else
  begin
    Button11.Caption      := rsm_52;
  end;
end;

procedure Tf_avpmain.Distance1Click(Sender: TObject);
begin
  Pagecontrol1.ActivePage := Outils;
  PageControl1Change(Sender);
  Button11.Caption  := rsm_53;
  activeplanet.MeasuringDistance := true;
end;

procedure Tf_avpmain.CheckBox1Click(Sender: TObject);
begin
if skiporient then exit;
  FollowNorth := CheckBox1.Checked;
  if FollowNorth then begin
     CheckBox4.Checked:=false;  // exclusive with zenith
  end;
  if FollowNorth then
    CameraOrientation := rmod(-PA + PoleOrientation + 360, 360)
  else
    CameraOrientation := Poleorientation;
  activeplanet.FollowNorth:=FollowNorth;
  activeplanet.Orientation:=CameraOrientation;
  RefreshplanetImage;
//  activeplanet.RefreshAll;
end;

procedure Tf_avpmain.CheckBox4Click(Sender: TObject);
begin
  if skiporient then exit;
    if geocentric then CheckBox4.Checked:=false;
    ZenithOnTop := CheckBox4.Checked;
    if ZenithOnTop then begin
       CheckBox1.Checked:=false;  // exclusive with pole
       if ObsLatitude>0 then RadioGroup2.ItemIndex:=0  // default rotation for current emisphere
                        else RadioGroup2.ItemIndex:=1;
    end;
    if ZenithOnTop then
      CameraOrientation := rmod(-PA + PoleOrientation + 360, 360)
    else
      CameraOrientation := Poleorientation;
    activeplanet.ZenithOnTop:=ZenithOnTop;
    activeplanet.Orientation:=CameraOrientation;
    RefreshplanetImage;
//    activeplanet.RefreshAll;
end;

procedure Tf_avpmain.ToolButton10Click(Sender: TObject);
begin
  listobject(5);
end;

procedure Tf_avpmain.BMP1Click(Sender: TObject);
var
  b: tbitmap;
begin
  savedialog1.DefaultExt := '.bmp';
  savedialog1.Filter     := 'bmp image|*.bmp';
  savedialog1.FileName   := combobox1.Text;
  if savedialog1.Execute then
  begin
    b := Tbitmap.Create;
    try
      activeplanet.SnapShot(b, saveimagewhite);
      b.SaveToFile(ChangeFileExt(savedialog1.FileName, '.bmp'));
    finally
      b.Free;
    end;
  end;
end;

procedure Tf_avpmain.JPG1Click(Sender: TObject);
var
  b: Tbitmap;
  j: Tjpegimage;
begin
  savedialog1.DefaultExt := '.jpg';
  savedialog1.Filter     := 'jpeg image|*.jpg';
  savedialog1.FileName   := combobox1.Text;
  if savedialog1.Execute then
  begin
    b := Tbitmap.Create;
    j := Tjpegimage.Create;
    try
      activeplanet.SnapShot(b, saveimagewhite);
      j.Assign(b);
      j.CompressionQuality:=100;
      j.SaveToFile(ChangeFileExt(savedialog1.FileName, '.jpg'));
    finally
      b.Free;
      j.Free;
    end;
  end;
end;

procedure Tf_avpmain.Selectiondimprimante1Click(Sender: TObject);
begin
{$ifdef mswindows}
  PrinterSetupDialog1.execute;
  GetPrinterResolution(PrtName, PrinterResolution);
{$endif}
end;

procedure Tf_avpmain.Imprimer1Click(Sender: TObject);
var
  i, w, ww, tl, hl, l, maxt,bh,bw: integer;
  xmin, xmax, ymin, ymax: integer;
  s,bs:    double;
  b:    tbitmap;
  buf1: string;
  {$ifdef darwin}
  bt:    tbitmap;
  {$endif}
begin
  {$ifdef unix}
    PrintDialog1.execute;
  {$endif}
  GetPrinterResolution(PrtName, PrinterResolution);
  s := PrinterResolution / 300;
  Printer.Orientation := poPortrait;
  Printer.Title := currentname;
  Printer.BeginDoc;
  with Printer do
  begin
    xmin := round(LeftMargin * PrinterResolution / 25.4);
    xmax := PageWidth;
    ymin := 0;
    ymax := PageHeight;
    Canvas.Font.Name := memo2.Font.Name;
    Canvas.Font.Color := clBlack;
    Canvas.Font.Size := 8;
    hl   := round(Canvas.TextHeight('H') * 1.1);
    Canvas.Font.Style := [fsBold];
    buf1 := Caption+':  '+vpaurl;
    Canvas.TextOut(Xmin + 10, ymin, buf1);
    Canvas.Font.Style := [];
    if language = 'fr' then
      buf1 := 'Planet database '+cpyr+' Ch. Legrand,  Reproduction interdite / Pour usage personnel uniquement'
    else
      buf1 := 'Planet database '+cpyr+' Ch. Legrand,  Forbidden copy / For personal use only';
    i := (xmax - xmin - Canvas.TextWidth(buf1)) div 2;
    w := Canvas.TextHeight(buf1);
    maxt := ymax - 3 * w;
//    Canvas.TextOut(Xmin + 10 + i, ymax - 2*w, buf1);  }
    w := 0;
    b := Tbitmap.Create;
    try
      if PrintChart then  begin
        // carte
        w := (xmax - xmin) * 2 div 3;
        activeplanet.snapshot(b, True);
        bs:=b.Width/b.Height;
       {$ifdef darwin}
        bt := Tbitmap.Create;   // crash on Mac if bitmap is bigger than 255x255
        bt.Assign(b);
        if bs > 1 then begin
          bt.Width:=255;
          bt.Height:=round(255/bs);
        end else begin
          bt.Height:=255;
          bt.Width:=round(255*bs);
        end;
        bt.Canvas.StretchDraw(Rect(0,0,bt.Width,bt.Height),b);
        canvas.Draw(xmin,ymin+hl,bt);
        bt.Free;
        {$else}
        if bs > 1 then begin
          bw:=w;
          bh:=round(w/bs);
        end else begin
          bh:=w;
          bw:=round(w*bs);
        end;
        canvas.StretchDraw(rect(xmin, ymin + hl, xmin + bw, ymin + bh + hl), b);
        {$endif}
      end;
      if PrintDesc then
      begin
        memo2.Visible:=true;
        ww := w;
        if (ww = 0) and PrintEph then
          ww := (xmax - xmin) * 2 div 3;
        Canvas.Font.Name := memo2.Font.Name;
        Canvas.Font.Color := clBlack;
        Canvas.Font.Size := 8;
        Canvas.Font.Style := [];
        Canvas.Brush.Style := bsClear;
        tl := ymin + ww + round(1.5 * hl);
        l  := Xmin + round(s * 10);
        memo2.Clear;
        dbm.Query('select * from planet where id=' + currentid);
        if dbm.RowCount > 0 then
          GetDetail(dbm.Results[0], memo2);  // we use a TMemo for the wordwrap capability
        for i := 1 to memo2.Lines.Count do
        begin
          if tl >= maxt then
          begin
            Canvas.TextOut(l, tl, 'Truncated ...');
            break;
          end;
          buf1 := memo2.Lines[i - 1];
          if (i = 1) or (copy(buf1, length(buf1), 1) = ':') then
            Canvas.Font.Style := [fsBold]
          else
            Canvas.Font.Style := [];
          Canvas.TextOut(l, tl, buf1);
          tl := tl + hl;
        end;
        memo2.Clear;
      end;
      if PrintEph then
      begin
        tl := ymin + 3 * hl;
        l  := round(s * 30) + xmin + w;
        Canvas.Font.Style := [fsBold];
        Canvas.TextOut(l, tl, Ephemerides.Caption);
        Canvas.Font.Style := [];
        tl := tl + hl;
        for i := 1 to Stringgrid1.RowCount do
        begin
          Canvas.TextOut(l, tl, Stringgrid1.Cells[0, i - 1] + ' ' + Stringgrid1.Cells[1, i - 1]);
          tl := tl + hl;
        end;
      end;
    finally
      b.Free;
      Printer.EndDoc;
      memo2.Visible:=false;
    end;
  end;
end;

procedure Tf_avpmain.Desc1HotClick(Sender: TObject);
begin
  ExecuteFile(desc1.HotURL);
end;

procedure Tf_avpmain.Copy1Click(Sender: TObject);
begin
case PageControl1.PageIndex of
0:  Desc1.CopyToClipboard;
1:  Memo1.CopyToClipboard;
2:  StringGrid1.CopyToClipboard;
end;
end;

procedure Tf_avpmain.SelectAll1Click(Sender: TObject);
begin
case PageControl1.PageIndex of
0:  Desc1.SelectAll;
1:  Memo1.SelectAll;
end;
end;

procedure Tf_avpmain.OverlayCaption1Click(Sender: TObject);
var
  dir: string;
begin
  chdir(appdir);
  dir := slash('Overlay') + slash(epla[CurrentPlanet]) + slash('caption');
  if fileexists(dir + overlayname[CurrentPlanet]) then
    showimg(dir, overlayname[CurrentPlanet], True);
end;

procedure Tf_avpmain.ToolButton3Click(Sender: TObject);
// rotation
var l,b: single;
    recenter:boolean;
begin
recenter:=activeplanet.getcenter(l,b);
  if ToolButton3.Down then
  begin
    checkbox2.Visible := False;   //mirror
    ToolButton6.Enabled := False; //mirror
    PanelRot.Visible := False;   // rotation
//    GroupBox3.Visible := True;    // satellite
//    Rotation1.Visible := True;
    activeplanet.Mirror:=False;
    activeplanet.VisibleSideLock:=false;
//    activeplanet.PoleIncl:=0;
//    activeplanet.CentralMeridian:=0;
    activeplanet.RefreshAll;
  end
  else
  begin
    checkbox2.Visible := True;
    ToolButton6.Enabled := True;
    PanelRot.Visible := True;
    case RadioGroup2.ItemIndex of
      0: CameraOrientation := 0;
      1: CameraOrientation := 180;
    end;
    GroupBox3.Visible := False;
    Rotation1.Visible := False;
    activeplanet.VisibleSideLock:=true;
    activeplanet.SatelliteRotation:=0;
    activeplanet.Orientation:=CameraOrientation;
    activeplanet.Mirror:=checkbox2.Checked;
    RefreshplanetImage;
  end;
if recenter then activeplanet.CenterAt(l,b);
end;

procedure Tf_avpmain.CheckBox8Click(Sender: TObject);
begin
  compresstexture := CheckBox8.Checked;
end;

procedure Tf_avpmain.NewWindowButtonClick(Sender: TObject);
var cdo:single;
begin
if planet2=nil then begin
 planet2:=Tf_planet.Create(Panelplanet2);
 planet2.GLSceneViewer1.Visible:=false;
 planet2.Caption:=Caption;
 planet2.planet.Align:=alClient;
 planet2.onplanetClick:=planetClickEvent;
 planet2.onGetLabel:=GetLabel;
 planet2.onGetSprite:=GetSprite;
 planet2.onplanetMove:=planetMoveEvent;
 planet2.onplanetMeasure:=planetMeasureEvent;
 planet2.onGetMsg:=GetMsg;
 planet2.PopUp:=PopupMenu1;
 planet2.Visible:=false;
 planet2.Init(false);
 planet2.Initialized:=true;
end;
if NewWindowButton.Down then begin
  SelectPlanet1.Enabled:=false;
  SplitSize:=0.5;
  Panelplanet2.Width:=Panelplanet.Width div 2;
  Splitter2.Visible:=true;
  Panelplanet2.Visible:=true;
  planet2.Enabled:=true;
  planet2.GLSceneViewer1.Visible:=true;
//  wantbump:=false;
  cdo:=planet2.GLSceneViewer1.Camera.DepthOfView;
  planet2.GLSceneViewer1.Camera.DepthOfView:=0;
  planet2.Assignplanet(planet1);
  planet2.GLSceneViewer1.Camera.DepthOfView:=cdo;
end else begin
  SelectPlanet1.Enabled:=true;
//  wantbump:=planet1.Bumpmap;
  planet2.Enabled:=false;
  Panelplanet2.Width:=0;
  Splitter2.Visible:=false;
  Panelplanet2.Visible:=false;
end;
end;

procedure Tf_avpmain.PhaseButtonClick(Sender: TObject);
begin
  phaseeffect := PhaseButton.Down;
  if phaseeffect and wantbump[CurrentPlanet] and activeplanet.CanBump then
     activeplanet.Bumpmap:=true
  else
     activeplanet.Bumpmap:=false;
  RefreshplanetImage;
end;

procedure Tf_avpmain.OpenCDC(objname,otherparam:string);
var param:string;
begin
    param:='--unique --nosplash ';
    if objname<>'' then param:=param+' --search='+trim(objname);
    param:=param+' '+otherparam;
    chdir(appdir);
    Execnowait(CdC+' '+param);
    StartCDC:=true;
end;

procedure Tf_avpmain.PopupMenu1Popup(Sender: TObject);
begin
  if TObject(TPopupMenu(sender).parent) is Tf_planet then SetActiveplanet(Tf_planet(TPopupMenu(sender).parent));
  RemoveMark1.Visible := (CurrentSelection <> '');
end;

procedure Tf_avpmain.RemoveMark1Click(Sender: TObject);
begin
  CurrentSelection := '';
  activeplanet.RefreshAll;
end;

procedure Tf_avpmain.planetMeasureEvent(Sender: TObject; m1,m2,m3,m4: string);
begin
  edit1.Text := m1 + rsm_18;
  edit2.Text := m2;
  edit3.Text := m3;
  edit4.Text := m4;
end;

procedure Tf_avpmain.SetActiveplanet(mf: Tf_planet);
begin
ToolButton14.Enabled:=mf.SatelliteRotation=0;
if mf<>activeplanet then begin
  activeplanet:=Tf_planet(mf);
  checkbox2.Checked:=activeplanet.Mirror;
  ToolButton3.Down:=not activeplanet.VisibleSideLock;
  if ToolButton3.Down then
  begin
    checkbox2.Visible := False;   //mirror
    ToolButton6.Enabled := False; //mirror
    PanelRot.Visible := False;   // rotation
    //GroupBox3.Visible := True;    // satellite
    Rotation1.Visible := True;
  end
  else
  begin
    checkbox2.Visible := True;
    ToolButton6.Enabled := True;
    PanelRot.Visible := True;
    GroupBox3.Visible := False;
    Rotation1.Visible := False;
  end;
  if activeplanet.MeasuringDistance then
  begin
    Button11.Caption:= rsm_53;
  end
  else
  begin
    Button11.Caption:= rsm_52;
  end;
  Poleorientation   := activeplanet.Poleorientation;
  CameraOrientation := activeplanet.Orientation;
  skiporient:=true;
  if PoleOrientation = 0 then
    RadioGroup2.ItemIndex := 0
  else
    RadioGroup2.ItemIndex := 1;
  ToolButton4.Down := (RadioGroup2.ItemIndex = 1);
  FollowNorth:=activeplanet.FollowNorth;
  ZenithOnTop:=activeplanet.ZenithOnTop;
  checkbox1.Checked := FollowNorth;
  checkbox4.Checked := ZenithOnTop;
  skiporient:=false;
  phaseeffect:=activeplanet.ShowPhase;
  PhaseButton.Down:=phaseeffect;
  GridButton.Down := activeplanet.ShowGrid;
  ToolButton14.Down:= activeplanet.ShowScale;
  if activeplanet.CurrentName<>'' then begin
     CurrentName:=activeplanet.CurrentName;
     Currentl:=rad2deg*activeplanet.CurrentL;
     Currentb:=rad2deg*activeplanet.CurrentB;
  end;
  skiprot:=true;
  if activeplanet.SatelliteRotation<>0 then rotstep := abs(activeplanet.SatelliteRotation);
  if rotstep=10 then combobox4.ItemIndex :=0
    else if rotstep=5 then combobox4.ItemIndex :=1
    else if rotstep=1 then combobox4.ItemIndex :=2
    else if rotstep=0.5 then combobox4.ItemIndex :=3
    else if rotstep=0.2 then combobox4.ItemIndex :=4
    else combobox4.ItemIndex :=2;
  TrackBar6.Position := round(activeplanet.SatelliteAltitude);
  TrackBar7.Position := round(activeplanet.SatInclination);
  skiprot:=false;
  showoverlay[CurrentPlanet]:=not (activeplanet.Overlay='');
  overlayname[CurrentPlanet]:=activeplanet.Overlay;
  overlaytr[CurrentPlanet]:=activeplanet.OverlayTransparency;
  if showoverlay[CurrentPlanet] and (overlayname[CurrentPlanet]<>'') and fileexists(Slash(activeplanet.OverlayPath)+Slash(epla[CurrentPlanet]) + slash('caption') + overlayname[CurrentPlanet]) then begin
     OverlayCaption1.Caption := remext(overlayname[CurrentPlanet]) + ' ' + rsCaption;
     OverlayCaption2.Caption := OverlayCaption1.Caption;
     OverlayCaption1.Visible := True;
     OverlayCaption2.Visible := True;
  end else begin
     OverlayCaption1.Visible := False;
     OverlayCaption2.Visible := False;
  end;
  CurrentJD:=activeplanet.JD;
  SetJDDate;
  RefreshplanetImage;
  if pagecontrol1.ActivePage = CentralMeridian then
  begin
    if currentmeridian<>activeplanet.CentralMeridian then
      UpdCentralMeridian;
  end;
end;
end;

procedure Tf_avpmain.planetClickEvent(Sender: TObject; Button: TMouseButton;
                     Shift: TShiftState; X, Y: Integer;
                     Onplanet: boolean; Lon, Lat: Single);
var wmin: double;
begin
if sender is Tf_planet then SetActiveplanet(Tf_planet(sender));
if button=mbLeft then begin
  if Onplanet then begin
    if (Tf_planet(Sender).Zoom >= 8) then
      wmin := -1
    else
      wmin := MinValue([10.0, 10/(Tf_planet(Sender).Zoom)]);
    identLB(Rad2Deg*Lon,Rad2Deg*Lat,wmin);
    Tf_planet(Sender).SetMark(deg2rad*currentl,deg2rad*currentb,capitalize(currentname));
  end else begin
     Tf_planet(Sender).SetMark(0,0,'');
  end;
end;
end;

procedure Tf_avpmain.planetMoveEvent(Sender: TObject; X, Y: Integer;
                     Onplanet: boolean; Lon, Lat: Single);
begin
if Onplanet then begin
  statusbar1.Panels[0].Text := rsm_10 + FormatLongitude(Rad2Deg*Lon);
  statusbar1.Panels[1].Text := rsm_11 + DEmToStr(Rad2Deg*Lat);
end else begin
  statusbar1.Panels[0].Text := rsm_10;
  statusbar1.Panels[1].Text := rsm_11;
end;
end;

function SetWhiteColor(x: integer): TColor;
begin
  Result := x + (x shl 8) + (x shl 16);
end;

procedure Tf_avpmain.TrackBar2Change(Sender: TObject);
begin
  planet1.AmbientColor := SetWhitecolor(Trackbar2.position);
  if planet2<>nil then planet2.AmbientColor := SetWhitecolor(Trackbar2.position);
end;

procedure Tf_avpmain.TrackBar3Change(Sender: TObject);
begin
  planet1.DiffuseColor := SetWhitecolor(Trackbar3.position);
  if planet2<>nil then planet2.DiffuseColor := SetWhitecolor(Trackbar3.position);
end;

procedure Tf_avpmain.TrackBar4Change(Sender: TObject);
begin
  planet1.SpecularColor := SetWhitecolor(Trackbar4.position);
  if planet2<>nil then planet2.SpecularColor := SetWhitecolor(Trackbar4.position);
end;

procedure Tf_avpmain.Button21Click(Sender: TObject);
begin
  TrackBar2.Position:=39;
  TrackBar2Change(Sender);
  TrackBar3.Position:=255;
  TrackBar3Change(Sender);
  TrackBar4.Position:=99;
  TrackBar4Change(Sender);
end;

procedure Tf_avpmain.LoadOverlay(fn: string; transparent: single);
begin
  if showoverlay[CurrentPlanet] and (fn<>'') and fileexists(Slash(activeplanet.OverlayPath)+Slash(epla[CurrentPlanet]) + fn) then
  begin
      activeplanet.OverlayTransparency:=transparent;
      activeplanet.OverlayTransparencyMethode:=0;
      activeplanet.Overlay:=fn;
      if fileexists(Slash(activeplanet.OverlayPath)+Slash(epla[CurrentPlanet]) + slash('caption') + fn) then
      begin
        OverlayCaption1.Caption := remext(fn) + ' ' + rsCaption;
        OverlayCaption2.Caption := OverlayCaption1.Caption;
        OverlayCaption1.Visible := True;
        OverlayCaption2.Visible := True;
      end
      else
      begin
        OverlayCaption1.Visible := False;
        OverlayCaption2.Visible := False;
      end;
  end
  else
  begin
    showoverlay[CurrentPlanet] := False;
    OverlayCaption1.Visible := False;
    OverlayCaption2.Visible := False;
    activeplanet.Overlay:='';
  end;
end;

end.

