object frmWindows: TfrmWindows
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Windows'
  ClientHeight = 484
  ClientWidth = 572
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object grdWindows: TcxGrid
    Left = 0
    Top = 0
    Width = 572
    Height = 484
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 259
    object tvWindows: TcxGridDBTableView
      NavigatorButtons.ConfirmDelete = False
      DataController.DataSource = dmData.dsWindow
      DataController.KeyFieldNames = 'ID'
      DataController.Options = [dcoAnsiSort, dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoSortByDisplayText, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.CellHints = True
      OptionsBehavior.ImmediateEditor = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.Indicator = True
      OptionsView.IndicatorWidth = 10
      object clmWindowsRecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
      end
      object clmWindowsID: TcxGridDBColumn
        DataBinding.FieldName = 'ID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        VisibleForCustomization = False
      end
      object clmWindowsIDGroup: TcxGridDBColumn
        DataBinding.FieldName = 'IDGroup'
        Visible = False
        GroupIndex = 0
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 52
      end
      object clmWindowsCheck: TcxGridDBColumn
        DataBinding.FieldName = 'Check'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 20
      end
      object clmWindowsName: TcxGridDBColumn
        DataBinding.FieldName = 'Name'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Filtering = False
        Width = 143
      end
      object clmWindowsIDTypeScheme: TcxGridDBColumn
        DataBinding.FieldName = 'IDTypeScheme'
        Visible = False
        GroupIndex = 1
      end
      object clmWindowsIDTypeWindow: TcxGridDBColumn
        DataBinding.FieldName = 'IDTypeWindow'
      end
      object clmWindowsFilename: TcxGridDBColumn
        DataBinding.FieldName = 'Filename'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 200
      end
      object clmWindowsIDPLDev: TcxGridDBColumn
        DataBinding.FieldName = 'IDPLDev'
      end
    end
    object lvlWindows: TcxGridLevel
      GridView = tvWindows
    end
  end
  object fsWindows: TJvFormStorage
    AppStorage = dmData.aifsMain
    AppStoragePath = 'frmWindows\'
    StoredValues = <>
    Left = 32
    Top = 108
  end
end
