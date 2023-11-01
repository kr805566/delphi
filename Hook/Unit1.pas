unit Unit1;
interface
uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls;


type TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private { Private declarations }
  public { Public declarations }
  end;
const WH_KEYBOARD_LL = $80000000;
var Form1: TForm1;
  hKeyHook: Integer;
  hKeyHookwin98: integer;

implementation

{$R *.dfm}

function KeyHook(iCode: Integer; wParam: wParam; Key: lParam): LRESULT; stdcall;
begin
  Result := 0;
  if iCode < 0 then //根據SDK說明，若iCode小於0，調用CallNextHookEx並返回
  begin
    Result := CallNextHookEx(hKeyHook, iCode, wParam, key);
    Exit;
  end;
  //在此�z�扣w需屏蔽的按�~,此�z�o屏蔽Ctrl c,Ctrl v,ctrl x
  if ((key and WH_KEYBOARD_LL) = 0) and (GetKeyState(vk_control) < 0) and ((wParam = Ord('X')) or (wParam = Ord('V')) or (wParam = Ord('C'))) then
    //此�z屏蔽F1，���韙����飽A自己按需修改
  //if ((key and WH_KEYBOARD_LL) = 0) and (GetKeyState(vk_F1) < 0) then
  begin
    Result := 1;
    Exit;
  end;
end;

//�縝瑹抻�

procedure TForm1.Button1Click(Sender: TObject);
var temp: integer;
begin
  if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then //win98
  begin
    SystemParametersInfo(Spi_screensaverrunning, 1, @temp, 0);
    hKeyHookwin98 := SetWindowsHookEx(WH_KEYBOARD, KeyHook, HInstance, 0);
  end
  else // win2000
  begin hKeyHook := SetWindowsHookEx(WH_KEYBOARD_LL, KeyHook, HInstance, 0);
  end;
end;
//解除屏蔽

procedure TForm1.Button2Click(Sender: TObject);
var temp: integer;
begin
  if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
  begin
    SystemParametersInfo(spi_screensaverrunning, 0, @temp, 0);
    UnHookWindowsHookEx(hKeyHookwin98);
    hKeyHookwin98 := 0;
  end
  else
  begin
    UnHookWindowsHookEx(hKeyHook); hKeyHook := 0;
  end;
end;



//  Keyboard Hook 回呼函數內容 


//  Destructor 


//  元件內部檢查 user 是否 idle, 
//  if  yes ==> 觸發 Notify Event 
procedure TBvIdleCheck._TimeHit(Sender: TObject); 
var 
    tNow: TDateTime; 
    nSecElapsed: integer; 
begin // [ 
    tNow=Now; 
    nSecElapsed=TimeDiffSec(tNow, s_tIoEvent); 
    if  nSecElapsed<FIdleTime then exit; 
if  Assigned(FOnIdle) then FOnIdle(Sender); 
    s_tIoEvent:=tNow; 
end; // ] TBvIdleCheck._TimeHit


end.

