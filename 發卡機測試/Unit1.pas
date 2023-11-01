unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, wsc32, keycode, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    StatusBar1: TStatusBar;
    Button2: TButton;
    Edit1: TEdit;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    GroupBox1: TGroupBox;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    procedure ButtonEnabled();
    procedure ReadCardButtonEnabled();
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
    p_comport: boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

function k2244c_Open(port: integer; baudrate: integer): Integer; stdcall; external 'ewtk2244.dll';
function k2244c_IssueCard(position: integer): Integer; stdcall; external 'ewtk2244.dll';
function k2244c_Close(): Integer; stdcall; external 'ewtk2244.dll';
function k2244c_MoveCard(position: integer): Integer; stdcall; external 'ewtk2244.dll';
function k2244c_ClearError(): Integer; stdcall; external 'ewtk2244.dll';

function E680_Open_ComPort(port: Integer): Integer; stdcall; external '680api.dll';
function E680_Close_ComPort(): Integer; stdcall; external '680api.dll';
function E680_Request_CardSN(serial: PAnsiChar): Integer; stdcall; external '680api.dll';




implementation

{$R *.dfm}

uses xUtils;

procedure TForm1.ReadCardButtonEnabled();
begin
  Button7.Enabled := not Button7.Enabled;
  Button8.Enabled := not Button8.Enabled;
  Button9.Enabled := not Button9.Enabled;
end;

procedure TForm1.ButtonEnabled();
begin
  Button1.Enabled := not Button1.Enabled;
  Button2.Enabled := not Button2.Enabled;
  Button3.Enabled := not Button3.Enabled;
  Button4.Enabled := not Button4.Enabled;
  Button5.Enabled := not Button5.Enabled;
  Button6.Enabled := not Button6.Enabled;



end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Text := '1';
  Edit2.Text := '4';
  Edit3.Text := '';
  p_comport := false;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  rtn: integer;
begin
  if p_comport = false then exit;
  rtn := k2244c_IssueCard(2);
  if rtn = 1 then
    StatusBar1.Panels[1].Text := 'Success'
  else if rtn = 2 then
    StatusBar1.Panels[1].Text := 'Card jammed (at Dispenser portion)'
  else
    StatusBar1.Panels[1].Text := 'Card jammed (at Feeder portion)';
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  port: integer;
  baudrate: integer;
  rtn: integer;
begin
  ButtonEnabled();
  if p_comport = true then exit;
  port := StrToInt(Edit1.Text);
  baudrate := 1;
  rtn := k2244c_Open(port, baudrate);
  if rtn = 1 then
  begin
    p_comport := true;
    StatusBar1.Panels[1].Text := 'Success';
  end
  else
  begin
    p_comport := false;
    StatusBar1.Panels[1].Text := 'Fail';
  end;
  StatusBar1.Panels[0].Text := 'RS232 OPEN'
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  rtn: integer;
begin
  ButtonEnabled();
  rtn := k2244c_Close();
  if rtn = 1 then
  begin
    p_comport := false;
    StatusBar1.Panels[1].Text := 'Success'
  end
  else
  begin
    p_comport := true;
    StatusBar1.Panels[1].Text := 'Fail';
  end;
  StatusBar1.Panels[0].Text := 'RS232 CLOSE'
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  rtn: integer;
  position: integer;
begin
  if p_comport = false then exit;
  position := 5;
  rtn := k2244c_MoveCard(position);

  if rtn = 1 then
    StatusBar1.Panels[1].Text := 'Success'
  else if rtn = 2 then
    StatusBar1.Panels[1].Text := 'Dispenser portion motor jammed'
  else
    StatusBar1.Panels[1].Text := 'Feeder portion motor jammed';
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  rtn: integer;
  position: integer;
begin
  if p_comport = false then exit;
  position := 7;
  rtn := k2244c_MoveCard(position);

  if rtn = 1 then
    StatusBar1.Panels[1].Text := 'Success'
  else if rtn = 2 then
    StatusBar1.Panels[1].Text := 'Dispenser portion motor jammed'
  else
    StatusBar1.Panels[1].Text := 'Feeder portion motor jammed';
end;



procedure TForm1.Button6Click(Sender: TObject);
var
  rtn: integer;
begin
  if p_comport = false then exit;
  rtn := k2244c_ClearError();
  if rtn = 1 then
    StatusBar1.Panels[1].Text := 'Success'
  else
    StatusBar1.Panels[1].Text := 'Fail';
end;


procedure TForm1.Button7Click(Sender: TObject);
var
  port: integer;
  rtn: integer;
begin
  ReadCardButtonEnabled();
  port := StrToInt(Edit2.Text);
  rtn := E680_Open_ComPort(port);

  if rtn = 1 then
    StatusBar1.Panels[1].Text := 'Success'
  else
    StatusBar1.Panels[1].Text := 'Fail';

end;

procedure TForm1.Button8Click(Sender: TObject);
var
  rtn: integer;
begin
  ReadCardButtonEnabled();
  rtn := E680_Close_ComPort();
  if rtn = 1 then
    StatusBar1.Panels[1].Text := 'Success'
  else
    StatusBar1.Panels[1].Text := 'Fail';

end;

procedure TForm1.Button9Click(Sender: TObject);
var
  rtn: integer;
  serial: PAnsiChar;
begin
  //serial := '';
  GetMem(serial, 20);
  rtn := E680_Request_CardSN(serial);
  if rtn = 1 then
  begin
    StatusBar1.Panels[1].Text := 'Success';
    Edit3.Text := ansistring(serial);
    //Edit3.Text := string(serial);
  end
  else
    StatusBar1.Panels[1].Text := 'Fail';
   FreeMem(serial);
end;

end.

