object Form1: TForm1
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu]
  Caption = 'VKBooks'
  ClientHeight = 465
  ClientWidth = 345
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 345
    Height = 465
    TabOrder = 0
    object Edit1: TEdit
      Left = 5
      Top = 5
      Width = 281
      Height = 33
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object ListBox1: TListBox
      Left = 4
      Top = 44
      Width = 335
      Height = 420
      Style = lbOwnerDrawFixed
      ItemHeight = 30
      TabOrder = 1
    end
    object BitBtn1: TBitBtn
      Left = 292
      Top = 5
      Width = 47
      Height = 33
      TabOrder = 2
      OnClick = BitBtn1Click
    end
  end
  object MainMenu1: TMainMenu
    Left = 208
    Top = 296
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N3: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = N3Click
      end
    end
    object N2: TMenuItem
      Caption = #1055#1086#1084#1086#1097#1100
    end
  end
end
