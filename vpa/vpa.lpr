program vpa;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Dialogs, avpmain, config, OpenGLAdapter, OpenGLTokens, GLScene_RunTime,
  CraterList, dbutil, fmsg, splashunit, SysUtils,
  TurboPowerIPro, u_constant, cu_tz, cu_planet, u_projection, u_util, pu_planet,
  u_translation_database, u_translation, uniqueinstance_package, downldialog,
  BigIma, uDE, mlb2, pu_ephem;

var i:integer;

{$R *.res}

begin
  {$ifdef USEHEAPTRC}
  SetHeapTraceOutput('/tmp/vma_heap.trc');
  {$endif}
  Application.Initialize;
  if not InitOpenGL then begin
     showmessage('Could not load the OpenGL library '+opengl32+' and '+glu32+crlf+'Please check your OpenGL installation.');
     halt;
  end;
  Application.CreateForm(Tf_avpmain, f_avpmain);
  Application.CreateForm(Tf_craterlist, f_craterlist);
  if (f_avpmain.param.IndexOf('-quit')<0) then begin
      Splashversion := VPAversion+blank+compile_time;
      splash := Tsplash.create(application);
      splash.VersionName:=VersionName;
      splash.Splashversion:=Splashversion;
      splash.transmsg:=transmsg;
      splash.show;
      splash.refresh;
      Application.Run;
  end
  else Application.Terminate;
end.

