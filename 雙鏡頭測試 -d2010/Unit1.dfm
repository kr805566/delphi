object Form1: TForm1
  Left = 245
  Top = 42
  Caption = 'CCD'
  ClientHeight = 594
  ClientWidth = 849
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = -7
    Top = 0
    Width = 417
    Height = 401
    TabOrder = 4
  end
  object Panel2: TPanel
    Left = 416
    Top = 0
    Width = 417
    Height = 401
    TabOrder = 5
  end
  object Button2: TButton
    Left = 264
    Top = 444
    Width = 65
    Height = 26
    Caption = #36984#25799
    TabOrder = 0
    OnClick = Button2Click
  end
  object Button1: TButton
    Left = 264
    Top = 477
    Width = 65
    Height = 25
    Caption = #38364#38281
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 335
    Top = 445
    Width = 65
    Height = 25
    Caption = #20786#23384'A'
    TabOrder = 1
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 335
    Top = 477
    Width = 65
    Height = 25
    Caption = #20786#23384'B'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer2Timer
    Left = 224
    Top = 536
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer1Timer
    Left = 224
    Top = 480
  end
end
