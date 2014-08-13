unit ufrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  cxEdit, DB, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxmdaset,
  cxCheckBox, dxBar,
  cxContainer, Menus,
  dxStatusBar, JvFormPlacement, JvComponentBase,
  JvAppIniStorage, ExtCtrls, JvExExtCtrls, JvSplitter,
  JvSplit, XPMan, uframeScript, AppEvnts, JvProgramVersionCheck,
  JvPropertyStore,
  XPStyleActnCtrls, ActnList, ActnMan, cxCustomData, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxFilter, cxData, cxDataStorage, cxDBData, cxDBLookupComboBox;

type
  TfrmMain = class(TForm)
    bmMain:      TdxBarManager;
    pmSchema:    TdxBarPopupMenu;
    barSchema:   TdxBar;
    btnSchemaAdd: TdxBarButton;
    btnSchemaEdit: TdxBarButton;
    btnSchemaCopy: TdxBarButton;
    btnSchemaDelete: TdxBarButton;
    barMainMenu: TdxBar;
    btnClose:    TdxBarButton;
    bsiFile:     TdxBarSubItem;
    btnSchemaImport: TdxBarButton;
    sbMain:      TdxStatusBar;
    fsMain:      TJvFormStorage;
    bsiUser:     TdxBarSubItem;
    btnSchemesSelectFiltered: TdxBarButton;
    btnSchemesUnSelectFiltered: TdxBarButton;
    btnSchemaGroups: TdxBarButton;
    btnSchemaTypes: TdxBarButton;
    bsiDirectories: TdxBarSubItem;
    bsiHelp:     TdxBarSubItem;
    btnAbout:    TdxBarButton;
    btnSchemesInvertFiltered: TdxBarButton;
    btnSchemesSelectFilteredOnly: TdxBarButton;
    btnHelp:     TdxBarButton;
    btnSite:     TdxBarButton;
    btnEnterKey: TdxBarButton;
    xpmnfstMain: TXPManifest;
    btnLogon:    TdxBarButton;
    frameScript: TframeScript;
    splScript:   TJvSplitter;
    tmrMain:     TTimer;
    pnlLogon:    TPanel;
    grdSchema:   TcxGrid;
    tvSchema:    TcxGridDBTableView;
    clmSchemaID: TcxGridDBColumn;
    clmSchemaCheck: TcxGridDBColumn;
    clmSchemaIDGroup: TcxGridDBColumn;
    clmSchemaDB: TcxGridDBColumn;
    clmSchemaSchema: TcxGridDBColumn;
    clmSchemaName: TcxGridDBColumn;
    clmSchemaIDType: TcxGridDBColumn;
    lvlSchema:   TcxGridLevel;
    pnlChecks:   TPanel;
    chkShowGroupBy: TcxCheckBox;
    amMain:      TActionManager;
    actSchemaAdd: TAction;
    actSchemaEdit: TAction;
    actSchemaDelete: TAction;
    actSchemaImport: TAction;
    actSchemaCopy: TAction;
    actSchemaLogon: TAction;
    actSchemesSelectFilteredOnly: TAction;
    actSchemesSelectFiltered: TAction;
    actSchemesUnSelectFiltered: TAction;
    actSchemesInvertFiltered: TAction;
    clmSchemaRecId: TcxGridDBColumn;
    clmSchemaPassword: TcxGridDBColumn;
    clmSchemaNameIsBold: TcxGridDBColumn;
    clmSchemaNameBackgroundColor: TcxGridDBColumn;
    clmSchemaNameTextColor: TcxGridDBColumn;
    clmSchemaVisible: TcxGridDBColumn;
    chkShowAllUsers: TcxCheckBox;
    actSchemaVisible: TAction;
    btnSchemaVisible: TdxBarButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnSchemaGroupsClick(Sender: TObject);
    procedure btnSchemaTypesClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure btnSiteClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnEnterKeyClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tvSchemaCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: boolean);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure tmrMainTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkShowGroupByPropertiesEditValueChanged(Sender: TObject);
    procedure actSchemaAddExecute(Sender: TObject);
    procedure actSchemaEditExecute(Sender: TObject);
    procedure actSchemaDeleteExecute(Sender: TObject);
    procedure actSchemaImportExecute(Sender: TObject);
    procedure actSchemaCopyExecute(Sender: TObject);
    procedure actSchemaLogonExecute(Sender: TObject);
    procedure actSchemesSelect(Sender: TObject);
    procedure tvSchemaCanFocusRecord(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; var AAllow: boolean);
    procedure tvSchemaKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure tvSchemaDataControllerFilterRecord(ADataController:
      TcxCustomDataController; ARecordIndex: integer; var Accept: boolean);
    procedure chkShowAllUsersPropertiesEditValueChanged(Sender: TObject);
    procedure actSchemaVisibleExecute(Sender: TObject);
    procedure tvSchemaFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: boolean);
  private
    procedure SelectFiltered(ASelect: integer);
    procedure SetFocus2LogonRec;
    procedure Logon;

  public
  end;

var
  frmScriptExecute: TfrmMain;
  frmLogon:     TfrmMain;
  frmLogonFast: TfrmMain;

procedure Logon;
procedure LogonFast;
procedure ScriptExecute;

implementation

uses
  udmData, ufrmSchemaAE, ufrmSchemaImport, ufrmSchemaGroups,
  ufrmSchemaTypes, ufrmAbout, ShellAPI;

{$R *.dfm}

procedure Logon;
begin
  with frmLogon do
  begin
    if not Assigned(frmLogon) then
    begin
      frmLogon := TfrmMain.Create(Application);

      Caption := 'Logon';
      Tag     := 2;

      clmSchemaCheck.Visible := False;

      splScript.Visible   := False;
      frameScript.Visible := False;
      pnlLogon.Align      := alClient;
      grdSchema.Align     := alClient;

      chkShowGroupBy.Checked := True;

      Left  := 0;
      Width := 230;

      btnSchemesSelectFiltered.Visible     := ivNever;
      btnSchemesUnSelectFiltered.Visible   := ivNever;
      btnSchemesInvertFiltered.Visible     := ivNever;
      btnSchemesSelectFilteredOnly.Visible := ivNever;

      tvSchema.OnDblClick := actSchemaLogonExecute;

      sbMain.Panels[0].Text := 'Double Click to logon. Escape to exit';

      fsMain.AppStoragePath := 'frmLogon\';
      fsMain.RestoreFormPlacement;
      fsMain.Active := True;

      tvSchema.OptionsView.GroupByBox := chkShowGroupBy.Checked;
    end;

    SetFocus2LogonRec;

    ShowModal;
  end;
end;

procedure LogonFast;
begin
  with frmLogonFast do
  begin
    if not Assigned(frmLogonFast) then
    begin
      frmLogonFast := TfrmMain.Create(Application);

      Caption := 'Fast Logon';
      Tag     := 1;

      tvSchema.OnCellClick   := frmLogonFast.tvSchemaCellClick;
      barSchema.Visible      := False;
      tvSchema.OptionsView.GroupByBox := False;
      clmSchemaCheck.Visible := False;

      chkShowGroupBy.Checked := False;

      splScript.Visible   := False;
      frameScript.Visible := False;
      pnlLogon.Align      := alClient;
      grdSchema.Align     := alClient;

      sbMain.Panels[0].Text := 'Click or Enter to logon. Escape to exit';

      Left  := 0;
      Width := 230;

      fsMain.AppStoragePath := 'frmLogonFast\';
      fsMain.RestoreFormPlacement;
      fsMain.Active := True;

      tvSchema.OptionsView.GroupByBox := chkShowGroupBy.Checked;
    end;

    SetFocus2LogonRec;
    //tmrMain.Enabled := True;

    ShowModal;
  end;
end;

procedure ScriptExecute;
begin
  with frmScriptExecute do
  begin
    if not Assigned(frmScriptExecute) then
    begin
      frmScriptExecute := TfrmMain.Create(Application);

      Caption := 'Database script execution';
      Tag     := 3;

      BorderIcons := [biSystemMenu, biMaximize];

      clmSchemaCheck.Visible := True;
      clmSchemaCheck.VisibleForCustomization := False;
      btnLogon.Visible := ivNever;

      OnKeyDown := nil;
      sbMain.Panels[0].Text := '';

      chkShowGroupBy.Checked := True;
      frameScript.mruScriptFile.Properties.OnButtonClick :=
        frameScript.mruScriptFilePropertiesButtonClick;
      frameScript.mruScriptFile.Properties.OnEditValueChanged :=
        frameScript.mruScriptFilePropertiesEditValueChanged;

      tvSchema.OnDblClick := actSchemaEditExecute;
      tvSchema.OptionsSelection.CellSelect := True;

      fsMain.AppStoragePath := 'frmScriptExecute\';
      fsMain.RestoreFormPlacement;
      fsMain.Active := True;

      frameScript.fsScript.RestoreFormPlacement;
      frameScript.fsScript.Active := True;

      tvSchema.OptionsView.GroupByBox := chkShowGroupBy.Checked;
      tvSchema.DataController.Refresh;

      tvSchema.Controller.GoToFirst;
    end;

    ShowModal;
  end;
end;

procedure TfrmMain.actSchemaLogonExecute(Sender: TObject);
begin
  Logon;
end;

procedure TfrmMain.actSchemaAddExecute(Sender: TObject);
begin
  dmData.mdSchema.Append;
  ShowSchemaAE(Self);
end;

procedure TfrmMain.actSchemaCopyExecute(Sender: TObject);
var
  LDB, LUserName, LPassword, LSchema: string;
  LIDGroup, LIDType: integer;
begin
  with dmData.mdSchema do
  begin
    LIDGroup := FieldByName('IDGroup').AsInteger;
    LIDType  := FieldByName('IDType').AsInteger;
    //    LServer  := FieldByName('Server').AsString;
    LDB      := FieldByName('DB').AsString;
    LUserName := FieldByName('UserName').AsString;
    LPassword := FieldByName('Password').AsString;
    LSchema  := FieldByName('Schema').AsString;

    Append;
    FieldByName('IDGroup').AsInteger := LIDGroup;
    FieldByName('IDType').AsInteger := LIDType;
    //    FieldByName('Server').AsString := LServer;
    FieldByName('DB').AsString     := LDB;
    FieldByName('UserName').AsString := LUserName;
    FieldByName('Password').AsString := LPassword;
    FieldByName('Schema').AsString := LSchema;

    ShowSchemaAE(Self);
  end;
end;

procedure TfrmMain.actSchemaDeleteExecute(Sender: TObject);
begin
  if MessageDlg('Are you sure?', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    dmData.mdSchema.Delete;
  end;
end;

procedure TfrmMain.actSchemaEditExecute(Sender: TObject);
begin
  dmData.mdSchema.Edit;
  ShowSchemaAE(Self);
end;

procedure TfrmMain.actSchemaVisibleExecute(Sender: TObject);
begin
  with dmData.mdSchema do
  begin
    Edit;
    FieldByName('Visible').AsBoolean := not FieldByName('Visible').AsBoolean;
    Post;
  end;
end;

procedure TfrmMain.actSchemaImportExecute(Sender: TObject);
begin
  ShowSchemaImport(Self);
end;

procedure TfrmMain.actSchemesSelect(Sender: TObject);
begin
  if Sender is TAction then
    SelectFiltered((Sender as TAction).Tag);
end;

procedure TfrmMain.btnAboutClick(Sender: TObject);
begin
  ShowAbout(Self);
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.btnHelpClick(Sender: TObject);
begin
  ShellExecute(GetDesktopWindow(), 'open',
    PAnsiChar('help.chm'), '', '',
    SW_MAXIMIZE);
end;

procedure TfrmMain.btnSchemaGroupsClick(Sender: TObject);
begin
  ShowSchemaGroups(Self);
end;

procedure TfrmMain.btnSchemaTypesClick(Sender: TObject);
begin
  ShowSchemaTypes(Self);
end;

procedure TfrmMain.btnSiteClick(Sender: TObject);
begin
  ShellExecute(GetDesktopWindow(), 'open',
    PAnsiChar('http://www.oratau.com'), '', '',
    SW_MAXIMIZE);
end;

procedure TfrmMain.chkShowAllUsersPropertiesEditValueChanged(Sender: TObject);
begin
  tvSchema.DataController.Refresh;
end;

procedure TfrmMain.chkShowGroupByPropertiesEditValueChanged(Sender: TObject);
begin
  tvSchema.OptionsView.GroupByBox := chkShowGroupBy.Checked;
end;

procedure TfrmMain.btnEnterKeyClick(Sender: TObject);
begin
  //  ShowEnterKeyDialog(0);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  case Self.Tag of
    1, 2:
    begin
      tmrMain.Enabled := False;
      Action := caHide;
    end;
    3:
    begin
      Action := caFree;
      frmScriptExecute := nil;
    end;
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  case Self.Tag of
    1, 2:
    begin
    end;
    3:
    begin
      frameScript.fsScript.SaveFormPlacement;
    end;
  end;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  grdSchema.SetFocus;
  if Assigned(tvSchema.Controller.FocusedRecord) then
  begin
    btnSchemaVisible.Down    :=
      VarIsNull(tvSchema.Controller.FocusedRecord.Values[clmSchemaVisible.Index]) or
      tvSchema.Controller.FocusedRecord.Values[clmSchemaVisible.Index];
    actSchemaEdit.Enabled    := True;
    actSchemaDelete.Enabled  := True;
    actSchemaCopy.Enabled    := True;
    actSchemaVisible.Enabled := True;
    actSchemaLogon.Enabled   := True;
  end
  else
  begin
    actSchemaEdit.Enabled    := False;
    actSchemaDelete.Enabled  := False;
    actSchemaCopy.Enabled    := False;
    actSchemaVisible.Enabled := False;
    actSchemaLogon.Enabled   := False;
  end;

end;

procedure TfrmMain.Logon;
begin
  dmData.Logon(True);
  Close;
end;

procedure TfrmMain.SetFocus2LogonRec;
 //var
 //  LUserName, LPassword, LDatabase: PChar;
begin
  if not dmData.fsMainSettings.ReadBoolean('UserGroupsAlwaysExpanded', True) then
  begin
    tvSchema.DataController.Options :=
      [dcoAnsiSort, dcoCaseInsensitive, dcoAssignGroupingValues,
      dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoSortByDisplayText,
      dcoImmediatePost];
    tvSchema.ViewData.Collapse(True);
  end
  else
  begin
    tvSchema.DataController.Options :=
      [dcoAnsiSort, dcoCaseInsensitive, dcoAssignGroupingValues,
      dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoSortByDisplayText,
      dcoGroupsAlwaysExpanded, dcoImmediatePost];
  end;

  tvSchema.Controller.GoToFirst;
  dmData.LocateLogonSchema;

  if (tvSchema.ViewData.RowCount > 0) and
    tvSchema.Controller.SelectedRecords[0].Expandable then
    tvSchema.Controller.SelectedRecords[0].Expand(True);

  if (tvSchema.ViewData.RowCount > 0) then
    while not tvSchema.Controller.SelectedRecords[0].IsData do
      tvSchema.Controller.GoToNext(True);
end;

procedure TfrmMain.SelectFiltered(ASelect: integer);
var
  LID, LSchemaID: variant;
  i: integer;
  LRecord: TcxCustomGridRecord;
begin
  LID := dmData.mdSchema['id'];
  with dmData.mdSchema do
  begin
    DisableControls;
    AfterPost := nil;// disable save to file

    try
      // Установить отметки ТОЛЬКО на отфильтрованные записи
      if ASelect = 3 then
      begin
        First;
        while not EOF do
        begin
          Edit;
          dmData.mdSchema['check'] := False;
          Post;

          Next;
        end;
      end;

      // ска��иро��ание ����фильтр��ванных ��������т��ок
      for i := 0 to tvSchema.ViewData.RowCount - 1 do
      begin
        LRecord   := tvSchema.ViewData.GetRecordByRecordIndex(
          tvSchema.ViewData.Rows[i].RecordIndex);
        LSchemaID := LRecord.Values[clmSchemaID.Index];

        if (tvSchema.ViewData.Rows[i].IsData) and (Locate('id', LSchemaID, [])) then
        begin
          Edit;
          case ASelect of
            0: // Снять отметку
            begin
              dmData.mdSchema['check'] := False;
            end;
            1, 3: // Установить отметку
            begin
              dmData.mdSchema['check'] := True;
            end;
            2: // Инвертирова��ь отметк��
            begin
              dmData.mdSchema['check'] :=
                not dmData.mdSchema.FieldByName('check').AsBoolean;
            end;

          end;
          Post;
        end;
      end;

      Locate('id', LID, []);

    finally
      AfterPost := dmData.mdSchemaAfterPost;// enable save to file
      dmData.SaveDataFile(dmData.mdSchema, C_SCHEMES_FILE);
      EnableControls;
    end;
  end;
end;

procedure TfrmMain.tmrMainTimer(Sender: TObject);
begin
  tmrMain.Enabled := False;

  if (Tag = 1) and Visible and not Active then
  begin
    //Close;
    Exit;
  end;

  tmrMain.Enabled := True;
end;

procedure TfrmMain.tvSchemaCanFocusRecord(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; var AAllow: boolean);
begin
  AAllow := ARecord.IsData;
end;

procedure TfrmMain.tvSchemaCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: boolean);
begin
  if (AButton = mbLeft) and ACellViewInfo.GridRecord.IsData then
    Logon;
end;

procedure TfrmMain.tvSchemaDataControllerFilterRecord(ADataController:
  TcxCustomDataController; ARecordIndex: integer; var Accept: boolean);
begin
  Accept := chkShowAllUsers.Checked or
    VarIsNull(ADataController.Values[ARecordIndex, clmSchemaVisible.Index]) or
    ADataController.Values[ARecordIndex, clmSchemaVisible.Index];
end;

procedure TfrmMain.tvSchemaFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: boolean);
begin
  if Assigned(AFocusedRecord) then
  begin
    btnSchemaVisible.Down    :=
      VarIsNull(AFocusedRecord.Values[clmSchemaVisible.Index]) or
      AFocusedRecord.Values[clmSchemaVisible.Index];
    actSchemaEdit.Enabled    := True;
    actSchemaDelete.Enabled  := True;
    actSchemaCopy.Enabled    := True;
    actSchemaVisible.Enabled := True;
    actSchemaLogon.Enabled   := True;
  end
  else
  begin
    actSchemaEdit.Enabled    := False;
    actSchemaDelete.Enabled  := False;
    actSchemaCopy.Enabled    := False;
    actSchemaVisible.Enabled := False;
    actSchemaLogon.Enabled   := False;
  end;
end;

procedure TfrmMain.tvSchemaKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  // only for fast logon
  if (Tag = 1) and (Key = VK_RETURN) then
    Logon;
end;

end.

