program prjDownload;

uses
  Vcl.Forms,
  uDownload in 'uDownload.pas' {frmDownload},
  uHistorico in 'uHistorico.pas' {frmHistorico},
  uBasicClass in 'uBasicClass.pas',
  uDiretorio in 'uDiretorio.pas' {frmDiretorio};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmDownload, frmDownload);
  Application.CreateForm(TfrmHistorico, frmHistorico);
  Application.CreateForm(TfrmDiretorio, frmDiretorio);
  Application.Run;
end.
