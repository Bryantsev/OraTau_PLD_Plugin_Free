unit ufrmQuickQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxContainer, cxEdit,
  cxGroupBox,
  cxPC,
  DB, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView, cxGrid, cxTextEdit, cxMemo, cxDBEdit, ExtCtrls,
  JvExExtCtrls, JvSplitter, dxBar,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  cxLabel,
  Menus, StdCtrls, cxButtons, dxStatusBar, cxCheckBox, cxDBExtLookupComboBox,
  
  JvComponentBase, JvFormPlacement, ActnList,
  XPStyleActnCtrls, ActnMan, StdActns, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxDBData;

type
  TfrmQuickQuery = class(TForm)
    gbQueryList:  TcxGroupBox;
    pcQuery:      TcxPageControl;
    tsQueryEdit:  TcxTabSheet;
    tsQueryResult: TcxTabSheet;
    tvQueryList:  TcxGridDBTableView;
    lvlQueryList: TcxGridLevel;
    grdQueryList: TcxGrid;
    tvQueryResult: TcxGridDBTableView;
    lvlQueryResult: TcxGridLevel;
    grdQueryResult: TcxGrid;
    clmQueryListID: TcxGridDBColumn;
    clmQueryListIDGroup: TcxGridDBColumn;
    clmQueryListIDTypeSchema: TcxGridDBColumn;
    clmQueryListName: TcxGridDBColumn;
    splQueryList: TJvSplitter;
    bmQuickQuery: TdxBarManager;
    barQuickQuery: TdxBar;
    btnAddQuery:  TdxBarButton;
    btnEditQuery: TdxBarButton;
    btnDeleteQuery: TdxBarButton;
    cxGroupBox1:  TcxGroupBox;
    cxGroupBox3:  TcxGroupBox;
    btnSave:      TcxButton;
    btnCancel:    TcxButton;
    sbQuickQuery: TdxStatusBar;
    btnFormatQuery: TcxButton;
    btnExecuteQuery: TcxButton;
    cxGroupBox4:  TcxGroupBox;
    edtResultText: TcxTextEdit;
    lblResult:    TcxLabel;
    btnPaste:     TcxButton;
    btnCopy:      TcxButton;
    elcbSchema:   TcxExtLookupComboBox;
    btnClose:     TdxBarButton;
    lblSchema:    TcxLabel;
    fsQuickQuery: TJvFormStorage;
    chkGridMode:  TcxCheckBox;
    lblName:      TcxLabel;
    edtQueryName: TcxDBTextEdit;
    lblDefaultSchema: TcxLabel;
    elcbDefaultSchema: TcxDBExtLookupComboBox;
    lcbTypeSchema: TcxDBLookupComboBox;
    lblTypeSchema: TcxLabel;
    lcbGroup:     TcxDBLookupComboBox;
    lblGroup:     TcxLabel;
    meQuery:      TcxDBMemo;
    btnOpenQueryFile: TcxButton;
    amQuickQuery: TActionManager;
    actExecuteQuery: TAction;
    actAddQuery:  TAction;
    actEditQuery: TAction;
    actDeleteQuery: TAction;
    actOpenQueryFile: TFileOpen;
    actFormatQuery: TAction;
    actCloseWindow: TAction;
    actPasteResultText: TAction;
    actCopyResultText: TAction;
    btnExecuteQueryTool: TdxBarButton;
    actSave:      TAction;
    actCancel:    TAction;
    btnSaveQuery: TdxBarButton;
    btnCancelEditQuery: TdxBarButton;
    chkClearDataAfterClose: TcxCheckBox;
    pmPopup:      TdxBarPopupMenu;
    actBestFit:   TAction;
    btnBestFit:   TdxBarButton;
    tvQueryResultColumn1: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure tvQueryResultCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: boolean);
    procedure tvQueryListFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtResultTextPropertiesEditValueChanged(Sender: TObject);
    procedure chkGridModePropertiesEditValueChanged(Sender: TObject);
    procedure tvQueryListDataControllerDataChanged(Sender: TObject);
    procedure actExecuteQueryExecute(Sender: TObject);
    procedure actCopyResultTextExecute(Sender: TObject);
    procedure actPasteResultTextExecute(Sender: TObject);
    procedure actAddQueryExecute(Sender: TObject);
    procedure actEditQueryExecute(Sender: TObject);
    procedure actCloseWindowExecute(Sender: TObject);
    procedure actDeleteQueryExecute(Sender: TObject);
    procedure actOpenQueryFileBeforeExecute(Sender: TObject);
    procedure actFormatQueryExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure tvQueryListCanFocusRecord(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; var AAllow: boolean);
    procedure tvQueryListKeyPress(Sender: TObject; var Key: char);
    procedure actBestFitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FQueryExecutedID: integer;

    procedure SetUser4QueryByFocus;

    //procedure QuickQueryEdit;
    procedure SetSaveButtonsState(AEnabled: boolean);
    procedure SetEditControlsState(AEnabled: boolean);
    procedure SetToolbarButtonsState;
  public
  end;

var
  frmQuickQuery: TfrmQuickQuery;

procedure ShowQuickQuery(AOwner: TComponent);

implementation

uses
  udmData, PlugInIntf;

{$R *.dfm}

procedure ShowQuickQuery(AOwner: TComponent);
begin
  if not Assigned(frmQuickQuery) then
    frmQuickQuery := TfrmQuickQuery.Create(AOwner);
  frmQuickQuery.ShowModal;
  //  frmQuickQuery.ParentWindow := IDE_GetClientHandle;
  //  frmQuickQuery.Show;
end;

procedure TfrmQuickQuery.actAddQueryExecute(Sender: TObject);
begin
  pcQuery.ActivePageIndex := 0;

  dmData.mdQuickQuery.Append;
  dmData.mdQuickQuery.FieldByName('Type').AsInteger := 1; // query
  SetSaveButtonsState(True);
  SetEditControlsState(True);

  edtQueryName.SetFocus;
  edtQueryName.SelText;
end;

procedure TfrmQuickQuery.actBestFitExecute(Sender: TObject);
begin
  tvQueryResult.ApplyBestFit;
end;

procedure TfrmQuickQuery.actCancelExecute(Sender: TObject);
begin
  SetToolbarButtonsState;
  SetSaveButtonsState(False);
  dmData.mdQuickQuery.Cancel;
end;

procedure TfrmQuickQuery.actCloseWindowExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmQuickQuery.actCopyResultTextExecute(Sender: TObject);
begin
  edtResultText.Text := Trim(edtResultText.Text);
  edtResultText.SelectAll;
  edtResultText.CopyToClipboard;
  Close;
end;

procedure TfrmQuickQuery.actDeleteQueryExecute(Sender: TObject);
begin
  if MessageBox(0, PChar('Are you sure, you want to delete the query <' +
    dmData.mdQuickQuery.FieldByName('Name').AsString + '>?'),
    'Query deletion confirmation', MB_ICONQUESTION or MB_YESNO or MB_DEFBUTTON2) =
    ID_YES then
    dmData.mdQuickQuery.Delete;

  SetToolbarButtonsState;
end;

procedure TfrmQuickQuery.actEditQueryExecute(Sender: TObject);
begin
  pcQuery.ActivePageIndex := 0; // tsQueryEdit

  dmData.mdQuickQuery.Edit;
  SetSaveButtonsState(True);
  edtQueryName.SetFocus;
  edtQueryName.SelText;
end;

procedure TfrmQuickQuery.actExecuteQueryExecute(Sender: TObject);
begin
  pcQuery.ActivePageIndex := 1; // tsQueryResult

  SetUser4QueryByFocus;

  if elcbSchema.EditValue = null then
  begin
    ShowMessage('Select a user to execute the query as.');
    elcbSchema.SetFocus;
  end
  else
  begin
    if (FQueryExecutedID <> dmData.mdQuickQuery.FieldByName('ID').AsInteger) or
      (dmData.qQuickQuery.SQL.Text <> dmData.mdQuickQuery.FieldByName(
      'Query').AsString) then
      tvQueryResult.ClearItems;
    dmData.ExecuteQuickQuery(elcbSchema.EditValue, meQuery.Text);
    //    if (FQueryExecutedID <> dmData.mdQuickQuery.FieldByName('ID').AsInteger) or
    //      (dmData.qQuickQuery.SQL.Text <> dmData.mdQuickQuery.FieldByName(
    //      'Query').AsString) then
    tvQueryResult.DataController.CreateAllItems(True);
    tvQueryResult.ApplyBestFit;

    FQueryExecutedID := dmData.mdQuickQuery.FieldByName('ID').AsInteger;
  end;

  //   if tvQueryResult.Columns[1].Options.SortByDisplayText = isbtDefault  then ShowMessage('test');
  //  tvQueryResult.Columns[1].Options.SortByDisplayText := isbtOff;
end;

procedure TfrmQuickQuery.actFormatQueryExecute(Sender: TObject);
begin
  if Trim(meQuery.Text) <> '' then
  begin
    dmData.mdQuickQuery.FieldByName('Query').AsString :=
      IDE_BeautifyText(PChar(meQuery.Text));
  end;
end;

procedure TfrmQuickQuery.actOpenQueryFileBeforeExecute(Sender: TObject);
var
  LFile: TStringList;
begin
  if actOpenQueryFile.Dialog.Execute(Self.Handle) then
  begin
    LFile := TStringList.Create;
    try
      LFile.LoadFromFile(actOpenQueryFile.Dialog.FileName);
      dmData.mdQuickQuery.FieldByName('Query').AsString := LFile.Text;

    finally
      FreeAndNil(LFile);
    end;
  end;
end;

procedure TfrmQuickQuery.actPasteResultTextExecute(Sender: TObject);
begin
  edtResultText.Text := Trim(edtResultText.Text);
  if not IDE_GetReadOnly then
    SendMessage(IDE_GetEditorHandle, EM_REPLACESEL, 0, integer(@edtResultText.Text[1]));

  Close;
end;

procedure TfrmQuickQuery.actSaveExecute(Sender: TObject);
begin
  dmData.mdQuickQuery.FieldByName('Type').AsInteger := 1; // query
  dmData.mdQuickQuery.Post;

  SetToolbarButtonsState;
  SetSaveButtonsState(False);
end;

procedure TfrmQuickQuery.chkGridModePropertiesEditValueChanged(Sender: TObject);
begin
  //tvQueryResult.DataController.DataModeController.GridMode := chkGridMode.Checked;
end;

procedure TfrmQuickQuery.edtResultTextPropertiesEditValueChanged(Sender: TObject);
begin
  if Trim(edtResultText.Text) <> '' then
  begin
    actPasteResultText.Enabled := True;
    actCopyResultText.Enabled  := True;
  end
  else
  begin
    actPasteResultText.Enabled := False;
    actCopyResultText.Enabled  := False;
  end;
end;

procedure TfrmQuickQuery.SetEditControlsState(AEnabled: boolean);
begin
  //  lcbGroup.Enabled     := AEnabled;
  //  meQuery.Enabled      := AEnabled;
  //  lcbTypeSchema.Enabled := AEnabled;
  //  elcbDefaultSchema.Enabled := AEnabled;
  //  edtQueryName.Enabled := AEnabled;
end;

procedure TfrmQuickQuery.SetSaveButtonsState(AEnabled: boolean);
begin
  actSave.Enabled   := AEnabled;
  actCancel.Enabled := AEnabled;
  actOpenQueryFile.Enabled := AEnabled;
  actFormatQuery.Enabled := AEnabled;

  actAddQuery.Enabled     := not AEnabled;
  actEditQuery.Enabled    := not AEnabled;
  actDeleteQuery.Enabled  := not AEnabled;
  actExecuteQuery.Enabled := not AEnabled;
  actCloseWindow.Enabled  := not AEnabled;
  grdQueryList.Enabled    := not AEnabled;
  if not AEnabled then
    SetToolbarButtonsState;


  lcbGroup.Enabled     := AEnabled;
  meQuery.Enabled      := AEnabled;
  lcbTypeSchema.Enabled := AEnabled;
  elcbDefaultSchema.Enabled := AEnabled;
  edtQueryName.Enabled := AEnabled;
end;

procedure TfrmQuickQuery.SetToolbarButtonsState;
begin
  if dmData.mdQuickQuery.RecordCount > 0 then
  begin
    actEditQuery.Enabled   := True;
    actDeleteQuery.Enabled := True;
  end
  else
  begin
    actEditQuery.Enabled   := False;
    actDeleteQuery.Enabled := False;
  end;
end;

procedure TfrmQuickQuery.SetUser4QueryByFocus;
begin
  if (elcbDefaultSchema.EditValue = null) and dmData.LocateLogonSchema then
    elcbSchema.EditValue := dmData.mdSchema.FieldByName('ID').AsInteger
  else
    elcbSchema.EditValue := elcbDefaultSchema.EditValue;
end;

procedure TfrmQuickQuery.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if chkClearDataAfterClose.Checked then
    dmData.CloseQuickQuery;
end;

procedure TfrmQuickQuery.FormCreate(Sender: TObject);
begin
  FQueryExecutedID := 0;
end;

procedure TfrmQuickQuery.FormShow(Sender: TObject);
begin
  edtResultText.Text := '';
  if chkClearDataAfterClose.Checked then
    tvQueryResult.ClearItems;
  pcQuery.ActivePageIndex := 1; // tsQueryResult
  SetToolbarButtonsState;

  if (dmData.qQuickQuery.RecordCount = 0) and (dmData.mdQuickQuery.RecordCount > 0) then
  begin
    tvQueryList.Controller.GoToFirst;
    while not tvQueryList.Controller.SelectedRecords[0].IsData do
      tvQueryList.Controller.GoToNext(True);

    if (elcbDefaultSchema.EditValue = null) and dmData.LocateLogonSchema then
      elcbSchema.EditValue := dmData.mdSchema.FieldByName('ID').AsInteger
    else
      elcbSchema.EditValue := elcbDefaultSchema.EditValue;
  end;

  tvQueryList.Control.SetFocus;
end;

procedure TfrmQuickQuery.tvQueryListCanFocusRecord(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; var AAllow: boolean);
begin
  AAllow := ARecord.IsData;
end;

procedure TfrmQuickQuery.tvQueryListDataControllerDataChanged(Sender: TObject);
begin
  SetToolbarButtonsState;
end;

procedure TfrmQuickQuery.tvQueryListFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: boolean);
begin
  SetUser4QueryByFocus;
end;

procedure TfrmQuickQuery.tvQueryListKeyPress(Sender: TObject; var Key: char);
begin
  if Key = Chr(13) then
    actExecuteQuery.Execute;
end;

procedure TfrmQuickQuery.tvQueryResultCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: boolean);
begin
  if ssCtrl in AShift then
    edtResultText.SelText := '-- ' + ACellViewInfo.Text + ' '
  else
    edtResultText.SelText := ACellViewInfo.Text + ' ';
end;

end.

