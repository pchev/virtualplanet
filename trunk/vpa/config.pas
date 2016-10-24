unit config;

{$MODE Delphi}
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
  LCLIntf,
{$endif}
  u_translation,
  Math, u_constant, cu_tz,
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, ExtCtrls, Inifiles, Grids, EnhEdits,
  CheckLst, LResources;

type

  { Tf_config }

  Tf_config = class(TForm)
    Button1: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button9: TButton;
    CheckBox10: TCheckBox;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label20: TLabel;
    Label21: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label8: TLabel;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    TabSheet2: TTabSheet;
    TabSheet5: TTabSheet;
    TextureBW: TCheckBox;
    ColorDialog1: TColorDialog;
    ComboBox6: TComboBox;
    ComboBoxCountry: TComboBox;
    ComboBoxTZ: TComboBox;
    GBlvall: TGroupBox;
    GBlv1: TGroupBox;
    GBlv2: TGroupBox;
    GBlv3: TGroupBox;
    GBlv4: TGroupBox;
    GBlv5: TGroupBox;
    GBlv6: TGroupBox;
    Label29: TLabel;
    Label3: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label40: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    LabelImp: TLabel;
    LabelGrid: TLabel;
    FontDialog1: TFontDialog;
    GroupBox2: TGroupBox;
    Label19: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    LabelFont: TLabel;
    Memo1: TMemo;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    RadioGroupLong: TRadioGroup;
    TexturePanel: TPanel;
    BumpRadioGroup: TRadioGroup;
    TabSheet1: TTabSheet;
    Label4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox3: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    TrackBar3: TTrackBar;
    Impression: TTabSheet;
    Label12: TLabel;
    LongEdit1: TLongEdit;
    Label13: TLabel;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    TrackBar1: TTrackBar;
    Label14: TLabel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Button2: TButton;
    Label15: TLabel;
    OpenDialog1: TOpenDialog;
    CheckBox13: TCheckBox;
    Label11: TLabel;
    CheckBox7: TCheckBox;
    Bevel4: TBevel;
    Label10: TLabel;
    ComboBox4: TComboBox;
    TabSheet3: TTabSheet;
    Bevel1: TBevel;
    CheckBox1: TCheckBox;
    Label5: TLabel;
    Shape1: TShape;
    Label6: TLabel;
    Shape2: TShape;
    Label7: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    CheckBox6: TCheckBox;
    CheckBox5: TCheckBox;
    Bevel7: TBevel;
    Label16: TLabel;
    Shape3: TShape;
    Label17: TLabel;
    TrackBarLabel: TTrackBar;
    Label18: TLabel;
    TabSheet4: TTabSheet;
    CheckBox17: TCheckBox;
    TabSheet6: TTabSheet;
    Bevel8: TBevel;
    Label23: TLabel;
    CheckBox16: TCheckBox;
    Bevel9: TBevel;
    OverlayPanel: TPanel;
    CheckBox11: TCheckBox;
    ComboBox5: TComboBox;
    Image1: TImage;
    Label30: TLabel;
    Label32: TLabel;
    TrackBar5: TTrackBar;
    procedure BumpRadioGroupClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure ComboBoxCountryChange(Sender: TObject);
    procedure ComboBoxTZChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure RadioButtonAllClick(Sender: TObject);
    procedure RadioButtonLvClick(Sender: TObject);
    procedure Shape1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ComboBox5Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StringGrid2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid2SelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure TextureBWClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
  private
    countrycode: TStringList;
    ov: TBitmap;
    lockoverlay,locktexture: boolean;
    FPrinterDialog : TNotifyEvent;
    procedure UpdateTzList;
    procedure showtexture;
    procedure FillHistorical;
  public
    newlang: string;
    tzinfo: TCdCTimeZone;
    obscountry,obstz : string;
    TexturePath,HistTex: string;
    HistN: array[0..maxlevel] of integer;
    texturefn: TStringList;
    TextureList: TStringList;
    TextureChanged: boolean;
    procedure SetObsCountry(value:string);
    procedure LoadCountry(fn:string);
    procedure Setlang;
  property onPrinterDialog : TNotifyEvent read FPrinterDialog write FPrinterDialog;
  end;

var
  f_config: Tf_config;

implementation

{$R config.lfm}

uses u_util;

procedure Tf_config.Setlang;
begin
      Caption := rst_3;
      label1.Caption := rst_19;
      label2.Caption := rsm_10;
      CheckBox1.Caption := rst_22;
      label4.Caption := rst_24;
      Button1.Caption := rst_18;
      Label5.Caption := rst_28;
      Label17.Caption := rst_29;
      Label7.Caption := rst_52;
      CheckBox5.Caption := rst_53;
      CheckBox6.Caption := rst_54;
      TabSheet1.Caption := rst_57;
      Label11.Caption := rst_75;
      Label10.Caption := rst_76;
      Combobox4.Items[0] := rst_77;
      Combobox4.Text := Combobox4.Items[0];
      CheckBox7.Caption := rst_80;
      Impression.Caption := rst_90;
      Label15.Caption := rst_91;
      Button2.Caption := rst_55;
      Label12.Caption := rst_92;
      Label13.Caption := rst_93;
      Checkbox8.Caption := rst_94;
      Checkbox9.Caption := rst_95;
      Checkbox13.Caption := rst_96;
      Label14.Caption := rst_97;
      Button4.Caption := rst_99;
      Label16.Caption := rst_100;
      Tabsheet3.Caption := rst_101;
      Label6.Caption := rst_103;
      Label18.Caption := rst_104;
      Checkbox17.Caption := rst_120;
      combobox1.items[0] := rst_147;
      combobox1.items[1] := rst_148;
      combobox1.ItemIndex := 0;
      combobox2.items[0] := rst_149;
      combobox2.items[1] := rst_150;
      combobox2.ItemIndex := 0;
      TabSheet4.Caption := rst_152;
      Label19.Caption := rst_144;
      TabSheet6.Caption := rst_169;
      CheckBox11.Caption := rst_170;
      label30.Caption := rst_171;
      label32.Caption := rst_172;
      Label23.Caption := rst_173;
      CheckBox16.Caption := rst_174;
      GroupBox2.Caption:=rsGrid;
      CheckBox10.Caption:=rsShowGrid;
      label3.Caption:= rsZoomLevel;
      Button5.Caption:=rsLabelsFont;
      Label35.Caption:=rsCountry;
      Label34.Caption:=rst_21;
      BumpRadioGroup.Items[0]:=rsPhaseWithout+blank+rsStandardText;
      //BumpRadioGroup.Items[1]:=rsPhaseWithDyn;
      BumpRadioGroup.Items[1]:=rsNoTextureToU;
      RadioGroupLong.Caption:=rsLongitudeSys;
      RadioGroupLong.Items[0]:=rsEast0360;
      RadioGroupLong.Items[1]:=rsEast180180;
      RadioGroupLong.Items[2]:=rsWest0360;
      RadioGroupLong.Items[3]:=rsWest180180;
      TextureBW.Caption:=rsConvertColor;
      TabSheet5.Caption := rst_109;
      Label24.Caption:=rsTelescopeFoc;
      Label25.Caption:=rsEyepieceFoca;
      Label26.Caption:=rsEyepieceAppa;
      Label28.Caption:=rsPower;
      Button6.Caption:=rst_113;
      TabSheet5.Caption := rsCCDField;
      Label49.Caption:=rsTelescopeFoc;
      Label50.Caption:=rsPixelSize;
      Label53.Caption:=rsPixelCount;
      Button9.Caption:=rst_113;

end;

Function GetLangCode(buf:string):string;
var p : integer;
begin
p:=pos(' ',buf);
result:=trim(copy(buf,1,p-1));
end;

function GBRadioChecked(GB: TGroupBox): integer;
var i: integer;
begin
result:=-1;
for i:=0 to GB.ControlCount-1 do begin
  if TRadioButton(GB.Controls[i]).Checked then begin
    result:=i;
    break;
  end;
end;
end;

procedure Tf_config.FormCreate(Sender: TObject);
var i,j,p : integer;
    buf,code,VPAlang : string;
    fs : TSearchRec;
    ft : TextFile;
    bt : TCheckBox;
    cb : TCheckBox;
procedure addbuttons(n:integer;txt:string);
var toppos:integer;
begin
  cb:=TCheckBox.Create(self);
  cb.Parent:=GBlvall;
  toppos:= 2+n*(cb.Height+4);
  cb.Top:=toppos;
  cb.Caption:=txt;
  cb.Tag:=n;
  cb.OnClick:=RadioButtonAllClick;
  bt:=TCheckBox.Create(self);
  bt.Parent:=GBlv1;
  bt.Top:=toppos;
  bt.Caption:='';
  bt.Checked:=false;
  bt.Tag:=n;
  bt.OnClick:=RadioButtonLvClick;
  bt:=TCheckBox.Create(self);
  bt.Parent:=GBlv2;
  bt.Top:=toppos;
  bt.Caption:='';
  bt.Checked:=false;
  bt.Tag:=1000+n;
  bt.OnClick:=RadioButtonLvClick;
  bt:=TCheckBox.Create(self);
  bt.Parent:=GBlv3;
  bt.Top:=toppos;
  bt.Caption:='';
  bt.Checked:=false;
  bt.Tag:=2000+n;
  bt.OnClick:=RadioButtonLvClick;
  bt:=TCheckBox.Create(self);
  bt.Parent:=GBlv4;
  bt.Top:=toppos;
  bt.Caption:='';
  bt.Checked:=false;
  bt.Tag:=3000+n;
  bt.OnClick:=RadioButtonLvClick;
  bt:=TCheckBox.Create(self);
  bt.Parent:=GBlv5;
  bt.Top:=toppos;
  bt.Caption:='';
  bt.Checked:=false;
  bt.Tag:=4000+n;
  bt.OnClick:=RadioButtonLvClick;
  bt:=TCheckBox.Create(self);
  bt.Parent:=GBlv6;
  bt.Top:=toppos;
  bt.Caption:='';
  bt.Checked:=false;
  bt.Tag:=5000+n;
  bt.OnClick:=RadioButtonLvClick;
end;
begin
BumpRadioGroup.Items.Delete(2);
{$ifdef mswindows}
 ScaleForm(self,Screen.PixelsPerInch/96);
{$endif}
ov:=Tbitmap.Create;
lockoverlay:=false;
locktexture:=false;
PageControl1.ActivePageIndex:=0;
i:=findfirst(slash(appdir)+slash('language')+'vpa.*.po',0,fs);
while i=0 do begin
  AssignFile(ft,slash(appdir)+slash('language')+fs.name);
  reset(ft);
  VPAlang:='';
  while not eof(ft) do begin
    readln(ft,buf);
    if buf='msgid "English"' then begin
       readln(ft,buf);
       p:=pos('"',buf);
       Delete(buf,1,p);
       p:=pos('"',buf);
       VPAlang:=copy(buf,1,p-1);
       break;
    end;
  end;
  CloseFile(ft);
  code:=extractfilename(fs.name);
  p:=pos('.',code);
  Delete(code,1,p);
  if p=0 then p:=9999;
  p:=pos('.',code);
  code:=copy(code,1,p-1);
  if code='en' then VPAlang:='English';
  buf:=code+' '+VPAlang;
  combobox3.Items.Add(buf);
  i:=findnext(fs);
end;
findclose(fs);
for j:=0 to combobox3.Items.Count-1 do if GetLangCode(combobox3.Items[j])=language then combobox3.ItemIndex:=j;
i:=findfirst(Slash(appdir)+Slash('Overlay')+Slash(epla[CurrentPlanet])+'*.jpg',0,fs);
combobox5.clear;
combobox5.Sorted:=true;
while i=0 do begin
  combobox5.Items.Add(remext(fs.name));
  i:=findnext(fs);
end;
findclose(fs);
Texturefn:=TStringList.Create;
TextureList:=TStringList.Create;
i:=findfirst(Slash(appdir)+Slash('Textures')+Slash(epla[CurrentPlanet])+'*',faDirectory,fs);
while i=0 do begin
  if ((fs.Attr and faDirectory)= faDirectory)and(fs.Name<>'.')and(fs.Name<>'..')and(fs.Name<>'Bumpmap')and(fs.Name<>'Overlay') then begin
    TextureList.Add(fs.name);
  end;
  i:=findnext(fs);
end;
findclose(fs);
TextureList.Sort;
for i:=0 to TextureList.Count-1 do begin
    if TextureList[i]=HistoricalDir then begin
      buf:=rsHistorical;
      FillHistorical;
    end
    else buf:=TextureList[i];
    addbuttons(i,buf);
end;
countrycode:=TStringList.Create;
end;

procedure Tf_config.FillHistorical;
var i : integer;
    fs : TSearchRec;
begin
ComboBox6.clear;
i:=findfirst(Slash(appdir)+Slash('Textures')+Slash(epla[CurrentPlanet])+Slash('Historical')+'*',faDirectory,fs);
while i=0 do begin
  if ((fs.Attr and faDirectory)= faDirectory)and(fs.Name<>'.')and(fs.Name<>'..') then begin
    ComboBox6.Items.Add(fs.name);
  end;
  i:=findnext(fs);
end;
findclose(fs);
ComboBox6.ItemIndex:=0;
end;

procedure Tf_config.Button5Click(Sender: TObject);
begin
if FontDialog1.Execute then begin
   LabelFont.Caption:=FontDialog1.Font.Name;
   LabelFont.Font:=FontDialog1.Font;
   LabelFont.Font.Color:=clWindowText;
end;
end;

procedure Tf_config.Button6Click(Sender: TObject);
begin
edit10.Text:=inttostr(round((strtofloat(edit6.text)/strtofloat(edit7.text)) ));
edit9.Text:=inttostr(round(60* strtofloat(edit8.text)/(strtofloat(edit6.text)/strtofloat(edit7.text)) ));
end;

procedure Tf_config.Button9Click(Sender: TObject);
var f,px,py,cx,cy: single;
begin
f:=strtofloat(edit11.text);
px:=strtofloat(edit12.text)/1000;
py:=strtofloat(edit13.text)/1000;
cx:=strtofloat(edit15.text);
cy:=strtofloat(edit16.text);
Edit14.Text:=FormatFloat(f2,arctan(px/f)*cx*rad2deg*60);
Edit17.Text:=FormatFloat(f2,arctan(py/f)*cy*rad2deg*60);
end;

procedure Tf_config.BumpRadioGroupClick(Sender: TObject);
begin
TexturePanel.Visible:=(BumpRadioGroup.ItemIndex=0);
TextureChanged:=true;
if BumpRadioGroup.ItemIndex=1 then CheckBox11.Checked:=true;
end;

procedure Tf_config.FormDestroy(Sender: TObject);
begin
countrycode.Free;
TextureList.Free;
Texturefn.Free;
ov.Free;
end;

procedure Tf_config.StringGrid2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var col,row,i:integer;
begin
StringGrid2.MouseToCell(X, Y, Col, Row);
if row=0 then exit;
if col>=2 then begin
    i:=strtointdef(stringgrid2.Cells[col,row],-1);
    inc(i);
    if i>2 then i:=0;
    stringgrid2.Cells[col,row]:=inttostr(i);
end;
end;

procedure Tf_config.StringGrid2SelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin
if Acol>=2 then canselect:=false else canselect:=true;
end;

procedure Tf_config.TextureBWClick(Sender: TObject);
begin
  TextureChanged:=true;
end;

procedure Tf_config.TrackBar1Change(Sender: TObject);
begin
  LabelImp.Caption:=inttostr(trackbar1.Position);
end;

procedure Tf_config.ComboBox3Change(Sender: TObject);
begin
newlang:=GetLangCode(combobox3.text);
end;

procedure Tf_config.Shape1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if ColorDialog1.Execute then with sender as TShape do begin
      Brush.Color:=ColorDialog1.Color;
   end;
end;

procedure Tf_config.Button2Click(Sender: TObject);
begin
if Assigned(FPrinterDialog) then FPrinterDialog(self);
end;

procedure Tf_config.showtexture;
var i,j: smallint;
    tex: string;
    ok:boolean;
begin
locktexture:=true;
    for j:=0 to 5 do begin
      for i:=0 to TextureList.Count-1 do begin
         tex:=texturefn[j];
         if pos(HistoricalDir,tex)>0 then tex:=noslash(ExtractFilePath(noslash(tex)));
         ok:=(TextureList[i]=tex) and DirectoryExists(slash(TexturePath)+slash(epla[CurrentPlanet])+slash(texturefn[j])+'L'+inttostr(j+1));
           case j of
             0: TCheckBox(GBlv1.Controls[i]).Checked:=ok;
             1: TCheckBox(GBlv2.Controls[i]).Checked:=ok;
             2: TCheckBox(GBlv3.Controls[i]).Checked:=ok;
             3: TCheckBox(GBlv4.Controls[i]).Checked:=ok;
             4: TCheckBox(GBlv5.Controls[i]).Checked:=ok;
             5: TCheckBox(GBlv6.Controls[i]).Checked:=ok;
           end;
      end;
    end;
locktexture:=false;
end;

procedure Tf_config.FormShow(Sender: TObject);
var
    i,k:integer;
begin
  memo1.Text:=rst_184;
  OverlayPanel.visible:=AsMultiTexture;
  panel2.Visible:=not AsMultiTexture;
  TexturePanel.Visible:=(BumpRadioGroup.ItemIndex=0);
  TrackBarLabel.Min:=-1000;
  TrackBarLabel.Max:=-100;
  TextureChanged:=false;
  showtexture;
  LabelGrid.Caption:=inttostr(TrackBar3.Position)+ldeg;
  LabelImp.Caption:=inttostr(trackbar1.Position);
  for i:=1 to maxlevel do HistN[i]:=-1;
  for i:=0 to texturefn.count-1 do
    if pos(HistoricalDir,texturefn[i])>0 then begin
      HistTex:=ExtractFileName(noslash(texturefn[i]));
      HistN[i]:=i;
    end;
  k:=-1;
  for i:=0 to GBlvall.ControlCount-1 do
     if TRadioButton(GBlvall.Controls[i]).Caption=rsHistorical then begin
       k:=TRadioButton(GBlvall.Controls[i]).Top;
       break;
     end;
  if k>0 then begin
     ComboBox6.Visible:=true;
     ComboBox6.Top:=k;
     for i:=0 to ComboBox6.Items.Count-1 do
       if ComboBox6.Items[i]=HistTex then begin
         ComboBox6.ItemIndex:=i;
         break;
     end;
  end
  else ComboBox6.Visible:=false;
  BringToFront;
end;

procedure Tf_config.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
if (ACol=0)and(Arow<=2) then CanSelect:=False;
end;

procedure Tf_config.ComboBox6Change(Sender: TObject);
var i: Integer;
begin
  HistTex:=ComboBox6.Text;
  for i:=0 to texturefn.count-1 do
    if pos(HistoricalDir,texturefn[i])>0 then begin
      texturefn[i]:=slash(ExtractFilePath(noslash(texturefn[i])))+HistTex;
    end;
  TextureChanged:=true;
end;

procedure Tf_config.RadioButtonAllClick(Sender: TObject);
var i: integer;
begin
i:=TCheckBox(sender).tag;
TCheckBox(sender).Checked:=false;
if TCheckBox(GBlv1.Controls[i]).Enabled then TCheckBox(GBlv1.Controls[i]).Checked:=true;
if TCheckBox(GBlv2.Controls[i]).Enabled then TCheckBox(GBlv2.Controls[i]).Checked:=true;
if TCheckBox(GBlv3.Controls[i]).Enabled then TCheckBox(GBlv3.Controls[i]).Checked:=true;
if TCheckBox(GBlv4.Controls[i]).Enabled then TCheckBox(GBlv4.Controls[i]).Checked:=true;
if TCheckBox(GBlv5.Controls[i]).Enabled then TCheckBox(GBlv5.Controls[i]).Checked:=true;
if TCheckBox(GBlv6.Controls[i]).Enabled then TCheckBox(GBlv6.Controls[i]).Checked:=true;
Application.ProcessMessages;
showtexture;
end;

procedure Tf_config.RadioButtonLvClick(Sender: TObject);
var i,j: integer;
    tex: string;
begin
if locktexture then exit;
i:=TCheckBox(sender).Tag mod 1000;
j:=trunc(TCheckBox(sender).Tag/1000);
if (i>=0)and(j>=0) then begin
  tex:=TextureList[i];
  if tex=HistoricalDir then tex:=slash(tex)+ComboBox6.text;
  if DirectoryExists(slash(TexturePath)+slash(epla[CurrentPlanet])+slash(tex)+'L'+inttostr(j+1)) then begin
    HistTex:=ComboBox6.Text;
    texturefn[j]:=tex;
    TextureChanged:=true;
    showtexture;
  end
    else begin
      TCheckBox(sender).Checked:=false;
      TCheckBox(sender).Enabled:=false;
      showtexture;
    end;
  end;
end;

procedure Tf_config.StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
with Sender as TStringGrid do begin
if (Acol>=2)and(Arow>0) then begin
  if (cells[acol,arow]='0')then begin
    Canvas.Brush.Color := clWhite;
    Canvas.FillRect(Rect);
  end else if (cells[acol,arow]='1')then begin
    Canvas.Brush.Color := clRed;
    Canvas.FillRect(Rect);
  end else if (cells[acol,arow]='2')then begin
    Canvas.Brush.Color := clLime;
    Canvas.FillRect(Rect);
  end;
  end;
end;
end;


procedure Tf_config.TrackBar3Change(Sender: TObject);
begin
  if TrackBar3.Position>24 then TrackBar3.Position:=30
  else if TrackBar3.Position>=19 then TrackBar3.Position:=20
  else if TrackBar3.Position>=14 then TrackBar3.Position:=15
  else if TrackBar3.Position>=9 then TrackBar3.Position:=10
  else if TrackBar3.Position>=4 then TrackBar3.Position:=5
  else TrackBar3.Position:=1;
LabelGrid.Caption:=inttostr(TrackBar3.Position)+ldeg;
if TrackBar3.Position=30 then TrackBar3.PageSize:=6
   else TrackBar3.PageSize:=5;
TrackBar3.LineSize:=TrackBar3.PageSize;
end;

{procedure Tf_config.ComboBox5Change(Sender: TObject);
begin
if fileexists(Slash(appdir)+Slash('Textures')+Slash('Overlay')+combobox5.text+'.jpg') then begin
   image1.Picture.LoadFromFile(Slash(appdir)+Slash('Textures')+Slash('Overlay')+combobox5.text+'.jpg');
   CheckBox11.Checked:=true;
end else begin
   image1.Picture.Assign(nil);
end;
end; }
procedure Tf_config.ComboBox5Change(Sender: TObject);
var  j:tjpegimage;
begin
if fileexists(Slash(appdir)+Slash('Overlay')+Slash(epla[CurrentPlanet])+combobox5.text+'.jpg') then begin
   j:=tjpegimage.create;
   try
   j.LoadFromFile(Slash(appdir)+Slash('Overlay')+Slash(epla[CurrentPlanet])+combobox5.text+'.jpg');
   ov.Width:=image1.Width;
   ov.Height:=image1.Height;
   ov.pixelformat:=pf24bit;
   ov.Canvas.StretchDraw(rect(0,0,ov.Width,ov.Height),j);
   TrackBar5Change(Sender);
   CheckBox11.Checked:=true;
   finally
    j.free;
   end;
end else begin
   ov.Assign(nil);
   image1.Picture.Assign(nil);
end;
end;

procedure Tf_config.TrackBar5Change(Sender: TObject);
var l : integer;
begin
if not ov.Empty then begin
   if lockoverlay then exit;
   lockoverlay:=true;
   try
    image1.Picture.bitmap.Assign(ov);
    l:=2*trackbar5.position;
    SetImgLum(image1.Picture.bitmap,l);
    image1.Refresh;
   finally
    lockoverlay:=false;
   end;
end;
end;

procedure Tf_config.LoadCountry(fn:string);
var f: textfile;
    buf: string;
    rec: TStringList;
procedure SplitRec(buf,sep:string; var arg: TStringList);
var i,l:integer;
begin
arg.clear;
l:=length(sep);
while pos(sep,buf)<>0 do begin
 for i:=1 to length(buf) do begin
  if copy(buf,i,l) = sep then begin
      arg.add(copy(buf,1,i-1));
      delete(buf,1,i-1+l);
      break;
  end;
 end;
end;
arg.add(buf);
end;
begin
if fileexists(fn) then begin
  rec:=TStringList.create;
  ComboBoxCountry.Clear;
  countrycode.Clear;
  Filemode:=0;
  system.assign(f,fn);
  reset(f);
  repeat
    readln(f,buf);
    buf:=trim(buf);
    if buf='' then continue;
    if buf[1]='#' then continue;
    SplitRec(buf,tab,rec);
    if rec.Count<3 then continue;
    countrycode.Add(rec[1]);
    ComboBoxCountry.Items.Add(rec[2]);
  until eof(f);
  CloseFile(f);
  rec.Free;
end;
end;

procedure Tf_config.SetObsCountry(value:string);
var i: integer;
begin
obscountry:=value;
for i:=0 to countrycode.Count-1 do begin
   if obscountry=countrycode[i] then begin
      ComboBoxCountry.ItemIndex:=i;
      break;
   end;
end;
UpdateTzList;
end;

procedure Tf_config.UpdateTzList;
var
  i,j: Integer;
  buf: string;
begin
ComboBoxTZ.clear;
j:=0;
for i:=0 to tzinfo.ZoneTabCnty.Count-1 do begin
  if tzinfo.ZoneTabCnty[i]=obscountry then begin
     buf:=tzinfo.ZoneTabZone[i];
     ComboBoxTZ.Items.Add(buf);
     if (j=0)or(tzinfo.ZoneTabZone[i]=obstz) then ComboBoxTZ.ItemIndex:=j;
     inc(j);
  end;
end;
ObsTZ:=ComboBoxTZ.Text;
end;

procedure Tf_config.ComboBoxCountryChange(Sender: TObject);
begin
obscountry:=countrycode[ComboBoxCountry.ItemIndex];
UpdateTzList;
end;

procedure Tf_config.ComboBoxTZChange(Sender: TObject);
begin
 obstz:=ComboBoxTZ.Text;
end;

end.

