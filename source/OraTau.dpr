library OraTau;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  udmData in 'udmData.pas' {dmData: TDataModule},
  ufrmAbout in 'ufrmAbout.pas' {frmAbout},
  ufrmMain in 'ufrmMain.pas' {frmMain},
  ufrmSchemaAE in 'ufrmSchemaAE.pas' {frmSchemaAE},
  ufrmSchemaGroups in 'ufrmSchemaGroups.pas' {frmSchemaGroups},
  ufrmSchemaImport in 'ufrmSchemaImport.pas' {frmSchemaImport},
  ufrmSchemaTypes in 'ufrmSchemaTypes.pas' {frmSchemaTypes},
  PlugInIntf in 'PlugInIntf.pas',
  ufrmLogonDialog in 'ufrmLogonDialog.pas' {frmLogonDialog},
  uframeScript in 'uframeScript.pas' {frameScript: TFrame},
  ufrmWindows in 'ufrmWindows.pas' {frmWindows};

{$R *.res}

begin
end.
