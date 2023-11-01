program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form2},

  wsc32 in 'T:\wsc4d\APPS\wsc32.pas',
  keycode in 'T:\wsc4d\APPS\keycode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
