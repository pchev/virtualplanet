unit dbutil;
{
Copyright (C) 2006 Patrick Chevalley

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
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
}
{$MODE objfpc}
{$H+}

interface

Uses Forms, Dialogs, SysUtils, mlb2, passql, passqlite;

const
    DBversion=101;
    MaxDBN=200;
    NumPlanetDBFields = 48;
    PlanetDBFields : array[1..NumPlanetDBFields,1..2] of string = (
      ('BODY','text'),
      ('NAME','text'),
      ('PUN','text'),
      ('NAMETYPE','text'),
      ('TYPE','text'),
      ('TYPECODE','text'),
      ('NAMEDETAIL','text'),
      ('NAMEORIGIN','text'),
      ('WORK','text'),
      ('COUNTRY','text'),
      ('NATIONALTY','text'),
      ('CENTURYN','text'),
      ('CENTURYC','text'),
      ('BIRTHPLACE','text'),
      ('BIRTHDATE','text'),
      ('DEATHPLACE','text'),
      ('DEATHDATE','text'),
      ('FACTS','text'),
      ('LONGIN','float'),
      ('LONGIC','text'),
      ('LATIN','float'),
      ('LATIC','text'),
      ('QUADRANT','text'),
      ('LENGTHKM','float'),
      ('WIDEKM','float'),
      ('Target','text'),
      ('Feature_ID','integer'),
      ('Feature_Name','text'),
      ('Clean_Feature_Name','text'),
      ('Feature_Type','text'),
      ('Feature_Type_Code','text'),
      ('Diameter','float'),
      ('Center_Latitude','float'),
      ('Center_Longitude','float'),
      ('Northern_Latitude','float'),
      ('Southern_Latitude','float'),
      ('Eastern_Longitude','float'),
      ('Western_Longitude','float'),
      ('Coordinate_System','text'),
      ('Quad','text'),
      ('Origin','text'),
      ('Continent','text'),
      ('Ethnicity','text'),
      ('Approval_Status','text'),
      ('Approval_Date','text'),
      ('Reference','text'),
      ('Last_Updated','text'),
      ('Additional_Info','text')
      );
      FPLANETN=1;
      FNAME=2;
      FLONGIN=5;
      FLATIN=6;
var
    database : array[1..9] of string;

Procedure LoadDB(dbm: TLiteDB);
Procedure CreateDB(dbm: TLiteDB);
Procedure ConvertDB(dbm: TLiteDB; fn,pla:string);
procedure DBjournal(dbname,txt:string);

implementation

Uses  u_constant, u_util, fmsg;

Procedure CreateDB(dbm: TLiteDB);
var i,dbv: integer;
    cmd,buf: string;
begin
buf:=dbm.QueryOne('select version from dbversion;');
dbv:=StrToIntDef(buf,0);
if dbv<DBversion then begin
 dbm.Query('drop table planet;');
 dbm.Query('drop table file_date;');
 dbm.Query('drop table user_database;');
 dbm.Query('drop table dbversion;');
 dbm.Commit;
 dbm.Query('Vacuum;');
 cmd:='create table planet ( '+
    'ID INTEGER PRIMARY KEY,PLANETN INTEGER';
 for i:=1 to NumPlanetDBFields do begin
   cmd:=cmd+','+PlanetDBFields[i,1]+' '+PlanetDBFields[i,2];
 end;
 cmd:=cmd+');';
 dbm.Query(cmd);
 if dbm.LastError<>0 then dbjournal(extractfilename(dbm.database),copy(cmd,1,60)+'...  Error: '+dbm.ErrorMessage);
 dbm.Query('create index planet_pos on planet (longin,latin);');
 dbm.Query('create index planet_name on planet (planetn,name);');
 dbjournal(extractfilename(dbm.database),'CREATE TABLE PLANET');

 cmd:='create table file_date ( '+
    'PLANETN integer,'+
    'FDATE integer'+
    ');';
 dbm.Query(cmd);
 if dbm.LastError<>0 then dbjournal(extractfilename(dbm.database),copy(cmd,1,60)+'...  Error: '+dbm.ErrorMessage);
 dbjournal(extractfilename(dbm.database),'CREATE TABLE FILE_DATE');

 cmd:='create table user_database ( '+
    'PLANETN integer,'+
    'NAME text'+
    ');';
 dbm.Query(cmd);
 if dbm.LastError<>0 then dbjournal(extractfilename(dbm.database),copy(cmd,1,60)+'...  Error: '+dbm.ErrorMessage);
 dbjournal(extractfilename(dbm.database),'CREATE TABLE USER_DATABASE');

 cmd:='create table dbversion ( '+
    'version integer'+
    ');';
 dbm.Query(cmd);
 cmd:='insert into dbversion values('+inttostr(DBversion)+');';
 dbm.Query(cmd);
 if dbm.LastError<>0 then dbjournal(extractfilename(dbm.database),copy(cmd,1,60)+'...  Error: '+dbm.ErrorMessage);
 dbjournal(extractfilename(dbm.database),'CREATE TABLE DBVERSION');
end;
end;

Procedure ConvertDB(dbm: TLiteDB; fn,pla:string);
var cmd,v: string;
    i,imax,ii,j:integer;
    db1:Tmlb2;
begin
if MsgForm=nil then Application.CreateForm(TMsgForm, MsgForm);
MsgForm.Label1.caption:=ExtractFileName(fn)+crlf+'Preparing Database. Please Wait ...';
msgform.show;
msgform.Refresh;
application.ProcessMessages;
db1:=Tmlb2.Create;
try
db1.init;
db1.CSVSeparator:=';';
db1.QuoteSeparator:='';
db1.LoadFromFile(fn);
db1.GoFirst;
dbm.StartTransaction;
dbm.Query('delete from planet where PLANETN='+pla+';');
dbm.Commit;
dbjournal(extractfilename(dbm.database),'DELETE ALL PLANETN='+pla);
v:='';
for i:=1 to NumPlanetDBFields do begin
  ii:=db1.GetFieldIndex(PlanetDBFields[i,1]);
  if ii=0 then v:=v+PlanetDBFields[i,1]+'; ';
end;
if v>'' then dbjournal(extractfilename(dbm.database), fn+' missing fields: '+v);
dbm.StartTransaction;
repeat
  cmd:='insert into planet values(NULL,'+pla+',';
  for i:=1 to NumPlanetDBFields do begin
    v:=db1.GetData(PlanetDBFields[i,1]);
    v:=stringreplace(v,',','.',[rfreplaceall]);
    v:=stringreplace(v,'""','''',[rfreplaceall]);
    v:=stringreplace(v,'"','',[rfreplaceall]);
    cmd:=cmd+'"'+v+'",';
  end;
  cmd:=copy(cmd,1,length(cmd)-1)+');';
  dbm.Query(cmd);
  if dbm.LastError<>0 then dbjournal(extractfilename(dbm.database),copy(cmd,1,60)+'...  Error: '+dbm.ErrorMessage);
  db1.GoNext;
until db1.EndOfFile;
imax:=dbm.GetLastInsertID;
dbm.Query('update planet set widekm=0 where widekm="";');
dbm.Query('update planet set widekm=0 where widekm="?";');
dbm.Query('update planet set widekm=0 where widekm="??";');
dbm.Query('update planet set lengthkm=0 where lengthkm="";');
dbm.Query('update planet set lengthkm=0 where lengthkm="?";');
dbm.Query('update planet set lengthkm=0 where lengthkm="??";');
dbm.Query('delete from file_date where planetn='+pla+';');
dbm.Query('insert into file_date values ('+pla+','+inttostr(fileage(fn))+');');
dbm.Commit;
dbjournal(extractfilename(dbm.database),'INSERT PLANETN='+pla+' MAX ID='+inttostr(imax));
finally
db1.Clear;
db1.Free;
end;
end;

Procedure LoadDB(dbm: TLiteDB);
var i,db_age : integer;
    buf:string;
    needvacuum: boolean;
begin
needvacuum:=false;
buf:=Slash(DBdir)+'dbplanet'+uplanguage+'.dbl';
dbm.Use(utf8encode(buf));
try
buf:=Slash(appdir)+Slash('Database')+'Mercury_Named_'+uplanguage+'.csv';
if fileexists(buf) then database[1]:=buf
   else database[1]:=Slash(appdir)+Slash('Database')+'Mercury_Named_EN.csv';
buf:=Slash(appdir)+Slash('Database')+'Venus_Named_'+uplanguage+'.csv';
if fileexists(buf) then database[2]:=buf
   else database[2]:=Slash(appdir)+Slash('Database')+'Venus_Named_EN.csv';
buf:=Slash(appdir)+Slash('Database')+'Mars_Named_'+uplanguage+'.csv';
if fileexists(buf) then database[4]:=buf
   else database[4]:=Slash(appdir)+Slash('Database')+'Mars_Named_EN.csv';
CreateDB(dbm);
for i:=1 to maxpla do begin
     if i=3 then continue; // no Earth for now.
     buf:=dbm.QueryOne('select fdate from file_date where planetn='+inttostr(i)+';');
     if buf='' then db_age:=0 else db_age:=strtoint(buf);
     if fileexists(database[i]) then begin
       PlanetInstalled[i]:=true;
       if (db_age<fileage(database[i])) then begin
          dbjournal(extractfilename(dbm.database),'LOAD DATABASE PLANETN='+inttostr(i)+' FROM FILE: '+database[i]+' FILE DATE: '+ DateTimeToStr(FileDateToDateTime(fileage(database[i]))) );
          convertDB(dbm,database[i],inttostr(i));
          needvacuum:=true;
       end;
     end
     else PlanetInstalled[i]:=false;
end;
if needvacuum then dbm.Query('Vacuum;');
finally
if MsgForm<>nil then MsgForm.Close;
end;
end;

procedure DBjournal(dbname,txt:string);
var f : textfile;
    fn: string;
const dbj='database_journal.txt';
begin
fn:=Slash(DBdir)+dbj;
if fileexists(fn) then begin
  assignfile(f,fn);
  append(f);
end else begin
  assignfile(f,fn);
  rewrite(f);
end;
writeln(f,FormatDateTime('yyyy"-"mm"-"dd" "hh":"nn":"ss',Now),' DB=',dbname,' ',txt);
closefile(f);
end;

end.
