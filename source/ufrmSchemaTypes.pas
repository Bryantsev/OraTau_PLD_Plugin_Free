unit ufrmSchemaTypes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, 
  DB, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid, Menus, StdCtrls,
  cxButtons, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData;

type
  TfrmSchemaTypes = class(TForm)
    grdSchemaTypes: TcxGrid;
    tvSchemaTypes: TcxGridDBTableView;
    clmSchemaGroupsRecId: TcxGridDBColumn;
    clmSchemaGroupsID: TcxGridDBColumn;
    clmSchemaGroupsName: TcxGridDBColumn;
    lvlSchemaTypes: TcxGridLevel;
    btnClose: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure ShowSchemaTypes(AOwner: TComponent);

var
  frmSchemaTypes: TfrmSchemaTypes;

implementation

uses
  udmData;

{$R *.dfm}

procedure ShowSchemaTypes(AOwner: TComponent);
begin
  frmSchemaTypes := TfrmSchemaTypes.Create(AOwner);
  frmSchemaTypes.ShowModal;
end;  

procedure TfrmSchemaTypes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frmSchemaTypes := nil;
end;

end.
