unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OverbyteIcsWndControl, OverbyteIcsHttpProt, StdCtrls;

type

  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    HttpCli1: THttpCli;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure HttpCli1RequestDone(Sender: TObject; RqType: THttpRequest;
      ErrCode: Word);
    procedure FormCreate(Sender: TObject);
    function MyEncodeUrl(source: string): string;
    procedure Button2Click(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


function TForm1.MyEncodeUrl(source: string): string;
var i: integer;
begin
  result := '';
  for i := 1 to length(source) do
    if not (source[i] in ['A'..'Z', 'a'..'z', '0', '1'..'9', '-', '_', '~', '.']) then
      result := result + '%' + inttohex(ord(source[i]), 2)
    else result := result + source[i];
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Data: AnsiString;
  a: string;
begin

  Edit1.Text := '0300905088';
  Edit2.Text := 'AKEY';


  Data := '';

  Memo1.Clear;

  HttpCli1.SendStream := TMemoryStream.Create;
  HttpCli1.SendStream.Write(Data[1], Length(Data));
  HttpCli1.SendStream.Seek(0, 0);
  HttpCli1.RcvdStream := TMemoryStream.Create;



  { a := '';
   a := a + 'http://192.168.0.99:1101/GatewaySvc.aspx?TxnData=%3C%3Fxml+version%3D%221.0%22%3F%3E%3CROWSET%3E+%3CROW%3E++%3CREVE-CODE%3';
   a := a + 'E0300905088%3C%2FREVE-CODE%3E++%3CACTION_COD%3EAKEY%3C%2FACTION_COD%3E++%3CIKEY_NOS%3E00000000%3C%2FIKEY_NOS%3E++%3CIKEY_SEQ';
   a := a + '%3E0%3C%2FIKEY_SEQ%3E%3CROOM_NOS%3E501%3C%2FROOM_NOS%3E++%3CCARD_UID%3E6A83D621%3C%2FCARD_UID%3E++%3CCI_DAT%3E2017%2F10%2F17+10';
   a := a + '%3A02%3A00%3C%2FCI_DAT%3E++%3CECO_DAT%3E2017%2F10%2F18+12%3A02%3A13%3C%2FECO_DAT%3E++%3CACTION_DAT%3E2017%2F10%2F17+10%3A03%3A50';
   a := a + '%3C%2FACTION_DAT%3E+%3C%2FROW%3E%3C%2FROWSET%3E&Randomstr=781359&istom=1';}

  a := '';
  a := a + '<?xml version="1.0"?>';
  a := a + '<ROWSET>';
  a := a + '<ROW>';
  a := a + '<REVE-CODE>' + Edit1.Text + '</REVE-CODE>';
  a := a + '<ACTION_COD>' + Edit2.Text + '</ACTION_COD>';
  a := a + '<IKEY_NOS></IKEY_NOS>';
  a := a + '<IKEY_SEQ></IKEY_SEQ>';
  a := a + '<ROOM_NOS>' + Edit3.Text + '</ROOM_NOS>';
  a := a + '<CARD_UID>' + Edit4.Text + '</CARD_UID>';
  a := a + '<CI_DAT>' + Edit5.Text + '</CI_DAT>';
  a := a + '<ECO_DAT>' + Edit6.Text + '</ECO_DAT>';
  a := a + '<ACTION_DAT>' + Edit7.Text + '</ACTION_DAT>';
  a := a + '</ROW>';
  a := a + '</ROWSET>';



  {a := a + '<?xml version="1.0"?>';
 a := a + '<ROWSET>';
  a := a + '<ROW>';
   a := a + '<REVE-CODE>0300905088</REVE-CODE>';
   a := a + '<ACTION_COD>AKEY</ACTION_COD>';
   a := a + '<IKEY_NOS>00000000</IKEY_NOS>';
   a := a + '<IKEY_SEQ>0</IKEY_SEQ>';
   a := a + '<ROOM_NOS>501</ROOM_NOS>';
   a := a + '<CARD_UID>6A83D621</CARD_UID>';
   a := a + '<CI_DAT>2017/10/18</CI_DAT>';
   a := a + '<ECO_DAT>2017/10/19</ECO_DAT>';
   a := a + '<ACTION_DAT>2017/10/18 08:06:43</ACTION_DAT>';
  a := a + '</ROW>';
 a := a + '</ROWSET>';}




  a := MyEncodeUrl(a);
  a := 'http://192.168.0.99:1101/GatewaySvc.aspx?TxnData=' + a + '&Randomstr=781359&istom=1';



  HttpCli1.URL := a;
  HttpCli1.ContentTypePost := 'application/x-www-form-urlencoded';
  HttpCli1.Agent := 'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; WOW64; Trident/6.0)';
  HttpCli1.Timeout := 10; //sec
  try
    HttpCli1.Post;
    //HttpCli1.Close;
  except
    on E: Exception do memo1.Lines.Add('Error2: ' + E.Message + #13);
  end;
  Close;
end;

procedure TForm1.HttpCli1RequestDone(Sender: TObject; RqType: THttpRequest;
  ErrCode: Word);
var
  Data: AnsiString; // WebServ demo send AnsiString replies
  Data2: string;
begin
  HttpCli1.SendStream.Free;
  HttpCli1.SendStream := nil;

  if ErrCode <> 0 then begin
    //RequestDone := RequestDone + 1;
    Memo1.Lines.Add('Post failed with error #' + IntToStr(ErrCode));
    HttpCli1.RcvdStream.Free;
    HttpCli1.RcvdStream := nil;
    Exit;
  end;
  if HttpCli1.StatusCode <> 200 then begin
    //RequestDone := RequestDone + 1;
    Memo1.Lines.Add('Post failed with error: ' + IntToStr(HttpCli1.StatusCode) +
      ' ' + HttpCli1.ReasonPhrase);
    HttpCli1.RcvdStream.Free;
    HttpCli1.RcvdStream := nil;
    Exit;
  end;
  Memo1.Lines.Add('Post was OK. Response was:');
  HttpCli1.RcvdStream.Seek(0, 0);
  SetLength(Data, HttpCli1.RcvdStream.Size);
  HttpCli1.RcvdStream.Read(Data[1], Length(Data));
  Memo1.Lines.Add(string(Data));
  Data2 := uppercase(trim(string(Data)));

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Text := ''; //REVE-CODE
  Edit2.Text := ''; //ACTION_COD
  Edit3.Text := ''; //ROOM_NOS
  Edit4.Text := ''; //CARD_UID
  Edit5.Text := ''; //CI_DAT
  Edit6.Text := ''; //ECO_DAT
  Edit7.Text := ''; //ACTION_DAT



  Edit3.Text := '501';
  Edit4.Text := '6A83D621';
  Edit5.Text := '2017/10/17';
  Edit6.Text := '2017/10/18';
  Edit7.Text := '2017/10/17 10:06:43';





end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Data: AnsiString;
  a: string;
begin

  Edit1.Text := '0300905188';
  Edit2.Text := 'DKEY';
  Data := '';

  Memo1.Clear;

  HttpCli1.SendStream := TMemoryStream.Create;
  HttpCli1.SendStream.Write(Data[1], Length(Data));
  HttpCli1.SendStream.Seek(0, 0);
  HttpCli1.RcvdStream := TMemoryStream.Create;



  a := '';
  a := a + '<?xml version="1.0"?>';
  a := a + '<ROWSET>';
  a := a + '<ROW>';
  a := a + '<REVE-CODE>' + Edit1.Text + '</REVE-CODE>';
  a := a + '<ACTION_COD>' + Edit2.Text + '</ACTION_COD>';
  a := a + '<IKEY_NOS></IKEY_NOS>';
  a := a + '<IKEY_SEQ></IKEY_SEQ>';
  a := a + '<ROOM_NOS>' + Edit3.Text + '</ROOM_NOS>';
    a := a + '<CARD_UID>' + Edit4.Text + '</CARD_UID>';
  a := a + '<ACTION_DAT>' + Edit7.Text + '</ACTION_DAT>';
  a := a + '</ROW>';
  a := a + '</ROWSET>';







  a := MyEncodeUrl(a);
  a := 'http://192.168.0.99:1101/GatewaySvc.aspx?TxnData=' + a + '&Randomstr=781359&istom=1';



  HttpCli1.URL := a;
  HttpCli1.ContentTypePost := 'application/x-www-form-urlencoded';
  HttpCli1.Agent := 'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; WOW64; Trident/6.0)';
  HttpCli1.Timeout := 10; //sec
  try
    HttpCli1.Post;
    //HttpCli1.Close;
  except
    on E: Exception do memo1.Lines.Add('Error2: ' + E.Message + #13);
  end;

Close;
end;

end.

