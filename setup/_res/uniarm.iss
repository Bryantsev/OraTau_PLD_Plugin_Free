[Files]
; Add the ISSkin DLL used for skinning Inno Setup installations.
Source: ISSkin.dll; DestDir: {app}; Flags: dontcopy

; Add the Visual Style resource contains resources used for skinning,
; you can also use Microsoft Visual Styles (*.msstyles) resources.
Source: Styles\Office2007.cjstyles; DestDir: {tmp}; Flags: dontcopy

Source: C:\_tools\uniarm\starter.exe; DestDir: {app}; Flags: onlyifdoesntexist
Source: C:\_tools\uniarm\Config\uniarm4setup.ini; DestDir: {app}\config; DestName: uniarm.ini; Flags: onlyifdoesntexist
Source: C:\_tools\uniarm\StarterUpdates\*.zip.*; DestDir: {app}\StarterUpdates; Tasks: ; Languages: ; Flags: onlyifdoesntexist
Source: C:\_tools\uniarm\Updates\cur\SupportExp.zip.aux; DestDir: {app}\updates\cur; Flags: onlyifdoesntexist
Source: C:\_tools\uniarm\Updates\cur\ModernExceptionDialogExp.zip.aux; DestDir: {app}\updates\cur; Flags: onlyifdoesntexist
Source: C:\_tools\uniarm\Updates\Cur\BuhReportsExp.zip.aux; DestDir: {app}\updates\cur; Components: " reports"; Flags: onlyifdoesntexist
Source: C:\_tools\uniarm\Updates\Cur\Report*.zip.aux; DestDir: {app}\updates\cur; Components: " reports"; Flags: onlyifdoesntexist
Source: C:\_tools\uniarm\Updates\Cur\ScanerExp.zip.aux; DestDir: {app}\updates\cur; Components: " kassa"; Flags: onlyifdoesntexist
Source: C:\_tools\uniarm\Updates\Cur\KassaExp.zip.aux; DestDir: {app}\updates\cur; Components: " kassa"; Tasks: ; Languages: ; Flags: onlyifdoesntexist
Source: C:\_tools\uniarm\Updates\Cur\TransportReestrExp.zip.aux; DestDir: {app}\updates\cur; Components: " transport_reestr"; Flags: onlyifdoesntexist; Tasks: ; Languages: 
[Dirs]
Name: {app}; Permissions: authusers-full
Name: {app}\config; Flags: uninsalwaysuninstall; Tasks: ; Languages: 
Name: {app}\StarterUpdates; Flags: uninsalwaysuninstall; Tasks: ; Languages: 
Name: {app}\updates; Flags: uninsalwaysuninstall; Tasks: ; Languages: 
Name: {app}\updates\cur; Tasks: ; Languages: ; Flags: uninsalwaysuninstall
[LangOptions]
LanguageName=Russian
LanguageID=$0419
[Setup]
InternalCompressLevel=ultra
OutputBaseFilename=uniarm_setup
Compression=lzma/ultra
AppCopyright=
AppName=Универсальный АРМ. ЖКХ
AppVerName=Универсальный АРМ. ЖКХ v1.0
PrivilegesRequired=poweruser
DefaultDirName={pf}\uniarm
DefaultGroupName=Универсальный АРМ. ЖКХ
UninstallLogMode=overwrite
AppID={{5F4F719D-937D-4F08-A5A7-BC7A20B82A7E}
UninstallDisplayIcon=
AppContact=
UninstallDisplayName=Удалить Универсальный АРМ. ЖКХ
ShowLanguageDialog=auto
OutputDir=D:\projects\setup\uniarm\out
VersionInfoVersion=1.0
VersionInfoCompany=
SetupLogging=false
WizardImageFile=styles\Office2007.bmp
[Languages]
Name: russian; MessagesFile: compiler:Languages\Russian.isl
[Icons]
Name: {group}\Универсальный АРМ. ЖКХ; Filename: {app}\starter.exe; WorkingDir: {app}; IconFilename: {app}\starter.exe; Languages: " russian"; IconIndex: 0
Name: {group}\Удалить Универсальный АРМ. ЖКХ; Filename: {uninstallexe}; WorkingDir: {app}; Languages: " russian"
Name: {commondesktop}\Универсальный АРМ. ЖКХ; Filename: {app}\starter.exe; WorkingDir: {app}; IconFilename: {app}\starter.exe; Languages: " russian"; Tasks: " desktopicon"; IconIndex: 0
[Tasks]
Name: desktopicon; Description: Добавить иконку на рабочий стол; Languages: 
[UninstallDelete]
Name: {app}; Type: filesandordirs; Tasks: ; Languages: 
[Run]
Filename: {app}\starter.exe; WorkingDir: {app}; Flags: postinstall skipifsilent nowait; Description: Запустить Универсальный АРМ. ЖКХ; Languages: " russian"; Components: 
[_ISTool]
UseAbsolutePaths=false
[Components]
Name: remote2; Description: Сеть vpn  (192.168.2.16); Languages: " russian"; Types: type1_remote2; Flags: exclusive
Name: remote1; Description: Сеть vpn (192.168.2.11); Languages: " russian"; Flags: exclusive; Types: type1_remote1
Name: remote3; Description: Внешняя сеть (62.183.33.30); Languages: " russian"; Flags: exclusive; Types: type1_remote3
Name: remote4; Description: Внешняя сеть (83.239.48.42); Languages: " russian"; Flags: exclusive; Types: type1_remote4
Name: local; Description: Локальная сеть провайдера; Languages: " russian"; Types: type2_local; Flags: exclusive
Name: reports; Description: Отчеты; Languages: " russian"; Types: custom
Name: kassa; Description: Касса; Types: custom; Languages: " russian"
Name: transport_reestr; Description: Транспортный реестр; Languages: " russian"; Types: custom
[Types]
Name: type1_remote2; Description: Сеть vpn (192.168.2.16); Languages: " russian"
Name: type1_remote1; Description: Сеть vpn (192.168.2.11); Languages: " russian"
Name: type1_remote3; Description: Внешняя сеть (62.183.33.30); Languages: " russian"
Name: type1_remote4; Description: Внешняя сеть (83.239.48.42); Languages: " russian"
Name: type2_local; Description: Локальная сеть провайдера; Languages: " russian"
Name: custom; Description: Пользовательская; Flags: iscustom; Languages: " russian"
[_ISToolPostCompile]
Name: D:\projects\setup\uniarm\out\gen_setup.cmd; Parameters: ; Flags: runminimized
[INI]
Filename: {app}\config.ini; Section: IP; Key: AddressServer; String: 192.168.1.16; Components: local
Filename: {app}\config.ini; Section: IP; Key: AddressServer; String: 192.168.2.11; Components: remote1
Filename: {app}\config.ini; Section: IP; Key: AddressServer; String: 192.168.2.16; Components: remote2
Filename: {app}\config.ini; Section: IP; Key: AddressServer; String: 62.183.33.30; Components: remote3; Tasks: 
Filename: {app}\config.ini; Section: IP; Key: AddressServer; String: 83.239.48.42; Components: remote4; Tasks: 
Filename: {app}\Config\uniarm.ini; Section: ConnectManager; Key: DefaultServer; String: 0; Components: remote1
Filename: {app}\Config\uniarm.ini; Section: ConnectManager; Key: DefaultServer; String: 1; Components: remote2
Filename: {app}\Config\uniarm.ini; Section: ConnectManager; Key: DefaultServer; String: 2; Components: remote4
Filename: {app}\Config\uniarm.ini; Section: ConnectManager; Key: DefaultServer; String: 3; Components: remote3; Tasks: ; Languages: 
Filename: {app}\Config\uniarm.ini; Section: ConnectManager; Key: DefaultServer; String: 4; Components: local; Tasks: ; Languages: 
Filename: {app}\config.ini; Section: IP; Key: PortServer; String: {code:GetConnectionParam|Port}
Filename: {app}\Config\uniarm.ini; Section: ConnectManager; Key: ProxyUse; String: {code:GetConnectionParam|ProxyUse}; Tasks: ; Languages: 
Filename: {app}\Config\uniarm.ini; Section: ConnectManager; Key: ProxyHost; String: {code:GetConnectionParam|ProxyHost}; Tasks: ; Languages: 
Filename: {app}\Config\uniarm.ini; Section: ConnectManager; Key: ProxyPort; String: {code:GetConnectionParam|ProxyPort}; Tasks: ; Languages: 
Filename: {app}\Config\uniarm.ini; Section: ConnectManager; Key: ProxyAutoriz; String: {code:GetConnectionParam|ProxyAutoriz}; Tasks: ; Languages: 
Filename: {app}\Config\uniarm.ini; Section: ConnectManager; Key: ProxyUsername; String: {code:GetConnectionParam|ProxyUsername}; Tasks: ; Languages: 
Filename: {app}\Config\uniarm.ini; Section: ConnectManager; Key: ProxyPassword; String: {code:GetConnectionParam|ProxyPassword}; Tasks: ; Languages: 
[Code]
var
  Label1: TLabel;
  edtPort: TEdit;
  Panel1: TPanel;
  Label2: TLabel;
  Label3: TLabel;
  Panel2: TPanel;
  Label4: TLabel;
  Label5: TLabel;
  edtProxyLogin: TEdit;
  edtProxyPassword: TEdit;
  edtProxyServer: TEdit;
  edtProxyPort: TEdit;
  chkProxyAuthorize: TCheckBox;
  chkProxy: TCheckBox;

function ConnectionPageCreate(PreviousPageId: Integer): Integer;
var
  Page: TWizardPage;
begin
  Page := CreateCustomPage(
    PreviousPageId,
    'Настройка подключения',
    'Настройка прокси-сервера и первичного подключения к серверу приложения'
  );

{ Label1 }
  Label1 := TLabel.Create(Page);
  with Label1 do
  begin
    Parent := Page.Surface;
    Caption := 'Порт сервера по умолчанию:';
    Left := ScaleX(24);
    Top := ScaleY(24);
    Width := ScaleX(148);
    Height := ScaleY(13);
  end;

  { edtPort }
  edtPort := TEdit.Create(Page);
  with edtPort do
  begin
    Parent := Page.Surface;
    Left := ScaleX(176);
    Top := ScaleY(20);
    Width := ScaleX(65);
    Height := ScaleY(21);
    TabOrder := 0;
    Text := '8094';
  end;

  { Panel1 }
  Panel1 := TPanel.Create(Page);
  with Panel1 do
  begin
    Parent := Page.Surface;
    Left := ScaleX(20);
    Top := ScaleY(76);
    Width := ScaleX(365);
    Height := ScaleY(113);
    BevelInner := bvRaised;
    BevelOuter := bvLowered;
    TabOrder := 2;
  end;

  { Label2 }
  Label2 := TLabel.Create(Page);
  with Label2 do
  begin
    Parent := Panel1;
    Caption := 'Адрес сервера:';
    Left := ScaleX(20);
    Top := ScaleY(20);
    Width := ScaleX(79);
    Height := ScaleY(13);
  end;

  { Label3 }
  Label3 := TLabel.Create(Page);
  with Label3 do
  begin
    Parent := Panel1;
    Caption := 'Порт:';
    Left := ScaleX(228);
    Top := ScaleY(20);
    Width := ScaleX(29);
    Height := ScaleY(13);
  end;

  { Panel2 }
  Panel2 := TPanel.Create(Page);
  with Panel2 do
  begin
    Parent := Panel1;
    Left := ScaleX(16);
    Top := ScaleY(56);
    Width := ScaleX(329);
    Height := ScaleY(41);
    BevelInner := bvRaised;
    BevelOuter := bvLowered;
    TabOrder := 3;
  end;

  { Label4 }
  Label4 := TLabel.Create(Page);
  with Label4 do
  begin
    Parent := Panel2;
    Caption := 'Логин:';
    Left := ScaleX(12);
    Top := ScaleY(16);
    Width := ScaleX(34);
    Height := ScaleY(13);
  end;

  { Label5 }
  Label5 := TLabel.Create(Page);
  with Label5 do
  begin
    Parent := Panel2;
    Caption := 'Пароль:';
    Left := ScaleX(164);
    Top := ScaleY(16);
    Width := ScaleX(41);
    Height := ScaleY(13);
  end;

  { edtProxyLogin }
  edtProxyLogin := TEdit.Create(Page);
  with edtProxyLogin do
  begin
    Parent := Panel2;
    Left := ScaleX(52);
    Top := ScaleY(12);
    Width := ScaleX(97);
    Height := ScaleY(21);
    TabOrder := 0;
  end;

  { edtProxyPassword }
  edtProxyPassword := TEdit.Create(Page);
  with edtProxyPassword do
  begin
    Parent := Panel2;
    Left := ScaleX(208);
    Top := ScaleY(12);
    Width := ScaleX(97);
    Height := ScaleY(21);
    TabOrder := 1;
	PasswordChar := '*';
  end;

  { edtProxyServer }
  edtProxyServer := TEdit.Create(Page);
  with edtProxyServer do
  begin
    Parent := Panel1;
    Left := ScaleX(104);
    Top := ScaleY(16);
    Width := ScaleX(105);
    Height := ScaleY(21);
    TabOrder := 0;
  end;

  { edtProxyPort }
  edtProxyPort := TEdit.Create(Page);
  with edtProxyPort do
  begin
    Parent := Panel1;
    Left := ScaleX(260);
    Top := ScaleY(16);
    Width := ScaleX(49);
    Height := ScaleY(21);
    TabOrder := 1;
  end;

  { chkProxyAuthorize }
  chkProxyAuthorize := TCheckBox.Create(Page);
  with chkProxyAuthorize do
  begin
    Parent := Panel1;
    Caption := 'использовать авторизацию';
    Left := ScaleX(24);
    Top := ScaleY(48);
    Width := ScaleX(161);
    Height := ScaleY(17);
    TabOrder := 2;
  end;

  { chkProxy }
  chkProxy := TCheckBox.Create(Page);
  with chkProxy do
  begin
    Parent := Page.Surface;
    Caption := 'использовать прокси сервер SOCKS5';
    Left := ScaleX(28);
    Top := ScaleY(68);
    Width := ScaleX(213);
    Height := ScaleY(17);
    TabOrder := 1;
  end;

  Result := Page.ID;
end;

procedure InitializeWizard();
begin
  ConnectionPageCreate(wpSelectComponents);
end;

function BoolAsString(Param: Boolean): String;
begin
	if Param then Result := 'True'
	else Result := 'False';
end;

function GetConnectionParam(Param: String): String;
begin
	case Param of
		'Port': Result := edtPort.Text;
		'ProxyUse': Result := BoolAsString(chkProxy.Checked);
		'ProxyHost': Result := edtProxyServer.Text;
		'ProxyPort': Result := edtProxyPort.Text;
		'ProxyAutoriz': Result := BoolAsString(chkProxyAuthorize.Checked);
		'ProxyUsername': Result := edtProxyLogin.Text;
		'ProxyPassword': Result := edtProxyPassword.Text;
	end;
end;



// Importing LoadSkin API from ISSkin.DLL
procedure LoadSkin(lpszPath: String; lpszIniFileName: String);
external 'LoadSkin@files:isskin.dll stdcall';

// Importing UnloadSkin API from ISSkin.DLL
procedure UnloadSkin();
external 'UnloadSkin@files:isskin.dll stdcall';

// Importing ShowWindow Windows API from User32.DLL
function ShowWindow(hWnd: Integer; uType: Integer): Integer;
external 'ShowWindow@user32.dll stdcall';

function InitializeSetup(): Boolean;
begin
	ExtractTemporaryFile('Office2007.cjstyles');
	LoadSkin(ExpandConstant('{tmp}\Office2007.cjstyles'), 'NormalAqua.ini');
	Result := True;
end;

procedure DeinitializeSetup();
begin
	// Hide Window before unloading skin so user does not get
	// a glimse of an unskinned window before it is closed.
	ShowWindow(StrToInt(ExpandConstant('{wizardhwnd}')), 0);
	UnloadSkin();
end;



