unit udmData;

interface

uses
  Windows, SysUtils, Classes, DB, DBAccess,
  DAScript, dxmdaset, OraScript, Ora, OraClasses,
  JvCipher, JvAppIniStorage,
  ExtCtrls,
  Dialogs, JvFormPlacement,
  JvUrlGrabbers, cxStyles, cxGridTableView,
  cxGrid,
  cxGridDBTableView,
  Controls,
  JvDialogs, 
  
  ImgList, cxGridCustomTableView, cxControls, cxGridCustomView, MemDS,
  cxClasses, JvUrlListGrabber,
  JvAppStorage, JvComponentBase, 
  JvChangeNotify, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxDBLookupComboBox;

const
  C_APP_NAME     = 'OraTau PLD Plugin Free';
  C_VERSION      = '1.5'; // Application version
  C_APP_NAME_VER = C_APP_NAME + ' ' + C_VERSION;
  C_COMPANY_PAGE = 'http://www.oratau.com';

  // folders and files
  C_PLUGIN_FOLDER     = '\OraTau_pld\';
  C_APP_DATA_FOLDER   = '\OraTau PLD Plugin\';
  C_SCHEMES_FILE      = 'users.dat';
  C_SCHEMA_TYPES_FILE = 'user_types.dat';
  C_SCHEMA_GROUP_FILE = 'user_groups.dat';
  C_QUICK_QUERY_FILE  = 'quick_query.dat';
  C_WINDOWS_FILE      = 'windows.dat';

  // Update interval
  C_uiNever    = -1;
  C_uiAppStart = 0;
  C_uiDaily    = 1;
  C_uiWeekly   = 7;
  C_uiMonthly  = 30;

type
  TdmData = class(TDataModule)
    mdSchema:    TdxMemData;
    fldSchemaID: TAutoIncField;
    fldSchemaIDGroup: TIntegerField;
    fldSchemaDB: TStringField;
    fldSchemaUserName: TStringField;
    fldSchemaPassword: TStringField;
    fldSchemaIDType: TIntegerField;
    fldSchemaCheck: TBooleanField;
    mdSchemaType: TdxMemData;
    fldSchemaTypeID: TAutoIncField;
    fldSchemaTypeName: TStringField;
    mdSchemaGroup: TdxMemData;
    fldSchemaGroupID: TAutoIncField;
    fldSchemaGroupName: TStringField;
    osMain:      TOraSession;
    oscrMain:    TOraScript;
    dsSchema:    TDataSource;
    dsSchemaType: TDataSource;
    dsSchemaGroup: TDataSource;
    fldSchemaSchema: TStringField;
    vcData:      TJvVigenereCipher;
    aifsMain:    TJvAppIniFileStorage;
    mdWindow:    TdxMemData;
    fldWindowID: TAutoIncField;
    fldWindowIDGroup: TIntegerField;
    fldWindowIDTypeScheme: TIntegerField;
    fldWindowCheck: TBooleanField;
    fldWindowName: TStringField;
    dsWindow:    TDataSource;
    fldWindowIDTypeWindow: TIntegerField;
    fldWindowFilename: TStringField;
    tmrMain:     TTimer;
    dlgSaveAs:   TSaveDialog;
    fsMainSettings: TJvFormStorage;
    httpugCheckVer: TJvHttpUrlGrabber;
    dsQuickQuery: TDataSource;
    mdQuickQuery: TdxMemData;
    fldQuickQueryID: TAutoIncField;
    fldQuickQueryIDGroup: TIntegerField;
    fldQuickQueryIDType: TIntegerField;
    fldQuickQueryName: TStringField;
    fldQuickQueryType: TIntegerField;
    fldQuickQueryQuery: TMemoField;
    fldQuickQueryDefaultSchema: TIntegerField;
    srMain:      TcxStyleRepository;
    style1:      TcxStyle;
    style2:      TcxStyle;
    style3:      TcxStyle;
    style4:      TcxStyle;
    style5:      TcxStyle;
    style6:      TcxStyle;
    style7:      TcxStyle;
    style8:      TcxStyle;
    style9:      TcxStyle;
    style10:     TcxStyle;
    style11:     TcxStyle;
    style12:     TcxStyle;
    style13:     TcxStyle;
    style14:     TcxStyle;
    ssMainGridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet;
    qQuickQuery: TOraQuery;
    dsQuickQueryResult: TOraDataSource;
    grdvrSchema: TcxGridViewRepository;
    tvSchema:    TcxGridDBTableView;
    clmSchemaID: TcxGridDBColumn;
    clmSchemaIDGroup: TcxGridDBColumn;
    clmSchemaDB: TcxGridDBColumn;
    clmSchemaUserName: TcxGridDBColumn;
    clmSchemaIDType: TcxGridDBColumn;
    clmSchemaSchema: TcxGridDBColumn;
    ilMain:      TImageList;
    fldSchemaNameIsBold: TBooleanField;
    fldSchemaNameBackgroundColor: TIntegerField;
    fldSchemaNameTextColor: TIntegerField;
    dlgOpenFile: TJvOpenDialog;
    fldWindowWinHandle: TIntegerField;
    fldWindowIdxPLDev: TIntegerField;
    fldSchemaVisible: TBooleanField;
    chnDataFile: TJvChangeNotify;
    procedure DataModuleCreate(Sender: TObject);
    procedure oscrMainError(Sender: TObject; E: Exception; SQL: string;
      var Action: TErrorAction);
    procedure mdSchemaAfterPost(DataSet: TDataSet);
    procedure mdSchemaTypeAfterPost(DataSet: TDataSet);
    procedure mdSchemaGroupAfterPost(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure mdWindowAfterDelete(DataSet: TDataSet);
    procedure mdWindowAfterPost(DataSet: TDataSet);
    procedure tmrMainTimer(Sender: TObject);
    procedure httpugCheckVerDoneFile(Sender: TObject; FileName: string;
      FileSize: integer; Url: string);
    procedure httpugCheckVerError(Sender: TObject; ErrorMsg: string);
    procedure mdQuickQueryAfterPost(DataSet: TDataSet);
    procedure mdQuickQueryAfterDelete(DataSet: TDataSet);
    procedure mdQuickQueryBeforeCancel(DataSet: TDataSet);
    procedure mdQuickQueryBeforePost(DataSet: TDataSet);
    procedure mdSchemaNewRecord(DataSet: TDataSet);
    procedure JvChangeNotify1Notifications0Change(Sender: TObject);
    procedure chnDataFileNotifications1Change(Sender: TObject);
  private
    FShowMessageOnUpdateDone: boolean;
    FIsWriteData: Boolean;
    FIsWriteSettings: Boolean;
    procedure LoadSettings;

  public
    MessageLog: TStrings;
    property IsWriteSettings: Boolean read FIsWriteSettings write FIsWriteSettings;

    function InputPassword(ACaption, AMessage: string; var APassword: string): boolean;

    procedure ExecuteScript(AScriptFile: string; AMessageLog: TStrings;
      ALoadFile, AUnSetSchemaOnSuccess, AExecuteInPLDev: boolean);
    procedure LoadData;
    procedure LoadDataFile(ADataSet: TdxMemData; AFileName: string);
    procedure SaveDataFile(ADataSet: TdxMemData; AFileName: string);

    // authorization in PLDev
    function PLDevLogon(ADatabase, AUserName, APassword, ASchema: string): boolean;
    // authorization in ODAC
    function ODACLogon(ADatabase, AUserName, APassword, ASchema: string): boolean;
    function Logon(APLDevLogon: boolean): boolean;      // authorization in PLDev or ODAC

    procedure CheckNewVer(AShowMessageOnDone: boolean);
    procedure SaveFile;
    procedure SaveSpecAndBodySeparate(AFilename: string);
    procedure SavePackageTypeInOne(AFilename: string);
    procedure OpenFile(ABackupOrTmp: integer);

    function LocateLogonSchema: boolean;

    procedure FilterQuickQueryByCurSchemaType(ASetFilter: boolean);
    procedure ExecuteQuickQuery(ASchemaID: integer; AQueryText: string);
    procedure CloseQuickQuery;


  end;

var
  dmData: TdmData;

  GPath2Plugin: string; // path to plugin dll

  // Flags
  GPLDevStarted: boolean;

  // Global settings
  GSavePasswordForLogon: boolean;
  GShowSaveAsFileDialog: boolean;
  GShowSaveAsFileDialog4ReadOnly: boolean;
  GSaveFilesSeparate:    boolean;
  GGenerateSpecAndBodyFile: boolean;

  GAppPath, GAppDataDir, GAppDataDBDir, GAppTmpFilesDir: string;
  GLogining: boolean = False;
  GIsWindowExecuting: boolean;
  //GIsWindowSaving: boolean;
  GErrorOnExecuteScript: boolean = False;
  GStopExecuteScript: boolean = False;

  GStoreFileHistory:      boolean = False;
  GStoreHistory4TmpFiles: boolean = True;
  GCountHistoryFiles:     integer = 10;

  GFormatSimpleComment: string;
  GFormatSpecComment:   string;

//  WM_REFRESH_DATA:     integer;
//  WM_REFRESH_SETTINGS: integer;

// comment selected text or current string in edit window of PL/SQL Developer
procedure OraTauComment(ACommentType: integer);

implementation

uses
  ufrmMain, JclFileUtils, Forms,
  ufrmAbout, PlugInIntf, Messages, Variants, ShellAPI, ufrmSchemaGroups,
  ufrmSchemaTypes, ufrmWindows, JclSysInfo, StrUtils, ufrmLogonDialog,
  ufrmSaveNewFile, ufrmSettings, JclIniFiles, ufrmQuickQuery, StdCtrls,
  Math, ufrmSchemaImport;

{$R *.dfm}

function before(const ASearch, Find: string): string;
var
  index: byte;
begin
  index := Pos(Find, ASearch);
  if index = 0 then
    Result := ASearch
  else
    Result := Copy(ASearch, 1, index - 1);
end;

function after(const ASearch, AFind: string): string;
var
  LIdx: byte;
begin
  LIdx := Pos(AFind, ASearch);
  if LIdx = 0 then
    Result := ASearch
  else
    Result := Copy(ASearch, LIdx + Length(AFind), 1000);
end;

procedure Delay(ATimeout: integer);
var
  t: cardinal;
begin
  while ATimeout > 0 do
  begin
    t := GetTickCount;
    if MsgWaitForMultipleObjects(0, nil^, False, ATimeOut, QS_ALLINPUT) =
      WAIT_TIMEOUT then
      Exit;
    Application.ProcessMessages;
    Dec(ATimeout, GetTickCount - t);
  end;
end;

procedure OraTauComment(ACommentType: integer);
// comment selected text or current string in edit window of PL/SQL Developer
var
  LCommentText: TStringList;
  LStrIdx, LSelStart, LSelEnd: integer;
  LComment1, LComment2, LSourceStrStart, LSourceStrEnd: string;
  LIdx4Comment, LLengthTextBeforeComment, LIncLineInSelection,
  LLengthEndLineInSelection: integer;
  LDoComment: Boolean;
begin
  case ACommentType of
    1:    begin
      LComment1 := GFormatSimpleComment;
      LComment2 := GFormatSpecComment;
    end;
    2:    begin
      LComment1 := GFormatSpecComment;
      LComment2 := GFormatSimpleComment;
    end;
  end;
  LIdx4Comment := 1000000000;

  if IDE_WindowHasEditor(True) and not IDE_GetReadOnly then
  begin
    // detect border of selected text area
    SendMessage(IDE_GetEditorHandle, EM_GETSEL, integer(@LSelStart), integer(@LSelEnd));

    if (SendMessage(IDE_GetEditorHandle, EM_LINEFROMCHAR, LSelStart, 0) <>
      SendMessage(IDE_GetEditorHandle, EM_LINEFROMCHAR, LSelEnd, 0)) and
      (SendMessage(IDE_GetEditorHandle, EM_LINEINDEX,
      SendMessage(IDE_GetEditorHandle, EM_LINEFROMCHAR, LSelEnd, 0), 0) =
      LSelEnd) then
      LIncLineInSelection := 0
    else
      LIncLineInSelection := 1;

    if SendMessage(IDE_GetEditorHandle, EM_LINEINDEX,
      SendMessage(IDE_GetEditorHandle, EM_LINEFROMCHAR, LSelEnd, 0) +
      LIncLineInSelection, 0) = 0 then
    begin
      LLengthEndLineInSelection :=
        SendMessage(IDE_GetEditorHandle, EM_LINELENGTH, LSelEnd, 0);
      LIncLineInSelection := 0;
    end
    else
      LLengthEndLineInSelection := 0;

    // select text area from start of line and get them
    SendMessage(IDE_GetEditorHandle, EM_SETSEL,
      SendMessage(IDE_GetEditorHandle, EM_LINEINDEX,
      SendMessage(IDE_GetEditorHandle, EM_LINEFROMCHAR, LSelStart, 0), 0),
      SendMessage(IDE_GetEditorHandle, EM_LINEINDEX,
      SendMessage(IDE_GetEditorHandle, EM_LINEFROMCHAR, LSelEnd, 0) +
      LIncLineInSelection, 0) + LLengthEndLineInSelection);

    SendMessage(IDE_GetEditorHandle, EM_GETSEL, integer(@LSelStart), integer(@LSelEnd));

    LCommentText := TStringList.Create;
    try
      with LCommentText do
      begin
        Text := StrPas(IDE_GetSelectedText);
        LLengthTextBeforeComment := Length(Text);

        // detect min symbol position of all lines of selected text
        for LStrIdx := 0 to Count - 1 do
        begin
          LSourceStrEnd := TrimLeft(Strings[LStrIdx]);

          if Trim(LSourceStrEnd) <> '' then
            LIdx4Comment := MinIntValue([LIdx4Comment, Length(Strings[LStrIdx]) -
              Length(LSourceStrEnd)]);
        end;

        if LIdx4Comment = 1000000000 then
          LIdx4Comment := 0;

        // detect what to do: comment or uncomment
        LDoComment := False;
        for LStrIdx := 0 to Count - 1 do
        begin
          LSourceStrEnd   := Strings[LStrIdx];
          // if be one uncommented not empty line then do comment for all selected text
          if (Trim(LSourceStrEnd) <> '') and not StartsText(LComment1, TrimLeft(LSourceStrEnd)) then
          begin
            LDoComment := True;
            Break;
          end;
        end;

        // comment/uncomment selected text
        for LStrIdx := 0 to Count - 1 do
        begin
          LSourceStrEnd   := TrimLeft(Strings[LStrIdx]);
          LSourceStrStart := ReplaceStr(Strings[LStrIdx], LSourceStrEnd, '');

          //          if Trim(LSourceStrEnd) <> '' then
          //            if StartsText(LComment1, LSourceStrEnd) then
          if not LDoComment then
          begin
            //            if Trim(LSourceStrEnd) <> '' then
            Strings[LStrIdx] := LSourceStrStart + after(LSourceStrEnd, LComment1);
          end
          else
          begin
            if Trim(LSourceStrEnd) <> '' then
              Strings[LStrIdx] :=
                Copy(Strings[LStrIdx], 1, LIdx4Comment) + LComment1 +
                Copy(Strings[LStrIdx], LIdx4Comment + 1, Length(Strings[LStrIdx]))
            else
              Strings[LStrIdx] := DupeString(' ', LIdx4Comment) + LComment1;
          end;
        end;

        // replace selected text with un/commented
        SendMessage(IDE_GetEditorHandle, EM_REPLACESEL, 0,
          integer(@LCommentText.Text[1]));

        SendMessage(IDE_GetEditorHandle, EM_SETSEL, LSelStart,
          LSelEnd + length(Text) - LLengthTextBeforeComment);
      end;

    finally
      FreeAndNil(LCommentText);
    end;
  end;
end;

// PlugIn identification, a unique identifier is received and
// the description is returned
function IdentifyPlugIn(ID: integer): PChar; cdecl;
begin
  PlugInID := ID;
  Result   := C_APP_NAME;
end;

// Called when the Plug-In is created
procedure OnCreate; cdecl;
begin
end;

// Called when the Plug-In is activated
procedure OnActivate; cdecl;
begin
  try
    GPLDevStarted      := False;
    Application.Handle := IDE_GetAppHandle;

    if not Assigned(dmData) then
    begin
      dmData := TdmData.Create(Application);
      //    dmData.tmrMain.Interval := 20000;
      //      dmData.fsMainSettings.ReadInteger('StartTimeout4SaveNew', 20) * 1000;
      dmData.tmrMain.Enabled := True;
    end;

    // ToolButton for Logon. Special menu index for single click logon
    IDE_CreateToolButton(PlugInID, 1, 'OraTau Fast Logon',
      PChar(GPath2Plugin + C_PLUGIN_FOLDER + 'oratau_logon_fast.bmp'), 0);
    // ToolButton for QuickQuery
    IDE_CreateToolButton(PlugInID, 4, 'OraTau Quick Query',
      PChar(GPath2Plugin + C_PLUGIN_FOLDER + 'oratau_quick_query.bmp'), 0);
    // ToolButton for Save
    IDE_CreateToolButton(PlugInID, 29, 'OraTau Save',
      PChar(GPath2Plugin + C_PLUGIN_FOLDER + 'oratau_save.bmp'), 0);

    IDE_SplashWriteLn(#13#10 + C_APP_NAME_VER + ' loaded');

  except
    on e: Exception do
      IDE_DebugLog(PAnsiChar(C_APP_NAME + ' error OnActivate: ' + e.Message));
  end;
end;

procedure AfterExecuteWindow(WindowType, Result: integer); cdecl;
begin
  GIsWindowExecuting := False;
end;

// This is the counterpart of the OnActivate. It is called when the Plug-In is de-activated
// in the configuration dialog.
procedure OnDeactivate; cdecl;
begin
  if Assigned(frmScriptExecute) then
    FreeAndNil(frmScriptExecute);

  if Assigned(frmLogon) then
    FreeAndNil(frmLogon);

  if Assigned(frmLogonFast) then
    FreeAndNil(frmLogonFast);

  if Assigned(frmWindows) then
    FreeAndNil(frmWindows);

  if Assigned(frmSaveNewFile) then
    FreeAndNil(frmSaveNewFile);

  if Assigned(frmQuickQuery) then
    FreeAndNil(frmQuickQuery);

  if Assigned(dmData) then
    FreeAndNil(dmData);
end;

// This is the counterpart of the OnCreate. You can dispose of anything you created in
// the OnCreate.
procedure OnDestroy; cdecl;
begin
end;

// Creating menus
function CreateMenuItem(Index: integer): PChar; cdecl;
begin
  Result := '';
  case Index of
    1: Result := 'OraTau / Oracle Logon Fast (One click logon)';
    2: Result := 'OraTau / Oracle Logon';
    3: Result := 'OraTau / Database script execution';
    4: Result := 'OraTau / Quick Query';

{$IFDEF DEBUG}
    20: Result := 'OraTau / Show windows list';
    //    21: Result := 'OraTau / test';
{$ENDIF}

    27: Result := 'File / Save All << OraTau / Open tmp-file';
    28: Result := 'File / Save All << OraTau / Open backup-file';
    29: Result := 'File / Save All << OraTau / Save';
    30: Result := 'File / Save All << OraTau / Save As...';

    35: Result := 'Edit / Selection / OraTau Simple Comment (Uncomment)';
    36: Result := 'Edit / Selection / OraTau Special Comment (Uncomment)';

    70: Result := 'OraTau / Directories / User groups';
    71: Result := 'OraTau / Directories / User types';
    72: Result := 'OraTau / Directories / Import users';

    //    79: Result := 'OraTau / Refresh Data and Settings';

    80: Result := 'OraTau / Settings';
    90: Result := 'OraTau / Check update';

    96: Result := 'OraTau / Help / OraTau PLD Help';
    97: Result := 'OraTau / Help / Home Page';
    99: Result := 'OraTau / Help / About';
  end;
end;

// One of our menus is selected
procedure OnMenuClick(Index: integer); cdecl;
begin
  case Index of
    1: LogonFast;
    2: Logon;
    3: ScriptExecute;
    4: ShowQuickQuery(nil);

    20: ShowWindowsList;
    //    21: begin
    //    ShowMessage(IDE_GetPersonalPrefSets);
    //    ShowMessage(IDE_GetDefaultPrefSets);
    //    end;

    27: dmData.OpenFile(2);
    28: dmData.OpenFile(1);
    29: dmData.SaveFile;
    30: ShowSaveAsFile;

    35: OraTauComment(1);
    36: OraTauComment(2);

    70: ShowSchemaGroups(nil);
    71: ShowSchemaTypes(nil);
    72: ShowSchemaImport(nil);

    //    79:    begin
    //      dmData.LoadSettings;
    //      dmData.LoadData;
    //    end;
    80: ShowSettings(nil, 0);
    90: dmData.CheckNewVer(True);

    96: ShellExecute(GetDesktopWindow(), 'open',
        PAnsiChar(GPath2Plugin + C_PLUGIN_FOLDER + 'oratau_pld_help.chm'), '', '', SW_MAXIMIZE);
    97: ShellExecute(GetDesktopWindow(), 'open',
        PAnsiChar(C_COMPANY_PAGE + '/oratau_pld/'), '', '', SW_MAXIMIZE);
    99: ShowAbout(Application);
  end;
end;

// This function allows you to display an about dialog. You can decide to display a
// dialog yourself (in which case you should return an empty text) or just return the
// about text.
function About: PChar; cdecl;
begin
  Result := nil;
  ShowAbout(nil);
end;

procedure AfterStart; cdecl;
var
  LTmpFiles, LOpenedFiles, LFilesForDelete: TStringList;
  LIdx: integer;
begin
  with dmData.fsMainSettings do
  begin
    if not ReadBoolean('AlreadyRun', False) then
    begin
      ShowSettings(nil, 0);
      WriteBoolean('AlreadyRun', True);
    end;

    // Repair wrong value into ini
    case ReadInteger('UpdateInterval', C_uiNever) of
      2: WriteInteger('UpdateInterval', 7);
      3: WriteInteger('UpdateInterval', 30);
      4: WriteInteger('UpdateInterval', -1);
    end;

    // check update on start or if it does never
    if (ReadInteger('UpdateInterval', C_uiNever) = C_uiAppStart) or
      ((ReadInteger('UpdateInterval', C_uiNever) <> C_uiNever) and
      (ReadFloat('LastCheckUpdate') +
      ReadInteger('UpdateInterval', C_uiNever) <= Date)) then
      dmData.CheckNewVer(False);

    // delete unused files that not in the windows list
    if ReadBoolean('DeleteTempFilesOnStart', True) then
      try
        LTmpFiles    := TStringList.Create;
        LOpenedFiles := TStringList.Create;
        LFilesForDelete := TStringList.Create;

        JclFileUtils.BuildFileList(GAppTmpFilesDir + '*.*', faAnyFile, LTmpFiles);

        for LIdx := 0 to IDE_GetWindowCount - 1 do
          if IDE_SelectWindow(LIdx) and (IDE_Filename <> '') then
            LOpenedFiles.Add(IDE_Filename);

        LOpenedFiles.CaseSensitive := False;
        for LIdx := 0 to LTmpFiles.Count - 1 do
          if (LOpenedFiles.IndexOf(GAppTmpFilesDir + LTmpFiles.Strings[LIdx]) =
            -1) and FileExists(GAppTmpFilesDir + LTmpFiles.Strings[LIdx]) then
            LFilesForDelete.Add(GAppTmpFilesDir + LTmpFiles.Strings[LIdx]);

        if (not ReadBoolean('DeleteOnStartConfirm', True) or
          ((LFilesForDelete.Count > 0) and
          (MessageBox(Application.Handle, PChar('Do you want to delete ' +
          IntToStr(LFilesForDelete.Count) + ' unused temporary files?'),
          'Confirm', MB_ICONQUESTION or MB_YESNO or MB_DEFBUTTON2) = ID_YES))) then
          for LIdx := 0 to LFilesForDelete.Count - 1 do
            try
              JclFileUtils.FileDelete(LFilesForDelete.Strings[LIdx], True);
            except
              on E: Exception do
                //ShowMessage(e.Message);
            end;
      finally
        FreeAndNil(LTmpFiles);
        FreeAndNil(LOpenedFiles);
        FreeAndNil(LFilesForDelete);
      end;
  end;
end;

procedure Configure; cdecl;
begin
  ShowSettings(nil, 0);
end;

// This will be called when PL/SQL Developer is about to close. If your PlugIn is not
// ready to close, you can show a message and return False.
function CanClose: boolean; cdecl;
begin
  Result := True;
end;

procedure OnConnectionChange;
var
  LUserName, LPassword, LDatabase: PChar;

begin
  if not GLogining and IDE_Connected then
  begin
    IDE_GetConnectionInfo(LUserName, LPassword, LDatabase);

    with dmData.mdSchema do
      if not Locate('UserName;DB',
        VarArrayOf([StrPas(LUserName), StrPas(LDatabase)]),
        [loCaseInsensitive]) then
      begin
        Append;
        FieldByName('DB').AsString     := StrPas(LDatabase);
        FieldByName('UserName').AsString := StrPas(LUserName);
        FieldByName('Schema').AsString := StrPas(LUserName);

        if GSavePasswordForLogon then
          FieldByName('Password').AsString :=
            dmData.vcData.EncodeString(dmData.vcData.Key, StrPas(LPassword));

        Post;
      end
      else
      if GSavePasswordForLogon and (FieldByName('Password').AsString <>
        dmData.vcData.EncodeString(dmData.vcData.Key, StrPas(LPassword))) then
      begin
        Edit;
        FieldByName('Password').AsString :=
          dmData.vcData.EncodeString(dmData.vcData.Key, StrPas(LPassword));
        Post;
      end;
  end;
end;

procedure OnWindowCreated(WindowType: integer); cdecl;
begin
  // While PL/Dev not started (load all windows)
  // after each created window waiting 5 sec before unset flag
  if not GPLDevStarted then
  begin
    dmData.tmrMain.Enabled  := False;
    dmData.tmrMain.Interval := 5000;
    dmData.tmrMain.Enabled  := True;
  end;

  if not GPLDevStarted //or GIsWindowSaving
    or not GShowSaveAsFileDialog or (not GShowSaveAsFileDialog4ReadOnly and
    IDE_GetReadOnly) then
    exit;

  if //IDE_Connected and
  IDE_CanSaveWindow and (IDE_Filename = '') then
    ShowSaveAsFile;

  //  with dmData.mdWindow do
  //  begin
  //    Append;
  //    FieldByName('Name').AsString     := StrPas(IDE_Filename);
  //    FieldByName('Filename').AsString := StrPas(IDE_Filename);
  //    FieldByName('IDTypeWindow').AsInteger := IDE_GetWindowType;
  //    FieldByName('Check').AsBoolean   := False;
  //    Post;
  //  end;
end;

procedure TdmData.CheckNewVer(AShowMessageOnDone: boolean);
var
  LProxyUserPassword: string;
begin
  FShowMessageOnUpdateDone := AShowMessageOnDone;

  with httpugCheckVer do
  begin
    ProxyAddresses := '';
    ProxyUserName  := '';
    ProxyPassword  := '';

    if fsMainSettings.ReadBoolean('NoProxy', False) then
      ProxyMode := pmNoProxy;

    if fsMainSettings.ReadBoolean('UseProxySysSettings', True) then
    begin
      ProxyMode := pmSysConfig;

      ProxyUserName := fsMainSettings.ReadString('ProxyUser');
      ProxyPassword := dmData.vcData.DecodeString(dmData.vcData.Key,
        fsMainSettings.ReadString('ProxyPassword'));
    end;

    if fsMainSettings.ReadBoolean('UseProxy', False) then
    begin
      ProxyMode := pmManual;

      ProxyAddresses := fsMainSettings.ReadString('ProxyServer') +
        ':' + fsMainSettings.ReadString('ProxyPort', '80');
      ProxyUserName  := fsMainSettings.ReadString('ProxyUser');
      ProxyPassword  := dmData.vcData.DecodeString(dmData.vcData.Key,
        fsMainSettings.ReadString('ProxyPassword'));
    end;

    if (ProxyMode <> pmNoProxy) and fsMainSettings.ReadBoolean('AskForPassword',
      False) and InputPassword('Check for ' + C_APP_NAME + ' updates',
      'Proxy password: ', LProxyUserPassword) then
      ProxyPassword := LProxyUserPassword;

    FileName := GAppDataDir + 'site_ver.ini';
    Start;
  end;
end;

procedure TdmData.chnDataFileNotifications1Change(Sender: TObject);
begin
  dmData.LoadSettings;
end;

procedure TdmData.CloseQuickQuery;
begin
  if qQuickQuery.Active then
    qQuickQuery.Close;
  if osMain.Connected then
    osMain.Disconnect;
end;

procedure TdmData.SaveSpecAndBodySeparate(AFilename: string);
var
  LTabIndex: integer;
  LObjectTypeStr, LFileNameSpec, LFileNameBody, LFileExt, LB, LBOMHead: string;
  LObjectType, LObjectOwner, LObjectName, LSubObject: PChar;
  LSLSource, LSLDest: TStringList;
  LIdx, LIdxSlash: integer;
  FL:      TFileStream;
  UTF8BOM: array[1..3] of byte;
  LIsUTF8: boolean;

  function GetLineBreak(AFilename: string): string;
  var
    LSize: integer;
    S:     string;
    P:     PChar;
  begin
    Result := #13#10;

    FL := TFileStream.Create(AFilename, fmOpenRead or fmShareDenyNone);
    try
      LSize := FL.Size - FL.Position;
      SetString(S, nil, LSize);
      FL.Read(Pointer(S)^, LSize);
      P := Pointer(S);
      while P^ <> #0 do
      begin
        while not (P^ in [#0, #10, #13]) do
          Inc(P);
        if P^ = #13 then
          Result := #13#10;
        if P^ = #10 then
          Result := #10;

        Break;
      end;
    finally
      FreeAndNil(FL);
    end;
  end;

  procedure SaveFile(AFilename: string; AStrList: TStringList);
  begin
    if Assigned(AStrList) then
    begin
      LBOMHead := AStrList.Strings[0];
      if (Ord(LBOMHead[1]) = UTF8BOM[1]) and (Ord(LBOMHead[2]) = UTF8BOM[2]) and
        (Ord(LBOMHead[3]) = UTF8BOM[3]) then
        AStrList.Strings[0] :=
          Copy(AStrList.Strings[0], 4, Length(AStrList.Strings[0]) - 3);

      FL      := TFileStream.Create(AFilename, fmOpenReadWrite or
        fmShareDenyNone or fmCreate);
      FL.Size := 0;
      try
        if LIsUTF8 then
          FL.WriteBuffer(UTF8BOM, SizeOf(UTF8BOM));

        AStrList.SaveToStream(FL);
        AStrList.Clear;
      finally
        FreeAndNil(FL);
      end;
    end;
  end;

begin
  if not GSaveFilesSeparate then
    Exit;

  LIsUTF8 := True;

  UTF8BOM[1] := $EF;
  UTF8BOM[2] := $BB;
  UTF8BOM[3] := $BF;

  LB := GetLineBreak(AFilename);

  LTabIndex := IDE_TabIndex(-1);
  IDE_TabIndex(0);
  IDE_GetWindowObject(LObjectType, LObjectOwner, LObjectName, LSubObject);
  LObjectTypeStr := StrPas(LObjectType);

  IDE_TabIndex(LTabIndex);

  if LObjectTypeStr = 'PACKAGE' then
    LFileExt := IDE_GetProcEditExtension('PACKAGE') //'spc'
  else
  if LObjectTypeStr = 'TYPE' then
    LFileExt := IDE_GetProcEditExtension('TYPE')//'typ';
  ;
  LFileNameSpec := AnsiReplaceStr(AFilename, ExtractFileExt(AFilename),
    '.' + LFileExt);

  if LObjectTypeStr = 'PACKAGE' then
    LFileExt := IDE_GetProcEditExtension('PACKAGE BODY') //'bdy'
  else
  if LObjectTypeStr = 'TYPE' then
    LFileExt := IDE_GetProcEditExtension('TYPE BODY')//'tpb';
  ;
  LFileNameBody := AnsiReplaceStr(AFilename, ExtractFileExt(AFilename),
    '.' + LFileExt);


  LSLSource := TStringList.Create;
  LSLSource.LineBreak := LB;
  LSLDest   := TStringList.Create;
  LSLDest.LineBreak := LB;
  try
    LSLSource.LoadFromFile(AFilename);

    LBOMHead := LSLSource.Strings[0];
    LIsUTF8  := (Ord(LBOMHead[1]) = UTF8BOM[1]) and
      (Ord(LBOMHead[2]) = UTF8BOM[2]) and (Ord(LBOMHead[3]) = UTF8BOM[3]);

    LIdxSlash := LSLSource.IndexOf('/');
    if LIdxSlash > -1 then
    begin
      for LIdx := 0 to LIdxSlash do
        LSLDest.Append(LSLSource.Strings[LIdx]);
      SaveFile(LFileNameSpec, LSLDest);

      for LIdx := LIdxSlash + 1 to LSLSource.Count - 1 do
        LSLDest.Append(LSLSource.Strings[LIdx]);
      SaveFile(LFileNameBody, LSLDest);
    end;

  finally
    if Assigned(LSLSource) then
      FreeAndNil(LSLSource);
    if Assigned(LSLDest) then
      FreeAndNil(LSLDest);
  end;
end;

procedure TdmData.SavePackageTypeInOne(AFilename: string);
var
  LObjectTypeStr, LFileNameAll, LFileNameSpec, LFileNameBody, LFileExt,
  LFileExtAll: string;
  LObjectType, LObjectOwner, LObjectName, LSubObject: PChar;
  UTF8BOM, LBOMHead: array[1..3] of byte;
  LFLSpec, LFLBody, LFLAll: TFileStream;
  LSSUTF8: TStringStream;
  LUTF8: UTF8String;
begin
  if not GGenerateSpecAndBodyFile then
    exit;

  UTF8BOM[1] := $EF;
  UTF8BOM[2] := $BB;
  UTF8BOM[3] := $BF;

  IDE_GetWindowObject(LObjectType, LObjectOwner, LObjectName, LSubObject);
  LObjectTypeStr := StrPas(LObjectType);
  if (LObjectTypeStr = 'PACKAGE') or (LObjectTypeStr = 'TYPE') then
  begin
    if LObjectTypeStr = 'PACKAGE' then
    begin
      LFileExt    := IDE_GetProcEditExtension('PACKAGE BODY'); //'spc'
      LFileExtAll := IDE_GetProcEditExtension('PACKAGE SPEC AND BODY'); //'pck'
    end
    else
    begin
      if LObjectTypeStr = 'TYPE' then
      begin
        LFileExt    := IDE_GetProcEditExtension('TYPE BODY'); //'typ'
        LFileExtAll := IDE_GetProcEditExtension('TYPE SPEC AND BODY'); //'typ'
      end;
    end;

    LFileNameAll  := AnsiReplaceStr(AFilename, ExtractFileExt(AFilename),
      '.' + LFileExtAll);
    LFileNameSpec := AFilename;
    LFileNameBody := AnsiReplaceStr(AFilename, ExtractFileExt(AFilename),
      '.' + LFileExt);
  end
  else
  if (LObjectTypeStr = 'PACKAGE BODY') or (LObjectTypeStr = 'TYPE BODY') then
  begin
    if LObjectTypeStr = 'PACKAGE BODY' then
    begin
      LFileExt    := IDE_GetProcEditExtension('PACKAGE'); //'spc'
      LFileExtAll := IDE_GetProcEditExtension('PACKAGE SPEC AND BODY'); //'pck'
    end
    else
    begin
      if LObjectTypeStr = 'TYPE BODY' then
      begin
        LFileExt    := IDE_GetProcEditExtension('TYPE'); //'typ'
        LFileExtAll := IDE_GetProcEditExtension('TYPE SPEC AND BODY'); //'typ'
      end;
    end;

    LFileNameAll  := AnsiReplaceStr(AFilename, ExtractFileExt(AFilename),
      '.' + LFileExtAll);
    LFileNameSpec := AnsiReplaceStr(AFilename, ExtractFileExt(AFilename),
      '.' + LFileExt);
    LFileNameBody := AFilename;
  end
  else
    exit// procedure or function;
  ;

  if not FileExists(LFileNameSpec) or not FileExists(LFileNameBody) then
    exit;

  try
    LFLSpec := TFileStream.Create(LFileNameSpec, fmOpenRead or fmShareDenyNone);
    LFLBody := TFileStream.Create(LFileNameBody, fmOpenRead or fmShareDenyNone);

    LFLAll      := TFileStream.Create(LFileNameAll, fmOpenReadWrite or
      fmShareDenyNone or fmCreate);
    LFLAll.Size := 0;
    // truncate BOM from source
    if (LFLSpec.Read(LBOMHead, 3) = 3) and (LBOMHead[1] = UTF8BOM[1]) and
      (LBOMHead[2] = UTF8BOM[2]) and (LBOMHead[3] = UTF8BOM[3]) then
      LFLSpec.Position := 3
    else
      LFLSpec.Position := 0;
    if (LFLBody.Read(LBOMHead, 3) = 3) and (LBOMHead[1] = UTF8BOM[1]) and
      (LBOMHead[2] = UTF8BOM[2]) and (LBOMHead[3] = UTF8BOM[3]) then
      LFLBody.Position := 3
    else
      LFLBody.Position := 0;

    // write bom if one of file in utf8
    if (LFLSpec.Position = 3) or (LFLBody.Position = 3) then
      LFLAll.WriteBuffer(UTF8BOM, Length(UTF8BOM));

    if (LFLSpec.Position = 0) and (LFLBody.Position = 3) then
    begin
      LSSUTF8 := TStringStream.Create('');
      try
        LSSUTF8.CopyFrom(LFLSpec, LFLSpec.Size);
        LUTF8 := AnsiToUtf8(LSSUTF8.DataString);
      finally
        FreeAndNil(LSSUTF8);
      end;
      LFLAll.WriteBuffer(LUTF8[1], Length(LUTF8));
    end
    else
      LFLAll.CopyFrom(LFLSpec, LFLSpec.Size - LFLSpec.Position);

    if (LFLSpec.Position = 3) and (LFLBody.Position = 0) then
    begin
      LSSUTF8 := TStringStream.Create('');
      try
        LSSUTF8.CopyFrom(LFLBody, LFLBody.Size);
        LUTF8 := AnsiToUtf8(LSSUTF8.DataString);
      finally
        FreeAndNil(LSSUTF8);
      end;
      LFLAll.WriteBuffer(LUTF8[1], Length(LUTF8));
    end
    else
      LFLAll.CopyFrom(LFLBody, LFLBody.Size - LFLBody.Position);

  finally
    FreeAndNil(LFLSpec);
    FreeAndNil(LFLBody);
    FreeAndNil(LFLAll);
  end;
end;

procedure TdmData.DataModuleCreate(Sender: TObject);
begin
  FIsWriteSettings := False;
  LoadSettings;

  LoadData;
end;

procedure TdmData.DataModuleDestroy(Sender: TObject);
begin
  chnDataFile.Active := False;

  dmData := nil;
end;

function TdmData.PLDevLogon(ADatabase, AUserName, APassword, ASchema: string): boolean;
var
  LUserName, LPassword, LDatabase: PChar;
begin
  Result := False;

  if GIsWindowExecuting then
    raise Exception.Create(
      'You cannot log on as another user while one or more windows are still executing');

  GLogining := True;
  try
    try
      if IDE_Connected then
      begin
        IDE_GetConnectionInfo(LUserName, LPassword, LDatabase);

        if (UpperCase(AUserName) = UpperCase(StrPas(LUserName))) and
          (UpperCase(APassword) = UpperCase(StrPas(LPassword))) and
          //(UpperCase(AUserName) = UpperCase(ASchema)) and
          (UpperCase(ADatabase) = UpperCase(StrPas(LDatabase))) then
        begin
          Result := True;
          Exit;
        end;
      end;

      if not IDE_SetConnection(PChar(AUserName), PChar(APassword),
        PChar(ADatabase)) then
        raise Exception.Create('Can’t logon as ' + AUserName +
          #13#10 + StrPas(SQL_ErrorMessage))
      else
        Result := True;

    except
      on E: Exception do
        MessageDlg(e.Message, mtError, [mbOK], 0);
    end;

    //    if Result and (UpperCase(AUserName) <> UpperCase(ASchema)) then
    //    begin
    //      if SQL_Execute(PChar('alter session set current_schema = ' +
    //        ASchema)) <> 0 then
    //      begin
    //        Result := False;
    //        raise Exception.Create('Could not set schema to ' + ASchema +
    //          #13#10 + StrPas(SQL_ErrorMessage));
    //      end;
    //    end;

  finally
    GLogining := False;
  end;
end;

procedure TdmData.ExecuteQuickQuery(ASchemaID: integer; AQueryText: string);
//var
//  LCurSchemaID: integer;
begin
  Screen.Cursor := crHourGlass;
  qQuickQuery.DisableControls;

  //LCurSchemaID := mdSchema.FieldByName('ID').AsInteger; // current schema
  //LocateLogonSchema;
  mdSchema.Locate('ID', ASchemaID, []);

  if Logon(False) then
    try
      try
        if qQuickQuery.Active then
          qQuickQuery.Close;
        qQuickQuery.SQL.Text := AQueryText;
        qQuickQuery.Open;

      except
        on E: Exception do
          MessageDlg(e.Message, mtError, [mbOK], 0);
      end;
    finally
      qQuickQuery.EnableControls;
      //mdSchema.Locate('ID', LCurSchemaID, []);
      Screen.Cursor := crDefault;
    end;
end;

procedure TdmData.ExecuteScript(AScriptFile: string; AMessageLog: TStrings;
  ALoadFile, AUnSetSchemaOnSuccess, AExecuteInPLDev: boolean);

begin
  Screen.Cursor := crHourGlass;
  mdSchema.DisableControls;
  mdSchema.AfterPost := nil;// disable save to file

  try
    MessageLog := AMessageLog;

    MessageLog.Append('Executing the script. Start (' +
      FormatDateTime('yyyy.mm.dd HH:mm:ss', Now) + ')' + #13#10 +
      'Script file: ' + AScriptFile + #13#10);

    with mdSchema do
    begin
      First;
      while not EOF do
      begin
        if FieldByName('Check').AsBoolean then
        begin
          MessageLog.Append('= The script is executed as  ' +
            FieldByName('Username').AsString + '@' +
            FieldByName('DB').AsString + ' (' +
            FormatDateTime('yyyy.mm.dd HH:mm:ss', Now) + ')');

          try
            if AExecuteInPLDev then
            begin
              if Logon(True) then
              begin
                // Open script in Command Window
                if (IDE_OpenFile(wtCommand, PChar(AScriptFile))) then
                  GIsWindowExecuting := True;
                IDE_Perform(1);

                while GIsWindowExecuting do
                  Delay(100);

                MessageLog.Append('PL/SQL Developer script execution message log:' +
                  IDE_GetText + ' (' + FormatDateTime(
                  'yyyy.mm.dd HH:mm:ss', Now) + ')');

                IDE_CloseFile; // Need that to clear log for future execution

                if AUnSetSchemaOnSuccess then
                begin
                  Edit;
                  FieldByName('Check').AsBoolean := False;
                  Post;
                end;

              end
              else
                MessageLog.Append('== An error occurred while user ' +
                  FieldByName('Username').AsString + '@' +
                  FieldByName('DB').AsString + ' logon (' +
                  FormatDateTime('yyyy.mm.dd HH:mm:ss', Now) + ')' + #13#10 + #13#10);
            end
            else
            if Logon(False) then
            begin
              GErrorOnExecuteScript := False;
              if ALoadFile then
              begin
                oscrMain.SQL.LoadFromFile(AScriptFile);
                oscrMain.Execute;
              end
              else
                oscrMain.ExecuteFile(AScriptFile);

              if not GErrorOnExecuteScript and AUnSetSchemaOnSuccess then
              begin
                Edit;
                FieldByName('Check').AsBoolean := False;
                Post;
              end;

              MessageLog.Append('== The script has been executed as ' +
                FieldByName('Username').AsString + '@' +
                FieldByName('DB').AsString + ' successfully (' +
                FormatDateTime('yyyy.mm.dd HH:mm:ss', Now) + ')' + #13#10 + #13#10);
            end
            else
              MessageLog.Append('== The script has been executed as ' +
                FieldByName('Username').AsString + '@' +
                FieldByName('DB').AsString + ' with errors (' +
                FormatDateTime('yyyy.mm.dd HH:mm:ss', Now) + ')' + #13#10 + #13#10);

          except
            on e: Exception do
              MessageLog.Append('== The script has been executed as ' +
                FieldByName('Username').AsString + '@' +
                FieldByName('DB').AsString + ' with errors (' +
                FormatDateTime('yyyy.mm.dd HH:mm:ss', Now) + ')' +
                #13#10 + e.Message + #13#10 + #13#10);
          end;
        end;

        Next;
        Application.ProcessMessages;
        if GStopExecuteScript then
        begin
          MessageLog.Append('A user has stoped the execution of the script! (' +
            FormatDateTime('yyyy.mm.dd HH:mm:ss', Now) + ')');
          Exit;
        end;

      end;

      MessageLog.Append('Executing the script. End (' +
        FormatDateTime('yyyy.mm.dd HH:mm:ss', Now) + ')');
    end;

  finally
    if osMain.Connected then
      osMain.Disconnect;
    GIsWindowExecuting := False;
    mdSchema.AfterPost := mdSchemaAfterPost;// enable save to file
    SaveDataFile(mdSchema, C_SCHEMES_FILE);
    mdSchema.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

procedure TdmData.FilterQuickQueryByCurSchemaType(ASetFilter: boolean);
begin
  if ASetFilter and LocateLogonSchema then
  begin
    mdQuickQuery.Filter   := 'IDType = ' + mdSchema.FieldByName('IDType').AsString;
    mdQuickQuery.Filtered := True;
  end
  else
  begin
    mdQuickQuery.Filter   := '';
    mdQuickQuery.Filtered := False;
  end;

end;

procedure TdmData.httpugCheckVerDoneFile(Sender: TObject; FileName: string;
  FileSize: integer; Url: string);
var
  LNewVersion: string;
begin
  LNewVersion := JclIniFiles.IniReadString(FileName, 'UpdateInfo', 'Version');

  if LNewVersion = '' then
  begin
    MessageDlg('Can’t check for ' + C_APP_NAME + ' updates' + #13#10 +
      'Check the update settings in the "OraTau -> Settings -> Updates" window',
      mtInformation, [mbOK], 0);
    Exit;
  end;

  if (C_VERSION <> LNewVersion) and
    (fsMainSettings.ReadString('LatestVersion', C_VERSION) <> LNewVersion) then
  begin
    if MessageDlg('A new version of ' + C_APP_NAME + ' ' + LNewVersion +
      ' has been found.' + #13#10 + 'Do you want to open the download webpage?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      ShellExecute(GetDesktopWindow(), 'open',
        PAnsiChar(C_COMPANY_PAGE + '/download.php#oratau_pld'), '', '',
        SW_MAXIMIZE);
  end
  else
  if FShowMessageOnUpdateDone then
    MessageBox(Application.Handle, 'No new updates found.', 'Update notification',
      MB_ICONINFORMATION or MB_OK or MB_DEFBUTTON1);

  fsMainSettings.WriteFloat('LastCheckUpdate', Date);
  fsMainSettings.WriteString('LatestVersion', LNewVersion);

  // if settings window open then refresh data in them
  if Assigned(frmSettings) then
    frmSettings.SetUpdateInfo;
end;

procedure TdmData.httpugCheckVerError(Sender: TObject; ErrorMsg: string);
begin
  MessageBox(Application.Handle, PChar(ErrorMsg),
    'An error occurred while checking for ' + C_APP_NAME + ' updates',
    MB_ICONERROR or MB_OK);
end;

function TdmData.InputPassword(ACaption, AMessage: string;
  var APassword: string): boolean;
var
  LMsgDialog:    TForm;
  LPasswordEdit: TEdit;
begin
  Result    := False;
  APassword := '';

  LMsgDialog    := CreateMessageDialog(AMessage, mtWarning, [mbOK, mbCancel]);
  LPasswordEdit := Tedit.Create(LMsgDialog);

  with LMsgDialog do
    try
      Caption := ACaption;
      Height  := 125;
      Width   := 200;


      with LPasswordEdit do
      begin
        Parent := LMsgDialog;
        Text   := '';
        PasswordChar := '*';
        Top    := 33;
        Left   := 55;
      end;

      if ShowModal = ID_OK then
      begin
        Result    := True;
        APassword := LPasswordEdit.Text;
      end;

    finally
      LPasswordEdit.Free;
      Free;
    end;
end;

procedure TdmData.JvChangeNotify1Notifications0Change(Sender: TObject);
begin
  dmData.LoadData;
end;

procedure TdmData.LoadData;
begin
  // load data file only if data writed in other instance of PL/SQL Developer
  if not FIsWriteData then
  begin
    LoadDataFile(mdSchemaType, C_SCHEMA_TYPES_FILE);
    LoadDataFile(mdSchemaGroup, C_SCHEMA_GROUP_FILE);
    LoadDataFile(mdSchema, C_SCHEMES_FILE);
    LoadDataFile(mdQuickQuery, C_QUICK_QUERY_FILE);
  end
  else FIsWriteData := False;
end;

procedure TdmData.LoadDataFile(ADataSet: TdxMemData; AFileName: string);
var
  LID: integer;
begin
  LID := 0;

  with ADataSet do
  begin
    if not Active then
      Open;

    if FileExists(GAppDataDBDir + AFileName) then
    begin
      DisableControls;

      if Active and (RecordCount > 0) and (FindField('id') <> nil) then
        LID := FieldByName('id').AsInteger;

      LoadFromBinaryFile(GAppDataDBDir + AFileName);

      if LID <> 0 then
        Locate('id', LID, []);

      EnableControls;
    end;
  end;
end;

procedure TdmData.LoadSettings;
// load global settings
var
  TheFileName : array[0..MAX_PATH] of char;
begin
  if FIsWriteSettings then
  begin
    FIsWriteSettings := False;
    Exit;
  end;

  try
    FillChar(TheFileName, sizeof(TheFileName), #0);
    GetModuleFileName(hInstance, TheFileName, sizeof(TheFileName));

    GPath2Plugin := ExtractFilePath(TheFileName);

    GAppDataDir     := GetAppdataFolder + C_APP_DATA_FOLDER;
    GAppDataDBDir   := GetAppdataFolder + C_APP_DATA_FOLDER + 'data\';
    GAppTmpFilesDir := GetAppdataFolder + C_APP_DATA_FOLDER + 'tmp_files\';

    if not DirectoryExists(GAppDataDBDir) then
      ForceDirectories(GAppDataDBDir);
    if not DirectoryExists(GAppTmpFilesDir) then
      ForceDirectories(GAppTmpFilesDir);

    if not chnDataFile.Active then
    begin
      chnDataFile.Notifications[0].Directory := GAppDataDBDir; // monitor data folder
      chnDataFile.Notifications[1].Directory := GAppDataDir; // Monitor settings folder
      chnDataFile.Active := True;
    end;

    //  GIsWindowSaving := False;

    with fsMainSettings do
    begin
      GShowSaveAsFileDialog := ReadBoolean('ShowSaveAsFileDialog', True);
      GShowSaveAsFileDialog4ReadOnly := ReadBoolean('ShowSaveAsFileDialog4ReadOnly', True);
      GSaveFilesSeparate    := ReadBoolean('SaveSeparate', False);
      GGenerateSpecAndBodyFile := ReadBoolean('GenerateSpecAndBodyFile', False);

      GStoreFileHistory      := ReadBoolean('StoreFileHistory', False);
      GStoreHistory4TmpFiles := ReadBoolean('StoreHistory4TmpFiles', True);
      GCountHistoryFiles     := ReadInteger('CountHistoryFiles', 10);

      // Logon
      GSavePasswordForLogon := ReadBoolean('SavePasswordForLogon', False);

      // Edit Settings (Format comments)
      GFormatSimpleComment := AnsiDequotedStr(ReadString('FormatSimpleComment',
        '"-- "'), '"');
      GFormatSpecComment   := AnsiDequotedStr(ReadString('FormatSpecComment',
        '"--* "'), '"');
    end;

  except
    on e: Exception do
      IDE_DebugLog(PAnsiChar(C_APP_NAME + ' error load settings: ' + e.Message));
  end;
end;

function TdmData.LocateLogonSchema: boolean;
var
  LUserName, LPassword, LDatabase: PChar;
begin
  Result := False;

  if IDE_Connected then
  begin
    IDE_GetConnectionInfo(LUserName, LPassword, LDatabase);

    Result := (dmData.mdSchema.RecordCount > 0) and
      mdSchema.Locate('UserName;DB',
      VarArrayOf([StrPas(LUserName), StrPas(LDatabase)]), [loCaseInsensitive]);
  end;
end;

function TdmData.Logon(APLDevLogon: boolean): boolean;
begin
  with dmData.mdSchema do
    if FieldByName('Password').AsString = '' then
      Result := ShowLogon(nil, APLDevLogon, FieldByName('UserName').AsString,
        FieldByName('DB').AsString, FieldByName('Schema').AsString)
    else
      Result := (APLDevLogon and PLDevLogon(FieldByName('DB').AsString,
        FieldByName('UserName').AsString, vcData.DecodeString(
        vcData.Key, FieldByName('Password').AsString),
        FieldByName('Schema').AsString)) or (not APLDevLogon and
        ODACLogon(FieldByName('DB').AsString, FieldByName('UserName').AsString,
        vcData.DecodeString(vcData.Key, FieldByName('Password').AsString),
        FieldByName('Schema').AsString)) or ShowLogon(nil, APLDevLogon,
        FieldByName('UserName').AsString, FieldByName('DB').AsString,
        FieldByName('Schema').AsString);
end;

function TdmData.ODACLogon(ADatabase, AUserName, APassword, ASchema: string): boolean;
begin
  Result := False;

  with osMain do
    try
      if Connected then
        Disconnect;

      Server   := ADatabase;
      Username := AUserName;
      Password := APassword;
      Schema   := ASchema;
      Connect;
      Result := True;

    except
      on E: Exception do
        MessageDlg(e.Message, mtError, [mbOK], 0);
    end;
end;

procedure TdmData.OpenFile(ABackupOrTmp: integer);
var
  LFilename: string;
  LIdxFile:  integer;
begin
  with dlgOpenFile do
  begin
    FileName   := '';
    InitialDir := '';
    LFilename  := IDE_Filename;

    case ABackupOrTmp of
      1: // backup-file
        if LFilename <> '' then
        begin
          InitialDir := ExtractFilePath(LFilename) + '_history\';
          if not DirectoryExists(InitialDir) then
            InitialDir := ExtractFilePath(LFilename);
          Filter := 'Current file backups|' + ReplaceStr(
            ExtractFileName(LFilename), ExtractFileExt(LFilename), '') +
            '~*~' + ExtractFileExt(LFilename) + '|Backup files|*~*~.*|All files|*.*';
        end
        else
          Filter := 'Backup files|*~*~.*|All files|*.*';
      2: // tmp-file
      begin
        Filter     := 'All files|*.*|Backup files|*~*~.*';
        InitialDir := GAppTmpFilesDir;
      end;
    end;

    if Execute(Application.Handle) then
      for LIdxFile := 0 to Files.Count - 1 do
        IDE_OpenFile(0, PChar(Files[LIdxFile]));
  end;
end;

procedure TdmData.mdQuickQueryAfterDelete(DataSet: TDataSet);
begin
  SaveDataFile(mdQuickQuery, C_QUICK_QUERY_FILE);
end;

procedure TdmData.mdQuickQueryAfterPost(DataSet: TDataSet);
begin
  SaveDataFile(mdQuickQuery, C_QUICK_QUERY_FILE);
end;

procedure TdmData.mdQuickQueryBeforeCancel(DataSet: TDataSet);
begin
  if not (DataSet.State in [dsEdit, dsInsert]) then
    Abort;
end;

procedure TdmData.mdQuickQueryBeforePost(DataSet: TDataSet);
begin
  if not (DataSet.State in [dsEdit, dsInsert]) then
    Abort;
end;

procedure TdmData.mdSchemaAfterPost(DataSet: TDataSet);
begin
  SaveDataFile(mdSchema, C_SCHEMES_FILE);
end;

procedure TdmData.mdSchemaGroupAfterPost(DataSet: TDataSet);
begin
  SaveDataFile(mdSchemaGroup, C_SCHEMA_GROUP_FILE);
end;

procedure TdmData.mdSchemaNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('Visible').AsBoolean := True;
end;

procedure TdmData.mdSchemaTypeAfterPost(DataSet: TDataSet);
begin
  SaveDataFile(mdSchemaType, C_SCHEMA_TYPES_FILE);
end;

procedure TdmData.mdWindowAfterDelete(DataSet: TDataSet);
begin
  SaveDataFile(mdWindow, C_WINDOWS_FILE);
end;

procedure TdmData.mdWindowAfterPost(DataSet: TDataSet);
begin
  SaveDataFile(mdWindow, C_WINDOWS_FILE);
end;

procedure TdmData.oscrMainError(Sender: TObject; E: Exception; SQL: string;
  var Action: TErrorAction);
begin
  MessageLog.Append(SQL);
  MessageLog.Append(e.Message);
  GErrorOnExecuteScript := True;
  if frmScriptExecute.frameScript.chkStopOnError.Checked then
    Action := eaException
  else
    Action := eaContinue;
end;

procedure TdmData.SaveDataFile(ADataSet: TdxMemData; AFileName: string);
begin
  // backup file
  if FileExists(GAppDataDBDir + AFileName) then
    JclFileUtils.FileCopy(GAppDataDBDir + AFileName, GAppDataDBDir +
      '~' + AFileName, True);
  ADataSet.SaveToBinaryFile(GAppDataDBDir + AFileName);
  FIsWriteData := True;
end;

procedure TdmData.SaveFile;
var
  LFilename: string;
  LVerFile, LIdx4FileDel: integer;
  LHistoryPath, LHistoryFileName, LHistoryFileExt, LHistoryFileVer: string;
  LFileSR:   TSearchRec;
  LFileList: TStringList;

  function PADL(ASource, AAddString: string; ALength: integer): string;
  begin
    Result := ASource;
    while Length(Result) < ALength do
      Result := AAddString + Result;
  end;

begin
  LFilename := IDE_Filename;
  if LFilename = '' then
    ShowSaveAsFile
  else
  begin
    if GStoreFileHistory and IDE_WindowIsModified and FileExists(LFilename) and
      (GStoreHistory4TmpFiles or (ExtractFilePath(LFilename) <> GAppTmpFilesDir)) then
      try
        try
          LHistoryPath := ExtractFilePath(LFilename) + '_history\';
          ForceDirectories(LHistoryPath);
          LHistoryFileExt := ExtractFileExt(LFilename);
          LHistoryFileName :=
            ReplaceStr(ExtractFileName(LFilename), LHistoryFileExt, '');
          LVerFile := 0;

          LFileList := TStringList.Create;

          if FindFirst(LHistoryPath + LHistoryFileName + '~*~' +
            LHistoryFileExt, faAnyFile - faDirectory - faVolumeID, LFileSR) = 0 then
            repeat
              LHistoryFileVer :=
                Trim(ReplaceStr(ReplaceStr(
                ReplaceStr(ReplaceStr(LFileSR.Name, LHistoryFileName, ''),
                LHistoryFileExt, ''), '~', ''), '.', ''));
              LFileList.Values[PADL(LHistoryFileVer, '0', 10)] := LFileSR.Name;
              LVerFile :=
                Max(LVerFile, StrToIntDef(LHistoryFileVer, LVerFile));
            until FindNext(LFileSR) <> 0;

          if LFileList.Count > GCountHistoryFiles then
          begin
            LFileList.Sort;
            for LIdx4FileDel := 0 to LFileList.Count - GCountHistoryFiles - 1 do
              FileDelete(LHistoryPath + LFileList.ValueFromIndex[LIdx4FileDel], True);
          end;

          Inc(LVerFile);
          FileCopy(LFilename, LHistoryPath + LHistoryFileName +
            '~' + IntToStr(LVerFile) + '~' + LHistoryFileExt);

        except
          on E: Exception do
            ShowMessage(e.Message);
        end;
      finally
        FindClose(LFileSR);
        if Assigned(LFileList) then
          FreeAndNil(LFileList);
      end;

    IDE_SaveFile;

    if (IDE_GetWindowType = wtProcEdit) and (ExtractFilePath(LFilename) <>
      GAppTmpFilesDir) then
      if (IDE_TabInfo(1) <> '') then
        SaveSpecAndBodySeparate(LFilename)
      else
        SavePackageTypeInOne(LFileName);
  end;
end;

procedure TdmData.tmrMainTimer(Sender: TObject);
begin
  tmrMain.Enabled := False;
  //  GIsWindowExecuting := False;
  GPLDevStarted   := True;
end;



// All exported functions
exports
  OnCreate,
  RegisterCallback,
  OnActivate,
  IdentifyPlugIn,
  CreateMenuItem,
  OnMenuClick,
  About,
  Configure,
  AfterStart,
  CanClose,
  OnConnectionChange,
  OnDeactivate,
  OnDestroy,
  OnWindowCreated,
  AfterExecuteWindow;

initialization
  RemoveCRInStringLiterals := True;

  //WM_REFRESH_DATA     := RegisterWindowMessage('OraTauPLD_RefreshData');
  //WM_REFRESH_SETTINGS := RegisterWindowMessage('OraTauPLD_RefreshSettings');

end.

