unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, RzEdit, RzSpnEdt, DB, MemDS,
  DBAccess, MSAccess, Buttons, ComCtrls, wsc32, keycode, IniFiles, ExceptionLog,
  OverbyteIcsWSocket, OverbyteIcsSmtpProt, OverbyteIcsWndControl,
  OverbyteIcsHttpProt;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button4: TButton;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    RzSpinEdit2: TRzSpinEdit;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    RzSpinEdit3: TRzSpinEdit;
    RzSpinEdit4: TRzSpinEdit;
    Label6: TLabel;
    Label7: TLabel;
    Button12: TButton;
    Button13: TButton;
    Label10: TLabel;
    Label8: TLabel;
    Timer1: TTimer;
    Label3: TLabel;
    RzNumericEdit1: TRzNumericEdit;
    Label9: TLabel;
    Label15: TLabel;
    Memo1: TMemo;
    Label34: TLabel;
    MSQuery1: TMSQuery;
    Timer2: TTimer;
    Edit1: TRzNumericEdit;
    CheckBox1: TCheckBox;
    Button11: TButton;
    Timer4: TTimer;
    StatusBar1: TStatusBar;
    Label30: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Timer5: TTimer;
    Edit3: TEdit;
    Label4: TLabel;
    RadioButton1: TRadioButton;
    MSQuery3: TMSQuery;
    Button7: TButton;
    Button8: TButton;
    Timer_mail: TTimer;
    SslSmtpClient: TSslSmtpCli;
    SslContext1: TSslContext;
    MSSQL_PLC_LOG: TMSSQL;
    MSSQL_PLC_OUT: TMSSQL;
    qyPLCOUT: TMSQuery;
    Button6: TButton;
    Button5: TButton;
    Button10: TButton;
    Button22: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure RzNumericEdit1Exit(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure RzSpinEdit3Change(Sender: TObject);
    procedure RzSpinEdit4Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure StatusBar1DblClick(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3Exit(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Timer_mailTimer(Sender: TObject);
    procedure SslSmtpClientRcptToError(Sender: TObject; ErrorCode: Word;
      RcptNameIdx: Integer; var Action: TSmtpRcptToErrorAction);
    procedure SslSmtpClientRequestDone(Sender: TObject;
      RqType: TSmtpRequest; ErrorCode: Word);
    procedure SslSmtpClientSessionClosed(Sender: TObject; ErrCode: Word);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button10Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
  private
    { Private declarations }
    Port: Integer;
    FEhloCount: Integer;
    P_NOPOOLING: array[1..256] of string;
    function get_macno: integer;
  public
    { Public declarations }
    function IntToBin(Value: Longint; Digits: Integer): string;
    function CRC(Code: integer; sbuf: array of byte): Byte;
    function CRC2(Code: string): Byte;
    procedure close1;
    procedure open1;
    procedure close2;
    procedure open2;
  end;

var
  Form1: TForm1;
  count, max, min: integer;
  stat: array[0..800] of byte;
  gDebug: boolean = False; //是否 debug 模式
  psize: integer;

implementation
uses DataModule;

{$R *.dfm}

procedure Log(a: variant);
var
  F2: TextFile;
  FileHandle: Integer;
begin
  if not FileExists('LOG.txt') then
  begin
    FileHandle := FileCreate('LOG.txt');
    FileClose(FileHandle);
  end;

  try
    AssignFile(F2, 'LOG.txt');
    Append(F2);

    if varisnull(a) then
      WriteLn(F2, FormatDateTime('yyyy/mm/dd hh:mm:ss', now) + ':NULL')
    else if VarIsEmpty(a) then
      WriteLn(F2, FormatDateTime('yyyy/mm/dd hh:mm:ss', now) + ':EMPTY')
    else if VarIsClear(a) then
      WriteLn(F2, FormatDateTime('yyyy/mm/dd hh:mm:ss', now) + ':CLEAR')
    else
      WriteLn(F2, FormatDateTime('yyyy/mm/dd hh:mm:ss', now) + ':' + vartostr(a));

    Flush(F2);
  finally
    CloseFile(F2);
  end;
end;

function YesNoBox(const Msg: string; button: integer = 1): Boolean;
var
  a: string;
begin
  a := '確認';
  if button = 1 then
    result := Application.MessageBox(PChar(Msg), PChar(a), MB_ICONQUESTION
      + MB_YESNO + MB_DEFBUTTON1 + MB_TOPMOST) = IDYES
  else
    result := Application.MessageBox(PChar(Msg), PChar(a), MB_ICONQUESTION
      + MB_YESNO + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES;
end;

procedure WarBox(const Msg: string; val: Integer = 1);
begin
  Application.MessageBox(PChar(Msg), 'Warning', MB_ICONWARNING + MB_TOPMOST);
end;

procedure ErrBox(const Msg: string; val: Integer = 1);
begin
  Application.MessageBox(PChar(Msg), 'Error', MB_ICONERROR + MB_TOPMOST);
end;

function GetContext2(const AIniFilename, str: string; Context: string = 'DB'): string;
var
  FIniFile: TIniFile;
  s: string;
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

procedure LogDay(a: variant; p2: string = '');
var
  F2: TextFile;
  FileHandle: Integer;
  s, b: string;
begin
  b := ExtractFilePath(Application.EXEName) + 'LOG';
  if not DirectoryExists(b) then
    if ForceDirectories(b) = false then
    begin
      errbox('無法建立 LOG 目錄');
      exit;
    end;

  p2 := trim(p2);
  if p2 = '' then
    s := b + '\' + FormatDateTime('yyyymmdd', now) + '.txt'
  else
    s := b + '\' + FormatDateTime('yyyymmdd', now) + '_' + p2 + '.txt';

  if not FileExists(s) then
  begin
    FileHandle := FileCreate(s);
    FileClose(FileHandle);
  end;

  try
    try
      AssignFile(F2, s);
      Append(F2);

      if varisnull(a) then
        WriteLn(F2, FormatDateTime('hh:mm:ss:zzz', now) + ' NULL')
      else if VarIsEmpty(a) then
        WriteLn(F2, FormatDateTime('hh:mm:ss:zzz', now) + ' EMPTY')
      else if VarIsClear(a) then
        WriteLn(F2, FormatDateTime('hh:mm:ss:zzz', now) + ' CLEAR')
      else if trim(a) = '' then
        WriteLn(F2, FormatDateTime('hh:mm:ss:zzz', now) + ' SPACE')
      else
        WriteLn(F2, FormatDateTime('hh:mm:ss:zzz', now) + ' ' + vartostr(a));

      Flush(F2);
    finally
      CloseFile(F2);
    end;
  except
  end;
end;

procedure LogDayHex2(a: array of byte; p2: string);
var
  F2: TextFile;
  FileHandle: Integer;
  s, b, c1, c2: string;
  X: Integer;
begin
  b := ExtractFilePath(Application.EXEName) + 'LOG';
  if not DirectoryExists(b) then
    if ForceDirectories(b) = false then
    begin
      errbox('無法建立 LOG 目錄');
      exit;
    end;

  p2 := trim(p2);
  s := b + '\' + FormatDateTime('yyyymmdd', now) + '_' + p2 + '.txt';

  if not FileExists(s) then
  begin
    FileHandle := FileCreate(s);
    FileClose(FileHandle);
  end;

  try
    AssignFile(F2, s);
    Append(F2);

    for x := 0 to high(a) do
    begin
      if x = 0 then
        c1 := IntToHex(a[x], 2)
      else
        c1 := c1 + ' ' + IntToHex(a[x], 2);

      c2 := c2 + char(a[x]);
    end;
    WriteLn(F2, FormatDateTime('hh:mm:ss:zzz', now) + ' ' + c1);

    Flush(F2);
  finally
    CloseFile(F2);
  end;
end;

procedure delay(MSecs: Longword);
var
  begintime: Longword;
begin
  begintime := gettickcount;
  repeat
    application.ProcessMessages;
    sleep(1);
  until gettickcount - begintime >= MSecs;
end;

procedure LogNumber(p1: string = '');
var
  CallStackList: TStringList;
  CallStack: TEurekaStackList;
  b, a: string;
  DebugInfo: TEurekaDebugInfo;
  Addr: DWord;
  v: variant;
begin
  try
    CallStackList := TStringList.Create;
    try
      CallStack := GetCurrentCallStack;
      try
        CallStackToStrings(CallStack, CallStackList);
        b := ExtractFilePath(Application.EXEName) + 'LOG';
        if not DirectoryExists(b) then
          ForceDirectories(b);
        a := b + '\' + FormatDateTime('yyyymmdd_HHmmsszzz', now) + '_errlog.txt';
        CallStackList.SaveToFile(a);
      finally
        CallStack.Free;
      end;
    finally
      CallStackList.Free;
    end;
  except
  end;

  try
    addr := DWord(GetLastExceptionAddress);
    if GetSourceInfoByAddr(addr, @DebugInfo) then
    begin
      v := Format('%s.%s.%s.%d[%d]', [
        DebugInfo.UnitName, DebugInfo.ClassName,
          DebugInfo.ProcedureName, DebugInfo.Line,
          DebugInfo.ProcOffsetLine]);
      if p1 > '' then
        logday(p1 + ',' + v, 'errlog')
      else
        logday(v, 'errlog');
    end;
  except
  end;
end;

function TForm1.get_macno: integer;
begin
  result := 0;
  if RadioButton1.Checked then
  begin
    if trim(Edit3.Text) = '' then
    begin
      warbox('請輸入房號!!');
      abort;
    end;
    if MSQuery3.FieldByName('MACNO').AsInteger = 0 then
    begin
      warbox('PLC對照表無MACNO!!');
      abort;
    end;
    result := MSQuery3.FieldByName('MACNO').AsInteger;
  end;
end;

function TForm1.CRC(Code: integer; sbuf: array of byte): Byte;
begin
  Result := $00;
  case code of
    4:
      begin
        Result := Result xor Byte(sbuf[0]);
        Result := Result xor Byte(sbuf[1]);
        Result := Result xor Byte(sbuf[2]);
        Result := Result xor Byte(sbuf[3]);
      end;
    5:
      begin
        Result := Result xor Byte(sbuf[0]);
        Result := Result xor Byte(sbuf[1]);
        Result := Result xor Byte(sbuf[2]);
        Result := Result xor Byte(sbuf[3]);
        Result := Result xor Byte(sbuf[4]);
      end
  else
    errbox('code must between 4 and 5.');
  end;
end;

function TForm1.IntToBin(Value: Longint; Digits: Integer): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to Digits do
    if Value and (1 shl i) <> 0 then
      Result := Result + '1'
    else
      Result := Result + '0';
end;

function TForm1.CRC2(Code: string): Byte;
var i: Integer;
begin
  Result := $00;
  for i := 1 to Length(Code) do
    Result := Result xor Byte(Code[i]);
end;

procedure TForm1.close2;
begin
  Button1.Enabled := false;
  Button4.Enabled := false;
  Button7.Enabled := false;
  Button8.Enabled := false;
end;

procedure TForm1.open2;
begin
  Button1.Enabled := true;
  Button4.Enabled := true;
  Button7.Enabled := true;
  Button8.Enabled := true;
end;

procedure TForm1.close1;
begin
  Button2.Enabled := true;
  RzSpinEdit2.Enabled := true;
  Button3.Enabled := false;
  Button1.Enabled := false;
  Button4.Enabled := false;
  //Button5.Enabled := false;
  //Button6.Enabled := false;
  Button7.Enabled := false;
  Button8.Enabled := false;
  //Button7.Enabled := false;
  //Button8.Enabled := false;
  //Button9.Enabled := false;
  //Button10.Enabled := false;
  //RzSpinEdit1.Enabled := false;
  RzSpinEdit3.Enabled := false;
  RzSpinEdit4.Enabled := false;
  Edit1.Enabled := false;
  Button12.Enabled := false;
  Button13.Enabled := false;
  //Button16.Enabled := false;
  //Button17.Enabled := false;
  //Button14.Enabled := false;
  //Button15.Enabled := false;
  RzNumericEdit1.Enabled := false;
  //Edit2.Enabled := false;
  //Button19.Enabled := false;
  //Button20.Enabled := false;
  //Button21.Enabled := false;
  //Button22.Enabled := false;

  //Shape1.brush.color := clblack;
  //Shape1.Refresh;
  //Shape4.brush.color := clblack;
  //Shape4.Refresh;
end;

procedure TForm1.open1;
begin
  Button2.Enabled := false;
  Button3.Enabled := true;
  Button1.Enabled := true;
  Button4.Enabled := true;
  //Button5.Enabled := true;
  //Button6.Enabled := true;
  Button7.Enabled := true;
  Button8.Enabled := true;
  //Button7.Enabled := true;
  //Button8.Enabled := true;
  //Button9.Enabled := true;
  //Button10.Enabled := true;
  //RzSpinEdit1.Enabled := true;
  RzSpinEdit3.Enabled := true;
  RzSpinEdit4.Enabled := true;
  Edit1.Enabled := true;
  Button12.Enabled := true;
  Button13.Enabled := FALSE;
  RzSpinEdit2.Enabled := FALSE;
  //Button16.Enabled := true;
  //Button17.Enabled := true;
  //Button14.Enabled := true;
  //Button15.Enabled := true;
  RzNumericEdit1.Enabled := true;
  //Edit2.Enabled := true;
  //Button19.Enabled := true;
  //Button20.Enabled := true;
  //Button21.Enabled := true;
  //Button22.Enabled := true;

  //Shape1.brush.color := clgreen;
  //Shape1.Refresh;
  //Shape4.brush.color := clgreen;
  //Shape4.Refresh;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  sbuf: array[1..6] of byte;
  a: string;
  MACNO: integer;
  pwd: string;
begin
  a := trim(Edit3.Text);
  pwd := trim(InputBox('開鐵門', '請輸入密碼：', ''));
  if pwd = '' then exit;
  if pwd <> '1688' then
  begin
    WarBox('密碼錯誤!!');
    exit;
  end;
  if copy(a, 1, 1) <> '1' then
  begin
    warbox('房號必須為1字頭!!');
    exit;
  end;

  try
    try
      close2;
      delay(300);
      MACNO := get_macno;
      sbuf[1] := byte($A5);
      sbuf[2] := byte($00);
      sbuf[3] := MACNO;
      sbuf[4] := byte($04);
      sbuf[5] := byte($01);
      sbuf[6] := byte(CRC(5, sbuf));

      MSSQL_PLC_OUT.ParamByName('CPNO').AsString := '01';
      MSSQL_PLC_OUT.ParamByName('PODT').AsDateTime := now;
      MSSQL_PLC_OUT.ParamByName('PO1').AsInteger := sbuf[1];
      MSSQL_PLC_OUT.ParamByName('PO2').AsInteger := sbuf[2];
      MSSQL_PLC_OUT.ParamByName('PO3').AsInteger := sbuf[3];
      MSSQL_PLC_OUT.ParamByName('PO4').AsInteger := sbuf[4];
      MSSQL_PLC_OUT.ParamByName('PO5').AsInteger := sbuf[5];
      MSSQL_PLC_OUT.ParamByName('PO6').AsInteger := sbuf[6];
      MSSQL_PLC_OUT.ParamByName('kind').AsInteger := 1;
      MSSQL_PLC_OUT.Execute;
    except
      on E: Exception do
      begin
        StatusBar1.Panels[1].Text := '1:' + E.Message;
        LogNumber(E.Message);
      end;
    end;
  finally
    open2;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Code: Integer;
  Baud: Integer;
  Parity: Integer;
  DataBits: Integer;
  StopBits: Integer;
begin
  Port := strtoint(RzSpinEdit2.Text) - 1;
  Baud := WSC_Baud9600;
  Parity := WSC_NoParity;
  DataBits := WSC_WordLength8;
  StopBits := WSC_OneStopBit;
  Code := SioReset(Port, 2048, 2048);
  if Code < 0 then
  begin
    warbox(AnsiString(Format('Error %d: Cannot reset port COM%d', [Code, 1 + Port])));
    StatusBar1.Panels[0].Text := 'COM PORT Fail';
    abort;
    //exit;
  end;
  SioBaud(Port, Baud);
  SioParms(Port, Parity, StopBits, DataBits);
  open1;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  a: string;
begin
  a := inputbox('密碼', '請輸入密碼:  ', '');
  if a <> '1688' then abort;

  Timer1.Enabled := false;
  SioDone(Port);
  close1;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  sbuf: array[1..6] of byte;
  a: string;
  MACNO: integer;
  pwd: string;
begin
  a := trim(Edit3.Text);
  pwd := trim(InputBox('開鐵門', '請輸入密碼：', ''));
  if pwd = '' then exit;
  if pwd <> '1688' then
  begin
    WarBox('密碼錯誤!!');
    exit;
  end;
  if copy(a, 1, 1) <> '1' then
  begin
    warbox('房號必須為1字頭!!');
    exit;
  end;

  try
    try
      close2;
      delay(300);
      MACNO := get_macno;
      sbuf[1] := byte($A5);
      sbuf[2] := byte($00);
      sbuf[3] := MACNO;
      sbuf[4] := byte($04);
      sbuf[5] := byte($00);
      sbuf[6] := byte(CRC(5, sbuf));

      MSSQL_PLC_OUT.ParamByName('CPNO').AsString := '01';
      MSSQL_PLC_OUT.ParamByName('PODT').AsDateTime := now;
      MSSQL_PLC_OUT.ParamByName('PO1').AsInteger := sbuf[1];
      MSSQL_PLC_OUT.ParamByName('PO2').AsInteger := sbuf[2];
      MSSQL_PLC_OUT.ParamByName('PO3').AsInteger := sbuf[3];
      MSSQL_PLC_OUT.ParamByName('PO4').AsInteger := sbuf[4];
      MSSQL_PLC_OUT.ParamByName('PO5').AsInteger := sbuf[5];
      MSSQL_PLC_OUT.ParamByName('PO6').AsInteger := sbuf[6];
      MSSQL_PLC_OUT.ParamByName('kind').AsInteger := 2;
      MSSQL_PLC_OUT.Execute;
    except
      on E: Exception do
      begin
        StatusBar1.Panels[1].Text := '2:' + E.Message;
        LogNumber(E.Message);
      end;
    end;
  finally
    open2;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
  WPath: string;
begin
  Edit3.Text := '';
  Label30.Caption := '';
  Timer1.Enabled := false;
  Timer2.Enabled := false;
  Timer4.Enabled := false;
  psize := 2588;

  Memo1.Text := '';
  WPath := ExtractFilePath(Application.EXEName);

  RzSpinEdit2.Text := GetContext2(WPath + 'SYSAP.INI', 'COMPORT', 'PLC');
  RzSpinEdit3.text := GetContext2(WPath + 'SYSAP.INI', 'MACBEG', 'PLC');
  RzSpinEdit4.text := GetContext2(WPath + 'SYSAP.INI', 'MACEND', 'PLC');
  Edit1.Text := GetContext2(WPath + 'SYSAP.INI', 'POLLING', 'PLC');
  RzNumericEdit1.Text := GetContext2(WPath + 'SYSAP.INI', 'READING', 'PLC');
  min := strtoint(RzSpinEdit3.text);
  max := strtoint(RzSpinEdit4.text);
  if GetContext2(WPath + 'SYSAP.INI', 'DEBUG', 'PLC') = '1' then
    gDebug := true
  else
    gDebug := false;

  close1;

  for i := 1 to 500 do stat[i] := byte($22);

  if GetContext2(WPath + 'SYSAP.INI', 'X1', 'KIND') = '0' then
  begin
    GroupBox1.Visible := false;
  end;

  if GetContext2(WPath + 'SYSAP.INI', 'A1', 'KIND') = '0' then
  begin
    Button1.Visible := false;
    Button4.Visible := false;
    //Button14.Visible := false;
    //Button15.Visible := false;
  end;

  if GetContext2(WPath + 'SYSAP.INI', 'B1', 'KIND') = '0' then
  begin
    //Button10.Visible := false;
  end;

  if GetContext2(WPath + 'SYSAP.INI', 'C1', 'KIND') = '0' then
  begin
    //Button16.Visible := false;
    //Button17.Visible := false;
  end;
  RadioButton1Click(nil);

  //Timer_mail.Interval := 30000; //test
  Timer_mail.Interval := 300000;
  Timer_mail.Enabled := true;
  //Timer_mailTimer(nil); //test
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled := false;
  Timer2.Enabled := false;
  Timer4.Enabled := false;

  delay(1000);
  SioDone(Port);
  if DataModule1.MSConnection1.Connected = true then
    DataModule1.MSConnection1.Connected := false;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  SioKeyCode(WSC_KEY_CODE);
  DataModule1 := TDataModule1.create(application);
  try
    if GetContext2(ExtractFilePath(Application.EXEName) + 'SYSAP.INI', 'Database', 'DB') > '' then
    begin
      DataModule1.MSConnection1.Open;
      MSQuery1.Open;
    end;
  except
  end;
  Button6Click(nil); //march add 1051017
  Button2Click(nil);
  Button12Click(nil);
  Timer4.Enabled := TRUE;
  //Timer4Timer(nil);
end;

procedure TForm1.RzNumericEdit1Exit(Sender: TObject);
var a, b, s: string;
  i: integer;
begin
  b := '';
  s := RzNumericEdit1.Text;
  for i := 1 to length(s) do
  begin
    a := copy(s, i, 1);
    if a = ',' then continue;
    b := b + a;
  end;

  if strtoint(b) >= strtoint(Edit1.text) then
  begin
    //showmessage('讀取資料 必須小於 詢問周期。');
    //RzNumericEdit1.Text := '10';
    //exit;
  end;
end;

procedure TForm1.Button12Click(Sender: TObject);
var
  a, b: integer;
begin
  a := strtoint(RzSpinEdit3.text);
  b := strtoint(RzSpinEdit4.text);
  if b < a then
  begin
    Timer1.Enabled := false;
    Button12.Enabled := true;
    Button13.Enabled := false;
    errbox('機台的截止數必須大於開始數。');
    exit;
  end;

  min := a;
  count := min;
  max := b;
  RzSpinEdit3.Enabled := false;
  RzSpinEdit4.Enabled := false;
  Button12.Enabled := false;
  Button13.Enabled := true;
  Edit1.Enabled := false;
  RzNumericEdit1.Enabled := false;

  Timer1.Interval := 200;
  //Timer1.Interval := 800; //march edit 1060818
  //Timer1.Interval := 500; //march edit 1060818
  //Timer1.Interval := 300; //march edit 1051026
  Timer1.Enabled := true;

  Timer2.Enabled := true;
end;

procedure TForm1.Button13Click(Sender: TObject);
var
  a: string;
begin
  a := inputbox('密碼', '請輸入密碼:  ', '');
  if a <> '1688' then abort;

  Timer1.Enabled := false;
  Timer2.Enabled := false;
  Button12.Enabled := true;
  Button13.Enabled := false;
  RzSpinEdit3.Enabled := true;
  RzSpinEdit4.Enabled := true;
  Edit1.Enabled := true;
  RzNumericEdit1.Enabled := true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  sbuf: array[1..6] of byte;
  revp: array[1..1024] of byte;
  count2: integer;
  Code: integer;
  s: string;
  j: integer;
  pcl_in, pcl: string;
  MACNO: integer;
  rmno: string;
  kind: integer;
  qty: integer;
begin
  if gconnect = false then exit;
  Timer1.Enabled := false;
  try
    try
      qyPLCOUT.Close;
      qyPLCOUT.Open;
      qty := qyPLCOUT.RecordCount;
      while not qyPLCOUT.Eof do
      begin
        if qyPLCOUT.FieldByName('PO1').AsInteger = 0 then
        begin
          qyPLCOUT.edit;
          qyPLCOUT['POFLAG'] := 'Y';
          qyPLCOUT.Post;

          qyPLCOUT.Next;
          continue;
        end;

        kind := qyPLCOUT.FieldByName('kind').AsInteger;
        sbuf[1] := qyPLCOUT.FieldByName('PO1').AsInteger;
        sbuf[2] := qyPLCOUT.FieldByName('PO2').AsInteger;
        sbuf[3] := qyPLCOUT.FieldByName('PO3').AsInteger;
        sbuf[4] := qyPLCOUT.FieldByName('PO4').AsInteger;
        sbuf[5] := qyPLCOUT.FieldByName('PO5').AsInteger;
        sbuf[6] := qyPLCOUT.FieldByName('PO6').AsInteger;
        sleep(50);
        SioTxClear(Port);
        code := SioPuts(Port, @sbuf, 6);
        sleep(500);

        s := '';
        for j := 1 to 6 do
        begin
          s := s + IntToHex(sbuf[j], 2) + ' ';
        end;
        logday('1: ' + s, 'Timer1Timer');
        if sbuf[3] = 27 then
          logday('1: ' + s, 'Timer1Timer2');

        MSSQL_PLC_LOG.ParamByName('A1').AsInteger := sbuf[1];
        MSSQL_PLC_LOG.ParamByName('A2').AsInteger := sbuf[2];
        MSSQL_PLC_LOG.ParamByName('A3').AsInteger := sbuf[3];
        MSSQL_PLC_LOG.ParamByName('A4').AsInteger := sbuf[4];
        MSSQL_PLC_LOG.ParamByName('A5').AsInteger := sbuf[5];
        MSSQL_PLC_LOG.ParamByName('A6').AsInteger := sbuf[6];
        MSSQL_PLC_LOG.ParamByName('KIND').AsInteger := kind;
        MSSQL_PLC_LOG.Execute;

        if Code < 0 then
        begin
          logday('SioPuts ERROR:' + inttostr(Code), 'Timer1Timer');
          exit;
        end;

        if (kind = 5) or (kind = 6) then //預冷關
          stat[sbuf[3]] := byte($11)
        else if (kind = 3) or (kind = 4) then //預冷開
          stat[sbuf[3]] := byte($66);

        Code := SioRxQue(Port);
        if code > 0 then
        begin
          SioGets(Port, @revp, Code);
          MSSQL_PLC_LOG.ParamByName('A1').AsInteger := revp[1];
          MSSQL_PLC_LOG.ParamByName('A2').AsInteger := revp[2];
          MSSQL_PLC_LOG.ParamByName('A3').AsInteger := revp[3];
          MSSQL_PLC_LOG.ParamByName('A4').AsInteger := revp[4];
          MSSQL_PLC_LOG.ParamByName('A5').AsInteger := revp[5];
          MSSQL_PLC_LOG.ParamByName('A6').AsInteger := revp[6];
          MSSQL_PLC_LOG.ParamByName('KIND').AsInteger := kind;
          MSSQL_PLC_LOG.Execute;

          s := '';
          for j := 1 to Code do
          begin
            s := s + IntToHex(revp[j], 2) + ' ';
          end;
          logday('2: ' + s, 'Timer1Timer');
          if revp[2] = 27 then
            logday('2: ' + s, 'Timer1Timer2');
        end;

        qyPLCOUT.edit;
        qyPLCOUT['POFLAG'] := 'Y';
        qyPLCOUT.Post;

        qyPLCOUT.Next;
      end;
      if qty > 0 then exit;

      ///////////////////////////////////////////////////////////////////////////////

      sbuf[1] := byte($A5);
      sbuf[2] := byte($00);
      sbuf[3] := byte(chr(count));
      count2 := count;
      sbuf[4] := byte($03);

      if (count >= 1) and (count <= 7) then
        sbuf[5] := byte($11)
      else
      begin
        if stat[sbuf[3]] = byte($66) then
          sbuf[5] := byte($66)
        else
        begin
          if stat[sbuf[3]] = byte($22) then
            sbuf[5] := byte($22)
          else
            sbuf[5] := byte($11);
          //sbuf[5] := byte($11); //OK，冷氣可以關，但造成rcu當機?
          //sbuf[5] := byte($22); //OK，但有時冷氣無法關?
        end;
      end;
      sbuf[6] := byte(CRC(5, sbuf));

      if not ((P_NOPOOLING[count] = '0')) then
      begin
        sleep(50);
        SioTxClear(Port);
        Code := SioPuts(Port, @sbuf, 6);
        sleep(500);

        MSSQL_PLC_LOG.ParamByName('A1').AsInteger := sbuf[1];
        MSSQL_PLC_LOG.ParamByName('A2').AsInteger := sbuf[2];
        MSSQL_PLC_LOG.ParamByName('A3').AsInteger := sbuf[3];
        MSSQL_PLC_LOG.ParamByName('A4').AsInteger := sbuf[4];
        MSSQL_PLC_LOG.ParamByName('A5').AsInteger := sbuf[5];
        MSSQL_PLC_LOG.ParamByName('A6').AsInteger := sbuf[6];
        MSSQL_PLC_LOG.ParamByName('KIND').AsInteger := 7;
        MSSQL_PLC_LOG.Execute;

        s := '';
        for j := 1 to 6 do
        begin
          s := s + IntToHex(sbuf[j], 2) + ' ';
        end;
        logday('3: ' + s, 'Timer1Timer');
        if sbuf[3] = 27 then
          logday('3: ' + s, 'Timer1Timer2');

        if Code < 0 then
        begin
          Memo1.Lines.Add('SioPuts ERROR:' + inttostr(Code) + ' ' + inttostr(count2));
          logday('SioPuts ERROR:' + inttostr(Code) + ' ' + inttostr(count2), 'PLC01LOG');
          count := count + 1;
          if count > max then count := min;
          exit;
        end;
      end
      else
      begin
        count := count + 1;
        if count > max then count := min;
        exit;
      end;

      count := count + 1;
      if count > max then count := min;
      Label30.Caption := inttostr(count2);
      Label30.Repaint;

      Code := SioRxQue(Port);
      if Code < 0 then
      begin
        Memo1.Lines.Add('SioRxQue ERROR:' + inttostr(Code) + ' ' + inttostr(count2));
        logday('SioRxQue ERROR:' + inttostr(Code) + ' ' + inttostr(count2), 'PLC01LOG');
        exit;
      end;
      if code <> 6 then
      begin
        Memo1.Lines.Add('Len ERROR:' + inttostr(Code) + ' ' + inttostr(count2));
        logday('LEN ERROR:' + inttostr(Code) + ' ' + inttostr(count2), 'PLC01LOG');

        code := SioGets(Port, @revp, Code);
        if code < 0 then
        begin
          Memo1.Lines.Add('SioGets ERROR:' + inttostr(Code) + ' ' + inttostr(count2));
          logday('SioGets ERROR:' + inttostr(Code) + ' ' + inttostr(count2), 'PLC01LOG');
          exit;
        end;
        s := '';
        for j := 1 to Code do
        begin
          s := s + IntToHex(revp[j], 2) + ' ';
        end;
        if s > '' then
          LOGday(s, 'PLC01LOG');
        exit;
      end;

      Code := SioGets(Port, @revp, Code);
      if code < 0 then
      begin
        Memo1.Lines.Add('SioGets ERROR:' + inttostr(Code) + ' ' + inttostr(count2));
        logday('SioGets ERROR:' + inttostr(Code) + ' ' + inttostr(count2), 'PLC01LOG');
        exit;
      end;

      MSSQL_PLC_LOG.ParamByName('A1').AsInteger := revp[1];
      MSSQL_PLC_LOG.ParamByName('A2').AsInteger := revp[2];
      MSSQL_PLC_LOG.ParamByName('A3').AsInteger := revp[3];
      MSSQL_PLC_LOG.ParamByName('A4').AsInteger := revp[4];
      MSSQL_PLC_LOG.ParamByName('A5').AsInteger := revp[5];
      MSSQL_PLC_LOG.ParamByName('A6').AsInteger := revp[6];
      MSSQL_PLC_LOG.ParamByName('KIND').AsInteger := 7;
      MSSQL_PLC_LOG.Execute;

      s := '';
      for j := 1 to Code do
      begin
        s := s + IntToHex(revp[j], 2) + ' ';
      end;
      logday('4: ' + s, 'Timer1Timer');
      if revp[2] = 27 then
        logday('4: ' + s, 'Timer1Timer2');

      MACNO := revp[2];
      pcl_in := IntToBin(revp[3], 7) + IntToBin(revp[4], 7);
      pcl :=
        copy(pcl_in, 1, 1) + ' ' +
        copy(pcl_in, 2, 1) + ' ' +
        copy(pcl_in, 3, 1) + ' ' +
        copy(pcl_in, 4, 1) + ' ' +
        copy(pcl_in, 5, 1) + ' ' +
        copy(pcl_in, 6, 1) + ' ' +
        copy(pcl_in, 7, 1) + ' ' +
        copy(pcl_in, 8, 1) + '    ' +
        copy(pcl_in, 9, 1) + ' ' +
        copy(pcl_in, 10, 1) + ' ' +
        copy(pcl_in, 11, 1) + ' ' +
        copy(pcl_in, 12, 1) + ' ' +
        copy(pcl_in, 13, 1) + ' ' +
        copy(pcl_in, 14, 1) + ' ' +
        copy(pcl_in, 15, 1) + ' ' +
        copy(pcl_in, 16, 1);

      if copy(pcl_in, 4, 1) = '1' then
        stat[sbuf[3]] := byte($22);

      rmno := '';
      if MSQuery1.Locate('MACNO', MACNO, []) then
      begin
        rmno := MSQuery1.FieldByName('rmno').AsString;
        MSQuery1.Edit;
        MSQuery1['A2'] := copy(pcl_in, 2, 1); //插卡
        MSQuery1['A4'] := copy(pcl_in, 4, 1); //用電
        MSQuery1['A5'] := copy(pcl_in, 5, 1); //鐵門
        //MSQuery1['A8'] := copy(pcl_in, 6, 1); //SOS
        MSQuery1['A3'] := copy(pcl_in, 3, 1); //冷氣
        MSQuery1['A10'] := copy(pcl_in, 10, 1); //勿擾
        MSQuery1['A9'] := copy(pcl_in, 9, 1); //clean
        MSQuery1.Post;
      end;

      if MACNO <= 9 then
        pcl := '  ' + inttostr(MACNO) + ' ' + pcl
      else if revp[2] <= 99 then
        pcl := ' ' + inttostr(MACNO) + ' ' + pcl
      else
        pcl := inttostr(MACNO) + ' ' + pcl;
      if CheckBox1.Checked = true then
      begin
        Memo1.Lines.Add(pcl + ' ' + rmno);
      end;
    except
      on E: Exception do
      begin
        StatusBar1.Panels[1].Text := '5:' + E.Message;
        LogNumber(E.Message);
        if pos(E.Message, 'Cannot perform this operation on a closed dataset') > 0 then
        begin
          DataModule1.MSConnection1.Close;
          DataModule1.MSConnection1.Open;
          MSQuery1.Close;
          MSQuery1.Open;
        end;
      end;
    end;
  finally
    Timer1.Enabled := true;
  end;
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', #8]) then Key := #0;
end;

procedure TForm1.RzSpinEdit3Change(Sender: TObject);
begin
  min := strtoint(RzSpinEdit3.text);
  max := strtoint(RzSpinEdit4.text);
end;

procedure TForm1.RzSpinEdit4Change(Sender: TObject);
begin
  min := strtoint(RzSpinEdit3.text);
  max := strtoint(RzSpinEdit4.text);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  MSQuery1.Close;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  if CheckBox1.Checked = true then
    Memo1.Lines.Clear;
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  Memo1.Text := '';
end;

procedure TForm1.Timer4Timer(Sender: TObject);
begin
  try
    try
      if GetContext2(ExtractFilePath(Application.EXEName) + 'SYSAP.INI', 'Database', 'DB') > '' then
      begin
        DataModule1.MSConnection1.Open;
        MSQuery1.Open;
      end;
    except
      on E: Exception do
      begin
        StatusBar1.Panels[1].Text := E.Message;
        LogNumber(E.Message);
      end;
    end;
  finally
    Timer4.Enabled := false;
  end;
end;

procedure TForm1.Timer5Timer(Sender: TObject);
var
  s: string;
  MSSQL1: TMSSQL;
begin
  s := GetContext2(ExtractFilePath(Application.EXEName) + 'SYSAP.INI', 'Database', 'DB');
  if s > '' then
  begin
    MSSQL1 := TMSSQL.Create(application);
    try
      try
        MSSQL1.SQL.Text := 'SELECT GETDATE()';
        MSSQL1.Connection := DataModule1.MSConnection1;
        MSSQL1.CommandTimeout := 3;
        MSSQL1.NonBlocking := True;
        MSSQL1.Execute;
      except
        on E: Exception do
        begin
          StatusBar1.Panels[1].Text := E.Message;
          LogNumber(E.Message);
        end;
      end;
    finally
      MSSQL1.Free;
    end;
  end;
end;

procedure TForm1.StatusBar1DblClick(Sender: TObject);
begin
  StatusBar1.Panels[1].Text := '';
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  Edit3.Color := clWindow;
  Edit3.Enabled := true;
  //RzSpinEdit1.Color := clBtnFace;
  //RzSpinEdit1.Enabled := false;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
  Edit3.Color := clBtnFace;
  Edit3.Enabled := false;
  //RzSpinEdit1.Color := clWindow;
  //RzSpinEdit1.Enabled := true;
end;

procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', #8]) then
    Key := #0;
end;

procedure TForm1.Edit3Exit(Sender: TObject);
var
  a: string;
begin
  a := trim(Edit3.Text);
  if a = '' then exit;
  MSQuery3.close;
  MSQuery3.ParamByName('p1').Value := a;
  MSQuery3.open;
  if MSQuery3.RecordCount = 0 then
  begin
    warbox('無此房號!!');
    Edit3.Text := '';
    exit;
  end;
  if MSQuery3.FieldByName('MACNO').AsInteger = 0 then
  begin
    warbox('PLC對照表無MACNO!!');
    Edit3.Text := '';
    exit;
  end;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  sbuf: array[1..6] of byte;
  a: string;
  MACNO: integer;
begin
  try
    try
      close2;
      delay(300);
      MACNO := get_macno;
      a := trim(Edit3.Text);

      if copy(a, 1, 1) = '1' then
      begin
        sbuf[1] := byte($A5);
        sbuf[2] := byte($00);
        sbuf[3] := MACNO;
        sbuf[4] := byte($09);
        sbuf[5] := byte($01);
        sbuf[6] := byte(CRC(5, sbuf));

        MSSQL_PLC_OUT.ParamByName('CPNO').AsString := '01';
        MSSQL_PLC_OUT.ParamByName('PODT').AsDateTime := now;
        MSSQL_PLC_OUT.ParamByName('PO1').AsInteger := sbuf[1];
        MSSQL_PLC_OUT.ParamByName('PO2').AsInteger := sbuf[2];
        MSSQL_PLC_OUT.ParamByName('PO3').AsInteger := sbuf[3];
        MSSQL_PLC_OUT.ParamByName('PO4').AsInteger := sbuf[4];
        MSSQL_PLC_OUT.ParamByName('PO5').AsInteger := sbuf[5];
        MSSQL_PLC_OUT.ParamByName('PO6').AsInteger := sbuf[6];
        MSSQL_PLC_OUT.ParamByName('kind').AsInteger := 3;
        MSSQL_PLC_OUT.Execute;
      end
      else
      begin
        sbuf[1] := byte($A5);
        sbuf[2] := byte($00);
        sbuf[3] := MACNO;
        sbuf[4] := byte($03);
        sbuf[5] := byte($66);
        sbuf[6] := byte(CRC(5, sbuf));

        MSSQL_PLC_OUT.ParamByName('CPNO').AsString := '01';
        MSSQL_PLC_OUT.ParamByName('PODT').AsDateTime := now;
        MSSQL_PLC_OUT.ParamByName('PO1').AsInteger := sbuf[1];
        MSSQL_PLC_OUT.ParamByName('PO2').AsInteger := sbuf[2];
        MSSQL_PLC_OUT.ParamByName('PO3').AsInteger := sbuf[3];
        MSSQL_PLC_OUT.ParamByName('PO4').AsInteger := sbuf[4];
        MSSQL_PLC_OUT.ParamByName('PO5').AsInteger := sbuf[5];
        MSSQL_PLC_OUT.ParamByName('PO6').AsInteger := sbuf[6];
        MSSQL_PLC_OUT.ParamByName('kind').AsInteger := 4;
        MSSQL_PLC_OUT.Execute;
      end;
    except
      on E: Exception do
      begin
        StatusBar1.Panels[1].Text := '3:' + E.Message;
        LogNumber(E.Message);
      end;
    end;
  finally
    open2;
  end;
end;

procedure TForm1.Button8Click(Sender: TObject);
var
  sbuf: array[1..6] of byte;
  a: string;
  MACNO: integer;
begin
  try
    try
      close2;
      delay(300);
      MACNO := get_macno;
      a := trim(Edit3.Text);

      if copy(a, 1, 1) = '1' then
      begin
        sbuf[1] := byte($A5);
        sbuf[2] := byte($00);
        sbuf[3] := MACNO;
        sbuf[4] := byte($09);
        sbuf[5] := byte($00);
        sbuf[6] := byte(CRC(5, sbuf));

        MSSQL_PLC_OUT.ParamByName('CPNO').AsString := '01';
        MSSQL_PLC_OUT.ParamByName('PODT').AsDateTime := now;
        MSSQL_PLC_OUT.ParamByName('PO1').AsInteger := sbuf[1];
        MSSQL_PLC_OUT.ParamByName('PO2').AsInteger := sbuf[2];
        MSSQL_PLC_OUT.ParamByName('PO3').AsInteger := sbuf[3];
        MSSQL_PLC_OUT.ParamByName('PO4').AsInteger := sbuf[4];
        MSSQL_PLC_OUT.ParamByName('PO5').AsInteger := sbuf[5];
        MSSQL_PLC_OUT.ParamByName('PO6').AsInteger := sbuf[6];
        MSSQL_PLC_OUT.ParamByName('kind').AsInteger := 5;
        MSSQL_PLC_OUT.Execute;
      end
      else
      begin
        sbuf[1] := byte($A5);
        sbuf[2] := byte($00);
        sbuf[3] := MACNO;
        sbuf[4] := byte($03);
        sbuf[5] := byte($11);
        sbuf[6] := byte(CRC(5, sbuf));

        MSSQL_PLC_OUT.ParamByName('CPNO').AsString := '01';
        MSSQL_PLC_OUT.ParamByName('PODT').AsDateTime := now;
        MSSQL_PLC_OUT.ParamByName('PO1').AsInteger := sbuf[1];
        MSSQL_PLC_OUT.ParamByName('PO2').AsInteger := sbuf[2];
        MSSQL_PLC_OUT.ParamByName('PO3').AsInteger := sbuf[3];
        MSSQL_PLC_OUT.ParamByName('PO4').AsInteger := sbuf[4];
        MSSQL_PLC_OUT.ParamByName('PO5').AsInteger := sbuf[5];
        MSSQL_PLC_OUT.ParamByName('PO6').AsInteger := sbuf[6];
        MSSQL_PLC_OUT.ParamByName('kind').AsInteger := 6;
        MSSQL_PLC_OUT.Execute;
      end;
    except
      on E: Exception do
      begin
        StatusBar1.Panels[1].Text := '4:' + E.Message;
        LogNumber(E.Message);
      end;
    end;
  finally
    open2;
  end;
end;

procedure TForm1.Timer_mailTimer(Sender: TObject);
var
  AIniFilename: string;
  SearchRec1: TSearchRec;
  a: integer;
  ts: TStringList;
begin
  //20151208_PLC01LOG.txt
  AIniFilename := ExtractFilePath(Application.EXEName) + 'LOG';
  AIniFilename := AIniFilename + '\' + FormatDateTime('yyyymmdd', now) + '_PLC01LOG.txt';
  if not FileExists(AIniFilename) then exit;

  try
    FindFirst(AIniFilename, faAnyFile, SearchRec1);
    a := SearchRec1.Size; //2588 3K
    if a >= psize then
    begin
      try
        StatusBar1.Panels[1].Text := '';
        StatusBar1.Refresh;
        if SslSmtpClient.Connected then
          SslSmtpClient.Quit;

        screen.Cursor := crSQLWait;
        FEhloCount := 0;

        SslSmtpClient.CharSet := 'utf-8';
        SslSmtpClient.ConvertToCharset := true;
        SslSmtpClient.DefaultEncoding := TSmtpDefaultEncoding(0);
        SslSmtpClient.Allow8bitChars := true;
        SslSmtpClient.FoldHeaders := true;

        SslSmtpClient.Host := 'smtp.mail.yahoo.com';
        SslSmtpClient.Port := '587';
        SslSmtpClient.SignOn := 'march77';
        SslSmtpClient.FromName := 'peterlin161@yahoo.com.tw';
        SslSmtpClient.HdrFrom := 'peterlin161@yahoo.com.tw';
        SslSmtpClient.HdrCc := '';
        SslSmtpClient.HdrSubject := 'PLC error';

        ts := TStringList.Create;
        ts.Add('PLC error');
        SslSmtpClient.MailMessage := ts;
        ts.Free;

        SslSmtpClient.AuthType := TSmtpAuthType(2);
        SslSmtpClient.SslType := TSmtpSslType(2);
        SslSmtpClient.SendMode := smtpToSocket;
        SslSmtpClient.ShareMode := smtpShareDenyWrite;
        SslSmtpClient.Timeout := 15;

        SslContext1.SslPrivKeyFile := '';
        SslContext1.SslPassPhrase := '';
        SslContext1.SslCertFile := '';
        SslContext1.SslCAFile := '';
        SslContext1.SslCAPath := '';
        SslContext1.SslVerifyPeer := false;

        SslSmtpClient.OnSslVerifyPeer := nil;
        SslSmtpClient.OnSslHandshakeDone := nil;
        SslSmtpClient.Username := 'peterlin161';
        SslSmtpClient.Password := 'mm16881688';
        SslSmtpClient.HdrPriority := TSmtpPriority(3);
        SslSmtpClient.RcptName.Clear;
        SslSmtpClient.RcptNameAdd('dbvcl.march@gmail.com', '', '');
        SslSmtpClient.Connect;
      except
        on e: exception do
        begin
          StatusBar1.Panels[1].Text := e.Message;
          LogNumber(e.Message);
        end;
      end;
    end;
  finally
    FindClose(SearchRec1);
  end;
end;

procedure TForm1.SslSmtpClientRcptToError(Sender: TObject; ErrorCode: Word;
  RcptNameIdx: Integer; var Action: TSmtpRcptToErrorAction);
begin
  screen.Cursor := crDefault;
end;

procedure TForm1.SslSmtpClientRequestDone(Sender: TObject;
  RqType: TSmtpRequest; ErrorCode: Word);
begin
  if ErrorCode <> 0 then
  begin
    screen.Cursor := crDefault;
    //StatusBar1.Panels[0].Text := 'fail';
    StatusBar1.Panels[1].Text := 'fail:' + SslSmtpClient.ErrorMessage;
    Exit;
  end;

  case RqType of
    smtpConnect:
      begin
        if SslSmtpClient.AuthType = smtpAuthNone then
          SslSmtpClient.Helo
        else
          SslSmtpClient.Ehlo;
      end;
    smtpHelo:
      SslSmtpClient.MailFrom;
    smtpEhlo:
      if SslSmtpClient.SslType = smtpTlsExplicit then
      begin
        Inc(FEhloCount);
        if FEhloCount = 1 then
          SslSmtpClient.StartTls
        else if FEhloCount > 1 then
          SslSmtpClient.Auth;
      end
      else
        SslSmtpClient.Auth;
    smtpStartTls:
      SslSmtpClient.Ehlo;
    smtpAuth:
      SslSmtpClient.MailFrom;
    smtpMailFrom:
      SslSmtpClient.RcptTo;
    smtpRcptTo:
      SslSmtpClient.Data;
    smtpData:
      SslSmtpClient.Quit;
    smtpQuit:
      begin
        screen.Cursor := crDefault;
        //StatusBar1.Panels[0].Text := 'OK';
        StatusBar1.Panels[1].Text := 'OK';
        psize := psize + 2588;
      end;
  end;
end;

procedure TForm1.SslSmtpClientSessionClosed(Sender: TObject;
  ErrCode: Word);
begin
  screen.Cursor := crDefault;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  f: textfile;
  readed: string;
begin
  //march add 1051017
  try
    assignfile(f, ExtractFilePath(Application.EXEName) + 'NOPOOLING.txt');
    reset(f);
    repeat
      readln(f, readed);
      readed := trim(readed);
      if readed > '' then
      begin
        P_NOPOOLING[strtoint(readed)] := '0';
      end;
    until (eof(f));
    StatusBar1.Panels[1].Text := 'TXT OK';
    //showmessage('ok');
  except
    on E: Exception do
    begin
      ShowMessage(e.Message);
    end;
  end;
  //march add 1051017
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  sbuf: array[1..6] of byte;
  a, s: string;
  MACNO, j: integer;
  code: integer;
  revp: array[1..1024] of byte;
  pcl_in, pcl: string;
begin
  a := trim(Edit3.Text);
  if copy(a, 1, 1) = '1' then
  begin
    warbox('房號必須為商務房!!');
    exit;
  end;

  MACNO := get_macno;
  sbuf[1] := byte($A5);
  sbuf[2] := byte($00);
  sbuf[3] := MACNO;
  sbuf[4] := byte($03);
  sbuf[5] := byte($11);
  sbuf[6] := byte(CRC(5, sbuf));

  SioTxClear(Port);
  code := SioPuts(Port, @sbuf, 6);
  sleep(300);

  s := '';
  for j := 1 to 6 do
  begin
    s := s + IntToHex(sbuf[j], 2) + ' ';
  end;
  Memo1.Lines.Add(s);

  if Code < 0 then
  begin
    Memo1.Lines.Add('SioPuts ERROR:' + inttostr(Code));
    exit;
  end;

  Code := SioRxQue(Port);
  if code > 0 then
  begin
    SioGets(Port, @revp, Code);
    s := '';
    for j := 1 to Code do
    begin
      s := s + IntToHex(revp[j], 2) + ' ';
    end;
    Memo1.Lines.Add(s);
    //stat[sbuf[3]] := byte($11); //add

    pcl_in := IntToBin(revp[3], 7) + IntToBin(revp[4], 7);
    pcl :=
      copy(pcl_in, 1, 1) + ' ' +
      copy(pcl_in, 2, 1) + ' ' +
      copy(pcl_in, 3, 1) + ' ' +
      copy(pcl_in, 4, 1) + ' ' +
      copy(pcl_in, 5, 1) + ' ' +
      copy(pcl_in, 6, 1) + ' ' +
      copy(pcl_in, 7, 1) + ' ' +
      copy(pcl_in, 8, 1) + '    ' +
      copy(pcl_in, 9, 1) + ' ' +
      copy(pcl_in, 10, 1) + ' ' +
      copy(pcl_in, 11, 1) + ' ' +
      copy(pcl_in, 12, 1) + ' ' +
      copy(pcl_in, 13, 1) + ' ' +
      copy(pcl_in, 14, 1) + ' ' +
      copy(pcl_in, 15, 1) + ' ' +
      copy(pcl_in, 16, 1);
    Memo1.Lines.Add('    ' + pcl);
    Memo1.Lines.Add('');
  end
  else
    Memo1.Lines.Add('SioRxQue is 0.');
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = VK_F12) then
  begin
    if Button5.Visible = false then
    begin
      Button5.Visible := true;
      Button10.Visible := true;
      Button22.Visible := true;
    end
    else
    begin
      Button5.Visible := false;
      Button10.Visible := false;
      Button22.Visible := false;
    end;
  end;
end;

procedure TForm1.Button10Click(Sender: TObject);
var
  sbuf: array[1..6] of byte;
  a, s: string;
  MACNO, j: integer;
  code: integer;
  revp: array[1..1024] of byte;
  pcl_in, pcl: string;
begin
  a := trim(Edit3.Text);
  if copy(a, 1, 1) = '1' then
  begin
    warbox('房號必須為商務房!!');
    exit;
  end;

  MACNO := get_macno;
  sbuf[1] := byte($A5);
  sbuf[2] := byte($00);
  sbuf[3] := MACNO;
  sbuf[4] := byte($03);
  sbuf[5] := byte($22);
  sbuf[6] := byte(CRC(5, sbuf));

  SioTxClear(Port);
  code := SioPuts(Port, @sbuf, 6);
  sleep(300);

  s := '';
  for j := 1 to 6 do
  begin
    s := s + IntToHex(sbuf[j], 2) + ' ';
  end;
  Memo1.Lines.Add(s);

  if Code < 0 then
  begin
    Memo1.Lines.Add('SioPuts ERROR:' + inttostr(Code));
    exit;
  end;

  Code := SioRxQue(Port);
  if code > 0 then
  begin
    SioGets(Port, @revp, Code);
    s := '';
    for j := 1 to Code do
    begin
      s := s + IntToHex(revp[j], 2) + ' ';
    end;
    Memo1.Lines.Add(s);
    //stat[sbuf[3]] := byte($11); //add

    pcl_in := IntToBin(revp[3], 7) + IntToBin(revp[4], 7);
    pcl :=
      copy(pcl_in, 1, 1) + ' ' +
      copy(pcl_in, 2, 1) + ' ' +
      copy(pcl_in, 3, 1) + ' ' +
      copy(pcl_in, 4, 1) + ' ' +
      copy(pcl_in, 5, 1) + ' ' +
      copy(pcl_in, 6, 1) + ' ' +
      copy(pcl_in, 7, 1) + ' ' +
      copy(pcl_in, 8, 1) + '    ' +
      copy(pcl_in, 9, 1) + ' ' +
      copy(pcl_in, 10, 1) + ' ' +
      copy(pcl_in, 11, 1) + ' ' +
      copy(pcl_in, 12, 1) + ' ' +
      copy(pcl_in, 13, 1) + ' ' +
      copy(pcl_in, 14, 1) + ' ' +
      copy(pcl_in, 15, 1) + ' ' +
      copy(pcl_in, 16, 1);
    Memo1.Lines.Add('    ' + pcl);
    Memo1.Lines.Add('');
  end
  else
    Memo1.Lines.Add('SioRxQue is 0.');
end;

procedure TForm1.Button22Click(Sender: TObject);
var
  sbuf: array[1..6] of byte;
  a, s: string;
  MACNO, j: integer;
  code: integer;
  revp: array[1..1024] of byte;
  pcl_in, pcl: string;
begin
  a := trim(Edit3.Text);
  if copy(a, 1, 1) = '1' then
  begin
    warbox('房號必須為商務房!!');
    exit;
  end;

  MACNO := get_macno;
  sbuf[1] := byte($A5);
  sbuf[2] := byte($00);
  sbuf[3] := MACNO;
  sbuf[4] := byte($03);
  sbuf[5] := byte($66);
  sbuf[6] := byte(CRC(5, sbuf));

  SioTxClear(Port);
  code := SioPuts(Port, @sbuf, 6);
  sleep(300);

  s := '';
  for j := 1 to 6 do
  begin
    s := s + IntToHex(sbuf[j], 2) + ' ';
  end;
  Memo1.Lines.Add(s);

  if Code < 0 then
  begin
    Memo1.Lines.Add('SioPuts ERROR:' + inttostr(Code));
    exit;
  end;

  Code := SioRxQue(Port);
  if code > 0 then
  begin
    SioGets(Port, @revp, Code);
    s := '';
    for j := 1 to Code do
    begin
      s := s + IntToHex(revp[j], 2) + ' ';
    end;
    Memo1.Lines.Add(s);
    //stat[sbuf[3]] := byte($11); //add

    pcl_in := IntToBin(revp[3], 7) + IntToBin(revp[4], 7);
    pcl :=
      copy(pcl_in, 1, 1) + ' ' +
      copy(pcl_in, 2, 1) + ' ' +
      copy(pcl_in, 3, 1) + ' ' +
      copy(pcl_in, 4, 1) + ' ' +
      copy(pcl_in, 5, 1) + ' ' +
      copy(pcl_in, 6, 1) + ' ' +
      copy(pcl_in, 7, 1) + ' ' +
      copy(pcl_in, 8, 1) + '    ' +
      copy(pcl_in, 9, 1) + ' ' +
      copy(pcl_in, 10, 1) + ' ' +
      copy(pcl_in, 11, 1) + ' ' +
      copy(pcl_in, 12, 1) + ' ' +
      copy(pcl_in, 13, 1) + ' ' +
      copy(pcl_in, 14, 1) + ' ' +
      copy(pcl_in, 15, 1) + ' ' +
      copy(pcl_in, 16, 1);
    Memo1.Lines.Add('    ' + pcl);
    Memo1.Lines.Add('');
  end
  else
    Memo1.Lines.Add('SioRxQue is 0.');
end;

end.

