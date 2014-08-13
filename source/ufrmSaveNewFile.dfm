object frmSaveNewFile: TfrmSaveNewFile
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'OraTau Save As...'
  ClientHeight = 233
  ClientWidth = 632
  Color = clBtnFace
  Constraints.MaxHeight = 260
  Constraints.MinHeight = 260
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  Icon.Data = {
    0000010001001010000001000000680400001600000028000000100000002000
    0000010020000000000000040000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000D0687050C06860FFB05850FFA05050FFA05050FFA05050FF904850FF9048
    40FF904840FF804040FF803840FF803840FF703840FF703830FF000000000000
    0000D06870FFF09090FFE08080FFB04820FF403020FFC0B8B0FFC0B8B0FFD0C0
    C0FFD0C8C0FF505050FFA04030FFA04030FFA03830FF703840FF000000000000
    0000D07070FFFF98A0FFF08880FFE08080FF705850FF404030FF907870FFF0E0
    E0FFF0E8E0FF908070FFA04030FFA04040FFA04030FF803840FF000000000000
    0000D07870FFFFA0A0FFF09090FFF08880FF705850FF000000FF404030FFF0D8
    D0FFF0E0D0FF807860FFB04840FFB04840FFA04040FF804040FF000000000000
    0000D07880FFFFA8B0FFFFA0A0FFF09090FF705850FF705850FF705850FF7058
    50FF706050FF806860FFC05850FFB05050FFB04840FF804040FF000000000000
    0000E08080FFFFB0B0FFFFB0B0FFFFA0A0FFF09090FFF08880FFE08080FFE078
    80FFD07070FFD06870FFC06060FFC05850FFB05050FF904840FF000000000000
    0000E08890FFFFB8C0FFFFB8B0FFD06060FFC06050FFC05850FFC05040FFB050
    30FFB04830FFA04020FFA03810FFC06060FFC05850FF904840FF000000000000
    0000E09090FFFFC0C0FFD06860FFFFFFFFFFFFFFFFFFFFF8F0FFF0F0F0FFF0E8
    E0FFF0D8D0FFE0D0C0FFE0C8C0FFA03810FFC06060FF904850FF000000000000
    0000E098A0FFFFC0C0FFD07070FFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0FFF0F0
    F0FFF0E8E0FFF0D8D0FFE0D0C0FFA04020FFD06860FFA05050FF000000000000
    0000F0A0A0FFFFC0C0FFE07870FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8
    F0FFF0F0F0FFF0E8E0FFF0D8D0FFB04830FFD07070FFA05050FF000000000000
    0000F0A8A0FFFFC0C0FFE08080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFF8F0FFF0F0F0FFF0E8E0FFB05030FFE07880FFA05050FF000000000000
    0000F0B0B0FFFFC0C0FFF08890FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFF8F0FFF0F0F0FFC05040FF603030FFB05850FF000000000000
    0000F0B0B0FFFFC0C0FFFF9090FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFF8F0FFC05850FFB05860FFB05860FF000000000000
    0000F0B8B0FFF0B8B0FFF0B0B0FFF0B0B0FFF0A8B0FFF0A0A0FFE098A0FFE090
    90FFE09090FFE08890FFE08080FFD07880FFD07870FFD07070FF000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFF8001FFFF8001FFFF8001FFFF8001FFFF8001FFFF8001FFFF8001FFFF8001
    FFFF8001FFFF8001FFFF8001FFFF8001FFFF8001FFFF8001FFFFFFFFFFFF}
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    632
    233)
  PixelsPerInch = 96
  TextHeight = 13
  object btnSaveAs: TcxButton
    Left = 520
    Top = 129
    Width = 96
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Save As...'
    TabOrder = 4
    OnClick = btnSaveAsClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000412023C06860B05850A05050A05050A0505090
      4850904840904840804040803840803840703840703830000000000000D06870
      F09090E08080B04820403020C0B8B0C0B8B0D0C0C0D0C8C0505050A04030A040
      30A03830703840000000000000D07070FF98A0F08880E0808070585040403090
      7870F0E0E0F0E8E0908070A04030A04040A04030803840000000000000D07870
      FFA0A0F09090F08880705850000000404030F0D8D0F0E0D0807860B04840B048
      40A04040804040000000000000D07880FFA8B0FFA0A0F0909070585070585070
      5850705850706050806860C05850B05050B04840804040000000000000E08080
      FFB0B0FFB0B0FFA0A0F09090F08880E08080E07880D07070D06870C06060C058
      50B05050904840000000000000E08890FFB8C0FFB8B0D06060C06050C05850C0
      5040B05030B04830A04020A03810C06060C05850904840000000000000E09090
      FFC0C0D06860FFFFFFFFFFFFFFF8F0F0F0F0F0E8E0F0D8D0E0D0C0E0C8C0A038
      10C06060904850000000000000E098A0FFC0C0D07070FFFFFFFFFFFFFFFFFFFF
      F8F0F0F0F0F0E8E0F0D8D0E0D0C0A04020D06860A05050000000000000F0A0A0
      FFC0C0E07870FFFFFFFFFFFFFFFFFFFFFFFFFFF8F0F0F0F0F0E8E0F0D8D0B048
      30D07070A05050000000000000F0A8A0FFC0C0E08080FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFF8F0F0F0F0F0E8E0B05030E07880A05050000000000000F0B0B0
      FFC0C0F08890FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0F0F0F0C050
      40603030B05850000000000000F0B0B0FFC0C0FF9090FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFF8F0C05850B05860B05860000000000000F0B8B0
      F0B8B0F0B0B0F0B0B0F0A8B0F0A0A0E098A0E09090E09090E08890E08080D078
      80D07870D0707000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000}
    LookAndFeel.Kind = lfStandard
  end
  object btnDoNothing: TcxButton
    Left = 520
    Top = 177
    Width = 96
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel (Esc)'
    TabOrder = 11
    OnClick = btnDoNothingClick
    LookAndFeel.Kind = lfStandard
  end
  object rgButtonDefault: TcxRadioGroup
    Left = 288
    Top = 165
    Anchors = [akTop, akRight]
    Caption = 'Default button'
    ParentFont = False
    Properties.Columns = 3
    Properties.Items = <>
    Style.BorderStyle = ebsUltraFlat
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -11
    Style.Font.Name = 'Tahoma'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 7
    Height = 40
    Width = 221
  end
  object gbTempFile: TcxGroupBox
    Left = 8
    Top = 8
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Temporary file'
    TabOrder = 0
    DesignSize = (
      616
      112)
    Height = 112
    Width = 616
    object lblFormat: TcxLabel
      Left = 21
      Top = 49
      Caption = 'Format:'
    end
    object lblFilename: TcxLabel
      Left = 13
      Top = 79
      Caption = 'Filename:'
    end
    object edtTempFilename: TcxButtonEdit
      Left = 69
      Top = 78
      Anchors = [akLeft, akTop, akRight]
      ParentShowHint = False
      Properties.Buttons = <>
      Properties.OnEditValueChanged = edtTempFilenamePropertiesEditValueChanged
      ShowHint = True
      TabOrder = 7
      OnKeyPress = edtTempFilenameKeyPress
      Width = 375
    end
    object edtTempFilenameFormat: TcxButtonEdit
      Left = 69
      Top = 48
      Anchors = [akLeft, akTop, akRight]
      ParentShowHint = False
      PopupMenu = pmTemplates
      Properties.Buttons = <
        item
          Default = True
        end>
      Properties.OnButtonClick = edtTempFilenameFormatPropertiesButtonClick
      Properties.OnEditValueChanged = edtTempFilenameFormatPropertiesEditValueChanged
      ShowHint = True
      TabOrder = 4
      Text = 'tmp_[ObjectType]_[SchemaType]_[ObjectName]_[UID]'
      Width = 432
    end
    object btnFormatDefault: TcxButton
      Left = 512
      Top = 46
      Width = 96
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Default'
      TabOrder = 5
      OnClick = btnFormatDefaultClick
      LookAndFeel.Kind = lfStandard
    end
    object btnSave2Temp: TcxButton
      Left = 512
      Top = 76
      Width = 96
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Save tmp-file'
      TabOrder = 9
      OnClick = btnSave2TempClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000412023C06860B05850A05050A05050A0505090
        4850904840904840804040803840803840703840703830000000000000D06870
        F09090E08080B04820403020C0B8B0C0B8B0D0C0C0D0C8C0505050A04030A040
        30A03830703840000000000000D07070FF98A0F08880E0808070585040403090
        7870F0E0E0F0E8E0908070A04030A04040A04030803840000000000000D07870
        FFA0A0F09090F08880705850000000404030F0D8D0F0E0D0807860B04840B048
        40A04040804040000000000000D07880FFA8B0FFA0A0F0909070585070585070
        5850705850706050806860C05850B05050B04840804040000000000000E08080
        FFB0B0FFB0B0FFA0A0F09090F08880E08080E07880D07070D06870C06060C058
        50B05050904840000000000000E08890FFB8C0FFB8B0D06060C06050C05850C0
        5040B05030B04830A04020A03810C06060C05850904840000000000000E09090
        FFC0C0D06860FFFFFFFFFFFFFFF8F0F0F0F0F0E8E0F0D8D0E0D0C0E0C8C0A038
        10C06060904850000000000000E098A0FFC0C0D07070FFFFFFFFFFFFFFFFFFFF
        F8F0F0F0F0F0E8E0F0D8D0E0D0C0A04020D06860A05050000000000000F0A0A0
        FFC0C0E07870FFFFFFFFFFFFFFFFFFFFFFFFFFF8F0F0F0F0F0E8E0F0D8D0B048
        30D07070A05050000000000000F0A8A0FFC0C0E08080FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFF8F0F0F0F0F0E8E0B05030E07880A05050000000000000F0B0B0
        FFC0C0F08890FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0F0F0F0C050
        40603030B05850000000000000F0B0B0FFC0C0FF9090FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF8F0C05850B05860B05860000000000000F0B8B0
        F0B8B0F0B0B0F0B0B0F0A8B0F0A0A0E098A0E09090E09090E08890E08080D078
        80D07870D0707000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      LookAndFeel.Kind = lfStandard
    end
    object lblPoint: TcxLabel
      Left = 446
      Top = 82
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = '.'
      Style.TextStyle = [fsBold]
      Height = 17
      Width = 9
    end
    object edtTempFileExt: TcxTextEdit
      Left = 453
      Top = 78
      Anchors = [akTop, akRight]
      TabOrder = 8
      Width = 48
    end
    object lblTempDirectory: TcxLabel
      Left = 25
      Top = 18
      Caption = 'Folder:'
    end
    object edtTempDirectory: TcxButtonEdit
      Left = 69
      Top = 17
      Anchors = [akLeft, akTop, akRight]
      ParentShowHint = False
      PopupMenu = pmTemplates
      Properties.Buttons = <>
      Properties.ReadOnly = True
      Properties.OnEditValueChanged = edtTempDirectoryPropertiesEditValueChanged
      ShowHint = True
      Style.Color = clInactiveCaptionText
      TabOrder = 1
      Width = 432
    end
    object btnOpenTmpFolder: TcxButton
      Left = 512
      Top = 15
      Width = 96
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Open Folder'
      TabOrder = 2
      OnClick = btnOpenTmpFolderClick
      LookAndFeel.Kind = lfStandard
    end
  end
  object rbSave2Temp: TcxRadioButton
    Left = 298
    Top = 181
    Width = 67
    Height = 17
    Caption = 'Save tmp'
    Checked = True
    TabOrder = 8
    TabStop = True
    OnClick = rbSetDefaultButtonClick
  end
  object rbSaveAs: TcxRadioButton
    Left = 372
    Top = 181
    Width = 68
    Height = 17
    Caption = 'Save As...'
    TabOrder = 9
    OnClick = rbSetDefaultButtonClick
  end
  object rbDoNothing: TcxRadioButton
    Left = 450
    Top = 181
    Width = 54
    Height = 17
    Caption = 'Cancel'
    TabOrder = 10
    OnClick = rbSetDefaultButtonClick
  end
  object sbSaveNew: TdxStatusBar
    Left = 0
    Top = 213
    Width = 632
    Height = 20
    Panels = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object chkDontShowThisDialog: TcxCheckBox
    Left = 8
    Top = 184
    Caption = 'don'#39't show this dialog again'
    Properties.OnEditValueChanged = chkDontShowThisDialogPropertiesEditValueChanged
    TabOrder = 6
    Width = 161
  end
  object cxLabel1: TcxLabel
    Left = 21
    Top = 132
    Caption = 'Filename:'
  end
  object edtFileName: TcxButtonEdit
    Left = 77
    Top = 131
    Anchors = [akLeft, akTop, akRight]
    ParentShowHint = False
    Properties.Buttons = <>
    ShowHint = True
    TabOrder = 2
    OnKeyPress = edtFileNameKeyPress
    Width = 375
  end
  object edtFileExt: TcxTextEdit
    Left = 461
    Top = 131
    Anchors = [akTop, akRight]
    TabOrder = 3
    Width = 48
  end
  object cxLabel2: TcxLabel
    Left = 454
    Top = 135
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = '.'
    Style.TextStyle = [fsBold]
    Height = 17
    Width = 6
  end
  object pmTemplates: TPopupMenu
    AutoHotkeys = maManual
    Left = 436
    Top = 52
    object pmiDatabase: TMenuItem
      Caption = '[Database]'
      OnClick = pmiItemClick
    end
    object pmiSchemaType: TMenuItem
      Caption = '[SchemaType]'
      OnClick = pmiItemClick
    end
    object pmiObjectType: TMenuItem
      Caption = '[ObjectType]'
      OnClick = pmiItemClick
    end
    object pmiObjectOwner: TMenuItem
      Caption = '[ObjectOwner]'
      OnClick = pmiItemClick
    end
    object pmiObjectName: TMenuItem
      Caption = '[ObjectName]'
      OnClick = pmiItemClick
    end
    object pmiUID: TMenuItem
      Caption = '[UID]'
      Hint = 'Unique ID'
      OnClick = pmiItemClick
    end
  end
  object fsSaveNewFile: TJvFormStorage
    AppStorage = dmData.aifsMain
    AppStoragePath = 'frmSaveNewFile\'
    Options = [fpSize, fpLocation]
    StoredProps.Strings = (
      'edtTempFilenameFormat.Text'
      'rbDoNothing.Checked'
      'rbSaveAs.Checked'
      'rbSave2Temp.Checked')
    StoredValues = <>
    Left = 256
  end
  object dlgSaveAs: TSaveDialog
    Options = [ofOverwritePrompt, ofPathMustExist, ofEnableSizing]
    Left = 208
    Top = 156
  end
end
