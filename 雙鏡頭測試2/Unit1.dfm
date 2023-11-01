object Form1: TForm1
  Left = 78
  Top = 174
  Width = 1312
  Height = 616
  Caption = 'Form1'
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
    Left = 1
    Top = 0
    Width = 640
    Height = 481
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 648
    Top = 0
    Width = 641
    Height = 481
    TabOrder = 1
  end
  object Button2: TButton
    Left = 240
    Top = 492
    Width = 65
    Height = 26
    Caption = #36984#25799
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button1: TButton
    Left = 240
    Top = 525
    Width = 65
    Height = 25
    Caption = #38364#38281
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 311
    Top = 493
    Width = 65
    Height = 25
    Caption = #20786#23384'A'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 311
    Top = 525
    Width = 65
    Height = 25
    Caption = #20786#23384'B'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Edit1: TEdit
    Left = 592
    Top = 520
    Width = 81
    Height = 21
    TabOrder = 6
    Text = 'Edit1'
  end
  object Button5: TButton
    Left = 592
    Top = 544
    Width = 81
    Height = 17
    Caption = 'Button5'
    TabOrder = 7
    OnClick = Button5Click
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer2Timer
    Left = 48
    Top = 640
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer1Timer
    Left = 200
    Top = 528
  end
end
