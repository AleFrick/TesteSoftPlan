unit uDiretorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.Outline,
  Vcl.Samples.DirOutln;

type
  TfrmDiretorio = class(TForm)
    doDirectorySel: TDirectoryOutline;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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

end.
