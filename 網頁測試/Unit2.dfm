object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 548
  ClientWidth = 830
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser1: TWebBrowser
    Left = 32
    Top = 47
    Width = 577
    Height = 497
    TabOrder = 0
    ControlData = {
      4C000000A23B00005E3300000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Button1: TButton
    Left = 32
    Top = 8
    Width = 89
    Height = 33
    Caption = #36617#20837
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 127
    Top = 8
    Width = 89
    Height = 34
    Caption = #40670#25802
    TabOrder = 2
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 312
    Top = 14
    Width = 81
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = '1000'
  end
  object Button3: TButton
    Left = 399
    Top = 8
    Width = 89
    Height = 34
    Caption = #33258#21205#40670#25802
    TabOrder = 4
    OnClick = Button3Click
  end
  object CheckBox1: TCheckBox
    Left = 496
    Top = 16
    Width = 81
    Height = 17
    Caption = #33258#21205#26356#26032
    TabOrder = 5
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 664
    Top = 240
  end
end
