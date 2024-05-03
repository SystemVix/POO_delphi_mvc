unit UnitClasseVendas;

interface

uses
  System.Classes, DB, UnitClasseVendedores;

type
  TVenda = class

  protected
    FId : Integer;
    FNumero : Integer;
    FData : TDateTime;
    FValor : Real;
    FVendedor : TVendedor;

    procedure SetNumero(numero : Integer);
    procedure SetValor(valor : Real);

  public
    constructor Create;
    destructor Destroy; override;

    function Buscar(numero : Integer) : Boolean;
    function Gravar : Boolean;

    procedure Clear;

    class function ObterTotalVendas(data1, data2 : TDateTime; vendedor : Integer) : TList;

    property Id : Integer
      read FId;
    property Numero : Integer
      read FNumero write SetNumero;
    property Data : TDateTime
      read FData write FData;
    property Valor : Real
      read FValor write SetValor;
    property Vendedor : TVendedor
      read FVendedor write FVendedor;
  end;

implementation

{ TVenda }

uses UnitDmVendas;

procedure TVenda.SetNumero(numero: Integer);
begin
  if numero >= 0 then
  begin
    FNumero := numero;
  end
  else
  begin
    FNumero := 0;
  end;
end;

procedure TVenda.SetValor(valor: Real);
begin
  if valor >= 0 then
  begin
    FValor := valor;
  end
  else
  begin
    FValor := 0;
  end;
end;

constructor TVenda.Create;
begin
  FVendedor := TVendedor.Create;
end;

destructor TVenda.Destroy;
begin
  FVendedor.Free;
  inherited;
end;

function TVenda.Buscar(numero: Integer): Boolean;

var
  id : Integer;

begin
  if DmVendas.Buscar(numero, Self, id) then
  begin
    Result := True;
    FId := id;
  end
  else
  begin
    Result := False;
  end;
end;

function TVenda.Gravar: Boolean;
begin
  Result := DmVendas.Gravar(Self);
end;

procedure TVenda.Clear;
begin
  FId := 0;
  FNumero := 0;
  FData := 0;
  FValor := 0;
  FVendedor.Clear;
end;

class function TVenda.ObterTotalVendas(data1, data2: TDateTime;
  vendedor: Integer): TList;

var
  listaVendas : TList;
  venda : TVenda;

begin
  listaVendas := TList.Create;
  DmVendas.ObterTotalVendas(data1, data2, vendedor);

  with DmVendas.QueryAcesso do
  begin
    if RecordCount <> 0 then
    begin
      First;

      while not Eof do
      begin
        venda := TVenda.Create;
        venda.Numero := FieldByName('NUMERO').AsInteger;
        venda.Data := FieldByName('DATA').AsDateTime;
        venda.Valor := FieldByName('VALOR').AsFloat;
        venda.Vendedor.BuscarMatricula(FieldByName('VENDEDOR').AsInteger);
        venda.FId := FieldByName('ID').AsInteger;

        listaVendas.Add(venda);
        Next;
      end;
    end;
  end;

  Result := listaVendas;
end;

end.
