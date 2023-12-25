object Form3: TForm3
  Left = 110
  Top = 12
  Width = 1441
  Height = 796
  Caption = 'Iterasi'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Bodoni Bd BT'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 25
  object Label8: TLabel
    Left = 19
    Top = 0
    Width = 1389
    Height = 34
    Caption = 
      'Program Algoritma Cuckoo Search (CS) untuk Menyelesaikan Capacit' +
      'ated Vehicle Routing Problem (CVRP)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Bodoni Bd BT'
    Font.Style = []
    ParentFont = False
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 738
    Width = 1425
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = #169' 2022 Yunita Maulinda'
        Width = 50
      end>
  end
  object mmIter: TMemo
    Left = 8
    Top = 40
    Width = 697
    Height = 697
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 712
    Top = 40
    Width = 705
    Height = 697
    ActivePage = TabSheet9
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Pembangkitan Awal Sarang dan Pengurutan Elemen Sarang'
      ImageIndex = 9
      object sgAwal: TStringGrid
        Left = 0
        Top = 0
        Width = 697
        Height = 657
        ColCount = 2
        RowCount = 2
        TabOrder = 0
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Nilai U'
      ImageIndex = 2
      object sgU: TStringGrid
        Left = 0
        Top = 0
        Width = 697
        Height = 657
        ColCount = 2
        RowCount = 2
        TabOrder = 0
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Nilai V'
      ImageIndex = 3
      object sgV: TStringGrid
        Left = 0
        Top = 0
        Width = 697
        Height = 657
        ColCount = 2
        RowCount = 2
        TabOrder = 0
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Nilai S'
      ImageIndex = 4
      object sgS: TStringGrid
        Left = 0
        Top = 0
        Width = 697
        Height = 657
        ColCount = 2
        RowCount = 2
        TabOrder = 0
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Nilai K'
      ImageIndex = 5
      object sgK: TStringGrid
        Left = 0
        Top = 0
        Width = 697
        Height = 657
        ColCount = 2
        RowCount = 2
        TabOrder = 0
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Nilai Levy Flights'
      ImageIndex = 6
      object sgLevy: TStringGrid
        Left = 0
        Top = 0
        Width = 697
        Height = 657
        ColCount = 2
        RowCount = 2
        TabOrder = 0
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'Pergantian Nilai Fungsi Tujuan'
      ImageIndex = 7
      object sgGanti: TStringGrid
        Left = 0
        Top = 0
        Width = 697
        Height = 657
        ColCount = 2
        RowCount = 2
        TabOrder = 0
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'Nilai Rand, R, dan Index Sarang'
      ImageIndex = 8
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 249
        Height = 505
        Caption = 'Nilai Rand'
        TabOrder = 0
        object sgRand: TStringGrid
          Left = 8
          Top = 24
          Width = 233
          Height = 473
          ColCount = 2
          RowCount = 2
          TabOrder = 0
        end
      end
      object GroupBox2: TGroupBox
        Left = 256
        Top = 0
        Width = 441
        Height = 505
        Caption = 'Nilai R'
        TabOrder = 1
        object sgR: TStringGrid
          Left = 8
          Top = 24
          Width = 425
          Height = 473
          ColCount = 2
          RowCount = 2
          TabOrder = 0
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 512
        Width = 697
        Height = 145
        Caption = 'Index Sarang Permut1 dan Permut2'
        TabOrder = 2
        object sgIndex: TStringGrid
          Left = 8
          Top = 24
          Width = 681
          Height = 113
          ColCount = 2
          RowCount = 1
          FixedRows = 0
          TabOrder = 0
        end
      end
    end
    object TabSheet12: TTabSheet
      Caption = 'Nilai BRW'
      ImageIndex = 11
      object sgBRW: TStringGrid
        Left = 0
        Top = 0
        Width = 697
        Height = 657
        ColCount = 2
        RowCount = 2
        TabOrder = 0
      end
    end
    object TabSheet13: TTabSheet
      Caption = 'Pergantian Sarang Terburuk'
      ImageIndex = 12
      object sgUpdate: TStringGrid
        Left = 0
        Top = 0
        Width = 697
        Height = 657
        ColCount = 2
        RowCount = 2
        TabOrder = 0
      end
    end
  end
end
