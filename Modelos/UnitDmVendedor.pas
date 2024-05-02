unit UnitDmVendedor;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBCustomDataSet, IBX.IBQuery,
  IBX.IBDatabase;

type
  TDmVendedor = class(TDataModule)
    Conexao: TIBDatabase;
    Transacao: TIBTransaction;
    QueryAcesso: TIBQuery;

  private
    { Private declarations }

  public
    { Public declarations }
    //function Gravar(vendedor : TVendedor) : Boolean;
  end;

var
  DmVendedor: TDmVendedor;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
