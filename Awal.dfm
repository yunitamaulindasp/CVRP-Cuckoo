object Form1: TForm1
  Left = 171
  Top = 81
  Width = 1441
  Height = 815
  Caption = 
    'Algoritma Cuckoo Search (CS) pada Capacitated Vehicle Routing Pr' +
    'oblem (CVRP)'
  Color = clWindow
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
    Left = 18
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
    Top = 737
    Width = 1425
    Height = 19
    Color = clBtnHighlight
    Panels = <
      item
        Alignment = taCenter
        Text = #169' 2022 Yunita Maulinda'
        Width = 50
      end>
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 40
    Width = 705
    Height = 697
    Caption = 'Input Graf'
    TabOrder = 1
    object imgTitik: TImage
      Left = 8
      Top = 32
      Width = 689
      Height = 657
      OnMouseUp = imgTitikMouseUp
    end
  end
  object GroupBox2: TGroupBox
    Left = 712
    Top = 40
    Width = 705
    Height = 353
    Caption = 'Input Jarak'
    TabOrder = 2
    object sgMatriks: TStringGrid
      Left = 8
      Top = 32
      Width = 689
      Height = 313
      ColCount = 2
      DefaultRowHeight = 27
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 0
      OnDrawCell = sgMatriksDrawCell
      OnKeyPress = sgMatriksKeyPress
      OnSelectCell = sgMatriksSelectCell
      OnSetEditText = sgMatriksSetEditText
    end
  end
  object GroupBox3: TGroupBox
    Left = 712
    Top = 392
    Width = 705
    Height = 345
    Caption = 'Input Data'
    TabOrder = 3
    object Label9: TLabel
      Left = 287
      Top = 64
      Width = 194
      Height = 25
      Caption = 'Kapasitas Kendaraan'
    end
    object Label10: TLabel
      Left = 287
      Top = 264
      Width = 149
      Height = 25
      Caption = 'Iterasi Maksimal'
    end
    object Label11: TLabel
      Left = 287
      Top = 144
      Width = 286
      Height = 25
      Caption = 'Probabilitas Pergantian Sarang'
    end
    object Label12: TLabel
      Left = 287
      Top = 104
      Width = 137
      Height = 25
      Caption = 'Banyak Sarang'
    end
    object Label1: TLabel
      Left = 287
      Top = 184
      Width = 37
      Height = 25
      Caption = 'Alfa'
    end
    object Label2: TLabel
      Left = 287
      Top = 224
      Width = 42
      Height = 25
      Caption = 'Beta'
    end
    object sgCust: TStringGrid
      Left = 8
      Top = 32
      Width = 249
      Height = 305
      ColCount = 2
      DefaultRowHeight = 27
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 0
      OnKeyPress = sgCustKeyPress
      OnSetEditText = sgCustSetEditText
    end
    object edKapasitas: TEdit
      Left = 608
      Top = 60
      Width = 65
      Height = 33
      TabOrder = 1
      OnKeyPress = edKapasitasKeyPress
    end
    object edSarang: TEdit
      Left = 608
      Top = 100
      Width = 65
      Height = 33
      TabOrder = 2
      OnKeyPress = edSarangKeyPress
    end
    object edPa: TEdit
      Left = 608
      Top = 140
      Width = 65
      Height = 33
      TabOrder = 3
      OnKeyPress = edPaKeyPress
    end
    object edIterMax: TEdit
      Left = 608
      Top = 260
      Width = 65
      Height = 33
      TabOrder = 4
      OnKeyPress = edIterMaxKeyPress
    end
    object edA: TEdit
      Left = 608
      Top = 180
      Width = 65
      Height = 33
      TabOrder = 5
      OnKeyPress = edAKeyPress
    end
    object edB: TEdit
      Left = 608
      Top = 220
      Width = 65
      Height = 33
      TabOrder = 6
      OnKeyPress = edBKeyPress
    end
  end
  object MainMenu1: TMainMenu
    Left = 17
    Top = 56
    object Home1: TMenuItem
      Caption = 'Home'
      object Mulai1: TMenuItem
        Caption = 'Proses'
        ShortCut = 16474
        OnClick = Mulai1Click
      end
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
    Left = 56
    Top = 56
  end
  object SaveDialog1: TSaveDialog
    Left = 96
    Top = 56
  end
  object XMLDocument1: TXMLDocument
    Left = 136
    Top = 56
    DOMVendorDesc = 'MSXML'
  end
end
