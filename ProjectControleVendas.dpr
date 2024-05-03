program ProjectControleVendas;

uses
  Vcl.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FormPrincipal},
  UnitDmVendedores in 'Modelos\UnitDmVendedores.pas' {DmVendedor: TDataModule},
  UnitClasseVendedores in 'Controles\UnitClasseVendedores.pas',
  UnitCadastroVendedores in 'Cenarios\UnitCadastroVendedores.pas' {FormCadastroVendedor},
  UnitDmVendas in 'Modelos\UnitDmVendas.pas' {DmVendas: TDataModule},
  UnitClasseVendas in 'Controles\UnitClasseVendas.pas',
  UnitCadastroVendas in 'Cenarios\UnitCadastroVendas.pas' {FormCadastroVendas},
  UnitConsultaComissoes in 'Cenarios\UnitConsultaComissoes.pas' {FormConsultaComissoes};

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
