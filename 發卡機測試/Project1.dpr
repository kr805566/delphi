program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  wsc32 in 'T:\wsc4d\APPS\wsc32.pas',
  keycode in 'T:\wsc4d\APPS\keycode.pas',
  xUtils in 'T:\delphi\XUTILS.PAS';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
