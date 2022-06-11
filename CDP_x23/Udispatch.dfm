object frm_main: Tfrm_main
  Left = 26
  Top = 108
  Width = 986
  Height = 590
  Caption = #22823#38593#30719' '#32534#32452#31449
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 544
    Width = 978
    Height = 19
    Panels = <
      item
        Width = 300
      end
      item
        Width = 300
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 40
    Width = 978
    Height = 504
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 300
      Top = 0
      Width = 8
      Height = 504
      Cursor = crHSplit
      Beveled = True
    end
    object Memo_station05: TMemo
      Left = 336
      Top = 208
      Width = 617
      Height = 49
      Lines.Strings = (
        '6566572'
        #19977#26012#20117#65288#28789#27849#30719#65289)
      ScrollBars = ssVertical
      TabOrder = 6
      Visible = False
    end
    object Memo_station04: TMemo
      Left = 336
      Top = 120
      Width = 617
      Height = 49
      Lines.Strings = (
        '6566572'
        #19977#26012#20117#65288#28789#27849#30719#65289)
      ScrollBars = ssVertical
      TabOrder = 5
      Visible = False
    end
    object Memo_07: TMemo
      Left = 328
      Top = 112
      Width = 617
      Height = 49
      Lines.Strings = (
        '6566572'
        #19977#26012#20117#65288#28789#27849#30719#65289)
      ScrollBars = ssVertical
      TabOrder = 2
      Visible = False
    end
    object Memo_02: TMemo
      Left = 328
      Top = 176
      Width = 617
      Height = 49
      Lines.Strings = (
        '6565734'
        #38706#22825#30719)
      ScrollBars = ssVertical
      TabOrder = 0
      Visible = False
    end
    object Memo_04: TMemo
      Left = 328
      Top = 240
      Width = 617
      Height = 57
      Lines.Strings = (
        '6563921'
        #38081#21271#30719)
      ScrollBars = ssVertical
      TabOrder = 1
      Visible = False
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 300
      Height = 504
      Align = alLeft
      BevelInner = bvLowered
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 3
      object DBGrid1: TDBGrid
        Left = 1
        Top = 49
        Width = 298
        Height = 454
        Align = alClient
        DataSource = DataSource1
        PopupMenu = PopupMenu1
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'seriary_number'
            Title.Alignment = taCenter
            Title.Caption = #36742#24207
            Width = 28
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'car_number'
            Title.Alignment = taCenter
            Title.Caption = #36710#21495
            Width = 78
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'car_marque'
            Title.Alignment = taCenter
            Title.Caption = #36710#22411
            Width = 45
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'carry_weight1'
            Title.Alignment = taCenter
            Title.Caption = #26631#37325
            Width = 45
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'self_weight1'
            Title.Alignment = taCenter
            Title.Caption = #33258#37325
            Width = 45
            Visible = True
          end>
      end
      object Panel5: TPanel
        Left = 1
        Top = 1
        Width = 298
        Height = 48
        Align = alTop
        BevelInner = bvLowered
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 16
          Width = 65
          Height = 13
          Caption = #36807#36710#26102#38388#65306
        end
        object Label_Dest: TLabel
          Left = 251
          Top = 20
          Width = 7
          Height = 13
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object cmbox_pTime: TComboBox
          Left = 80
          Top = 16
          Width = 157
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = cmbox_pTimeChange
        end
      end
    end
    object Panel4: TPanel
      Left = 308
      Top = 0
      Width = 670
      Height = 504
      Align = alClient
      BevelInner = bvLowered
      BevelOuter = bvNone
      Caption = 'Panel4'
      TabOrder = 4
      object DBGridEh1: TDBGridEh
        Left = 1
        Top = 1
        Width = 668
        Height = 412
        Align = alClient
        DataSource = DataSource2
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -13
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        PopupMenu = Popup2
        TabOrder = 2
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
      object judgmentPtime: TDBEdit
        Left = 320
        Top = 152
        Width = 121
        Height = 21
        DataField = 'past_time'
        DataSource = DataSource2
        TabOrder = 1
        Visible = False
      end
      object Panel6: TPanel
        Left = 1
        Top = 454
        Width = 668
        Height = 49
        Align = alBottom
        BevelInner = bvLowered
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          668
          49)
        object btn_print: TButton
          Left = 476
          Top = 16
          Width = 83
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = #25968#25454#25171#21360'(&P)'
          TabOrder = 0
          OnClick = btn_printClick
        end
        object btn_csv: TButton
          Left = 572
          Top = 16
          Width = 83
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = #25968#25454#19978#25253'(&D)'
          TabOrder = 1
          OnClick = btn_csvClick
        end
      end
      object Panel7: TPanel
        Left = 1
        Top = 413
        Width = 668
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 3
        DesignSize = (
          668
          41)
        object CHB_heavy: TCheckBox
          Left = 572
          Top = 16
          Width = 85
          Height = 17
          Anchors = [akRight, akBottom]
          Caption = #37325#36710
          TabOrder = 0
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 978
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    Caption = #25968#25454#22788#29702#20013#24515
    Color = clBtnShadow
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object PopupMenu1: TPopupMenu
    Left = 256
    Top = 136
    object add8car: TMenuItem
      Caption = #28155#21152#32534#36710#32452
      OnClick = add8carClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Caption = #25968#25454#27719#24635
      OnClick = N5Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N7: TMenuItem
      Caption = #32534#36753#21040#31449
      OnClick = N7Click
    end
    object N4: TMenuItem
      Caption = #20851#20110
      OnClick = N4Click
    end
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 352
    Top = 8
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 312
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet2
    Left = 112
    Top = 48
  end
  object ADODataSet2: TADODataSet
    Connection = ADOConnection1
    CursorType = ctStatic
    CommandText = 'select * from trainOrder'
    Parameters = <>
    Left = 80
    Top = 48
    object ADODataSet2train_number: TIntegerField
      FieldName = 'train_number'
    end
    object ADODataSet2seriary_number: TIntegerField
      FieldName = 'seriary_number'
    end
    object ADODataSet2car_number: TStringField
      FieldName = 'car_number'
      Size = 30
    end
    object ADODataSet2car_marque: TStringField
      FieldName = 'car_marque'
      Size = 30
    end
    object ADODataSet2carry_weight1: TBCDField
      FieldName = 'carry_weight1'
      Precision = 9
      Size = 3
    end
    object ADODataSet2self_weight1: TBCDField
      FieldName = 'self_weight1'
      Precision = 9
      Size = 3
    end
    object ADODataSet2past_time: TWideStringField
      FieldName = 'past_time'
      Size = 50
    end
    object ADODataSet2outFlag: TWideStringField
      FieldName = 'outFlag'
      Size = 50
    end
    object ADODataSet2sn: TAutoIncField
      FieldName = 'sn'
      ReadOnly = True
    end
  end
  object DataSource2: TDataSource
    DataSet = switchyard
    Left = 568
    Top = 88
  end
  object Popup2: TPopupMenu
    Left = 520
    Top = 184
    object del1car: TMenuItem
      Caption = #21024#38500#36710#36742#32534#32452
      OnClick = del1carClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N9: TMenuItem
      Caption = #25968#25454#27719#24635
      OnClick = N5Click
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object N11: TMenuItem
      Caption = #32534#36753#21040#31449
      OnClick = N7Click
    end
    object N12: TMenuItem
      Caption = #20851#20110
      OnClick = N4Click
    end
  end
  object addDispatch: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 256
    Top = 176
  end
  object delDispatch: TADOQuery
    Connection = add1del
    Parameters = <>
    Left = 520
    Top = 224
  end
  object add1del: TADOConnection
    LoginPrompt = False
    Left = 392
    Top = 8
  end
  object checkCPS_: TTimer
    Interval = 6000
    OnTimer = checkCPS_Timer
    Left = 8
    Top = 496
  end
  object ADOQuery_temp1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 40
    Top = 496
  end
  object ADOQuery_temp2: TADOQuery
    Connection = connectMDB
    Parameters = <>
    Left = 80
    Top = 496
  end
  object connectMDB: TADOConnection
    LoginPrompt = False
    Left = 80
    Top = 448
  end
  object ADODataSet_traintotalh: TADODataSet
    Connection = connectMDB
    Parameters = <>
    Left = 120
    Top = 496
  end
  object ADOQuery_Exec: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 160
    Top = 496
  end
  object ADODataSet_carNumber: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 200
    Top = 496
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
    Left = 312
    Top = 504
  end
  object switchyard: TADODataSet
    Connection = ADOConnection1
    CommandText = 'select * from switchyard'
    Parameters = <>
    Left = 536
    Top = 88
    object switchyardjournalID: TAutoIncField
      FieldName = 'journalID'
      ReadOnly = True
    end
    object switchyardmineName: TStringField
      FieldName = 'mineName'
      Size = 30
    end
    object switchyarddirection_PS: TStringField
      FieldName = 'direction_PS'
      Size = 30
    end
    object switchyarddirection_SC: TStringField
      FieldName = 'direction_SC'
      Size = 30
    end
    object switchyardcar_number: TStringField
      FieldName = 'car_number'
      Size = 30
    end
    object switchyardcar_marque: TStringField
      FieldName = 'car_marque'
      Size = 30
    end
    object switchyardcarry_weight1: TBCDField
      FieldName = 'carry_weight1'
      Precision = 9
      Size = 3
    end
    object switchyardself_weight1: TBCDField
      FieldName = 'self_weight1'
      Precision = 9
      Size = 3
    end
    object switchyardcargo_generalID: TStringField
      FieldName = 'cargo_generalID'
      Size = 30
    end
    object switchyardtonNumber: TBCDField
      FieldName = 'tonNumber'
      Precision = 9
      Size = 3
    end
    object switchyardbreed: TStringField
      FieldName = 'breed'
      Size = 30
    end
    object switchyardswitchyardNotepad: TStringField
      FieldName = 'switchyardNotepad'
      Size = 90
    end
    object switchyardpast_time: TStringField
      FieldName = 'past_time'
      Size = 30
    end
    object switchyardseriary_number: TIntegerField
      FieldName = 'seriary_number'
    end
  end
end
