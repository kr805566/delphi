object Form1: TForm1
  Left = 192
  Top = 127
  Width = 979
  Height = 563
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 64
    Top = 360
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 264
    Top = 336
    Width = 97
    Height = 49
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 56
    Top = 128
    Width = 713
    Height = 193
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Button2: TButton
    Left = 424
    Top = 376
    Width = 25
    Height = 17
    Caption = 'Button2'
    TabOrder = 2
  end
  object MSConnection1: TMSConnection
    Database = 'H001'
    Username = 'AP01'
    Server = '.\SQLEXPRESS'
    LoginPrompt = False
    Left = 352
    Top = 40
    EncryptedPassword = 'CEFFCEFFCFFFCCFFCEFFCEFFCFFFCCFF'
  end
  object MSQuery1: TMSQuery
    Connection = MSConnection1
    SQL.Strings = (
      
        'select * from fare where FADATE>='#39'106/01/01'#39' and FADATE<='#39'106/09' +
        '/14'#39)
    Left = 432
    Top = 48
  end
  object DataSource1: TDataSource
    DataSet = MSQuery1
    Left = 80
    Top = 64
  end
end
