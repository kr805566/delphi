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
  if iCode < 0 then //�ھ�SDK�����A�YiCode�p��0�A�ե�CallNextHookEx�ê�^
  begin
    Result := CallNextHookEx(hKeyHook, iCode, wParam, key);
    Exit;
  end;
  //�b���z���w�ݫ̽������~,���z�o�̽�Ctrl c,Ctrl v,ctrl x
  if ((key and WH_KEYBOARD_LL) = 0) and (GetKeyState(vk_control) < 0) and ((wParam = Ord('X')) or (wParam = Ord('V')) or (wParam = Ord('C'))) then
    //���z�̽�F1�A��񤣄㋹�A�ۤv���ݭק�
  //if ((key and WH_KEYBOARD_LL) = 0) and (GetKeyState(vk_F1) < 0) then
  begin
    Result := 1;
    Exit;
  end;
end;

//����̽�

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
//�Ѱ��̽�

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



//  Keyboard Hook �^�I��Ƥ��e 


//  Destructor 


//  ���󤺳��ˬd user �O�_ idle, 
//  if  yes ==> Ĳ�o Notify Event 
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
