unit ufrmAbout;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, JvLinkLabel, JvExExtCtrls,
  JvComponentBase,
  cxControls, cxContainer, cxEdit, cxTextEdit,
  cxLabel, Menus, cxButtons, cxMemo, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters;

type
  TfrmAbout = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    lblProductName: TLabel;
    lblCopyright: TLabel;
    lblSite: TcxLabel;
    lblFeedback: TcxLabel;
    btnOK:  TcxButton;
    btnCheckUpdate: TcxButton;
    lblGNULicense: TLabel;
    lblSources: TcxLabel;
    procedure lblSiteClick(Sender: TObject);
    procedure lblFeedbackClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCheckUpdateClick(Sender: TObject);
    procedure lblSourcesClick(Sender: TObject);
  private
  public
  end;

procedure ShowAbout(AOwner: TComponent);

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

uses ShellAPI, udmData;

procedure ShowAbout(AOwner: TComponent);
begin
  frmAbout := TfrmAbout.Create(AOwner);
  frmAbout.ShowModal;
end;

procedure TfrmAbout.btnCheckUpdateClick(Sender: TObject);
begin
  dmData.CheckNewVer(True);
end;

procedure TfrmAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action   := caFree;
  frmAbout := nil;
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
var
  LUserName: string;
begin
  lblProductName.Caption := C_APP_NAME_VER;
  lblSite.Hint     := C_COMPANY_PAGE + '/oratau_pld/';
  lblFeedback.Hint := C_COMPANY_PAGE + '/feedback.php';
end;

procedure TfrmAbout.lblSiteClick(Sender: TObject);
begin
  ShellExecute(GetDesktopWindow(), 'open',
    PAnsiChar(C_COMPANY_PAGE + '/oratau_pld/'), '', '',
    SW_MAXIMIZE);
end;

procedure TfrmAbout.lblSourcesClick(Sender: TObject);
begin
  ShellExecute(GetDesktopWindow(), 'open',
    PAnsiChar('https://github.com/Bryantsev/oratau-pld-plugin/'), '', '',
    SW_MAXIMIZE);
end;

procedure TfrmAbout.lblFeedbackClick(Sender: TObject);
begin
  ShellExecute(GetDesktopWindow(), 'open',
    PAnsiChar(C_COMPANY_PAGE + '/feedback.php'), '', '',
    SW_MAXIMIZE);
end;

end.

