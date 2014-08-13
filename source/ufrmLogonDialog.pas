unit ufrmLogonDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxMRUEdit,
  cxLabel, Menus, StdCtrls, cxButtons,
  JvComponentBase, JvFormPlacement, cxCheckBox, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters;

type
  TfrmLogonDialog = class(TForm)
    edtUserName:  TcxTextEdit;
    edtPassword:  TcxTextEdit;
    cmbConnectAs: TcxComboBox;
    mruDatabase:  TcxMRUEdit;
    lblUserName:  TcxLabel;
    lblPassword:  TcxLabel;
    lblDatabase:  TcxLabel;
    lblConnectAs: TcxLabel;
    btnCancel:    TcxButton;
    btnConnect:   TcxButton;
    fsLogon:      TJvFormStorage;
    chkSavePassword: TcxCheckBox;
    edtSchema:    TcxTextEdit;
    lblSchema:    TcxLabel;
    procedure btnConnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtPasswordPropertiesChange(Sender: TObject);
  private
    FPLDevLogon: boolean;
  public
  end;

function ShowLogon(AOwner: TComponent; APLDevLogon: boolean;
  AUserName, ADatabase, ASchema: string): boolean;

implementation

uses
  udmData;

{$R *.dfm}

var
  LLogonResult: boolean;

function ShowLogon(AOwner: TComponent; APLDevLogon: boolean;
  AUserName, ADatabase, ASchema: string): boolean;
var
  frmLogon: TfrmLogonDialog;
begin
  LLogonResult := False;
  frmLogon     := TfrmLogonDialog.Create(AOwner);

  with frmLogon do
  begin
    FPLDevLogon := APLDevLogon;

    edtUserName.Text := AUserName;
    mruDatabase.Text := ADatabase;
    edtSchema.Text   := ASchema;

    ShowModal;
    Result := LLogonResult;
  end;
end;

procedure TfrmLogonDialog.btnCancelClick(Sender: TObject);
begin
  LLogonResult := False;
  Close;
end;

procedure TfrmLogonDialog.btnConnectClick(Sender: TObject);
begin
  if (edtPassword.Text = '') then
    raise Exception.Create('Set password!')
  else
  begin
    if (FPLDevLogon and dmData.PLDevLogon(mruDatabase.Text, edtUserName.Text,
      edtPassword.Text, edtSchema.Text)) or (not FPLDevLogon and
      dmData.ODACLogon(mruDatabase.Text, edtUserName.Text, edtPassword.Text,
      edtSchema.Text)) then
      LLogonResult := True;

    if LLogonResult then
    begin
      with dmData.mdSchema do
      begin
        if chkSavePassword.Checked and (FieldByName('Password').AsString <>
          dmData.vcData.EncodeString(dmData.vcData.Key, edtPassword.Text)) then
        begin

          //          DisableControls;
          //          try
          Edit;
          FieldByName('Password').AsString :=
            dmData.vcData.EncodeString(dmData.vcData.Key, edtPassword.Text);
          Post;

          //          finally
          //            EnableControls;
          //          end;
        end;
      end;

      Close;
    end;
  end;
end;

procedure TfrmLogonDialog.edtPasswordPropertiesChange(Sender: TObject);
begin
  btnConnect.Enabled := not (edtPassword.Text = '');
end;

procedure TfrmLogonDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmLogonDialog.FormCreate(Sender: TObject);
begin
  chkSavePassword.Checked := GSavePasswordForLogon;
end;

end.

