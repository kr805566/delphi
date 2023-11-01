program Project2;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  AVICAP in 'AVICAP.PAS';

{$R *.res}

begin
  Application.Initialize;
 
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
