unit Unit1;

interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellAPI, Menus, ExtCtrls, StdCtrls, ComCtrls;
const
  WM_TRAYICON = WM_APP + 0;

type
  TForm1 = class(TForm)
    PopupMenu: TPopupMenu;
    Hello1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
   procedure MyMsg(var msg: TWMKeyDown); message WM_KEYDOWN;

    procedure FormActivate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Hello1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);


  private
    procedure WMTrayIcon(var message: TMessage); message WM_TRAYICON;
    procedure ModifyTrayIcon(Action: DWORD);









  public
  end;



var
  Form1: TForm1;




implementation


{$R *.dfm}


procedure TForm1.FormCreate(Sender: TObject);
begin
  Canvas.Font.Size := 24;
  Canvas.Font.Style := [fsBold];
  Canvas.Font.Color := clRed;
  Canvas.Brush.Color := clWhite;
end;




procedure TForm1.WMTrayIcon(var message: TMessage);
var
  MousePos: TPoint;
begin

  if message.LPARAM = WM_RBUTTONDOWN then
  begin
    SetActiveWindow(Handle);
    GetCursorPos(MousePos);
    PopupMenu.Popup(MousePos.X, MousePos.Y);
  end;
end;


procedure TForm1.MyMsg(var msg: TWMKeyDown);
var
  buf: array[0..31] of Char;
  rect: TRect;
  str: string;
begin

  GetKeyNameText(msg.KeyData, buf, Length(buf));

  str := buf;                                                                                                                                    
  rect := ClientRect;
  Canvas.FillRect(rect);
 // ShowMessage(str);
  // Canvas.TextRect(rect, str, [tfSingleLine, tfCenter, tfVerticalCenter]);
  inherited;
end;

procedure TForm1.ModifyTrayIcon(Action: DWORD);
var
  NIData: TNotifyIconData;
begin
  with NIData do
  begin
    cbSize := sizeof(TNotifyIconData);
    UID := 0;
    uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
    Wnd := Handle;
    // 若發生任何事件, 以此訊息傳遞給 Wnd 視窗
    uCallBackMessage := WM_TRAYICON;
    // 與程式本身使用同樣的圖示
    HICON := Application.Icon.Handle;
    // 提示文字與程式標題相同
    StrPCopy(szTip, 'Service');
  end;
  // 依據 Action 去新增，修改或刪除 TrayIcon
  Shell_NotifyIcon(Action, @NIData);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Application.Minimize;
  ShowWindow(Application.Handle, SW_HIDE);
  ModifyTrayIcon(NIM_ADD);
end;



procedure TForm1.Exit1Click(Sender: TObject);
begin
 ModifyTrayIcon(NIM_DELETE);
  Application.ProcessMessages;
  Application.Terminate;

end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
ShowMessage(InTToSTr(Key));
end;

procedure TForm1.Hello1Click(Sender: TObject);
begin
 ShowWindow(Application.Handle, SW_RESTORE);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
Form1.FormKeyDown;
end;

end.

