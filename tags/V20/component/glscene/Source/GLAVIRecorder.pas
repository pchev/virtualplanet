//
// This unit is part of the GLScene Project, http://glscene.org
//
{ : GLAVIRecorder<p>

  Component to make it easy to record GLScene frames into an AVI file<p>

  <b>History : </b><font size=-1><ul>
  <li>17/11/14 - PW - Refactored TAVIRecorder to TGLAVIRecorder
  <li>12/07/07 - DaStr - Improved Cross-Platform compatibility
  (Bugtracker ID = 1684432)
  <li>17/03/07 - DaStr - Dropped Kylix support in favor of FPC (BugTracekrID=1681585)
  <li>29/01/07 - DaStr - Moved registration to GLSceneRegister.pas
  <li>01/06/05 - NelC - Replaced property GLFullScreenViewer with GLNonVisualViewer
  <li>26/01/05 - JAJ - Can now operate with a GLFullScreenViewer
  <li>22/10/04 - EG - Can now operate without a SceneViewer
  <li>13/05/04 - EG - Added irmBitBlt mode (now the default mode)
  <li>05/01/04 - EG - Added Recording function and ability to record arbitrary bitmap,
  Added OnPostProcessEvent
  <li>08/07/03 - NelC - Fixed access violation on exit (thx Solerman Kaplon)
  and minor updates
  <li>11/12/01 - EG - Minor changes for compatibility with JEDI VfW.pas
  <li<02/03/01 - EG - Added TAVIImageRetrievalMode
  <li>24/02/01 - NelC - Creation and initial code
  </ul></font>
}
unit GLAVIRecorder;

interface

{$I GLScene.inc}
{$IFNDEF MSWINDOWS}{$MESSAGE Error 'Unit not supported'}{$ENDIF}

uses
  Windows,
{$IFDEF GLS_DELPHI_XE2_UP}
  WinApi.Messages, System.Classes, System.SysUtils,
  VCL.Controls, VCL.Forms, VCL.Extctrls, VCL.Graphics, VCL.Dialogs,
{$ELSE}
  Messages, Classes, SysUtils,
  Controls, Forms, Extctrls, Graphics, Dialogs,
{$ENDIF}
  GLGraphics, GLSVfw, GLScene, GLViewer;

type
  TAVICompressor = (acDefault, acShowDialog, acDivX);

  PAVIStream = ^IAVIStream;

  // TAVISizeRestriction
  //
  { : Frame size restriction.<p>
    Forces frame dimensions to be a multiple of 2, 4, or 8. Some compressors
    require this. e.g. DivX 5.2.1 requires mutiples of 2. }
  TAVISizeRestriction = (srNoRestriction, srForceBlock2x2, srForceBlock4x4,
    srForceBlock8x8);

  TAVIRecorderState = (rsNone, rsRecording);

  // TAVIImageRetrievalMode
  //
  { : Image retrieval mode for frame capture.<p>
    Following modes are supported:<p>
    <li>irmSnapShot : retrieve OpenGL framebuffer content using glReadPixels
    <li>irmRenderToBitmap : renders the whole scene to a bitmap, this is
    the slowest mode, but it won't be affected by driver-side specifics.
    <li>irmBitBlt : tranfers the framebuffer using the BitBlt function,
    usually the fastest solution
    </ul> }
  TAVIImageRetrievalMode = (irmSnapShot, irmRenderToBitmap, irmBitBlt);

  TAVIRecorderPostProcessEvent = procedure(Sender: TObject; frame: TBitmap)
    of object;

  // TGLAVIRecorder
  //
  { : Component to make it easy to record GLScene frames into an AVI file. }
  TGLAVIRecorder = class(TComponent)
  private
    { Private Declarations }
    AVIBitmap: TBitmap;
    AVIFrameIndex: integer;

    AVI_DPI: integer;

    asi: TAVIStreamInfo;

    pfile: IAVIFile;
    Stream, Stream_c: IAVIStream; // AVI stream and stream to be compressed

    FBitmapInfo: PBitmapInfoHeader;
    FBitmapBits: Pointer;
    FBitmapSize: Dword;

    FTempName: String;
    // so that we know the filename to delete case of user abort

    FAVIFilename: string;
    FFPS: byte;
    FWidth: integer;
    FHeight: integer;
    FSizeRestriction: TAVISizeRestriction;
    FImageRetrievalMode: TAVIImageRetrievalMode;
    RecorderState: TAVIRecorderState;
    FOnPostProcessEvent: TAVIRecorderPostProcessEvent;

    FBuffer: TGLSceneBuffer;

    procedure SetHeight(const val: integer);
    procedure SetWidth(const val: integer);
    procedure SetSizeRestriction(const val: TAVISizeRestriction);
    procedure SetGLSceneViewer(const Value: TGLSceneViewer);
    procedure SetGLNonVisualViewer(const Value: TGLNonVisualViewer);

  protected
    { Protected Declarations }
    // Now, TAVIRecorder is tailored for GLScene. Maybe we should make a generic
    // TAVIRecorder, and then sub-class it to use with GLScene
    FGLSceneViewer: TGLSceneViewer;
    // FGLNonVisualViewer accepts GLNonVisualViewer and GLFullScreenViewer
    FGLNonVisualViewer: TGLNonVisualViewer;
    // FCompressor determines if the user is to choose a compressor via a dialog box, or
    // just use a default compressor without showing a dialog box.
    FCompressor: TAVICompressor;
    // some video compressor assumes input dimensions to be multiple of 2, 4 or 8.
    // Restricted() is for rounding off the width and height.
    // Currently I can't find a simple way to know which compressor imposes
    // what resiction, so the SizeRestiction property is there for the user to set.
    // The source code of VirtualDub (http://www.virtualdub.org/)
    // may give us some cues on this.
    // ( BTW, VirtualDub is an excellent freeware for editing your AVI. For
    // converting AVI into MPG, try AVI2MPG1 - http://www.mnsi.net/~jschlic1 )
    function Restricted(s: integer): integer;

    procedure InternalAddAVIFrame;

  public
    { Public Declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CreateAVIFile(DPI: integer = 0): boolean;
    procedure AddAVIFrame; overload;
    procedure AddAVIFrame(bmp: TBitmap); overload;
    procedure CloseAVIFile(UserAbort: boolean = false);
    function Recording: boolean;

  published
    { Published Declarations }
    property FPS: byte read FFPS write FFPS default 25;
    property GLSceneViewer: TGLSceneViewer read FGLSceneViewer
      write SetGLSceneViewer;
    property GLNonVisualViewer: TGLNonVisualViewer read FGLNonVisualViewer
      write SetGLNonVisualViewer;
    property Width: integer read FWidth write SetWidth;
    property Height: integer read FHeight write SetHeight;
    property Filename: String read FAVIFilename write FAVIFilename;
    property Compressor: TAVICompressor read FCompressor write FCompressor
      default acDefault;
    property SizeRestriction: TAVISizeRestriction read FSizeRestriction
      write SetSizeRestriction default srForceBlock8x8;
    property ImageRetrievalMode: TAVIImageRetrievalMode read FImageRetrievalMode
      write FImageRetrievalMode default irmBitBlt;

    property OnPostProcessEvent: TAVIRecorderPostProcessEvent
      read FOnPostProcessEvent write FOnPostProcessEvent;

  end;

  // ---------------------------------------------------------------------
  // ---------------------------------------------------------------------
  // ---------------------------------------------------------------------
implementation

// ---------------------------------------------------------------------
// ---------------------------------------------------------------------
// ---------------------------------------------------------------------

// DIB support rountines for AVI output

procedure InitializeBitmapInfoHeader(Bitmap: HBITMAP;
  var BI: TBitmapInfoHeader);
var
  BM: Windows.TBitmap;
begin
  GetObject(Bitmap, SizeOf(BM), @BM);
  with BI do
  begin
    biSize := SizeOf(BI);
    biWidth := BM.bmWidth;
    biHeight := BM.bmHeight;
    biPlanes := 1;
    biXPelsPerMeter := 0;
    biYPelsPerMeter := 0;
    biClrUsed := 0;
    biClrImportant := 0;
    biCompression := BI_RGB;
    biBitCount := 24;
    // force 24 bits. Most video compressors would deal with 24-bit frames only.
    biSizeImage := (((biWidth * biBitCount) + 31) div 32) * 4 * biHeight;
  end;
end;

procedure InternalGetDIBSizes(Bitmap: HBITMAP; var InfoHeaderSize: integer;
  var ImageSize: Dword);
var
  BI: TBitmapInfoHeader;
begin
  InitializeBitmapInfoHeader(Bitmap, BI);
  InfoHeaderSize := SizeOf(TBitmapInfoHeader);
  ImageSize := BI.biSizeImage;
end;

// InternalGetDIB
//
function InternalGetDIB(Bitmap: HBITMAP; var bitmapInfo; var bits): boolean;
var
  focus: HWND;
  dc: HDC;
  errCode: integer;
begin
  InitializeBitmapInfoHeader(Bitmap, TBitmapInfoHeader(bitmapInfo));
  focus := GetFocus;
  dc := GetDC(focus);
  try
    errCode := GetDIBits(dc, Bitmap, 0, TBitmapInfoHeader(bitmapInfo).biHeight,
      @bits, TBitmapInfo(bitmapInfo), DIB_RGB_COLORS);
    Result := (errCode <> 0);
  finally
    ReleaseDC(focus, dc);
  end;
end;

// ------------------
// ------------------ TAVIRecorder ------------------
// ------------------

// Create
//
constructor TGLAVIRecorder.Create(AOwner: TComponent);
begin
  inherited;
  FWidth := 320; // default values
  FHeight := 200;
  FFPS := 25;
  FCompressor := acDefault;
  RecorderState := rsNone;
  FSizeRestriction := srForceBlock8x8;
  FImageRetrievalMode := irmBitBlt;
end;

// Destroy
//
destructor TGLAVIRecorder.Destroy;
begin
  // if still open here, abort it
  if RecorderState = rsRecording then
    CloseAVIFile(True);
  inherited;
end;

// Restricted
//
function TGLAVIRecorder.Restricted(s: integer): integer;
begin
  case FSizeRestriction of
    srForceBlock2x2:
      Result := (s div 2) * 2;
    srForceBlock4x4:
      Result := (s div 4) * 4;
    srForceBlock8x8:
      Result := (s div 8) * 8;
  else
    Result := s;
  end;
end;

// SetHeight
//
procedure TGLAVIRecorder.SetHeight(const val: integer);
begin
  if (RecorderState <> rsRecording) and (val <> FHeight) and (val > 0) then
    FHeight := Restricted(val);
end;

// SetWidth
//
procedure TGLAVIRecorder.SetWidth(const val: integer);
begin
  if (RecorderState <> rsRecording) and (val <> FWidth) and (val > 0) then
    FWidth := Restricted(val);
end;

// SetSizeRestriction
//
procedure TGLAVIRecorder.SetSizeRestriction(const val: TAVISizeRestriction);
begin
  if val <> FSizeRestriction then
  begin
    FSizeRestriction := val;
    FHeight := Restricted(FHeight);
    FWidth := Restricted(FWidth);
  end;
end;

// AddAVIFrame (from sceneviewer)
//
procedure TGLAVIRecorder.AddAVIFrame;
var
  bmp32: TGLBitmap32;
  bmp: TBitmap;
begin
  if RecorderState <> rsRecording then
    raise Exception.Create('Cannot add frame to AVI. AVI file not created.');

  if FBuffer <> nil then
    case ImageRetrievalMode of
      irmSnapShot:
        begin
          bmp32 := FBuffer.CreateSnapShot;
          try
            bmp := bmp32.Create32BitsBitmap;
            try
              AVIBitmap.Canvas.Draw(0, 0, bmp);
            finally
              bmp.Free;
            end;
          finally
            bmp32.Free;
          end;
        end;
      irmBitBlt:
        begin
          FBuffer.RenderingContext.Activate;
          try
            BitBlt(AVIBitmap.Canvas.Handle, 0, 0, AVIBitmap.Width,
              AVIBitmap.Height, wglGetCurrentDC, 0, 0, SRCCOPY);
          finally
            FBuffer.RenderingContext.Deactivate;
          end;
        end;
      irmRenderToBitmap:
        begin
          FBuffer.RenderToBitmap(AVIBitmap, AVI_DPI);
        end;
    else
      Assert(false);
    end;

  InternalAddAVIFrame;
end;

// AddAVIFrame (from custom bitmap)
//
procedure TGLAVIRecorder.AddAVIFrame(bmp: TBitmap);
begin
  if RecorderState <> rsRecording then
    raise Exception.Create('Cannot add frame to AVI. AVI file not created.');
  AVIBitmap.Canvas.Draw(0, 0, bmp);

  InternalAddAVIFrame;
end;

// InternalAddAVIFrame
//
procedure TGLAVIRecorder.InternalAddAVIFrame;
begin
  if Assigned(FOnPostProcessEvent) then
    FOnPostProcessEvent(Self, AVIBitmap);
  with AVIBitmap do
  begin
    InternalGetDIB(Handle, FBitmapInfo^, FBitmapBits^);
    if AVIStreamWrite(Stream_c, AVIFrameIndex, 1, FBitmapBits, FBitmapSize,
      AVIIF_KEYFRAME, nil, nil) <> AVIERR_OK then
      raise Exception.Create('Add Frame Error');
    Inc(AVIFrameIndex);
  end;
end;

function TGLAVIRecorder.CreateAVIFile(DPI: integer = 0): boolean;
var
  SaveDialog: TSaveDialog;
  gaAVIOptions: TAVICOMPRESSOPTIONS;
  galpAVIOptions: PAVICOMPRESSOPTIONS;
  bitmapInfoSize: integer;
  AVIResult: Cardinal;
  ResultString: String;
begin
  FTempName := FAVIFilename;

  if FTempName = '' then
  begin
    // if user didn't supply a filename, then ask for it
    SaveDialog := TSaveDialog.Create(Application);
    try
      with SaveDialog do
      begin
        Options := [ofHideReadOnly, ofNoReadOnlyReturn];
        DefaultExt := '.avi';
        Filter := 'AVI Files (*.avi)|*.avi';
        if Execute then
          FTempName := SaveDialog.Filename;
      end;
    finally
      SaveDialog.Free;
    end;
  end;

  Result := (FTempName <> '');
  if Result then
  begin
    if FileExists(FTempName) then
    begin
      Result := (MessageDlg(Format('Overwrite file %s?', [FTempName]),
        mtConfirmation, [mbYes, mbNo], 0) = mrYes);
      // AVI streamers don't trim the file they're written to, so start from zero
      if Result then
        DeleteFile(FTempName);
    end;
  end;

  if not Result then
    Exit;

  AVIFileInit; // initialize the AVI lib.

  AVIBitmap := TBitmap.Create;
  AVIFrameIndex := 0;

  RecorderState := rsRecording;

  try
    AVIBitmap.PixelFormat := pf24Bit;
    AVIBitmap.Width := FWidth;
    AVIBitmap.Height := FHeight;

    // note: a filename with extension other then AVI give generate an error.
    if AVIFileOpen(pfile, PChar(FTempName), OF_WRITE or OF_CREATE, nil) <> AVIERR_OK
    then
      raise Exception.Create
        ('Cannot create AVI file. Disk full or file in use?');

    with AVIBitmap do
    begin
      InternalGetDIBSizes(Handle, bitmapInfoSize, FBitmapSize);
      FBitmapInfo := AllocMem(bitmapInfoSize);
      FBitmapBits := AllocMem(FBitmapSize);
      InternalGetDIB(Handle, FBitmapInfo^, FBitmapBits^);
    end;

    FillChar(asi, SizeOf(asi), 0);

    with asi do
    begin
      fccType := streamtypeVIDEO; // Now prepare the stream
      fccHandler := 0;
      dwScale := 1; // dwRate / dwScale = frames/second
      dwRate := FFPS;
      dwSuggestedBufferSize := FBitmapSize;
      rcFrame.Right := FBitmapInfo.biWidth;
      rcFrame.Bottom := FBitmapInfo.biHeight;
    end;

    if AVIFileCreateStream(pfile, Stream, asi) <> AVIERR_OK then
      raise Exception.Create('Cannot create AVI stream.');

    with AVIBitmap do
      InternalGetDIB(Handle, FBitmapInfo^, FBitmapBits^);

    galpAVIOptions := @gaAVIOptions;
    FillChar(gaAVIOptions, SizeOf(gaAVIOptions), 0);
    gaAVIOptions.fccType := streamtypeVIDEO;

    case FCompressor of
      acShowDialog:
        begin
          // call a dialog box for the user to choose the compressor options
          AVISaveOptions(0, ICMF_CHOOSE_KEYFRAME or ICMF_CHOOSE_DATARATE, 1,
            Stream, galpAVIOptions);
        end;
      acDivX:
        with gaAVIOptions do
        begin
          // ask for generic divx, using current default settings
          fccHandler := mmioFOURCC('d', 'i', 'v', 'x');
        end;
    else
      with gaAVIOptions do
      begin // or, you may want to fill the compression options yourself
        fccHandler := mmioFOURCC('M', 'S', 'V', 'C');
        // User MS video 1 as default.
        // I guess it is installed on every Win95 or later.
        dwQuality := 7500; // compress quality 0-10,000
        dwFlags := 0;
        // setting dwFlags to 0 would lead to some default settings
      end;
    end;

    AVIResult := AVIMakeCompressedStream(Stream_c, Stream, galpAVIOptions, nil);

    if AVIResult <> AVIERR_OK then
    begin
      if AVIResult = AVIERR_NOCOMPRESSOR then
        ResultString := 'No such compressor found'
      else
        ResultString := '';
      raise Exception.Create('Cannot make compressed stream. ' + ResultString);
    end;

    if AVIStreamSetFormat(Stream_c, 0, FBitmapInfo, bitmapInfoSize) <> AVIERR_OK
    then
      raise Exception.Create('AVIStreamSetFormat Error');
    // no error description found in MSDN.

    AVI_DPI := DPI;

  except
    CloseAVIFile(True);
    raise;
  end;

end;

procedure TGLAVIRecorder.CloseAVIFile(UserAbort: boolean = false);
begin
  // if UserAbort, CloseAVIFile will also delete the unfinished file.
  try
    if RecorderState <> rsRecording then
      raise Exception.Create('Cannot close AVI file. AVI file not created.');

    AVIBitmap.Free;

    FreeMem(FBitmapInfo);
    FreeMem(FBitmapBits);

    AVIFileExit; // finalize the AVI lib.

    // release the interfaces explicitly (can't rely on automatic release)
    Stream := nil;
    Stream_c := nil;
    pfile := nil;

    if UserAbort then
      DeleteFile(FTempName);
  finally
    RecorderState := rsNone;
  end;
end;

// Recording
//
function TGLAVIRecorder.Recording: boolean;
begin
  Result := (RecorderState = rsRecording);
end;

procedure TGLAVIRecorder.SetGLSceneViewer(const Value: TGLSceneViewer);
begin
  FGLSceneViewer := Value;
  if Assigned(FGLSceneViewer) then
    FBuffer := FGLSceneViewer.Buffer
  else
    FBuffer := nil;
end;

procedure TGLAVIRecorder.SetGLNonVisualViewer(const Value: TGLNonVisualViewer);
begin
  FGLNonVisualViewer := Value;
  if Assigned(FGLNonVisualViewer) then
    FBuffer := FGLNonVisualViewer.Buffer
  else
    FBuffer := nil;
end;

end.
