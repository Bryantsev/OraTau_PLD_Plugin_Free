unit ufrmSaveNewFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxTextEdit, cxControls, cxContainer, cxEdit, cxLabel,
  cxMaskEdit, cxButtonEdit, Menus,
  StdCtrls, cxButtons, cxCheckBox, cxGroupBox,
  cxRadioGroup, dxStatusBar, JvComponentBase, JvFormPlacement, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters;

type
  TfrmSaveNewFile = class(TForm)
    btnSaveAs: TcxButton;
    btnDoNothing: TcxButton;
    rgButtonDefault: TcxRadioGroup;
    gbTempFile: TcxGroupBox;
    lblFormat: TcxLabel;
    lblFilename: TcxLabel;
    edtTempFilename: TcxButtonEdit;
    edtTempFilenameFormat: TcxButtonEdit;
    btnFormatDefault: TcxButton;
    btnSave2Temp: TcxButton;
    rbSave2Temp: TcxRadioButton;
    rbSaveAs: TcxRadioButton;
    rbDoNothing: TcxRadioButton;
    lblPoint: TcxLabel;
    edtTempFileExt: TcxTextEdit;
    pmTemplates: TPopupMenu;
    pmiObjectType: TMenuItem;
    pmiSchemaType: TMenuItem;
    pmiObjectName: TMenuItem;
    pmiUID: TMenuItem;
    pmiDatabase: TMenuItem;
    sbSaveNew: TdxStatusBar;
    lblTempDirectory: TcxLabel;
    edtTempDirectory: TcxButtonEdit;
    fsSaveNewFile: TJvFormStorage;
    pmiObjectOwner: TMenuItem;
    chkDontShowThisDialog: TcxCheckBox;
    cxLabel1: TcxLabel;
    edtFileName: TcxButtonEdit;
    edtFileExt: TcxTextEdit;
    cxLabel2: TcxLabel;
    dlgSaveAs: TSaveDialog;
    btnOpenTmpFolder: TcxButton;
    procedure btnFormatDefaultClick(Sender: TObject);
    procedure pmiItemClick(Sender: TObject);
    procedure edtTempFilenameFormatPropertiesEditValueChanged(Sender: TObject);
    procedure edtTempFilenameFormatPropertiesButtonClick(Sender: TObject;
      AButtonIndex: integer);
    procedure edtTempFilenamePropertiesEditValueChanged(Sender: TObject);
    procedure edtTempDirectoryPropertiesEditValueChanged(Sender: TObject);
    procedure rbSetDefaultButtonClick(Sender: TObject);
    procedure btnDoNothingClick(Sender: TObject);
    procedure btnSave2TempClick(Sender: TObject);
    procedure btnSaveAsClick(Sender: TObject);
    procedure chkDontShowThisDialogPropertiesEditValueChanged(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOpenTmpFolderClick(Sender: TObject);
    procedure edtTempFilenameKeyPress(Sender: TObject; var Key: char);
    procedure edtFileNameKeyPress(Sender: TObject; var Key: char);
  private
    FFileNameCur: string;
    FWindowType:  integer;
    FObjectType:  string;

    procedure SetDefaultButton;
  public
    procedure SetFileName(ASetTempFileName, ASetFileName: boolean);
  end;

var
  frmSaveNewFile: TfrmSaveNewFile;

procedure ShowSaveAsFile;

implementation

uses
  PlugInIntf, udmData, StrUtils, ShellAPI, JclSysInfo;

{$R *.dfm}

procedure ShowSaveAsFile;
var
  LWindowCaption: array[0..127] of char;
begin
  GetWindowText(IDE_GetChildHandle, @LWindowCaption, 128);

  if not IDE_CanSaveWindow or (Pos('Cursor resultset', LWindowCaption) > 0) then
    Exit;

  if not Assigned(frmSaveNewFile) then
    frmSaveNewFile := TfrmSaveNewFile.Create(nil);

  with frmSaveNewFile do
  begin
    FFileNameCur := IDE_Filename;
    FWindowType  := IDE_GetWindowType;
    SetFileName(True, True);

    ShowModal;
  end;
end;

procedure TfrmSaveNewFile.btnDoNothingClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSaveNewFile.btnFormatDefaultClick(Sender: TObject);
begin
  if MessageDlg('Are you sure?', mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
    edtTempFilenameFormat.Text := 'tmp_[ObjectType]_[SchemaType]_[ObjectName]_[UID]';
end;

procedure TfrmSaveNewFile.btnOpenTmpFolderClick(Sender: TObject);
begin
  ShellExecute(GetDesktopWindow(), 'open', PChar(GAppTmpFilesDir), '', '', SW_NORMAL);
end;

procedure TfrmSaveNewFile.btnSave2TempClick(Sender: TObject);
begin
  if not FileExists(GAppTmpFilesDir + edtTempFilename.Text + '.' +
    edtTempFileExt.Text) or (MessageBox(Application.Handle,
    'File already exists.' + #13#10 + 'Do you want to overwrite it?',
    'Confirm', MB_ICONQUESTION or MB_YESNO or MB_DEFBUTTON2) = ID_YES) then
  begin
    IDE_SetFilename(PChar(edtTempDirectory.Text + edtTempFilename.Text +
      '.' + edtTempFileExt.Text));
    IDE_SaveFile;

    Close;
  end;
end;

procedure TfrmSaveNewFile.btnSaveAsClick(Sender: TObject);
var
  LDefaultDir: string;

  procedure GetDefaultDir;
  begin
    case FWindowType of
      wtProcEdit: LDefaultDir := StrPas(IDE_GetGeneralPref('ProgramFileDir'));
      wtTest: LDefaultDir     := StrPas(IDE_GetGeneralPref('TestScriptDir'));
      wtSQL: LDefaultDir      := StrPas(IDE_GetGeneralPref('SQLScriptDir'));
      wtReport: LDefaultDir   := StrPas(IDE_GetGeneralPref('ReportFileDir'));
      wtCommand: LDefaultDir  := StrPas(IDE_GetGeneralPref('CommandFileDir'));
      wtDiagram: LDefaultDir  := StrPas(IDE_GetGeneralPref('DiagramFileDir'));
      wtProject: LDefaultDir  := StrPas(IDE_GetGeneralPref('ProjectsDir'));
      else
        LDefaultDir := '';
    end;
  end;

begin
  Self.Hide;

  try
    with dlgSaveAs do
    begin
      GetDefaultDir;

      Filter     := IDE_GetFileTypes(FWindowType);
      //'*.' + edtFileExt.Text + '|*.' + edtFileExt.Text + '|All files (*.*)|*.*';
      FileName   := edtFileName.Text + '.' + edtFileExt.Text;
      DefaultExt := edtFileExt.Text;
      if (FFileNameCur <> '') and (ExtractFilePath(FFileNameCur) <> GAppTmpFilesDir) then
        InitialDir := ExtractFilePath(FFileNameCur);

      if (LDefaultDir <> '') and ((FFileNameCur = '') or
        (ExtractFilePath(FFileNameCur) = GAppTmpFilesDir)) then
        InitialDir := LDefaultDir;

      if Execute(Application.Handle) then
      begin
        IDE_SetFilename(PChar(FileName));
        IDE_SaveFile;

        if GSaveFilesSeparate and (FWindowType = wtProcEdit) then
        begin
          if (IDE_TabInfo(1) <> '') then
            dmData.SaveSpecAndBodySeparate(FileName)
          else
            dmData.SavePackageTypeInOne(FileName);
        end;
      end;
    end;

  finally
    Close;
  end;
end;

procedure TfrmSaveNewFile.chkDontShowThisDialogPropertiesEditValueChanged(
  Sender: TObject);
begin
  dmData.fsMainSettings.WriteBoolean('ShowSaveAsFileDialog', not
    chkDontShowThisDialog.Checked);
  GShowSaveAsFileDialog := not chkDontShowThisDialog.Checked;
end;

procedure TfrmSaveNewFile.edtFileNameKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    btnSaveAsClick(nil);
end;

procedure TfrmSaveNewFile.edtTempDirectoryPropertiesEditValueChanged(Sender: TObject);
begin
  edtTempDirectory.Hint := edtTempDirectory.Text;
end;

procedure TfrmSaveNewFile.edtTempFilenameFormatPropertiesButtonClick(Sender: TObject;
  AButtonIndex: integer);
begin
  pmTemplates.Popup(Self.Left + edtTempFilenameFormat.Left + edtTempFilenameFormat.Width,
    Self.Top + edtTempFilenameFormat.Top + edtTempFilenameFormat.Height);
end;

procedure TfrmSaveNewFile.edtTempFilenameFormatPropertiesEditValueChanged(
  Sender: TObject);
begin
  if MessageBox(Application.Handle, 'Update the name of a temp file?',
    'Confirmation', MB_ICONQUESTION or MB_YESNO or MB_DEFBUTTON1) = ID_YES then
    SetFileName(True, False);
  edtTempFilenameFormat.Hint := edtTempFilenameFormat.Text;
end;

procedure TfrmSaveNewFile.edtTempFilenameKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    btnSave2TempClick(nil);
end;

procedure TfrmSaveNewFile.edtTempFilenamePropertiesEditValueChanged(Sender: TObject);
begin
  edtTempFilename.Hint := edtTempFilename.Text;
end;

procedure TfrmSaveNewFile.FormShow(Sender: TObject);
begin
  SetDefaultButton;
end;

procedure TfrmSaveNewFile.pmiItemClick(Sender: TObject);
begin
  if Sender is TMenuItem then
    edtTempFilenameFormat.SelText := (Sender as TMenuItem).Caption;
end;

procedure TfrmSaveNewFile.rbSetDefaultButtonClick(Sender: TObject);
begin
  SetDefaultButton;
end;

procedure TfrmSaveNewFile.SetDefaultButton;
begin
  if (FFileNameCur = '') then
  begin
    if rbDoNothing.Checked then
      btnDoNothing.SetFocus;
    if rbSave2Temp.Checked then
      btnSave2Temp.SetFocus;
    if rbSaveAs.Checked then
      btnSaveAs.SetFocus;
  end
  else
    btnSaveAs.SetFocus;
end;

procedure TfrmSaveNewFile.SetFileName(ASetTempFileName, ASetFileName: boolean);
var
  LTabIndex: integer;

  LObjectType, LObjectOwner, LObjectName, LSubObject: PChar;
  LFilePrefix, LFileExt, LTempFileName: string;
  LDatabase, LSQLText, LSchemaType:     string;
begin
  LTabIndex := IDE_TabIndex(-1);
  IDE_TabIndex(0);
  IDE_GetWindowObject(LObjectType,
    LObjectOwner, LObjectName, LSubObject);
  IDE_TabIndex(LTabIndex);

  FObjectType := StrPas(LObjectType);

  if (FWindowType = wtProcEdit) and (IDE_TabInfo(1) <> '') then
  begin
    if FObjectType = 'PACKAGE' then
      LFileExt := IDE_GetProcEditExtension('PACKAGE SPEC AND BODY') //'pck'
    else
    begin
      if FObjectType = 'TYPE' then
        LFileExt := IDE_GetProcEditExtension('TYPE SPEC AND BODY'); //'typ';
    end;
  end
  else
    LFileExt := StrPas(IDE_GetDefaultExtension(FWindowType)) +
      StrPas(IDE_GetProcEditExtension(PChar(FObjectType)));

  LFilePrefix := LFileExt;

  // for sql window spec name
  if (FWindowType = wtSQL) then
  begin
    LSQLText := UpperCase(StrPas(IDE_GetText));
    if PosEx('CREATE OR REPLACE VIEW', LSQLText) <> 0 then
    begin
      LFilePrefix := 'view';
      LObjectName := PChar(LowerCase(Copy(LSQLText,
        PosEx('CREATE OR REPLACE VIEW ', LSQLText) + 23, PosEx(' AS', LSQLText) -
        PosEx('CREATE OR REPLACE VIEW ', LSQLText) - 23)));
    end
    else
    begin
      if PosEx('CREATE MATERIALIZED VIEW', LSQLText) <> 0 then
      begin
        LFilePrefix := 'mview';
        LObjectName := PChar(LowerCase(Copy(LSQLText,
          PosEx('CREATE MATERIALIZED VIEW ', LSQLText) + 25,
          PosEx(' AS', LSQLText) - PosEx('CREATE MATERIALIZED VIEW ', LSQLText) - 25)));
      end
      else
      begin
        if PosEx('SELECT ', LSQLText) <> 0 then
        begin
          LFilePrefix := 'table';
          LObjectName := PChar(
            AnsiReplaceStr(AnsiReplaceStr(
            LowerCase(Copy(LSQLText, PosEx(' FROM ', LSQLText) + 6,
            PosEx(' ', LSQLText, PosEx(' FROM ', LSQLText) + 6) -
            PosEx(' FROM ', LSQLText) - 6)), #13, ''), #10, ''));
        end;
      end;
    end;
  end;

  if IDE_Connected then
  begin
    if (dmData.fldSchemaIDType.Value <> 0) and
      dmData.mdSchemaType.Locate('id', dmData.fldSchemaIDType.Value, []) then
      LSchemaType := dmData.fldSchemaTypeName.Value;

    LDatabase := dmData.fldSchemaDB.Value;
  end;

  LTempFileName := LowerCase(ReplaceStr(ReplaceStr(ReplaceStr(
    ReplaceStr(ReplaceStr(ReplaceStr(LowerCase(edtTempFilenameFormat.Text),
    '[database]', LDatabase), '[schematype]', LSchemaType), '[objectowner]',
    StrPas(LObjectOwner)), '[objectname]', StrPas(LObjectName)),
    '[objecttype]', LFilePrefix), '[uid]', FormatDateTime(
    'yyyy-mm-dd_hh-nn-ss_zzz', Now)));

  edtTempDirectory.Text := GAppTmpFilesDir;

  if ASetTempFileName then
  begin
    if (FFileNameCur = '') or (ExtractFilePath(FFileNameCur) <> GAppTmpFilesDir) then
    begin
      edtTempFilename.Text := LTempFileName;
      edtTempFileExt.Text  := LFileExt;
    end
    else
    begin
      edtTempFilename.Text := AnsiReplaceStr(ExtractFileName(FFileNameCur),
        ExtractFileExt(FFileNameCur), '');
      edtTempFileExt.Text  := AnsiReplaceStr(ExtractFileExt(FFileNameCur), '.', '');
    end;
  end;

  edtFileName.Text := StrPas(LObjectName);
  if (FFileNameCur = '') then
    edtFileExt.Text := LFileExt
  else
    edtFileExt.Text := AnsiReplaceStr(ExtractFileExt(FFileNameCur), '.', '');

  if ASetFileName then
  begin
    if (FFileNameCur <> '') and (FWindowType <> wtProcEdit) then
    begin
      edtFileName.Text := AnsiReplaceStr(ExtractFileName(FFileNameCur),
        ExtractFileExt(FFileNameCur), '');
      edtFileExt.Text  := AnsiReplaceStr(ExtractFileExt(FFileNameCur), '.', '');
    end;
  end;
end;

end.

