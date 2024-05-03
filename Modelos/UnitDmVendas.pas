unit UnitDmVendas;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBCustomDataSet, IBX.IBQuery,
  IBX.IBDatabase, Dialogs, UnitClasseVendas;

type
  TDmVendas = class(TDataModule)
    Conexao: TIBDatabase;
    Transacao: TIBTransaction;
    QueryAcesso: TIBQuery;

  private
    { Private declarations }

  public
    { Public declarations }
    function Gravar(venda : TVenda) : Boolean;
    function Buscar(numero : Integer; venda : TVenda; var id : Integer) : Boolean;

    procedure ObterTotalVendas(data1, data2 : TDateTime; vendedor : Integer);
  end;

var
  DmVendas: TDmVendas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmVendas }

function TDmVendas.Gravar(venda: TVenda): Boolean;
begin
  Result := False;

  try
    if not Conexao.Connected then
    begin
      Conexao.Open;
      Transacao.StartTransaction;
    end;
    if QueryAcesso.Active then
    begin
      QueryAcesso.Close;
    end;
    QueryAcesso.SQL.Clear;
    if venda.Id <> 0 then
    begin
      // parei aqui para fazer a ClasseVendas
    end;
  except
    on e : Exception do
    begin
      ShowMessage('Problemas no acesso ao banco de dados ' + #13 + e.Message);
    end;
  end;
end;

function TDmVendas.Buscar(numero: Integer; venda: TVenda;
  var id: Integer): Boolean;
begin
  Result := False;

  try
    if not Conexao.Connected then
    begin
      Conexao.Open;
      Transacao.StartTransaction;
    end;

    if QueryAcesso.Active then
    begin
      QueryAcesso.Close;
    end;

    QueryAcesso.SQL.Clear;
    QueryAcesso.SQL.Add('SELECT SL."ID", SL."VENDEDOR", SL."NUMERO", SL."DATA", SL."VALOR"');
    QueryAcesso.SQL.Add('FROM VENDAS SL');
    QueryAcesso.SQL.Add('WHERE SL."NUMERO" = :ITNUMERO');

    QueryAcesso.Params.ParamByName('ITNUMERO').Value := numero;
    QueryAcesso.Open;

    if QueryAcesso.RecordCount <> 0 then
    begin
      Result := True;
      venda.Numero := numero;
      venda.Data := QueryAcesso.FieldByName('DATA').AsDateTime;
      venda.Valor := QueryAcesso.FieldByName('VALOR').AsFloat;
      venda.Vendedor.BuscarMatricula(QueryAcesso.FieldByName('VENDEDOR').AsInteger);

      id := QueryAcesso.FieldByName('ID').AsInteger;
    end;

  except
    on e : Exception do
    begin
      ShowMessage('Problemas no acesso ao banco de dados ' + #13 + e.Message);
    end;
  end;
end;

procedure TDmVendas.ObterTotalVendas(data1, data2: TDateTime;
  vendedor: Integer);
begin
  try
    if not Conexao.Connected then
    begin
      Conexao.Open;
      Transacao.StartTransaction;
    end;

    if QueryAcesso.Active then
    begin
      QueryAcesso.Close;
    end;

    QueryAcesso.SQL.Clear;
    QueryAcesso.SQL.Add('SELECT SL."ID", SL."VENDEDOR", SL."NUMERO", SL."DATA", SL."VALOR"');
    QueryAcesso.SQL.Add('FROM VENDAS SL');
    QueryAcesso.SQL.Add('WHERE ("ID" = :ITNUMERO AND SL."DATA" BETWEEN :ITDATA1 AND ITDATA2)');

    QueryAcesso.Params.ParamByName('ITNUMERO').Value := vendedor;
    QueryAcesso.Params.ParamByName('ITDATA1').Value := data1;
    QueryAcesso.Params.ParamByName('ITDATA2').Value := data2;
  except

  end;
end;

end.
