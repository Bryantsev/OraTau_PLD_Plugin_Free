unit ufrmSchemaGroups;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, 
  DB, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Menus, StdCtrls,
  cxButtons, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData;

type
  TfrmSchemaGroups = class(TForm)
    tvSchemaGroups: TcxGridDBTableView;
    lvlSchemaGroups: TcxGridLevel;
    grdSchemaGroups: TcxGrid;
    clmSchemaGroupsRecId: TcxGridDBColumn;
    clmSchemaGroupsID: TcxGridDBColumn;
    clmSchemaGroupsName: TcxGridDBColumn;
    btnClose: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure ShowSchemaGroups(AOwner: TComponent);

var
  frmSchemaGroups: TfrmSchemaGroups;

implementation

uses
  udmData;

{$R *.dfm}

procedure ShowSchemaGroups(AOwner: TComponent);
begin
  frmSchemaGroups := TfrmSchemaGroups.Create(AOwner);
  frmSchemaGroups.ShowModal;
end;  

procedure TfrmSchemaGroups.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frmSchemaGroups := nil;
end;

end.
