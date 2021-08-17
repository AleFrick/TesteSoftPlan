unit uDownload;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  IdBaseComponent, IdAntiFreezeBase, Vcl.IdAntiFreeze, IdIOHandler,   IdSSLOpenSSLHeaders,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  IdAuthentication, UBasicClass;

type
  TfrmDownload = class(TForm)
    IdAntiFreeze1: TIdAntiFreeze;
    IdHTTP1: TIdHTTP;
    dlgSave: TSaveDialog;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Panel1: TPanel;
    edtUrl: TLabeledEdit;
    ckbOpcao: TCheckBox;
    Panel2: TPanel;
    btnBaixar: TButton;
    Button2: TButton;
    Panel3: TPanel;
    lblStatus: TLabel;
    pbProgresso: TProgressBar;
    btnMensagem: TButton;
    Button1: TButton;
    lblPorcentagem: TLabel;
    cnnConexao: TFDConnection;
    driver: TFDPhysSQLiteDriverLink;
    FDQuery1: TFDQuery;
    FileOpenDialog1: TFileOpenDialog;
    procedure Button2Click(Sender: TObject);
    function RetornaPorcentagem(ValorMaximo, ValorAtual: real): string;
    function RetornaKiloBytes(ValorAtual: real): string;
    procedure IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdHTTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure btnBaixarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnMensagemClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TPorcentagem = class (TSubjectObserver)
  protected
    procedure Change(Dados: TDados); override;
  end ;
  TPositionProgress = class (TSubjectObserver)
  protected
    procedure Change(Dados: TDados); override;
  end ;
var
  frmDownload: TfrmDownload;
  indDownload: Boolean;
  porcentoDownload: String;
  DadosDownload: TDados;

implementation

{$R *.dfm}

uses uHistorico, uDiretorio;

procedure TfrmDownload.btnBaixarClick(Sender: TObject);
var
  fileDownload : TFileStream;
  IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
begin
  if trim(edtUrl.Text) = '' then
  begin
    MessageDlg('Url não informada ',mtWarning,[mbOK],0);
    Abort;
  end;

  dlgSave.Filter := 'Arquivos' + ExtractFileExt(edtUrl.Text) + '|*' + ExtractFileExt(edtUrl.Text);
  dlgSave.FileName := 'Arquivo';
  if dlgSave.Execute then
  begin
    fileDownload := TFileStream.Create(dlgSave.FileName + ExtractFileExt(edtUrl.Text), fmCreate);
    try
      if not DirectoryExists('C:\OpenSSL') then
        frmDiretorio.ShowModal;
      if frmDiretorio.pastaSel <> '' then
        IdOpenSSLSetLibPath(frmDiretorio.pastaSel)
      else
      begin
        MessageDlg('Download cancelado', mtInformation, [mbOK],0 );
        abort;
      end;
      try
        indDownload := True;
        FDQuery1.SQL.Text := 'insert into LOGDOWNLOAD values(null,"'+edtUrl.Text+'", "'+FormatDateTime('YYYY-MM-DD', Now)+'", null)';
        FDQuery1.ExecSQL;
        lblStatus.Visible   := indDownload;
        btnBaixar.Enabled   := not indDownload;


        IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(IdHttp1);
        IdSSLIOHandlerSocket.SSLOptions.Method := sslvTLSv1_2;
        IdSSLIOHandlerSocket.SSLOptions.Mode:= sslmUnassigned;
        IdHTTP1.IOHandler := IdSSLIOHandlerSocket;
        IdHTTP1.Get(edtUrl.Text, fileDownload);
      except
        on E: exception do
          raise Exception.Create(e.Message);
      end;
    finally
      FreeAndNil(fileDownload);
    end;
  end;
end;

procedure TfrmDownload.btnMensagemClick(Sender: TObject);
begin
  if indDownload then  
    ShowMessage('Foram baixados ' + DadosDownload.Porcentagem);
end;

procedure TfrmDownload.Button1Click(Sender: TObject);
begin
  frmHistorico.Show;
end;

procedure TfrmDownload.Button2Click(Sender: TObject);
begin
  indDownload := False;
  IdHTTP1.Disconnect;
end;

procedure TfrmDownload.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if indDownload then
    if MessageDlg('Existe um download em andamento, gostaria de sair mesmo assim?', mtConfirmation, [mbYes, mbNo],0) = mrNo then
      Abort
    else
      IdHTTP1.Disconnect;
end;

procedure TfrmDownload.FormShow(Sender: TObject);
begin
  if not FileExists('C:\TesteAlex\softplan.db') then
  begin
    MessageDlg('Banco não encontrado, selecione o arquivo.', mtInformation, [mbOK], 0);
    if FileOpenDialog1.Execute then
      cnnConexao.Params.Database := FileOpenDialog1.FileName
    else
    begin
      MessageDlg('Necessário selecionar o banco, aplicação será fechada.', mtWarning, [mbOK], 0);
      Application.Terminate;
    end;
  end else
    cnnConexao.Params.Database := 'C:\TesteAlex\softplan.db';
end;

procedure TfrmDownload.IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
var
  aPositionProgress: TPositionProgress;
  aPorcentagem: TPorcentagem;
  observer: TSubject;
begin
  try
    try
      indDownload := true;
      aPositionProgress := TPositionProgress.Create(nil);
      aPorcentagem := TPorcentagem.Create(nil);

      observer := TSubject.Create();
      observer.RegisterObserver(aPorcentagem);
      observer.RegisterObserver(aPositionProgress);

      TThread.Synchronize(nil,
      procedure
      begin
        DadosDownload.Posicao := AWorkCount;
        DadosDownload.Porcentagem := RetornaPorcentagem(pbprogresso.Max, AWorkCount);
        observer.Change(DadosDownload);
      end);
      lblStatus.Caption    := 'Baixando ... ' + RetornaKiloBytes(AWorkCount);
    except
      on E: exception do
        raise Exception.Create(E.Message);
    end;
  finally
    FreeAndNil(aPositionProgress);
  end;
end;

procedure TfrmDownload.IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  pbprogresso.Max := AWorkCountMax;
  indDownload := True;

end;

procedure TfrmDownload.IdHTTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  indDownload := False;
  if pbProgresso.Position = pbProgresso.Max then
  begin
    FDQuery1.SQL.Text := 'update LOGDOWNLOAD set DATAFIM = "'+FormatDateTime('YYYY-MM-DD', Now)+'" where codigo = (select max(codigo) from LOGDOWNLOAD limit 1)';
    FDQuery1.ExecSQL;
  end;
  DadosDownload.Posicao := 0;
  DadosDownload.Porcentagem := '0%';
  pbprogresso.Position := DadosDownload.Posicao;
  lblPorcentagem.Caption := DadosDownload.Porcentagem;

  lblStatus.Caption    := 'Download Finalizado ...';
  btnBaixar.Enabled    := not indDownload;
  lblStatus.Visible := indDownload;  
  if ckbOpcao.Checked then
    Application.Terminate;
end;

function TfrmDownload.RetornaKiloBytes(ValorAtual: real): string;
var
  resultado : real;
begin
  resultado := ((ValorAtual / 1024) / 1024);
  Result    := FormatFloat('0.000 KBs', resultado);
end;

function TfrmDownload.RetornaPorcentagem(ValorMaximo, ValorAtual: real): string;
var
  resultado: Real;
begin
  resultado := ((ValorAtual * 100) / ValorMaximo);
  Result    := FormatFloat('0%', resultado);
end;

{ TPorcentagem }

procedure TPorcentagem.Change(Dados: TDados);
begin
  inherited;
  frmDownload.lblPorcentagem.Caption := Dados.Porcentagem;
end;

{ TPositionProgress }

procedure TPositionProgress.Change(Dados: TDados);
begin
  inherited;
  frmDownload.pbProgresso.Position := Dados.Posicao;
end;

end.
