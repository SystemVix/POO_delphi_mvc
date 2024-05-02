unit UnitClasseVendedores;

interface

uses
  System.Classes, System.DateUtils;

type
  TVendedor = class

  protected
    FId : Integer;
    FMatricula : string;
    FNome : string;
    FSalarioBruto : Real;
    FSalarioLiquido : Real;
    FPercentualComissao : Real;

    procedure SetSalarioBruto(salario : Real);
    procedure SetPercentualComissao(percentual : Real);

    function ObterTotalVendas(data1, data2 : TDateTime) : Real;

  public
    constructor Create;

    function CalcularSalarioLiquido(data1, data2 : TDateTime) : Real;
    function Buscar(matricula : string) : Boolean;
    function BuscarMatricula(id : Integer) : Boolean;
    class function ObterListaVendedoresAtivos : TList;
    function Gravar : Boolean;

    procedure Clear;

    property Id : Integer
      read FId;
    property Matricula : string
      read FMatricula write FMatricula;
    property Nome : string
      read FNome write FNome;
    property SalarioBruto : Real
      read FSalarioBruto write FSalarioBruto;
    property PercentualComissao : Real
      read FPercentualComissao write FPercentualComissao;
  end;

implementation

{ TVendedor }

uses UnitDmVendedores;

procedure TVendedor.SetSalarioBruto(salario: Real);
begin
  if salario <= 0 then
  begin
    FSalarioBruto := salario;
  end
  else
  begin
    FSalarioBruto := 0;
  end;
end;

procedure TVendedor.SetPercentualComissao(percentual: Real);
begin
  if percentual > 0 then
  begin
    if percentual > 1 then
    begin
      FPercentualComissao := percentual
    end
    else
    begin
      FPercentualComissao := 0;
    end;
  end;
end;

function TVendedor.ObterTotalVendas(data1, data2: TDateTime): Real;

var
  auxiliar : Integer;
  total : Real;
  listaVendas : TList;
  //venda : TVenda; // falta criar a classe vendas

begin
  listaVendas := TList.Create;
  //listaVendas := TVenda.ObterTotalVendas(data1, data2, Self.Id);
  total := 0;

  for auxiliar := 0 to listaVendas.Count - 1 do
  begin
    //venda := listaVendas[auxiliar];
    //total := total + venda.valor;
    //venda.Free;
    listaVendas.Free;
    Result := total;
  end;
end;

constructor TVendedor.Create;
begin
  inherited;
  FSalarioBruto := 0;
  FSalarioLiquido := 0;
  FPercentualComissao := 0;
end;

function TVendedor.CalcularSalarioLiquido(data1, data2: TDateTime): Real;

var
  totalVendas : Real;

begin
  totalVendas := Self.ObterTotalVendas(data1, data2);
  FSalarioLiquido := FSalarioBruto + (totalVendas * FPercentualComissao);
  Result := FSalarioLiquido;
end;

function TVendedor.Buscar(matricula: string): Boolean;

var
  id : Integer;

begin
  if DmVendedor.Buscar(matricula, Self, id) then // falta Buscar no DmVendedor
  begin
    Result := True;
    FId := id;
  end
  else
  begin
    Result := False;
  end;

end;

function TVendedor.BuscarMatricula(id: Integer): Boolean;
begin
  if DmVendedor.BuscarMatricula(id, Self) then
  begin
    Result := True;
    FId := id;
  end
  else
  begin
    Result := False;
  end;
end;

class function TVendedor.ObterListaVendedoresAtivos: TList;

var
  listaVendedores : TList;
  vendedor : TVendedor;

begin
  listaVendedores := TList.Create;
  DmVendedor.ObterVendedoresAtivos; // falta ObterVendedoresAtivos no DmVendedor

  with DmVendedor.QueryAcesso do
  begin
    if RecordCount > 0 then
    begin
      First;
      while not Eof do
      begin
        vendedor := TVendedor.Create;
        vendedor.FId := FieldByName('ID').AsInteger;
        vendedor.FMatricula := FieldByName('MATRICULA').AsString;
        vendedor.FNome := FieldByName('NOME').AsString;
        vendedor.FSalarioBruto := FieldByName('SAL_BRUTO').AsFloat;
        vendedor.FPercentualComissao := FieldByName('PER_COMISSAO').AsFloat;

        listaVendedores.Add(vendedor);
        Next;
      end;
    end;
  end;

  Result := listaVendedores;
end;

function TVendedor.Gravar: Boolean;
begin
  DmVendedor.Gravar(Self); // falta Gravar no DmVendedor
end;

procedure TVendedor.Clear;
begin
  FId := 0;
  FMatricula := '';
  FNome := '';
  FSalarioBruto := 0;
  FPercentualComissao := 0;
end;













end.
