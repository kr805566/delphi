unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, MemDS, DBAccess, MSAccess, ExtCtrls, dxGDIPlusClasses,
  AppEvnts;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    MSConnection1: TMSConnection;
    MSQuery1: TMSQuery;
    TrayIcon1: TTrayIcon;
    Image1: TImage;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
begin
   Hide();
WindowState := wsMinimized;
TrayIcon1.Visible := True;
TrayIcon1.Animate := True;
TrayIcon1.ShowBalloonHint;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
id,pwd :String;

begin
MSQuery1.Open;
id := trim(uppercase(Edit1.Text));
pwd := trim(uppercase(Edit2.Text));
if MSQuery1.Locate('USNO', id, []) then
  if MSQuery1.fieldbyname('USPWD').AsString = pwd then
   ShowMessage('�n�J���\')
  else
    ShowMessage('�K�X���~')
else
  ShowMessage('���~')




end;

procedure TForm1.FormCreate(Sender: TObject);
begin

Edit1.Text := 'DBVCL';
Edit2.Text := '1103';

end;

procedure TForm1.TrayIcon1Click(Sender: TObject);



begin


   Show;
WindowState := wsNormal;
trayicon1.Visible := False;
end;


end.
