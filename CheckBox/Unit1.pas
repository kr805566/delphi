unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Edit1: TEdit;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Label2: TLabel;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    ScrollBar1: TScrollBar;
    Button19: TButton;
    Button20: TButton;
    procedure Panel1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    function FormSize(Sender: TObject; X, Y, W, H: Integer): string;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
  private
    StartFormHeight, StartFormWidth: Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


function TForm1.FormSize(Sender: TObject; X, Y, W, H: Integer): string;
var
  ResizeW, ResizeH, ResizeS: Integer;
begin
  ResizeW := Form1.ClientWidth;
  ResizeH := Form1.ClientHeight;
  ResizeS := Round(ResizeW * 12 / StartFormWidth);

  X := Round(X * ResizeH / StartFormHeight);
  Y := Round(Y * ResizeW / StartFormWidth);

  TButton(Sender).Font.Size := ResizeS;
  TButton(Sender).Width := Round(ResizeW * W / StartFormWidth);
  TButton(Sender).Height := Round(ResizeH * H / StartFormHeight);

  TButton(Sender).Left := Round((ResizeW - TButton(Sender).Width) / 2 + X);
  TButton(Sender).Top := Round((ResizeH - TButton(Sender).Height) / 2 + Y);


end;


procedure TForm1.Panel1Click(Sender: TObject);
begin
  if Panel1.Caption = '' then
    Panel1.Caption := ' กิ'
  else
    Panel1.Caption := '';
end;


procedure TForm1.FormResize(Sender: TObject);
begin

  FormSize(Button1, -75, -50, 50, 25);
  FormSize(Button2, 0, -50, 50, 25);
  FormSize(Button3, 75, -50, 50, 25);

  FormSize(Button4, -75, 0, 50, 25);
  FormSize(Button5, 0, 0, 50, 25);
  FormSize(Button6, 75, 0, 50, 25);

  FormSize(Button7, -75, 50, 50, 25);
  FormSize(Button8, 0, 50, 50, 25);
  FormSize(Button9, 75, 50, 50, 25);

  FormSize(Button10, -75, 100, 50, 25);
  FormSize(Button11, 0, 100, 50, 25);
  FormSize(Button12, 75, 100, 50, 25);

  FormSize(Button13, -75, 150, 75, 25);
  FormSize(Button14, 75, 150, 75, 25);


  FormSize(Edit1, 0, -100, 200, 25);
  FormSize(Label2, 0, -125, 200, 25);


end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  StartFormHeight := Form1.ClientHeight;
  StartFormWidth := Form1.ClientWidth;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit1.Text := Edit1.Text + TButton(Sender).Caption;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Edit1.Text := Edit1.Text + TButton(Sender).Caption;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Edit1.Text := Edit1.Text + TButton(Sender).Caption;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Edit1.Text := Edit1.Text + TButton(Sender).Caption;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Edit1.Text := Edit1.Text + TButton(Sender).Caption;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Edit1.Text := Edit1.Text + TButton(Sender).Caption;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Edit1.Text := Edit1.Text + TButton(Sender).Caption;


end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  Edit1.Text := Edit1.Text + TButton(Sender).Caption;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  Edit1.Text := Edit1.Text + TButton(Sender).Caption;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  Edit1.Text := Copy(Edit1.Text, 1, Length(Edit1.Text) - 1);
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  Edit1.Text := '';
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  if Length(Edit1.Text) = 6 then
    Button13.Enabled := True
  else
    Button13.Enabled := False;
end;



procedure TForm1.Button14Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
ShowMessage('OK');
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
Form1.WindowState:=wsMaximized;
end;

procedure TForm1.Button16Click(Sender: TObject);
begin
Form1.WindowState:=wsNormal;
end;

procedure TForm1.Button17Click(Sender: TObject);
begin
Form1.BorderStyle:=bsNone;
end;

procedure TForm1.Button18Click(Sender: TObject);
begin
Form1.BorderStyle:= bsSizeable;
end;

procedure TForm1.Button19Click(Sender: TObject);
begin
Form1.AlphaBlend:=True;
end;

procedure TForm1.Button20Click(Sender: TObject);
begin
Form1.AlphaBlend:=False;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
Form1.AlphaBlendValue:=ScrollBar1.Position ;
end;

end.
