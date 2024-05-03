program ProjectControleVendas;

uses
  Vcl.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FormPrincipal},
  UnitCadastroVendedores in 'Cenarios\UnitCadastroVendedores.pas' {FormCadastroVendedor},
  UnitCadastroVendas in 'Cenarios\UnitCadastroVendas.pas' {FormCadastroVendas},
  UnitConsultaComissoes in 'Cenarios\UnitConsultaComissoes.pas' {FormConsultaComissoes},
  UnitClasseVendedores in 'Controles\UnitClasseVendedores.pas',
  UnitClasseVendas in 'Controles\UnitClasseVendas.pas',
  UnitDmVendedores in 'Modelos\UnitDmVendedores.pas' {DmVendedores: TDataModule},
  UnitDmVendas in 'Modelos\UnitDmVendas.pas' {DmVendas: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TDmVendedor, DmVendedor);
  Application.CreateForm(TFormCadastroVendedor, FormCadastroVendedor);
  Application.CreateForm(TDmVendas, DmVendas);
  Application.CreateForm(TFormCadastroVendas, FormCadastroVendas);
  Application.CreateForm(TFormConsultaComissoes, FormConsultaComissoes);
  Application.Run;
end.
