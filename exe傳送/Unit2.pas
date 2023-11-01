unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  RemoteHost: String;
  SW: String;
  Port: String;
  ServerClient: String;
  exeAnsiChar: PAnsiChar;

begin

  ServerClient := ' Client';

  RemoteHost := '192.168.0.29';
  Port := ' 17820';
  SW := ' True';

  exeAnsiChar := PAnsiChar
    (AnsiString('..\vcTalkNow.exe ' + RemoteHost + Port + SW + ServerClient));

  WinExec(exeAnsiChar, SW_SHOW);
  // WinExec('vcTalkNow.exe '+ RemoteHost, SW_SHOW);
end;

end.
