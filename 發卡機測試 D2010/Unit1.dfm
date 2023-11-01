object Form2: TForm2
  Left = 0
  Top = 0
  Caption = #30332#21345#27231
  ClientHeight = 368
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 40
    Top = 32
    Width = 73
    Height = 33
    Caption = 'Open'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 40
    Top = 71
    Width = 73
    Height = 33
    Caption = 'Close'
    Enabled = False
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 40
    Top = 110
    Width = 73
    Height = 33
    Caption = 'IssueCard'
    Enabled = False
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 40
    Top = 149
    Width = 73
    Height = 30
    Caption = 'Capture'
    Enabled = False
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 40
    Top = 185
    Width = 177
    Height = 33
    Caption = 'MoveToExit HoldPosition'
    Enabled = False
    TabOrder = 4
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 40
    Top = 224
    Width = 73
    Height = 33
    Caption = 'Colse'
    Enabled = False
    TabOrder = 5
    OnClick = Button6Click
  end
  object GroupBox1: TGroupBox
    Left = 248
    Top = 71
    Width = 137
    Height = 147
    Caption = #35712#21345
    TabOrder = 6
    object Button7: TButton
      Left = 72
      Top = 76
      Width = 59
      Height = 25
      Caption = 'close'
      Enabled = False
      TabOrder = 0
      OnClick = Button7Click
    end
    object Button8: TButton
      Left = 10
      Top = 107
      Width = 124
      Height = 25
      Caption = 'RequestCardSN'
      Enabled = False
      TabOrder = 1
      OnClick = Button8Click
    end
    object Button9: TButton
      Left = 7
      Top = 76
      Width = 59
      Height = 25
      Caption = 'Open'
      TabOrder = 2
      OnClick = Button9Click
    end
    object Edit2: TEdit
      Left = 14
      Top = 39
      Width = 89
      Height = 21
      TabOrder = 3
      Text = 'Edit1'
    end
  end
  object Edit1: TEdit
    Left = 184
    Top = 32
    Width = 89
    Height = 21
    TabOrder = 7
    Text = 'Edit1'
  end
  object Edit3: TEdit
    Left = 232
    Top = 236
    Width = 89
    Height = 21
    TabOrder = 8
    Text = 'Edit1'
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 349
    Width = 471
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end>
    ExplicitLeft = 96
    ExplicitTop = 320
    ExplicitWidth = 0
  end
end
