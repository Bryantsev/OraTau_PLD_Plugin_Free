unit ufrmSchemaImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxContainer, cxEdit, cxTextEdit, cxMemo, cxLabel, Menus,
  StdCtrls, cxButtons, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  cxGroupBox, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters;

type
  TfrmSchemaImport = class(TForm)
    meSchemas:   TcxMemo;
    lblSchemaImport: TcxLabel;
    btnSchemaImport: TcxButton;
    btnClose:    TcxButton;
    gbDefault:   TcxGroupBox;
    lcbSchemaGroup: TcxLookupComboBox;
    lblSchemaGroup: TcxLabel;
    lblType:     TcxLabel;
    lcbSchemaType: TcxLookupComboBox;
    lblDatabase: TcxLabel;
    edtDatabase: TcxTextEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSchemaImportClick(Sender: TObject);
  private
  public
  end;

procedure ShowSchemaImport(AOwner: TComponent);

var
  frmSchemaImport: TfrmSchemaImport;

implementation

uses
  udmData, DB;

{$R *.dfm}

procedure ShowSchemaImport(AOwner: TComponent);
begin
  frmSchemaImport := TfrmSchemaImport.Create(AOwner);
  frmSchemaImport.ShowModal;
end;

procedure TfrmSchemaImport.btnSchemaImportClick(Sender: TObject);
var
  LIdxLine, LIdxSlash, LIdxAmp, LImportedCount: integer;
  LIDImportedGroup:   variant;
  LSchema, LDatabase: string;
begin
  LImportedCount := 0;

  dmData.mdSchema.DisableControls;
  try
    for LIdxLine := 0 to meSchemas.Lines.Count - 1 do
    begin
      LSchema := Trim(meSchemas.Lines.Strings[LIdxLine]);
      // add new group
      if LSchema[1] = '>' then
      begin
        LSchema := Copy(LSchema, 2, length(LSchema) - 1);
        with dmData.mdSchemaGroup do
        begin
          if not Locate('name', LSchema, [loCaseInsensitive]) then
          begin
            Append;
            FieldByName('Name').AsString := LSchema;
            Post;
          end;

          LIDImportedGroup := FieldByName('ID').Value;
        end;
      end
      // user/schema
      else
      begin
        LIdxAmp := Pos('@', LSchema);
        if LIdxAmp = 0 then
        begin
          LDatabase := edtDatabase.Text;
          LIdxAmp   := Length(LSchema) + 1;
        end
        else
          LDatabase := Copy(LSchema, LIdxAmp + 1, 99);

        LIdxSlash := Pos('/', LSchema);

        //      if ((LIdxSlash <> 0) or (edtPassword.Text <> '')) then
        //      begin
        if LIdxSlash = 0 then
        begin
          if LIdxAmp <> 0 then
            LIdxSlash := LIdxAmp
          else
          begin
            LIdxSlash := Length(LSchema) + 1;
          end;
        end;

        with dmData.mdSchema do
        begin
          Append;
          // imported group more priority then default
          if VarIsNull(LIDImportedGroup) then
            FieldByName('IDGroup').Value := lcbSchemaGroup.EditValue
          else
            FieldByName('IDGroup').Value := LIDImportedGroup;
          FieldByName('IDType').Value := lcbSchemaType.EditValue;
          FieldByName('DB').AsString := Trim(AnsiUpperCase(LDatabase));
          //FieldByName('Schema').AsString := Trim(Copy(LSchema, 0, LIdxSlash - 1));
          //        if edtUserName.Text <> '' then
          //          FieldByName('UserName').AsString := Trim(edtUserName.Text)
          //        else
          FieldByName('UserName').AsString := Trim(Copy(LSchema, 0, LIdxSlash - 1));
          if Copy(LSchema, LIdxSlash + 1, LIdxAmp - LIdxSlash - 1) <> '' then
            //          FieldByName('Password').AsString :=
            //            dmData.vcData.EncodeString(dmData.vcData.Key, edtPassword.Text)
            //        else
            FieldByName('Password').AsString :=
              dmData.vcData.EncodeString(dmData.vcData.Key,
              Copy(LSchema, LIdxSlash + 1, LIdxAmp - LIdxSlash - 1));
          Post;
        end;
        Inc(LImportedCount);
      end;
      //      end;
    end;

  finally
    dmData.mdSchema.EnableControls;
  end;

  //Close;
  ShowMessage('Imported ' + IntToStr(LImportedCount) + ' users!');
end;

procedure TfrmSchemaImport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frmSchemaImport := nil;
end;

end.

