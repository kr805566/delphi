object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 243
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 25
  object Edit1: TEdit
    Left = 48
    Top = 64
    Width = 137
    Height = 33
    TabOrder = 0
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 208
    Top = 60
    Width = 105
    Height = 41
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 48
    Top = 112
    Width = 137
    Height = 33
    TabOrder = 2
    Text = 'Edit1'
  end
  object MSConnection_local: TMSConnection
    Database = 'KIOSK_LOG'
    Options.KeepDesignConnected = False
    Username = 'ap01'
    Server = '192.168.0.99,6433'
    LoginPrompt = False
    Left = 376
    Top = 104
    EncryptedPassword = 'CEFFCEFFCFFFCCFFCEFFCEFFCFFFCCFF'
  end
end
