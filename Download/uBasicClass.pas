unit uBasicClass;

interface

uses System.SysUtils, System.Variants, System.Classes;

type
  TDados = record
    Posicao: Integer;
    Porcentagem: string;
end;

type
  TSubjectObserver = class (TComponent)
  private
    FOnChange: TNotifyEvent;
  protected
    procedure Change(Dados: TDados); virtual; abstract;
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
end ;
type
  TSubject = class (TObject)
  private
    FObservers: TList;
  public
    procedure RegisterObserver(Observer: TComponent);
    procedure UnregisterObserver(Observer: TComponent);
    procedure Change(Dados: TDados);
    constructor Create();
end;

implementation

{ TSubject }

procedure TSubject.Change(Dados: TDados);
var
  Obs: TSubjectObserver;
  I: Integer;
begin
  for I := 0 to FObservers.Count - 1 do
  begin
    Obs := FObservers[I];
    Obs.Change(Dados);
  end;
end;

constructor TSubject.Create;
begin
  FObservers := TList.Create();
end;

procedure TSubject.RegisterObserver(Observer: TComponent);
begin
  FObservers.Add(Observer);
end;

procedure TSubject.UnregisterObserver(Observer: TComponent);
begin
  FObservers.Remove(Observer);
end;

end.
