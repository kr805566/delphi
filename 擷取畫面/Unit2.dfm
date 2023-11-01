object Form2: TForm2
  Left = 0
  Top = 0
  Align = alClient
  AlphaBlendValue = 1
  BorderStyle = bsNone
  Caption = 'Form2'
  ClientHeight = 576
  ClientWidth = 736
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -32
  Font.Name = 'Times New Roman'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClick = Button1Click
  OnDblClick = FormDblClick
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 36
  object Image1: TImage
    Left = -712
    Top = -552
    Width = 736
    Height = 576
    AutoSize = True
    Stretch = True
    OnClick = Button1Click
    OnDblClick = FormDblClick
  end
  object Button2: TButton
    Left = 135
    Top = 90
    Width = 113
    Height = 41
    Caption = #36664#20837
    TabOrder = 0
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 254
    Top = 90
    Width = 113
    Height = 41
    Caption = #38364#38281
    TabOrder = 1
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 32
    Top = 88
    Width = 89
    Height = 44
    TabOrder = 2
    Text = '10'
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 304
    Top = 200
  end
end
