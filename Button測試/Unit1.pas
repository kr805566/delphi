unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DateUtils, DB, MemDS, DBAccess, MSAccess, Mask,
  ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    MaskEdit1: TMaskEdit;
    Panel1: TPanel;
    Button4: TButton;
    Edit1: TEdit;
    Button5: TButton;
    Button6: TButton;
    Edit2: TEdit;
    Button7: TButton;
    Edit3: TEdit;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    But1: TButton;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
uses Clipbrd;


procedure TForm1.Button1Click(Sender: TObject);
var
  A: array[1..100] of TButton;
begin
  A[1] := TButton.Create(Self);

  A[1].Parent := Self;
  A[1].Top := 100;
  A[1].Left := 100;
  A[1].Width := 100;
  A[1].Height := 100;



end;

procedure TForm1.Button2Click(Sender: TObject);
var
  I: Integer;
begin

  for i := 1 to 2 do
  begin
    TButton(FindComponent('Button' + IntToStr(i))).Caption := '變更';
  end;

end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Time1: TDateTime;
  M, n: Integer;
  status: PAnsiChar;
begin

  N := 5;
  M := 5 - (5 - N mod 5) mod 5;
  //SHOWMESSAGE(INTTOSTR(M));
  GetMem(status, 3);

  status[1] := #$80;
  N := integer(status[1]);
  ShowMessage(IntToStr(DayofWeek(now) - 1));


  ShowMessage(IntToStr(integer(status[1])));

  ShowMessage(FormatDateTime('yyyy/mm/dd hh:nn:ss', IncHour(Now, 15)));
  Time1 := IncHour(now, -9);
  ShowMessage(FormatDateTime('yyyy/mm/dd hh:nn:ss', Time1));

  ShowMessage(IntToStr(-13 mod 7));
  ShowMessage(FormatDateTime('ddd', now));

  Time1 := StrToDate('2017/05/11') + StrToTime('10:20:30');
  ShowMessage(FormatDateTime('eeee/mm/dd hh:nn:ss', Time1));



end;





























































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































procedure TForm1.Button4Click(Sender: TObject);
begin

  TEdit(TPanel(Tbutton(Sender).Parent).FindChildControl('Edit1')).Text := '20';

end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  try
    try
      try
        Abort;
      finally
        ShowMessage('finally 1');
      end;
    except
      ShowMessage('except 1');
      Abort;
    end;
  except
    try
      try
        ShowMessage('except 2');
        Abort;
      except
        ShowMessage('except 3');
        Abort;
      end;
    finally
      ShowMessage('finally 2');
    end;
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
ShowMessage(IntToStr(Not 3));
  try
    try
      ShowMessage('try 1');
      Abort;
    except
      ShowMessage('except 1');
    end;
  finally
    ShowMessage('finally 1');
  end;

  try
    try
      ShowMessage('try 2');
      Abort;
    finally
      ShowMessage('finally 2');
    end;

  except
    ShowMessage('except 2');

  end;

end;


procedure TForm1.Button7Click(Sender: TObject);
begin
Edit2.CopyToClipboard;//將 Edit1 的文字複製到剪貼簿
  Clipboard.AsText := Edit2.Text;
  Edit3.PasteFromClipboard;//將剪貼簿內容複製到 Edit2
  Clipboard.Clear;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
// form1.WindowState := wsNormal;
//  form1.BringToFront;

SendMessage(application.Handle, WM_SYSCOMMAND,SC_RESTORE,0); 


 // SetWindowPos (form1.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE Or SWP_NOMOVE) ;
 //SetWindowPos obj.hwnd, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOSIZE Or SWP_NOMOVE 
end;

end.

