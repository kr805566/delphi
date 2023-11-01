unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, MemDS, DBAccess, MSAccess;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    MSConnection_local: TMSConnection;
    Edit2: TEdit;
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
  qyPara: TMSQuery;
  v: String;
  gp: array [0 .. 1024] of String;
begin
  qyPara := TMSQuery.Create(application);
  try
    qyPara.Connection := MSConnection_local;
    qyPara.SQL.text :=
      'select PANO,PAVALUE from xpara where CPNO=:CPNO order by pano';
    qyPara.ParamByName('CPNO').AsWideString := '01';
    qyPara.Open;
    qyPara.First;
    while not qyPara.eof do
    begin
      v := trim(qyPara.fieldbyname('PAVALUE').AsString);
      gp[qyPara.fieldbyname('PANO').AsInteger] := v;

      qyPara.next;
    end;
  finally
    qyPara.Close;
    qyPara.Free;
  end;

  Edit2.text := gp[StrToInt(Edit1.text)];

end;

end.
