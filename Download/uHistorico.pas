unit uHistorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfrmHistorico = class(TForm)
    Panel1: TPanel;
    cnnConexao: TFDConnection;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    dtpDataInicial: TDateTimePicker;
    dtpDataFinal: TDateTimePicker;
    Button1: TButton;
    lblDataInicial: TLabel;
    lblDataFinal: TLabel;
    rdgFiltroData: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BuscarHistorico(aDataIni, aDataFim: TDate; IndexFiltro: Integer);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHistorico: TfrmHistorico;

implementation

{$R *.dfm}

procedure TfrmHistorico.BuscarHistorico(aDataIni, aDataFim: TDate; IndexFiltro: Integer);
var
  filtro: string;
begin
  if IndexFiltro < 2 then
  begin
    if aDataIni > aDataFim then
    begin
      MessageDlg('Data inicial maior que final', mtError, [mbOK],0) ;
      abort
    end;
    if(aDataIni <> null) and (aDataFim <> null) then
    begin
      case IndexFiltro of
        0: filtro := 'DATAINICIO';
        1: filtro := 'DATAFIM';
      end;

      FDQuery1.SQL.Text := 'select CODIGO, DATAINICIO, DATAFIM,URL from logdownload '+
                           ' where '+filtro+' between "'+FormatDateTime('YYYY-MM-DD', dtpDataInicial.Date)+'" and'+
                           '"'+FormatDateTime('YYYY-MM-DD', dtpDataFinal.Date)+'" ORDER BY CODIGO DESC';
    end else
    begin
      MessageDlg('Data inicial ou final não foram informadas', mtError, [mbOK],0 );
      abort;
    end;
  end else
  begin
    FDQuery1.SQL.Text := 'select * from logdownload order by codigo desc';
  end;
  try
    if not cnnConexao.Connected then
      cnnConexao.Connected := True;
    FDQuery1.Open();
  except
    on e: exception do
      raise Exception.Create(e.Message);
  end;
end;

procedure TfrmHistorico.Button1Click(Sender: TObject);
begin
  BuscarHistorico(dtpDataInicial.Date, dtpDataFinal.Date, rdgFiltroData.ItemIndex);
end;

procedure TfrmHistorico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cnnConexao.Connected := false;
end;

procedure TfrmHistorico.FormShow(Sender: TObject);
begin
  BuscarHistorico(Now, Now, 2);
end;

end.
