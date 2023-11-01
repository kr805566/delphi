unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,AviCap;

const
  WM_CAP_START = WM_USER;
  WM_CAP_DRIVER_CONNECT = WM_CAP_START + 10;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Timer1: TTimer;
    Button2: TButton;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    Panel3: TPanel;
    Button5: TButton;
    Timer2: TTimer;
    Memo1: TMemo;
    ComboBox1: TComboBox;
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);



      
  private
    vcHWND, vcHWND1,hwdc2: THandle;

    

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{function capCreateCaptureWindow(lpszWindowName: LPCSTR; dwStyle: DWord;
  x, y, nWidth, nHeight: integer; hwndParent: HWND; nID: integer): HWND;
  stdcall; external 'AVICAP32.DLL' name 'capCreateCaptureWindowA';}

 function EnumChildProc(hwnd: HWND; lParam: LPARAM): BOOL; stdcall;
 var
 str :array [0..1024] of char; //�^�`���
begin

  {TMemo(lParam).Lines.Add(IntToStr(hwnd)); //hwnd�N�O�l���^���y�`
GetWindowText(hwnd,str,1024);
 TMemo(lParam).Lines.Add( String(str));
 GetClassName(hwnd,str,1024);
 TMemo(lParam).Lines.Add('ClassName= '+ String(str));



 TMemo(lParam).Lines.Add( '-------------------');}

 GetClassName(hwnd,str,1024);
if  String(str)='ComboBox' Then
TMemo(lParam).Lines.Add(IntToStr(hwnd));


  Result := True;
end;



procedure TForm1.Button1Click(Sender: TObject);
begin
  try
    capSetCallbackOnStatus(vcHWND, LongInt(0));
    capDriverDisconnect(vcHWND);
    DestroyWindow(vcHWND);
    vcHWND := 0;

    capSetCallbackOnStatus(vcHWND1, LongInt(0));
    capDriverDisconnect(vcHWND1);
    DestroyWindow(vcHWND1);
    vcHWND1 := 0;

    // MciClose;
  finally
    // Close;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);

begin


  SendMessage(vcHWND, WM_CAP_DLG_VIDEOSOURCE, 0, 0);
 SendMessage(vcHWND1, WM_CAP_DLG_VIDEOSOURCE, 0, 0);

end;

procedure TForm1.Button3Click(Sender: TObject);
var
  achSingleFileName: array [0 .. 255] of ansiChar; //char
  gCapSingleImageFileName: AnsiString; //string
begin
  if vcHWND = 0 then
    exit;
  gCapSingleImageFileName := 'd:\TempBmp\'
  + FormatDateTime('yyyymmddhhnnss',Now) +'.BMP';

  capGrabFrame(vcHWND);
  StrPCopy(achSingleFileName, gCapSingleImageFileName);
  capFileSaveDIB(vcHWND, LongInt(@achSingleFileName));
  //capFileSaveDIB(vcHWND,'d:\aa\TEMP.BMP');

  {if vcHWND = 0 then
    exit;

  capOverlay(vcHWND, 0);
  capPreviewScale(vcHWND, 1);
  capPreviewRate(vcHWND, 40);
  capPreview(vcHWND, 1);
  Image1.Picture.LoadFromFile('d:\aa\TEMP.BMP');}
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  achSingleFileName: array [0 .. 255] of ansiChar; //char
  gCapSingleImageFileName: AnsiString; //string
begin
  if vcHWND1 = 0 then
    exit;
   gCapSingleImageFileName := 'd:\TempBmp\'
  + FormatDateTime('yyyymmddhhnnss',Now) +'.BMP';

  capGrabFrame(vcHWND1);
  StrPCopy(achSingleFileName, gCapSingleImageFileName);
  capFileSaveDIB(vcHWND1, LongInt(@achSingleFileName));

end;

procedure TForm1.Button5Click(Sender: TObject);

var
 hwdc, hwdc1: THandle;
 A:Integer;
 hWnd:LongInt;
begin
//SetWindowText(_T('About This'));�s��r��� (2).txt
hwdc := capCreateCaptureWindow('test', WS_CHILD or WS_VISIBLE, 0, 0, Panel1.Width, Panel1.Height, Panel3.Handle, 0);
SendMessage(hwdc, 1034, 0, 0);

SendMessage(hwdc, 1077, 1, 0);
SendMessage(hwdc, 1076, 100, 0);


SendMessage(hwdc, 1074, 1, 0);
//capDriverConnect(hwdc,a) ;


 PostMessage(hwdc,  WM_CAP_DLG_VIDEOSOURCE, 0, 0);


//PostMessage(hwdc1,WM_KEYDOWN   ,VK_RETURN ,0);

  Timer2.Enabled:=true;

  end;


procedure TForm1.FormActivate(Sender: TObject);
var
  a, b: boolean;
  i, j: integer;
begin
  // vcHWND := capCreateCaptureWindow ('Capture Window', WS_CHILD or WS_VISIBLE ,0, 0, 320,240 , Form1.Handle, 0);
  // vcHWND1 := capCreateCaptureWindow ( 'Capture Window', WS_CHILD or WS_VISIBLE ,0, 0, 320,240 , Form1.Handle, 0);
  // SendMessage (vcHWND, WM_CAP_DRIVER_CONNECT, 0 , 0);
  // SendMessage (vcHWND1, WM_CAP_DRIVER_CONNECT, 0 , 0);

  vcHWND := capCreateCaptureWindow('Video1', WS_CHILD or WS_VISIBLE, 0,0, 640,
    480, Panel1.Handle, 0);           //(X,Y,W,H)
  vcHWND1 := capCreateCaptureWindow('Video1', WS_CHILD or WS_VISIBLE, 0, 0,
    640, 480, Panel2.Handle, 0);


  SendMessage(vcHWND, WM_CAP_DRIVER_CONNECT, 0, 0);
  SendMessage(vcHWND, WM_CAP_SET_PREVIEWRATE, 1, 0);
  SendMessage(vcHWND, WM_CAP_SET_OVERLAY, 1, 0);
  SendMessage(vcHWND, WM_CAP_SET_PREVIEW, 1, 0);

  SendMessage(vcHWND1, WM_CAP_DRIVER_CONNECT, 0,1);
  SendMessage(vcHWND1, WM_CAP_SET_PREVIEWRATE, 1, 0);  // (THandle,WM_CAP_SET_PREVIEWRATE,time,0)
  SendMessage(vcHWND1, WM_CAP_SET_OVERLAY, 1, 0);
  SendMessage(vcHWND1, WM_CAP_SET_PREVIEW, 1, 0);

  { b := false;
    for  i := 0 to 9 do
    begin
    b := Boolean(capDriverConnect( vcHWND, i ));
    if b then break;
    end;

    if( Not b ) then  ShowMessage('��v���s������.');


    a := false;
    for j := 0 to  9 do
    begin
    a := Boolean(capDriverConnect( vcHWND1, j ));
    if a then break;

    end;

    if( Not a )then ShowMessage('��v���s������..');


    //  capPreview(vcHWND,0);
    //  capPreviewRate(vcHWND,65);
    //  capPreview(vcHWND1,0);
    //  capPreviewRate(vcHWND1,66); }

end;

procedure TForm1.FormCreate(Sender: TObject);
var
bReturn : Boolean;
x:Integer;
strName,strVer : array [0 .. 100] of Char;
begin
bReturn:=true;
x:=0;
while X<10  do
begin

bReturn := capGetDriverDescription(x, strName, 100, strVer, 100);


  ComboBox1.Items.Add(strName);
 x:=x+1;
end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  {SendMessage(vcHWND, WM_CAP_SET_CALLBACK_FRAME, 0, 0);
  SendMessage(vcHWND, WM_CAP_GRAB_FRAME_NOSTOP, 1, 0);

  SendMessage(vcHWND1, WM_CAP_SET_CALLBACK_FRAME, 0, 0);
  SendMessage(vcHWND1, WM_CAP_GRAB_FRAME_NOSTOP, 1, 0);}
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
 hwdc1: THandle;
 N:INTEGER; Str:array[0..1024] of  Char;

begin


  hwdc1 := FindWindow(nil,'���T�ӷ�');
 //hwdc2:=FindWindowEx( hwdc1,0,'ComboBox','Logitech HD Webcam C270');
   EnumChildWindows(hwdc1, @EnumChildProc, Integer(Memo1));

{PostMessage(hwdc1,WM_SYSCOMMAND ,SC_KEYMENU	,0);


 PostMessage(hwdc1,WM_NEXTDLGCTL   ,0 ,0);



PostMessage(hwdc1,WM_KEYDOWN  ,VK_TAB  ,0);
PostMessage(hwdc1,WM_KEYDOWN  ,VK_TAB  ,0);}


           //   PostMessage(hwdc1,WM_SYSKEYDOWN   ,VK_DOWN  ,0);



 hwdc2:= StrToInt(Memo1.Lines[0]);

SendMessage(hwdc2, CB_SHOWDROPDOWN, 1, 0);
PostMessage(hwdc2,WM_KEYDOWN  ,VK_Down  ,0);
PostMessage(hwdc2,WM_KEYDOWN   ,VK_RETURN ,0);
PostMessage(hwdc1,WM_KEYDOWN   ,VK_RETURN ,0);
{keybd_event(VK_MENU,0,0,0);
PostMessage(hwdc1,WM_KEYDOWN  ,VK_Down  ,0);
PostMessage(hwdc1,WM_KEYDOWN  ,VK_Down  ,0);
Sleep(50);
keybd_event(VK_F4,0,KEYEVENTF_KEYUP,0);



keybd_event(VK_MENU,0,KEYEVENTF_KEYUP,0);  }


// PostMessage(hwdc1,WM_KEYDOWN   ,VK_RETURN ,0);





Timer2.Enabled:=False;


end;

procedure Log(a: variant);
var
  F2: TextFile;
  FileHandle: Integer;
begin
  if not FileExists('LOG.txt') then
  begin
    FileHandle := FileCreate('LOG.txt');
    FileClose(FileHandle);
  end;

  try
    AssignFile(F2, 'LOG.txt');
    Append(F2);

    if varisnull(a) then
      WriteLn(F2, FormatDateTime('yyyy/mm/dd hh:mm:ss', now) + ':NULL')
    else if VarIsEmpty(a) then
      WriteLn(F2, FormatDateTime('yyyy/mm/dd hh:mm:ss', now) + ':EMPTY')
    else if VarIsClear(a) then
      WriteLn(F2, FormatDateTime('yyyy/mm/dd hh:mm:ss', now) + ':CLEAR')
    else
      WriteLn(F2, FormatDateTime('yyyy/mm/dd hh:mm:ss', now) + ':' + vartostr(a));

    Flush(F2);
  finally
    CloseFile(F2);
  end;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
log(Key);
//
//
end;




 

end.

