unit DataModule;

interface

uses
  SysUtils, Classes, DB, DBAccess, MSAccess, MemDS, Forms, OLEDBAccess, MemData, IniFiles;

type
  TDataModule1 = class(TDataModule)
    MSConnection1: TMSConnection;
    MSConnection2: TMSConnection;
    procedure DataModuleDestroy(Sender: TObject);
    procedure MSConnection1BeforeConnect(Sender: TObject);
    procedure MSConnection1AfterConnect(Sender: TObject);
    procedure MSConnection1AfterDisconnect(Sender: TObject);
    procedure MSConnection1Error(Sender: TObject; E: EDAError;
      var Fail: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure MSConnection2BeforeConnect(Sender: TObject);
    procedure MSConnection2Error(Sender: TObject; E: EDAError;
      var Fail: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;
  gconnect: boolean;

implementation
uses Unit1;

{$R *.dfm}

function GetContext(const AIniFilename, str: string): string;
var
  FIniFile: TIniFile;
  s: string;
const
  Context = 'DB';
begin
  if not FileExists(AIniFilename) then exit;

  FIniFile := TIniFile.Create(AIniFilename);
  try
    with FIniFile do
    begin
      s := trim(ReadString(Context, str, ''));
    end;
    Result := s;
  finally
    FIniFile.Free;
  end;
end;

procedure TDataModule1.DataModuleDestroy(Sender: TObject);
begin
  MSConnection1.Close;
end;

procedure TDataModule1.MSConnection1BeforeConnect(Sender: TObject);
var
  apath: string;
  s: string;
begin
  aPath := ExtractFilePath(Application.EXEName);
  MSConnection1.Close;
  MSConnection1.LoginPrompt := false;
  MSConnection1.Database := GetContext(aPath + 'SYSAP.INI', 'Database');
  MSConnection1.Password := '11031103';
  MSConnection1.Server := GetContext(aPath + 'SYSAP.INI', 'Server');
  MSConnection1.Username := GetContext(aPath + 'SYSAP.INI', 'Username');

  if uppercase(GetContext(aPath + 'SYSAP.INI', 'Provider')) = '' then
    MSConnection1.Options.Provider := prAuto
  else if uppercase(GetContext(aPath + 'SYSAP.INI', 'Provider')) = 'SQLOLEDB.1' then
    MSConnection1.Options.Provider := prSQL
  else if uppercase(GetContext(aPath + 'SYSAP.INI', 'Provider')) = 'SQLNCLI.1' then
    MSConnection1.Options.Provider := prNativeClient;

  s := GetContext(aPath + 'SYSAP.INI', 'NetworkLibrary');
  if s > '' then
    MSConnection1.Options.NetworkLibrary := s;

  s := GetContext(aPath + 'SYSAP.INI', 'ConnectionTimeout');
  if s > '' then
    MSConnection1.ConnectionTimeout := strtoint(s);
end;

procedure TDataModule1.MSConnection1AfterConnect(Sender: TObject);
begin
  gconnect := true;
  Form1.StatusBar1.Panels[0].Text := 'DB連線';
  Form1.StatusBar1.Panels[1].Text := '';
end;

procedure TDataModule1.MSConnection1AfterDisconnect(Sender: TObject);
begin
  gconnect := false;
  Form1.StatusBar1.Panels[0].Text := 'DB不連線';
  Form1.StatusBar1.Panels[1].Text := '';
end;

procedure TDataModule1.MSConnection1Error(Sender: TObject; E: EDAError;
  var Fail: Boolean);
begin
  Form1.StatusBar1.Panels[1].Text := 'DB1:' + e.Message;
end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  gconnect := false;
end;

procedure TDataModule1.MSConnection2BeforeConnect(Sender: TObject);
var
  apath: string;
  s: string;
begin
  aPath := ExtractFilePath(Application.EXEName);
  MSConnection2.Close;
  MSConnection2.LoginPrompt := false;
  MSConnection2.Database := 'HOTELB_PLC';
  MSConnection2.Password := '11031103';
  MSConnection2.Server := GetContext(aPath + 'SYSAP.INI', 'Server');
  MSConnection2.Username := GetContext(aPath + 'SYSAP.INI', 'Username');

  if uppercase(GetContext(aPath + 'SYSAP.INI', 'Provider')) = '' then
    MSConnection2.Options.Provider := prAuto
  else if uppercase(GetContext(aPath + 'SYSAP.INI', 'Provider')) = 'SQLOLEDB.1' then
    MSConnection2.Options.Provider := prSQL
  else if uppercase(GetContext(aPath + 'SYSAP.INI', 'Provider')) = 'SQLNCLI.1' then
    MSConnection2.Options.Provider := prNativeClient;

  s := GetContext(aPath + 'SYSAP.INI', 'NetworkLibrary');
  if s > '' then
    MSConnection2.Options.NetworkLibrary := s;

  s := GetContext(aPath + 'SYSAP.INI', 'ConnectionTimeout');
  if s > '' then
    MSConnection2.ConnectionTimeout := strtoint(s);
end;

procedure TDataModule1.MSConnection2Error(Sender: TObject; E: EDAError;
  var Fail: Boolean);
begin
  Form1.StatusBar1.Panels[1].Text := 'DB2:' + e.Message;
end;

end.

