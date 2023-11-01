unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;

    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


function EnumChildProc(hwnd: HWND; lParam: LPARAM): BOOL; stdcall; //¦^ˆ`¨ç‡Û
begin
  TMemo(lParam).Lines.Add(IntToStr(hwnd)); //hwnd´N¬O¤lµ¡Ê^ªº¥y¬`
  Result := True;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  EnumChildWindows(Handle, @EnumChildProc, Integer(Memo1)); //@¬O¨ú«üƒáªº¦a§}¡ALIKE Addr()
end;


end.
 