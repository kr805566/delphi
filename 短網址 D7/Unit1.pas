unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerSocket, IdSSLOpenSSL, StrUtils, IdURI;


type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocket1: TIdSSLIOHandlerSocket;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    Edit3: TEdit;

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
var html, actionurl: string;
  //makeshort: TStringList;
  IdSSLIOHandlerSocket1: TIdSSLIOHandlerSocket;

  jsonToSend: TStringStream;
  m1,m2:Integer;
begin

  


  try
     memo1.Clear;


    actionurl := 'https://www.googleapis.com/urlshortener/v1/url?key=AIzaSyCVeMp6ItbHRiOVMC-pacsLuENhbrBdAiY';

    IdHttp1.Request.ContentType := 'application/json';

    //makeshort.Add('{"longUrl": "' + Edit1.Text + '"}');

    jsonToSend := TStringStream.Create('{"longUrl": "' + Edit2.Text + '"}');
    jsonToSend.Position := 0;



    IdSSLIOHandlerSocket1 := TIdSSLIOHandlerSocket.Create(nil);


    IdSSLIOHandlerSocket1.SSLOptions.Method := sslvTLSv1;
    IdSSLIOHandlerSocket1.SSLOptions.Mode := sslmUnassigned;
    IdSSLIOHandlerSocket1.SSLOptions.VerifyMode := [];
    IdSSLIOHandlerSocket1.SSLOptions.VerifyDepth := 0;


    IdHttp1.IOHandler := IdSSLIOHandlerSocket1;


    IdHttp1.Request.ContentType := 'application/json';
    IdHttp1.Request.Accept := 'application/json';

    // IdHTTP1.Request.ContentEncoding := 'UTF-8'; //Using this gives error 415

    html := IdHTTP1.Post(actionurl, jsonToSend);


  except on e: EIdHTTPProtocolException do
    begin
      memo1.lines.add(idHTTP1.response.ResponseText);
      memo1.lines.add(e.ErrorMessage);
    end;
  end;



  memo1.Lines.add(html);
  jsonToSend.Free;

  // makeshort.Free;


   m1 := Pos('id', html)+6;
  m2 := Pos('longUrl', html)-5;


  Edit3.Text:=AnsiMidStr(html,m1,m2-m1) ;



end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     Edit2.Text :='https://chart.googleapis.com/chart?chs=250x500&cht=qr&chl=' + Edit1.Text
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Edit1.Text:='';
Edit2.Text:='';
Edit3.Text:='';

end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if  Key= 13 then Abort;
ShowMessage(Chr(Key));
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
if  Key= #13 then
 Abort;


end;

end.

