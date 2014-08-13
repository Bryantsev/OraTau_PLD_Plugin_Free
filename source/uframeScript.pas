unit uframeScript;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxMaskEdit,
  cxTextEdit, cxMemo, cxCheckBox, StdCtrls,
  cxButtons, cxLabel, cxControls, cxContainer, cxEdit, cxGroupBox,
  JvFormPlacement, JvComponentBase,
  JvAppIniStorage, cxDropDownEdit, cxMRUEdit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters;

type
  TframeScript = class(TFrame)
    gbSettings:    TcxGroupBox;
    lblScriptFile: TcxLabel;
    btnExecute:    TcxButton;
    chkCompileInvalid: TcxCheckBox;
    chkStopOnError: TcxCheckBox;
    btnClearLog:   TcxButton;
    lblMessageLog: TcxLabel;
    meMessageLog:  TcxMemo;
    chkLoadFile:   TcxCheckBox;
    chkAutoClearLog: TcxCheckBox;
    odScriptFile:  TOpenDialog;
    fsScript:      TJvFormStorage;
    chkUnSetSchemaOnSuccess: TcxCheckBox;
    chkExecuteInPLDev: TcxCheckBox;
    mruScriptFile: TcxMRUEdit;
    procedure btnClearLogClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure mruScriptFilePropertiesEditValueChanged(Sender: TObject);
    procedure mruScriptFileDblClick(Sender: TObject);
    procedure mruScriptFilePropertiesButtonClick(Sender: TObject);
  private
    procedure SelectScriptFile;
  public
  end;

implementation

uses
  udmData, PlugInIntf;

{$R *.dfm}

procedure TframeScript.btnClearLogClick(Sender: TObject);
begin
  meMessageLog.Lines.Clear;
end;

procedure TframeScript.btnExecuteClick(Sender: TObject);
begin
  // Cancel execute script
  if btnExecute.Tag = 1 then
  begin
    GStopExecuteScript := True;
    if chkExecuteInPLDev.Checked then
      IDE_Perform(2); // break execute current window

    Exit;
  end;

  if mruScriptFile.Text = '' then
    raise Exception.Create('Choose a script file to execute!');

  if MessageDlg('Are you sure?', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    if chkAutoClearLog.Checked then
      meMessageLog.Clear;

    try
      btnExecute.Caption := 'Stop';
      btnExecute.Font.Color := clRed;
      btnExecute.Tag := 1; // executing

      dmData.ExecuteScript(mruScriptFile.Text, meMessageLog.Lines,
        chkLoadFile.Checked, chkUnSetSchemaOnSuccess.Checked, chkExecuteInPLDev.Checked);

    finally
      btnExecute.Caption := 'Execute';
      btnExecute.Font.Color := clWindowText;
      GStopExecuteScript := False;
      btnExecute.Tag := 0;
    end;
  end;
end;

procedure TframeScript.mruScriptFileDblClick(Sender: TObject);
begin
  SelectScriptFile;
end;

procedure TframeScript.mruScriptFilePropertiesButtonClick(Sender: TObject);
begin
  SelectScriptFile;
end;

procedure TframeScript.mruScriptFilePropertiesEditValueChanged(Sender: TObject);
var
  LIdx: integer;
begin
  mruScriptFile.Hint := mruScriptFile.Text;
  if mruScriptFile.Text = '' then
    Exit;

  with mruScriptFile.Properties.LookupItems do
  begin
    LIdx := IndexOf(mruScriptFile.Text);
    if LIdx >= 0 then
      Move(LIdx, 0)
    else
      Insert(0, mruScriptFile.Text);

    if mruScriptFile.Properties.Items.Count > 9 then
      Delete(9);
  end;

  meMessageLog.Lines.Append('Script file: ' + mruScriptFile.Text);
end;

procedure TframeScript.SelectScriptFile;
begin
  if Trim(mruScriptFile.Text) <> '' then
  begin
    odScriptFile.InitialDir := ExtractFileDir(Trim(mruScriptFile.Text));
  end;
  if odScriptFile.Execute then
  begin
    mruScriptFile.Text := odScriptFile.FileName;
  end;
end;

end.

