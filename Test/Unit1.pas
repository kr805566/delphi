unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, MSAccess, StdCtrls, Grids, DBGrids;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    MSConnection1: TMSConnection;
    MSQuery1: TMSQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button2: TButton;
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

procedure TForm1.Button1Click(Sender: TObject);
var i, sum: integer;
begin
  MSQuery1.Open;

  sum := 0;
  for i := 0 to (MSQuery1.RecordCount - 1) do
  begin

    Sum := Sum + (MSQuery1.FieldByName('FAAMOUNT').AsInteger);
    MSQuery1.next
  end;

  showmessage(IntToStr(Sum));
end;

end.

