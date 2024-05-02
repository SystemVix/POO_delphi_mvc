unit UnitDmVendedores;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBCustomDataSet, IBX.IBQuery,
  IBX.IBDatabase, Dialogs, UnitClasseVendedores;

type
  TDmVendedor = class(TDataModule)
    Conexao: TIBDatabase;
    Transacao: TIBTransaction;
    QueryAcesso: TIBQuery;

  private
    { Private declarations }

  public
    { Public declarations }

    function Gravar(vendedor : TVendedor) : Boolean;
    function Buscar(matricula : string; vendedor : TVendedor; var id : Integer)
      : Boolean;
    function BuscarMatricula(Id : Integer; vendedor : TVendedor) : Boolean;

    procedure ObterVendedoresAtivos;
  end;

var
  DmVendedor: TDmVendedor;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmVendedor }

function TDmVendedor.Gravar(vendedor: TVendedor): Boolean;
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

    if vendedor.Id <> 0 then
    begin
      QueryAcesso.SQL.Add('UPDATE VENDEDORES VD');
      QueryAcesso.SQL.Add('SET VD."MATRICULA" = :ITMATRICULA,');
      QueryAcesso.SQL.Add(' VD."NOME" = :ITNOME');
      QueryAcesso.SQL.Add(' VD."SAL_BRUTO" = :ITSAL_BRUTO');
      QueryAcesso.SQL.Add(' VD."PER_COMISSAO" = :ITPER_COMISSAO');
      QueryAcesso.SQL.Add('WHERE VD."ID" = :ITID');

      QueryAcesso.Params.ParamByName('ITID').Value := vendedor.Id;
      QueryAcesso.Params.ParamByName('ITMATRICULA').Value := vendedor.Matricula;
      QueryAcesso.Params.ParamByName('ITNOME').Value := vendedor.Nome;
      QueryAcesso.Params.ParamByName('ITSAL_BRUTO').Value :=
        vendedor.SalarioBruto;
      QueryAcesso.Params.ParamByName('ITPER_COMISSAO').Value :=
        vendedor.PercentualComissao;
    end
    else
    begin
      QueryAcesso.SQL.Add('INSERT INTO VENDEDORES');
      QueryAcesso.SQL.Add('("MATRICULA", "NOME", "SAL_BRUTO", "PER_COMISSAO")');
      QueryAcesso.SQL.Add('VALUES');
      QueryAcesso.SQL.Add('(:ITMATRICULA, :ITNOME, :ITSAL_BRUTO, :ITPER_COMISSAO)');

      QueryAcesso.Params.ParamByName('ITMATRICULA').Value := vendedor.Matricula;
      QueryAcesso.Params.ParamByName('ITNOME').Value := vendedor.Nome;
      QueryAcesso.Params.ParamByName('ITSAL_BRUTO').Value :=
        vendedor.SalarioBruto;
      QueryAcesso.Params.ParamByName('ITPER_COMISSAO').Value :=
        vendedor.PercentualComissao;
    end;

    QueryAcesso.ExecSQL;
    Transacao.Commit;
    Result := True;

  except
    on e : Exception do
    begin
      ShowMessage('Problemas no acesso ao banco de dados ' + #13 + e.Message);
    end;
  end;

end;

function TDmVendedor.Buscar(matricula: string; vendedor: TVendedor;
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
    QueryAcesso.SQL.Add('SELECT VD."ID", VD."MATRICULA", VD."NOME", VD."SAL_BRUTO", VD."PER_COMISSAO"');
    QueryAcesso.SQL.Add('FROM VENDEDORES VD');
    QueryAcesso.SQL.Add('WHERE VD."MATRICULA" = :ITMATRICULA');

    QueryAcesso.Params.ParamByName('ITMATRICULA').Value := matricula;
    QueryAcesso.Open;

    if QueryAcesso.RecordCount <> 0 then
    begin
      Result := True;
      vendedor.Matricula := QueryAcesso.FieldByName('MATRICULA').AsString;
      vendedor.Nome := QueryAcesso.FieldByName('NOME').AsString;
      vendedor.SalarioBruto := QueryAcesso.FieldByName('SAL_BRUTO').AsFloat;
      vendedor.PercentualComissao := QueryAcesso.FieldByName
        ('PER_COMISSAO').AsFloat;
    end;

  except
    on e : Exception do
    begin
      ShowMessage('Problemas no acesso ao banco de dados ' + #13 + e.Message);
    end;
  end;

end;

function TDmVendedor.BuscarMatricula(Id: Integer; vendedor: TVendedor): Boolean;
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
    QueryAcesso.SQL.Add('SELECT VD."ID", VD."MATRICULA", VD."NOME", VD."SAL_BRUTO", VD."PER_COMISSAO"');
    QueryAcesso.SQL.Add('FROM VENDEDORES VD');
    QueryAcesso.SQL.Add('WHERE VD."ID" = :ITID');

    QueryAcesso.Params.ParamByName('ITID').Value := Id;
    QueryAcesso.Open;

    if QueryAcesso.RecordCount <> 0 then
    begin
      Result := True;
      vendedor.Matricula := QueryAcesso.FieldByName('MATRICULA').AsString;
      vendedor.Nome := QueryAcesso.FieldByName('NOME').AsString;
      vendedor.SalarioBruto := QueryAcesso.FieldByName('SAL_BRUTO').AsFloat;
      vendedor.PercentualComissao := QueryAcesso.FieldByName
        ('PER_COMISSAO').AsFloat;
    end;

  except
    on e : Exception do
    begin
      ShowMessage('Problemas no acesso ao banco de dados ' + #13 + e.Message);
    end;
  end;

end;

procedure TDmVendedor.ObterVendedoresAtivos;
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
    QueryAcesso.SQL.Add('SELECT VD."ID", VD."MATRICULA", VD."NOME", VD."SAL_BRUTO", VD."PER_COMISSAO"');
    QueryAcesso.SQL.Add('FROM VENDEDORES VD');
    QueryAcesso.Open;

  except
    on e : Exception do
    begin
      ShowMessage('Problemas no acesso ao banco de dados ' + #13 + e.Message);
    end;
  end;
end;

end.
