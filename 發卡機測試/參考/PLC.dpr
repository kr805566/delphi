program PLC;

uses
  ExceptionLog,
  Forms,
  Windows,
  Unit1 in 'Unit1.pas' {Form1},
  DataModule in 'DataModule.pas' {DataModule1: TDataModule},
  keycode in '..\..\..\..\..\wsc4d\APPS\keycode.pas',
  wsc32 in '..\..\..\..\..\wsc4d\APPS\wsc32.pas';

{$R *.res}

var
  AppWnd: HWND;
begin
  AppWnd := FindWindow('TApplication', '┬北╰参');
  if AppWnd <> 0 then
  begin
    if IsIconic(AppWnd) then
      ShowWindow(AppWnd, SW_RESTORE)
    else
      SetForegroundWindow(AppWnd);

    Exit;
  end;

  Application.Initialize;
  Application.Title := '┬北╰参';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

