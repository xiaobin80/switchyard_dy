object frm_sa: Tfrm_sa
  Left = 175
  Top = 134
  BorderStyle = bsSingle
  Caption = #25968#25454#27719#24635
  ClientHeight = 521
  ClientWidth = 801
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 801
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    Caption = #25968#25454#27719#24635
    Color = clBtnShadow
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 40
    Width = 801
    Height = 462
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 249
      Height = 462
      Align = alLeft
      Caption = #25628#32034#26465#20214
      TabOrder = 0
      object Label1: TLabel
        Left = 24
        Top = 208
        Width = 39
        Height = 13
        Caption = #21040#31449#65306
      end
      object Label2: TLabel
        Left = 24
        Top = 240
        Width = 39
        Height = 13
        Caption = #29028#31181#65306
      end
      object Label4: TLabel
        Left = 24
        Top = 272
        Width = 52
        Height = 13
        Caption = #35843#24230#21592#65306
      end
      object Label3: TLabel
        Left = 24
        Top = 328
        Width = 39
        Height = 13
        Caption = #38057#25968#65306
        Visible = False
      end
      object GroupBox2: TGroupBox
        Left = 24
        Top = 32
        Width = 201
        Height = 161
        Caption = #26085#26399#21306#38388
        TabOrder = 0
        object Label5: TLabel
          Left = 8
          Top = 80
          Width = 13
          Height = 13
          Caption = #33267
        end
        object DateTimePicker1: TDateTimePicker
          Left = 7
          Top = 24
          Width = 186
          Height = 21
          CalAlignment = dtaLeft
          Date = 38776.3856335995
          Time = 38776.3856335995
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkDate
          ParseInput = False
          TabOrder = 0
        end
        object DateTimePicker2: TDateTimePicker
          Left = 7
          Top = 104
          Width = 186
          Height = 21
          CalAlignment = dtaLeft
          Date = 38776.3857612153
          Time = 38776.3857612153
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkDate
          ParseInput = False
          TabOrder = 1
        end
        object DTP_sTime: TDateTimePicker
          Left = 6
          Top = 48
          Width = 186
          Height = 21
          CalAlignment = dtaLeft
          Date = 39147.25
          Time = 39147.25
          Color = clBtnFace
          DateFormat = dfShort
          DateMode = dmComboBox
          Enabled = False
          Kind = dtkTime
          ParseInput = False
          TabOrder = 2
        end
        object DTP_oTime: TDateTimePicker
          Left = 6
          Top = 128
          Width = 186
          Height = 21
          CalAlignment = dtaLeft
          Date = 39147.75
          Time = 39147.75
          Color = clBtnFace
          DateFormat = dfShort
          DateMode = dmComboBox
          Enabled = False
          Kind = dtkTime
          ParseInput = False
          TabOrder = 3
        end
      end
      object cmbox_dz: TComboBox
        Left = 72
        Top = 208
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
      end
      object cmbox_mz: TComboBox
        Left = 72
        Top = 240
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
      end
      object cmbox_dd: TComboBox
        Left = 72
        Top = 272
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
      end
      object pnl_btn: TPanel
        Left = 2
        Top = 419
        Width = 245
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 4
        object btn_find: TButton
          Left = 24
          Top = 8
          Width = 75
          Height = 25
          Caption = #25628#32034'(&F)'
          TabOrder = 0
          OnClick = btn_findClick
        end
        object btn_print2: TButton
          Left = 148
          Top = 8
          Width = 75
          Height = 25
          Caption = #25171#21360'(&P)'
          TabOrder = 1
          OnClick = btn_print2Click
        end
      end
      object cmb_gs: TComboBox
        Left = 72
        Top = 336
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 5
        Visible = False
      end
      object CheckBox1: TCheckBox
        Left = 24
        Top = 304
        Width = 97
        Height = 17
        Caption = #39640#32423#26597#35810
        TabOrder = 6
        OnClick = CheckBox1Click
      end
    end
    object DBGridEh1: TDBGridEh
      Left = 249
      Top = 0
      Width = 552
      Height = 462
      Align = alClient
      DataSource = DataSource1
      Flat = False
      FooterColor = clWindow
      FooterFont.Charset = GB2312_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -13
      FooterFont.Name = #23435#20307
      FooterFont.Style = []
      TabOrder = 1
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      UseMultiTitle = True
      Columns = <
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'mineName'
          Footers = <>
          Title.Caption = #30719#21035
          Width = 29
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'direction_PS'
          Footers = <>
          Title.Caption = #21435#21521'|'#21040'  '#31449
          Width = 128
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'direction_SC'
          Footers = <>
          Title.Caption = #21435#21521'|'#25910#36135#20154
          Width = 156
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'car_number'
          Footers = <>
          Title.Caption = #36710#21495
          Width = 74
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'car_marque'
          Footers = <>
          Title.Caption = #36710#22411
          Width = 45
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'carry_weight1'
          Footers = <>
          Title.Caption = #26631#37325
          Width = 45
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'self_weight1'
          Footers = <>
          Title.Caption = #33258#37325
          Width = 45
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'cargo_generalID'
          Footers = <>
          Title.Caption = #36135#36890#21495
          Width = 74
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'tonNumber'
          Footers = <>
          Title.Caption = #21544
          Width = 24
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'breed'
          Footers = <>
          Title.Caption = #21697#31181
          Width = 29
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'switchyardNotepad'
          Footers = <>
          Title.Caption = #35760'   '#20107
          Width = 90
        end>
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 502
    Width = 801
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object DataSource1: TDataSource
    DataSet = totals1
    Left = 440
    Top = 104
  end
  object totals1: TADODataSet
    Connection = frm_main.ADOConnection1
    CursorType = ctStatic
    CommandText = 'select * from OldSwitchyard'
    Parameters = <>
    Left = 400
    Top = 104
  end
  object FindData: TADOQuery
    Connection = frm_main.ADOConnection1
    Parameters = <>
    Left = 440
    Top = 8
  end
  object PrintDBGridEh1: TPrintDBGridEh
    DBGridEh = DBGridEh1
    Options = []
    PageFooter.Font.Charset = DEFAULT_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -11
    PageFooter.Font.Name = 'MS Sans Serif'
    PageFooter.Font.Style = []
    PageHeader.Font.Charset = DEFAULT_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -11
    PageHeader.Font.Name = 'MS Sans Serif'
    PageHeader.Font.Style = []
    Units = MM
    Left = 256
    Top = 448
  end
end
