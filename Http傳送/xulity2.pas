unit xulity2;

interface

uses Windows, Messages, Classes, SysUtils, Forms, Controls, Variants,
  DateUtils, Menus, Math, Dialogs, StdCtrls,
  ShellAPI, IniFiles, Graphics, StrUtils, Mask, DBCtrls;

function GetRmnoOld(p: string): string;
function GetRmno(p: string): string;
function GetRmnoNEW(p: string): string;
function MyEncodeUrl(source: string): string;
function GetFileVersionString(const AFileName: string): string;
function GetContext(const AIniFilename, str: string; Context: string = 'DB'): string;
procedure XML_LOG(a: variant);
function UrlDecode2(const EncodedStr: string): string;
function HexToInt(HexStr: string): Int64;
function URLEncode3(const S: string; const InQueryString: Boolean): string;
procedure Log(a: variant);

implementation

uses Unit1;

function URLEncode3(const S: string; const InQueryString: Boolean): string;
var
  Idx: Integer; // loops thru characters in string
begin
  Result := '';
  for Idx := 1 to Length(S) do
  begin
    case S[Idx] of
      'A'..'Z', 'a'..'z', '0'..'9', '-', '_', '.':
        Result := Result + S[Idx];
      ' ':
        if InQueryString then
          Result := Result + '+'
        else
          Result := Result + '%20';
    else
      Result := Result + '%';
      //Result := Result + '%' + SysUtils.IntToHex(Ord(S[Idx]), 2);
    end;
  end;
end;

function HexToInt(HexStr: string): Int64;
var RetVar: Int64;
  i: byte;
begin
  HexStr := UpperCase(HexStr);
  if HexStr[length(HexStr)] = 'H' then
    Delete(HexStr, length(HexStr), 1);
  RetVar := 0;

  for i := 1 to length(HexStr) do begin
    RetVar := RetVar shl 4;
    if HexStr[i] in ['0'..'9'] then
      RetVar := RetVar + (byte(HexStr[i]) - 48)
    else
      if HexStr[i] in ['A'..'F'] then
        RetVar := RetVar + (byte(HexStr[i]) - 55)
      else begin
        Retvar := 0;
        break;
      end;
  end;

  Result := RetVar;
end;

function UrlDecode2(const EncodedStr: string): string;
var
  I: Integer;
begin
  Result := '';
  if Length(EncodedStr) > 0 then
  begin
    I := 1;
    while I <= Length(EncodedStr) do
    begin
      if EncodedStr[I] = '%' then
      begin
        Result := Result + Chr(HexToInt(EncodedStr[I + 1]
          + EncodedStr[I + 2]));
        I := Succ(Succ(I));
      end
      else if EncodedStr[I] = '+' then
        Result := Result + ' '
      else
        Result := Result + EncodedStr[I];

      I := Succ(I);
    end;
  end;
end;

procedure delay(MSecs: Longword);
var
  begintime: Longword;
begin
  begintime := gettickcount;
  repeat
    application.ProcessMessages;
  until gettickcount - begintime >= MSecs;
end;

procedure Log(a: variant);
var
  F2: TextFile;
  FileHandle: Integer;
begin
  //if plc_test=false then exit; //march del 1030519

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

function GetFileVersionString(const AFileName: string): string;
var
  FileName: string;
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  Result := '';
  FileName := AFileName;
  UniqueString(FileName);
  InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
  if InfoSize <> 0 then
  begin
    GetMem(VerBuf, InfoSize);
    try
      if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VerBuf) then
        if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
        begin
          Result := InttoStr(FI.dwFileVersionMS div $10000) + '.'
            + IntToStr(FI.dwFileVersionMS mod $10000) + '.'
            + IntToStr(FI.dwFileVersionLS div $10000) + '.'
            + IntToStr(FI.dwFileVersionLS mod $10000);
        end;
    finally
      FreeMem(VerBuf);
    end;
  end;
end;

function GetFileVersionStringEx(const AFileName: string): string;
var
  FileName: string;
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  Result := '';
  FileName := AFileName;
  UniqueString(FileName);
  InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
  if InfoSize <> 0 then
  begin
    GetMem(VerBuf, InfoSize);
    try
      if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VerBuf) then
        if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
        begin
          Result := InttoStr(FI.dwFileVersionMS div $10000) + '.'
            + IntToStr(FI.dwFileVersionMS mod $10000) + '.'
            + IntToStr(FI.dwFileVersionLS div $10000) + '.'
            + IntToStr(FI.dwFileVersionLS mod $10000);
          if ((FI.dwFileFlags and VS_FF_DEBUG) xor VS_FF_DEBUG) = 0 then
            Result := Result + ' Debug Version.';
          if ((FI.dwFileFlags and VS_FF_PRERELEASE) xor VS_FF_PRERELEASE) = 0 then
            Result := Result + ' Trial Version.';
        end;
    finally
      FreeMem(VerBuf);
    end;
  end;
end;

procedure debug(a1: variant);
begin
  if VarIsNull(a1) then ShowMessage(vartostr(a1) + ' is null.')
  else if VarIsEmpty(a1) then ShowMessage(vartostr(a1) + ' is empty.')
  else if VarIsClear(a1) then ShowMessage(vartostr(a1) + ' is clear.')
  else ShowMessage(vartostr(a1));
end;

procedure DebugOut(a1: variant);
var
  F2: TextFile;
  FileHandle: Integer;
begin
  if not FileExists('Debug_out.txt') then
  begin
    FileHandle := FileCreate('Debug_out.txt');
    FileClose(FileHandle);
  end;

  AssignFile(F2, 'Debug_out.txt');
  Append(F2);
  WriteLn(F2, TimeToStr(Time) + ':' + vartostr(a1) + #13);
  Flush(F2);
  CloseFile(F2);
end;

function URLEncode(InStr: string): string;
var
  intSourceLen: integer;
  intForLoop: integer;
  strTemp: string;
  strSource: string;
  strDestCode: string;
  charTemp: char;
begin
  strSource := UTF8Encode(InStr);
  strDestCode := '';
  intSourceLen := length(strSource);
  for intForLoop := 1 to intSourceLen do
  begin
    charTemp := strSource[intForLoop];
    if charTemp = ' ' then
    begin
      strDestCode := strDestCode + '+';
    end
    else if charTemp = #13 then
    begin
      strDestCode := strDestCode + '%0D%0A';
    end
    else if (charTemp < '0') or ((charTemp < 'A') and (charTemp > '9')) or
      ((charTemp > 'Z') and (charTemp < 'a')) or (charTemp > 'z') then
    begin
      strTemp := inttohex(ord(charTemp), 2);
      strDestCode := strDestCode + '%' + strTemp;
    end
    else
    begin
      strDestCode := strDestCode + charTemp;
    end;
  end;
  Result := strDestCode;
end;

function URLDecode(const S: string): string;
var
  Idx: Integer; // loops thru chars in string
  Hex: string; // string of hex characters
  Code: Integer; // hex character code (-1 on error)
begin
  // Intialise result and string index
  Result := '';
  Idx := 1;
  // Loop thru string decoding each character
  while Idx <= Length(S) do
  begin
    case S[Idx] of
      '%':
        begin
          // % should be followed by two hex digits - exception otherwise
          if Idx <= Length(S) - 2 then
          begin
            // there are sufficient digits - try to decode hex digits
            Hex := S[Idx + 1] + S[Idx + 2];
            Code := SysUtils.StrToIntDef('$' + Hex, -1);
            Inc(Idx, 2);
          end
          else
            // insufficient digits - error
            Code := -1;
          // check for error and raise exception if found
          if Code = -1 then
            raise SysUtils.EConvertError.Create(
              'Invalid hex digit in URL'
              );
          // decoded OK - add character to result
          Result := Result + Chr(Code);
        end;
      '+':
        // + is decoded as a space
        Result := Result + ' '
    else
      // All other characters pass thru unchanged
      Result := Result + S[Idx];
    end;
    Inc(Idx);
  end;
end;

function MyEncodeUrl(source: string): string;
var i: integer;
begin
  result := '';
  for i := 1 to length(source) do
    if not (source[i] in ['A'..'Z', 'a'..'z', '0', '1'..'9', '-', '_', '~', '.']) then
      result := result + '%' + inttohex(ord(source[i]), 2)
    else result := result + source[i];
end;

function GetRmnoOld(p: string): string;
var
  pos1, pos2: string;
  n1, n2: integer;
  rmno: string;
begin
  pos1 := '<OROOM_NOS>';
  n1 := pos(pos1, p);
  pos2 := '</OROOM_NOS>';
  n2 := pos(pos2, p);
  rmno := uppercase(copy(p, n1 + length(pos1), n2 - n1 - length(pos2)));
  result := rmno;
end;

function GetRmnoNEW(p: string): string;
var
  pos1, pos2: string;
  n1, n2: integer;
  rmno: string;
begin
  pos1 := '<NROOM_NOS>';
  n1 := pos(pos1, p);
  pos2 := '</NROOM_NOS>';
  n2 := pos(pos2, p);
  rmno := uppercase(copy(p, n1 + length(pos1), n2 - n1 - length(pos2)));
  result := rmno;
end;

function CRC(Data: array of Byte; Code: integer): Byte;
begin
  Result := $00;
  case code of
    4:
      begin
        Result := Result xor Byte(Data[1]);
        Result := Result xor Byte(Data[2]);
        Result := Result xor Byte(Data[3]);
        Result := Result xor Byte(Data[4]);
      end;
    5:
      begin
        Result := Result xor Byte(Data[1]);
        Result := Result xor Byte(Data[2]);
        Result := Result xor Byte(Data[3]);
        Result := Result xor Byte(Data[4]);
        Result := Result xor Byte(Data[5]);
      end
  else
    showmessage('code must between 4 and 5.');
  end;
end;

function GetContext(const AIniFilename, str: string; Context: string = 'DB'): string;
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

function GetRmno(p: string): string;
var
  pos1, pos2: string;
  n1, n2: integer;
  rmno: string;
begin
  pos1 := '<ROOM_NOS>';
  n1 := pos(pos1, p);
  pos2 := '</ROOM_NOS>';
  n2 := pos(pos2, p);
  rmno := trim(uppercase(copy(p, n1 + length(pos1), n2 - n1 - length(pos2) + 1)));
  result := rmno;
end;

procedure XML_LOG(a: variant);
{var
  F2: TextFile;
  FileHandle: Integer;}
begin
  //Form1.ADOCommand3.Parameters.ParamByName('P1').Value := now;
  //Form1.ADOCommand3.Parameters.ParamByName('P2').Value := a;
  //Form1.ADOCommand3.Execute;


  {frmMain.Query1.CLOSE;
  frmMain.QuerY1.Open;
  frmMain.Query1.EDIT;
  frmMain.Query1['A1'] := formatdatetime('yyyy/mm/dd hh:mm:ss', now);
  frmMain.Query1['A2'] := A;
  frmMain.Query1.Post;}

  //frmMain.ADOCommand2.Parameters.ParamByName('P1').Value := formatdatetime('yyyy/mm/dd hh:mm:ss', now);
  //frmMain.ADOCommand2.Parameters.ParamByName('P2').Value := a;
  //frmMain.ADOCommand2.Execute;

  //if log_test = false then exit;

  {if not FileExists('XML.txt') then
  begin
    FileHandle := FileCreate('XML.txt');
    FileClose(FileHandle);
  end;

  try
    AssignFile(F2, 'XML.txt');
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
  end;}
end;

end.

