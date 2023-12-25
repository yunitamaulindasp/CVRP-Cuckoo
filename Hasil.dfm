object Form2: TForm2
  Left = 559
  Top = 19
  Width = 771
  Height = 818
  Caption = 
    'Algoritma Cuckoo Search (CS) pada Capacitated Vehicle Routing Pr' +
    'oblem (CVRP)'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Bodoni Bd BT'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 25
  object Label8: TLabel
    Left = 19
    Top = 8
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
    Top = 753
    Width = 1417
    Height = 19
    Color = clWindow
    Panels = <
      item
        Alignment = taCenter
        Text = #169' 2022 Yunita Maulinda'
        Width = 50
      end>
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 48
    Width = 705
    Height = 705
    Caption = 'Graf Hasil'
    TabOrder = 1
    object imghasil: TImage
      Left = 8
      Top = 24
      Width = 689
      Height = 673
    end
  end
  object GroupBox2: TGroupBox
    Left = 720
    Top = 48
    Width = 697
    Height = 649
    Caption = 'Rute Hasil'
    TabOrder = 2
    object mmOutput: TMemo
      Left = 8
      Top = 24
      Width = 673
      Height = 617
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object Button3: TButton
    Left = 720
    Top = 701
    Width = 697
    Height = 49
    Caption = 'Kembali'
    TabOrder = 3
    OnClick = Button3Click
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 8
    object Home1: TMenuItem
      Caption = 'Home'
      object Simpan1: TMenuItem
        Caption = 'Simpan'
        ShortCut = 16467
        OnClick = Simpan1Click
      end
      object Keluar1: TMenuItem
        Caption = 'Keluar'
        ShortCut = 16465
        OnClick = Keluar1Click
      end
    end
    object File1: TMenuItem
      Caption = 'File'
      object iterasi: TMenuItem
        Caption = 'Tampilkan Iterasi'
        ShortCut = 16468
        OnClick = iterasiClick
      end
      object Buka1: TMenuItem
        Caption = 'Buka'
        ShortCut = 16463
        OnClick = Buka1Click
      end
      object Reset1: TMenuItem
        Caption = 'Reset'
        ShortCut = 8238
        OnClick = Reset1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 40
    Top = 8
  end
end
