object Harvy: THarvy
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'HarvyToBase'
  ClientHeight = 336
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Btn_Scan: TButton
    Left = 390
    Top = 48
    Width = 121
    Height = 49
    Caption = #1057#1082#1072#1085#1080#1088#1086#1074#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Btn_ScanClick
  end
  object PB_TotalProgress: TProgressBar
    Left = 8
    Top = 8
    Width = 503
    Height = 17
    Max = 999999
    TabOrder = 1
  end
  object InfoGroup: TGroupBox
    Left = 8
    Top = 43
    Width = 369
    Height = 90
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1093#1086#1076#1077' '#1089#1082#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103
    TabOrder = 2
    object Lbl_CurrPos: TLabel
      Left = 20
      Top = 25
      Width = 122
      Height = 16
      Caption = #1058#1077#1082#1091#1097#1072#1103' '#1087#1086#1079#1080#1094#1080#1103':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Lbl_frf: TLabel
      Left = 248
      Top = 55
      Width = 14
      Height = 16
      Caption = #1080#1079
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Lbl_frc: TLabel
      Left = 248
      Top = 25
      Width = 14
      Height = 16
      Caption = #1080#1079
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Lbl_DataFounded: TLabel
      Left = 20
      Top = 57
      Width = 117
      Height = 16
      Caption = #1053#1072#1081#1076#1077#1085#1086' '#1076#1072#1085#1085#1099#1093':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Edt_CurrPos: TEdit
      Left = 148
      Top = 22
      Width = 81
      Height = 24
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object Edt_DataFounded: TEdit
      Left = 148
      Top = 52
      Width = 81
      Height = 24
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object Edt_LinkScaned: TEdit
      Left = 280
      Top = 52
      Width = 70
      Height = 24
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object Edt_Total: TEdit
      Left = 280
      Top = 22
      Width = 70
      Height = 24
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
  end
  object Btn_Options: TButton
    Left = 436
    Top = 106
    Width = 75
    Height = 25
    Caption = '>>>'
    TabOrder = 3
    OnClick = Btn_OptionsClick
  end
  object PgC_Params: TPageControl
    Left = 527
    Top = 8
    Width = 250
    Height = 185
    ActivePage = PG_ScanParams
    TabOrder = 4
    object PG_ScanParams: TTabSheet
      Caption = #1089#1082#1072#1085#1080#1088#1086#1074#1072#1085#1080#1077
      object Grp_ScanBox: TGroupBox
        Left = 6
        Top = 1
        Width = 227
        Height = 98
        Caption = #1044#1080#1072#1087#1072#1079#1086#1085' '#1089#1082#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Lbl_ScanFrom: TLabel
          Left = 13
          Top = 27
          Width = 123
          Height = 16
          Caption = #1057#1090#1072#1088#1090#1086#1074#1099#1081' '#1080#1085#1076#1077#1082#1089
        end
        object Lbl_ScanTo: TLabel
          Left = 13
          Top = 59
          Width = 127
          Height = 16
          BiDiMode = bdLeftToRight
          Caption = #1060#1080#1085#1072#1083#1100#1085#1099#1081' '#1080#1085#1076#1077#1082#1089
          ParentBiDiMode = False
        end
        object Edt_ScanFrom: TEdit
          Left = 146
          Top = 24
          Width = 71
          Height = 24
          NumbersOnly = True
          TabOrder = 0
          Text = '1'
          OnClick = Edt_ScanFromClick
        end
        object Edt_ScanTo: TEdit
          Left = 146
          Top = 56
          Width = 71
          Height = 24
          NumbersOnly = True
          TabOrder = 1
          Text = '999999'
          OnClick = Edt_ScanToClick
        end
      end
      object Chck_ReparseCheck: TCheckBox
        Left = 12
        Top = 105
        Width = 177
        Height = 17
        Caption = #1056#1077#1087#1072#1088#1089#1080#1085#1075' Bad Link'#39#1086#1074
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = Chck_ReparseCheckClick
      end
      object ChB_TestMode: TCheckBox
        Left = 12
        Top = 129
        Width = 197
        Height = 17
        Hint = 'wo DB connection'
        Caption = #1058#1077#1089#1090#1086#1074#1099#1081' '#1088#1077#1078#1080#1084' (no DB)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
    end
    object PG_ProxyParams: TTabSheet
      Caption = 'proxy'
      ImageIndex = 1
      object Lbl_ProxyPort: TLabel
        Left = 14
        Top = 55
        Width = 33
        Height = 16
        Caption = #1055#1086#1088#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Lbl_ProxyServer: TLabel
        Left = 14
        Top = 32
        Width = 48
        Height = 16
        Caption = #1057#1077#1088#1074#1077#1088
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Lbl_ProxyUsername: TLabel
        Left = 14
        Top = 79
        Width = 73
        Height = 16
        Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Lbl_ProxyPassword: TLabel
        Left = 14
        Top = 103
        Width = 50
        Height = 16
        Caption = #1055#1072#1088#1086#1083#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Lbl_ProxyType: TLabel
        Left = 14
        Top = 127
        Width = 63
        Height = 16
        Caption = #1058#1080#1087' Proxy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Chck_UseProxy: TCheckBox
        Left = 14
        Top = 6
        Width = 99
        Height = 17
        Caption = #1048#1089#1087'. '#1087#1088#1086#1082#1089#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object Edt_ProxyServerIP: TEdit
        Left = 102
        Top = 31
        Width = 102
        Height = 21
        TabOrder = 1
      end
      object Edt_ProxyPortNo: TEdit
        Left = 102
        Top = 54
        Width = 102
        Height = 21
        NumbersOnly = True
        TabOrder = 2
      end
      object Edt_ProxyUsername: TEdit
        Left = 102
        Top = 78
        Width = 102
        Height = 21
        Hint = 'not necessary'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
      object Edt_ProxyPassword: TEdit
        Left = 102
        Top = 102
        Width = 102
        Height = 21
        Hint = 'not necessary'
        ParentShowHint = False
        PasswordChar = '#'
        ShowHint = True
        TabOrder = 4
      end
      object Btn_PickUpProxy: TButton
        Left = 158
        Top = 2
        Width = 79
        Height = 25
        Caption = 'Pick up proxy'
        TabOrder = 5
        OnClick = Btn_PickUpProxyClick
      end
      object CMB_ProxyType: TComboBox
        Left = 102
        Top = 126
        Width = 102
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ItemIndex = 0
        ParentFont = False
        TabOrder = 6
        Text = 'http'
        Items.Strings = (
          'http'
          'https')
      end
    end
    object PG_MailingParams: TTabSheet
      Caption = #1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1077
      ImageIndex = 2
      object Lbl_MailHost: TLabel
        Left = 14
        Top = 32
        Width = 30
        Height = 16
        Caption = 'Host'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Lbl_MailUsername: TLabel
        Left = 14
        Top = 55
        Width = 64
        Height = 16
        Caption = 'Username'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Lbl_MailPass: TLabel
        Left = 14
        Top = 79
        Width = 63
        Height = 16
        Caption = 'Password'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Lbl_MailPort: TLabel
        Left = 14
        Top = 103
        Width = 28
        Height = 16
        Caption = 'Port'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Lbl_MailTo: TLabel
        Left = 14
        Top = 127
        Width = 43
        Height = 16
        Caption = 'Mail to'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Edt_MailHost: TEdit
        Left = 102
        Top = 31
        Width = 102
        Height = 21
        Hint = 'f.e. "smtp.Rambler.ru"'
        DoubleBuffered = False
        ParentDoubleBuffered = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object Edt_MailUsername: TEdit
        Left = 102
        Top = 54
        Width = 102
        Height = 21
        TabOrder = 1
      end
      object Edt_MailPass: TEdit
        Left = 102
        Top = 78
        Width = 102
        Height = 21
        PasswordChar = '#'
        TabOrder = 2
      end
      object Chck_Mailing: TCheckBox
        Left = 14
        Top = 5
        Width = 209
        Height = 17
        Caption = #1059#1074#1077#1076#1086#1084#1083#1077#1085#1080#1077' '#1085#1072' '#1087#1086#1095#1090#1091
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object Edt_MailPort: TEdit
        Left = 102
        Top = 102
        Width = 102
        Height = 21
        NumbersOnly = True
        TabOrder = 4
      end
      object Edt_MailTo: TEdit
        Left = 102
        Top = 126
        Width = 102
        Height = 21
        TabOrder = 5
      end
    end
    object PG_DBConnectionParams: TTabSheet
      Caption = #1041#1044
      ImageIndex = 3
      object Btn_DBConnect: TButton
        Left = 10
        Top = 127
        Width = 75
        Height = 25
        Caption = 'Connect'
        TabOrder = 0
        OnClick = Btn_DBConnectClick
      end
      object Btn_DBDisconnect: TButton
        Left = 156
        Top = 127
        Width = 75
        Height = 25
        Caption = 'Disconnect'
        TabOrder = 1
        OnClick = Btn_DBDisconnectClick
      end
      object Grp_DBParams: TGroupBox
        Left = 3
        Top = 0
        Width = 236
        Height = 121
        Caption = 'Current params'
        TabOrder = 2
        object Lbl_DBServer: TLabel
          Left = 14
          Top = 18
          Width = 44
          Height = 16
          Caption = 'Server'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Lbl_DBUsername: TLabel
          Left = 14
          Top = 41
          Width = 64
          Height = 16
          Caption = 'Username'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Lbl_DBPort: TLabel
          Left = 14
          Top = 65
          Width = 28
          Height = 16
          Caption = 'Port'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Lbl_DBShema: TLabel
          Left = 14
          Top = 89
          Width = 62
          Height = 16
          Caption = 'Database'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Edt_DBUsername: TEdit
          Left = 116
          Top = 40
          Width = 102
          Height = 21
          ReadOnly = True
          TabOrder = 0
        end
        object Edt_DBServerIP: TEdit
          Left = 116
          Top = 17
          Width = 102
          Height = 21
          ReadOnly = True
          TabOrder = 1
        end
        object Edt_DBPortNo: TEdit
          Left = 116
          Top = 64
          Width = 102
          Height = 21
          NumbersOnly = True
          ReadOnly = True
          TabOrder = 2
        end
        object Edt_Schema: TEdit
          Left = 116
          Top = 88
          Width = 102
          Height = 21
          NumbersOnly = True
          ReadOnly = True
          TabOrder = 3
        end
      end
    end
  end
  object Mem_PyOut: TMemo
    Left = 8
    Top = 144
    Width = 503
    Height = 49
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -7
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 5
    Visible = False
  end
  object MainConnection: TMyConnection
    Database = 'icetradesch'
    Username = 'HarvyToBase'
    Server = 'localhost'
    Left = 40
    Top = 216
    EncryptedPassword = 'B7FF9EFF8DFF89FF86FFA0FFAFFF9EFF8CFFDBFFD6FF'
  end
  object AddCommand: TMyCommand
    Connection = MainConnection
    Left = 40
    Top = 265
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 160
    Top = 272
  end
  object IdSMTP: TIdSMTP
    MailAgent = 'Mozilla'
    SASLMechanisms = <>
    Left = 160
    Top = 216
  end
  object Py_Engine: TPythonEngine
    DllName = 'python310.dll'
    DllPath = 'G:\__Git\HarvyToBase\Dll'
    APIVersion = 1013
    RegVersion = '3.10.5'
    UseLastKnownVersion = False
    IO = Py_GUIInOut
    Left = 280
    Top = 216
  end
  object Py_GUIInOut: TPythonGUIInputOutput
    UnicodeIO = True
    RawOutput = False
    Output = Mem_PyOut
    Left = 280
    Top = 272
  end
  object BL_Table: TMyTable
    TableName = 'badlinks'
    Connection = MainConnection
    Left = 368
    Top = 216
  end
end
