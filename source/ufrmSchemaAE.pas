unit ufrmSchemaAE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxMaskEdit, cxDropDownEdit, cxDBEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxCheckBox, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, Menus, StdCtrls,
  cxButtons, cxLabel, 
  Buttons, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters;

type
  TfrmSchemaAE = class(TForm)
    edtUserName: TcxDBTextEdit;
    edtPassword: TcxDBTextEdit;
    chkShowPassword: TcxCheckBox;
    lcbType:    TcxDBLookupComboBox;
    lcbGroup:   TcxDBLookupComboBox;
    btnSave:    TcxButton;
    btnCancel:  TcxButton;
    lblGroup:   TcxLabel;
    lblDB:      TcxLabel;
    lblUserName: TcxLabel;
    lblPassword: TcxLabel;
    lblType:    TcxLabel;
    edtDB:      TcxDBTextEdit;
    chkVisible: TcxDBCheckBox;
    btnEditGroups: TBitBtn;
    btnEditTypes: TBitBtn;
    procedure chkShowPasswordPropertiesEditValueChanged(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditValueChanged(Sender: TObject);
    procedure btnEditGroupsClick(Sender: TObject);
    procedure btnEditTypesClick(Sender: TObject);
  private
  public
  end;

procedure ShowSchemaAE(AOwner: TComponent);

var
  frmSchemaAE: TfrmSchemaAE;

implementation

uses
  DB, udmData, ufrmSchemaGroups, ufrmSchemaTypes;

{$R *.dfm}

procedure ShowSchemaAE(AOwner: TComponent);
begin
  frmSchemaAE := TfrmSchemaAE.Create(AOwner);
  with frmSchemaAE do
  begin
    if dmData.mdSchema.State = dsInsert then
      Caption := 'New user'
    else
    begin
      Caption := 'Edit user';
      //      if edtSchema.Text = '' then
      //        edtSchema.EditValue := edtUserName.EditValue;
    end;

    with dmData.mdSchema do
    begin
      if FieldByName('Visible').IsNull then
        FieldByName('Visible').AsBoolean := True;


      FieldByName('Password').AsString :=
        dmData.vcData.DecodeString(dmData.vcData.Key, FieldByName('Password').AsString);
    end;

    btnSave.Enabled := False;

    ShowModal;
  end;
end;

procedure TfrmSchemaAE.btnCancelClick(Sender: TObject);
begin
  dmData.mdSchema.Cancel;
end;

procedure TfrmSchemaAE.btnEditGroupsClick(Sender: TObject);
begin
  ShowSchemaGroups(nil);
end;

procedure TfrmSchemaAE.btnEditTypesClick(Sender: TObject);
begin
  ShowSchemaTypes(nil);
end;

procedure TfrmSchemaAE.btnSaveClick(Sender: TObject);
begin
  //  if edtSchema.Text = '' then
  //    edtSchema.EditValue := edtUserName.EditValue;

  with dmData.mdSchema do
  begin
    FieldByName('DB').AsString     := Trim(FieldByName('DB').AsString);
    FieldByName('UserName').AsString := Trim(FieldByName('UserName').AsString);
    FieldByName('Schema').AsString := Trim(FieldByName('UserName').AsString);
    //Trim(FieldByName('Schema').AsString);
    FieldByName('Password').AsString :=
      dmData.vcData.EncodeString(dmData.vcData.Key, FieldByName('Password').AsString);

    Post;
  end;
end;

procedure TfrmSchemaAE.chkShowPasswordPropertiesEditValueChanged(Sender: TObject);
begin
  if not chkShowPassword.Checked then
    edtPassword.Properties.EchoMode := eemPassword
  else
    edtPassword.Properties.EchoMode := eemNormal;
end;

procedure TfrmSchemaAE.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action      := caFree;
  frmSchemaAE := nil;
end;

procedure TfrmSchemaAE.EditValueChanged(Sender: TObject);
begin
  btnSave.Enabled := True;
end;

end.

