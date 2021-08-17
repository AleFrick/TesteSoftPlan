unit uDiretorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.Outline,
  Vcl.Samples.DirOutln, Vcl.ExtCtrls;

type
  TfrmDiretorio = class(TForm)
    doDirectorySel: TDirectoryOutline;
    Panel1: TPanel;
    Button3: TButton;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    edtDiretorio: TEdit;
    Label1: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    fPasta: String;
  public
    { Public declarations }
    property pastaSel: String read fPasta write fPasta;
  end;

var
  frmDiretorio: TfrmDiretorio;

implementation

{$R *.dfm}

procedure TfrmDiretorio.Button1Click(Sender: TObject);
begin
  pastaSel := doDirectorySel.Directory;
  frmDiretorio.Close;
end;

procedure TfrmDiretorio.Button2Click(Sender: TObject);
begin
  pastaSel := '';
  frmDiretorio.Close;
end;

procedure TfrmDiretorio.Button3Click(Sender: TObject);
begin
  try
    if not(trim(edtDiretorio.Text) = '') then
      doDirectorySel.Directory := edtDiretorio.Text;
  except
    on E: exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
