unit ufrmWindows;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvFormPlacement,
  DB, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData;

type
  TfrmWindows = class(TForm)
    fsWindows:      TJvFormStorage;
    tvWindows:      TcxGridDBTableView;
    lvlWindows:     TcxGridLevel;
    grdWindows:     TcxGrid;
    clmWindowsRecId: TcxGridDBColumn;
    clmWindowsID:   TcxGridDBColumn;
    clmWindowsIDGroup: TcxGridDBColumn;
    clmWindowsName: TcxGridDBColumn;
    clmWindowsCheck: TcxGridDBColumn;
    clmWindowsIDTypeScheme: TcxGridDBColumn;
    clmWindowsIDTypeWindow: TcxGridDBColumn;
    clmWindowsFilename: TcxGridDBColumn;
    clmWindowsWinHandle: TcxGridDBColumn;
    procedure tvWindowsCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: boolean);
  private
  public
  end;

var
  frmWindows: TfrmWindows;

procedure ShowWindowsList;

implementation

uses
  udmData, PlugInIntf;

{$R *.dfm}

procedure ShowWindowsList;
var
  i:    integer;
  lstr: string;
  LWindowCaption: array[0..255] of char;
begin
  dmData.mdWindow.Close;
  dmData.mdWindow.Open;

  for I := 0 to IDE_GetWindowCount - 1 do
  begin
    IDE_SelectWindow(i);
    GetWindowText(IDE_GetChildHandle, @LWindowCaption, 256);
    lstr := lstr + #13#10 + LWindowCaption;

    with dmData, dmData.mdWindow do
    begin
      Append;
      fldWindowWinHandle.Value := IDE_GetChildHandle;
      fldWindowName.Value      := LWindowCaption;
      fldWindowFilename.Value  := StrPas(IDE_Filename);
      fldWindowIDTypeWindow.Value := IDE_GetWindowType;
      fldWindowCheck.Value     := False;
      fldWindowIDxPLDev.Value  := I;
      Post;
    end;
  end;

  //  ShowMessage(lstr);

  with frmWindows do
  begin
    if not Assigned(frmWindows) then
      frmWindows := TfrmWindows.Create(Application);
    Show;
  end;
end;


procedure TfrmWindows.tvWindowsCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: boolean);
begin
//  ShowMessage('ttt');
  if (AButton = mbLeft) and ACellViewInfo.GridRecord.IsData then
        ShowWindow(dmData.fldWindowWinHandle.Value, SW_SHOW);
    IDE_ActivateWindow(dmData.fldWindowIdxPLDev.Value);
end;

end.

