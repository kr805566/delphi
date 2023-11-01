unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, Menus;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;

    procedure FormDblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button2Click(Sender: TObject);
begin
  Sleep(StrToInt(Edit1.Text) * 1000);
  Timer1.Enabled := True;
  Form2.AlphaBlend := True;

end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.FormDblClick(Sender: TObject);
begin

  Close;
end;

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 65 then
  begin
    Timer1.Enabled := False;
    Form2.AlphaBlend := False;
    Form2.FormStyle := fsNormal;

  end;

end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin

  Form2.FormStyle := fsStayOnTop;
  SetWindowPos(Application.handle, HWND_TOPMOST, 0, 0, 0, 0,
    SWP_NOSIZE Or SWP_NOMOVE);
  SetWindowPos(Application.handle, HWND_NOTOPMOST, 0, 0, 0, 0,
    SWP_NOSIZE Or SWP_NOMOVE);

end;

procedure TForm2.Button1Click(Sender: TObject);
var
  dc: hdc;
  MyCanvas: TCanVas;
  Bmp: TBitmap;
  Jpg: TJpegImage;
begin
  // application.Minimize; // 視窗最小化
  Application.ProcessMessages; // 視窗取得控制
  // 可能要delay一下，不然抓到空白東東

  Image1.Height := Form2.Height;
  Image1.Width := Form2.Width;
  Image1.Left := Form2.Width;
  Image1.Top := Form2.Height;
  Sleep(1500);
  Jpg := TJpegImage.Create;
  MyCanvas := TCanVas.Create;
  Bmp := TBitmap.Create;
  dc := getdc(0);
  try
    MyCanvas.handle := dc;

    Bmp.Width := Width;
    Bmp.Height := Height;
    Bmp.Canvas.CopyRect(Rect(0, 0, Screen.Width, Screen.Height), MyCanvas,
      Rect(0, 0, Screen.Width, Screen.Height));
    Image1.Picture.Bitmap.Assign(Bmp);
    Bmp.SaveToFile('test.Bmp');

    Jpg.Assign(Bmp);
    Jpg.Performance := jpBestQuality;
    Jpg.CompressionQuality := 30; // 你想要的壓縮品質
    Jpg.Compress;
    Jpg.SaveToFile('test.jpg');
  finally
    releasedc(0, dc);
    MyCanvas.Free;
    Bmp.Free;
  end;
  // application.Restore; // 視窗回復
end;

end.
