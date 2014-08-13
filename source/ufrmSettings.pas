unit ufrmSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxContainer, cxEdit, cxCheckBox, Menus,
  StdCtrls, cxButtons, cxPC, cxTextEdit, cxLabel, cxGroupBox,
  cxRadioGroup, cxCurrencyEdit,
  ActnList, XPStyleActnCtrls, ActnMan, cxMaskEdit, cxSpinEdit,
  cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters;

type
  TfrmSettings = class(TForm)
    btnApply: TcxButton;
    btnCancel: TcxButton;
    btnSave: TcxButton;
    pcSettings: TcxPageControl;
    tsFilesAndDialogs: TcxTabSheet;
    chkShowSaveAsFileDialog: TcxCheckBox;
    tsLogon: TcxTabSheet;
    chkSavePasswordForLogon: TcxCheckBox;
    chkShowSaveAsFileDialog4ReadOnly: TcxCheckBox;
    tsUpdate: TcxTabSheet;
    chkDeleteTempFilesOnStart: TcxCheckBox;
    chkDeleteOnStartConfirm: TcxCheckBox;
    cxGroupBox1: TcxGroupBox;
    gbUserPassword: TcxGroupBox;
    lblUserPass: TcxLabel;
    edtUser: TcxTextEdit;
    edtPassword: TcxTextEdit;
    gbProxy: TcxGroupBox;
    lblServer: TcxLabel;
    edtServer: TcxTextEdit;
    rbUseProxy: TcxRadioButton;
    rbUseSystemSettings: TcxRadioButton;
    rbNoProxy: TcxRadioButton;
    edtPort: TcxCurrencyEdit;
    chkAskPassword: TcxCheckBox;
    gbCheckOnlineUpdates: TcxGroupBox;
    btnCheckUpdate: TcxButton;
    rbAppStart: TcxRadioButton;
    rbDaily: TcxRadioButton;
    rbWeekly: TcxRadioButton;
    rbMonthly: TcxRadioButton;
    rbNever: TcxRadioButton;
    lblLatestVersion: TcxLabel;
    lblCurVersion: TcxLabel;
    lblLastCheck: TcxLabel;
    chkSaveSeparate: TcxCheckBox;
    amSettings: TActionManager;
    actSave: TAction;
    actCancel: TAction;
    actApply: TAction;
    actCheckNewVer: TAction;
    tsEditor: TcxTabSheet;
    gbComment: TcxGroupBox;
    edtFormatSimpleComment: TcxTextEdit;
    lbl1: TcxLabel;
    lbl2: TcxLabel;
    edtFormatSpecComment: TcxTextEdit;
    lblFormatSimpleComment: TcxLabel;
    lblFormatSpecComment: TcxLabel;
    chkUserGroupsExpanded: TcxCheckBox;
    chkStoreFileHistory: TcxCheckBox;
    edtCountHistoryFiles: TcxSpinEdit;
    chkStoreHistory4TmpFiles: TcxCheckBox;
    chkGenerateSpecAndBodyFile: TcxCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure EditValueChanged(Sender: TObject);
    procedure rbAppStartClick(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actCheckNewVerExecute(Sender: TObject);
  private
    FUpdateInterval: integer;

    procedure SaveSettings;
  public
    procedure SetUpdateInfo;
  end;

var
  frmSettings: TfrmSettings;

procedure ShowSettings(AOwner: TComponent; AIndexPage: integer);

implementation

uses
  udmData;

{$R *.dfm}

procedure ShowSettings(AOwner: TComponent; AIndexPage: integer);
begin
  // to avoid infinite loop when calling to check for updates from the form settings
  if not Assigned(frmSettings) then
  begin
    frmSettings := TfrmSettings.Create(AOwner);
    frmSettings.pcSettings.ActivePageIndex := AIndexPage;

    frmSettings.ShowModal;
  end;
end;

procedure TfrmSettings.actApplyExecute(Sender: TObject);
begin
  SaveSettings;
end;

procedure TfrmSettings.actCancelExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmSettings.actCheckNewVerExecute(Sender: TObject);
begin
  dmData.CheckNewVer(True);
end;

procedure TfrmSettings.actSaveExecute(Sender: TObject);
begin
  SaveSettings;
  Close;
end;

procedure TfrmSettings.EditValueChanged(Sender: TObject);
begin
  actApply.Enabled := True;
  actSave.Enabled  := True;

  if Sender is TcxCheckBox and ((Sender as TcxCheckBox).Name =
    'chkShowSaveAsFileDialog') then
    chkShowSaveAsFileDialog4ReadOnly.Enabled := (Sender as TcxCheckBox).Checked;
  if Sender is TcxCheckBox and ((Sender as TcxCheckBox).Name =
    'chkDeleteTempFilesOnStart') then
    chkDeleteOnStartConfirm.Enabled := (Sender as TcxCheckBox).Checked;

  if Sender is TcxTextEdit and ((Sender as TcxTextEdit).Name =
    'edtFormatSimpleComment') then
  begin
    lblFormatSimpleComment.Caption := '("' + edtFormatSimpleComment.Text + '")';
    lblFormatSimpleComment.Hint    := lblFormatSimpleComment.Caption;
  end;
  if Sender is TcxTextEdit and ((Sender as TcxTextEdit).Name =
    'edtFormatSpecComment') then
  begin
    lblFormatSpecComment.Caption := '("' + edtFormatSpecComment.Text + '")';
    lblFormatSpecComment.Hint    := lblFormatSpecComment.Caption;
  end;

  if Sender is TcxCheckBox and ((Sender as TcxCheckBox).Name =
    'chkStoreFileHistory') then
  begin
    edtCountHistoryFiles.Enabled     := (Sender as TcxCheckBox).Checked;
    chkStoreHistory4TmpFiles.Enabled := (Sender as TcxCheckBox).Checked;
  end;

end;

procedure TfrmSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action      := caFree;
  frmSettings := nil;
end;

procedure TfrmSettings.FormCreate(Sender: TObject);
begin
  with dmData.fsMainSettings do
  begin
    // Files and Dialogs
    chkShowSaveAsFileDialog.Checked := GShowSaveAsFileDialog;
    chkShowSaveAsFileDialog4ReadOnly.Checked := GShowSaveAsFileDialog4ReadOnly;
    chkDeleteTempFilesOnStart.Checked :=
      ReadBoolean('DeleteTempFilesOnStart', True);
    chkDeleteOnStartConfirm.Checked := ReadBoolean('DeleteOnStartConfirm', True);
    chkSaveSeparate.Checked := GSaveFilesSeparate;
    chkGenerateSpecAndBodyFile.Checked := GGenerateSpecAndBodyFile;

    chkStoreFileHistory.Checked := GStoreFileHistory;
    chkStoreHistory4TmpFiles.Checked := GStoreHistory4TmpFiles;
    edtCountHistoryFiles.Value := GCountHistoryFiles;
    //    edtStartTimeout4SaveNew.EditValue := ReadInteger('StartTimeout4SaveNew', 20);

    // Logon
    chkSavePasswordForLogon.Checked := GSavePasswordForLogon;
    chkUserGroupsExpanded.Checked   := ReadBoolean('UserGroupsAlwaysExpanded', True);

    // Internet and Update Settings
    rbNoProxy.Checked  := ReadBoolean('NoProxy', False);
    rbUseSystemSettings.Checked := ReadBoolean('UseProxySysSettings', True);
    rbUseProxy.Checked := ReadBoolean('UseProxy', False);

    edtServer.Text   := ReadString('ProxyServer');
    edtPort.Value    := ReadFloat('ProxyPort', 80);
    edtUser.Text     := ReadString('ProxyUser');
    edtPassword.Text := dmData.vcData.DecodeString(dmData.vcData.Key,
      ReadString('ProxyPassword'));
    chkAskPassword.Checked := ReadBoolean('AskForPassword', False);

    // Check Online Updates interval
    FUpdateInterval := ReadInteger('UpdateInterval', C_uiNever);
    case FUpdateInterval of
      C_uiAppStart: rbAppStart.Checked := True;
      C_uiDaily: rbDaily.Checked     := True;
      C_uiWeekly: rbWeekly.Checked   := True;
      C_uiMonthly: rbMonthly.Checked := True;
      C_uiNever: rbNever.Checked     := True;
    end;

    lblCurVersion.Caption := 'Current Version: ' + C_VERSION;
    SetUpdateInfo;

    // Edit Settings
    edtFormatSimpleComment.Text := GFormatSimpleComment;
    edtFormatSpecComment.Text   := GFormatSpecComment;
  end;

  actApply.Enabled := False;
  actSave.Enabled  := False;
end;

procedure TfrmSettings.rbAppStartClick(Sender: TObject);
begin
  actApply.Enabled := True;
  actSave.Enabled  := True;

  FUpdateInterval := (Sender as TcxRadioButton).Tag;
end;

procedure TfrmSettings.SaveSettings;
begin
  with dmData.fsMainSettings do
  begin
    // Files and Dialogs
    WriteBoolean('ShowSaveAsFileDialog', chkShowSaveAsFileDialog.Checked);
    GShowSaveAsFileDialog := chkShowSaveAsFileDialog.Checked;

    WriteBoolean('ShowSaveAsFileDialog4ReadOnly',
      chkShowSaveAsFileDialog4ReadOnly.Checked);
    GShowSaveAsFileDialog4ReadOnly := chkShowSaveAsFileDialog4ReadOnly.Checked;

    WriteBoolean('DeleteTempFilesOnStart', chkDeleteTempFilesOnStart.Checked);
    WriteBoolean('DeleteOnStartConfirm', chkDeleteOnStartConfirm.Checked);

    WriteBoolean('SaveSeparate', chkSaveSeparate.Checked);
    GSaveFilesSeparate := chkSaveSeparate.Checked;

    WriteBoolean('GenerateSpecAndBodyFile', chkGenerateSpecAndBodyFile.Checked);
    GGenerateSpecAndBodyFile := chkGenerateSpecAndBodyFile.Checked;

    WriteBoolean('StoreFileHistory', chkStoreFileHistory.Checked);
    GStoreFileHistory := chkStoreFileHistory.Checked;
    WriteBoolean('StoreHistory4TmpFiles', chkStoreHistory4TmpFiles.Checked);
    GStoreHistory4TmpFiles := chkStoreHistory4TmpFiles.Checked;
    WriteInteger('CountHistoryFiles', edtCountHistoryFiles.Value);
    GCountHistoryFiles := edtCountHistoryFiles.Value;
    //    WriteInteger('StartTimeout4SaveNew', edtStartTimeout4SaveNew.EditValue);


    // Logon
    WriteBoolean('SavePasswordForLogon', chkSavePasswordForLogon.Checked);
    GSavePasswordForLogon := chkSavePasswordForLogon.Checked;
    WriteBoolean('UserGroupsAlwaysExpanded', chkUserGroupsExpanded.Checked);

    // Internet Settings
    WriteBoolean('NoProxy', rbNoProxy.Checked);
    WriteBoolean('UseProxySysSettings', rbUseSystemSettings.Checked);
    WriteBoolean('UseProxy', rbUseProxy.Checked);
    WriteString('ProxyServer', edtServer.Text);
    WriteInteger('ProxyPort', edtPort.EditValue);
    WriteString('ProxyUser', edtUser.Text);
    WriteString('ProxyPassword',
      dmData.vcData.EncodeString(dmData.vcData.Key, edtPassword.Text));
    WriteBoolean('AskForPassword', chkAskPassword.Checked);

    // Check Online Updates interval
    WriteInteger('UpdateInterval', FUpdateInterval);

    // Edit Settings
    WriteString('FormatSimpleComment', AnsiQuotedStr(edtFormatSimpleComment.Text, '"'));
    GFormatSimpleComment := edtFormatSimpleComment.Text;
    WriteString('FormatSpecComment', AnsiQuotedStr(edtFormatSpecComment.Text, '"'));
    GFormatSpecComment := edtFormatSpecComment.Text;
  end;

  actApply.Enabled := False;
  actSave.Enabled  := False;
  dmData.IsWriteSettings := True;
end;

procedure TfrmSettings.SetUpdateInfo;
begin
  lblLastCheck.Caption     := 'Last Check: ' +
    FormatDateTime('yyyy-mm-dd', dmData.fsMainSettings.ReadFloat('LastCheckUpdate'));
  lblLatestVersion.Caption := 'Latest Version: ' +
    dmData.fsMainSettings.ReadString('LatestVersion', '_._');

  if C_VERSION <> dmData.fsMainSettings.ReadString('LatestVersion', '_._') then
    lblLatestVersion.Style.Font.Color := clRed
  else
    lblLatestVersion.Style.Font.Color := clWindowText;
end;

end.

