program ProjectControleVendas;

uses
  Vcl.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FormPrincipal},
  UnitDmVendedor in 'Modelos\UnitDmVendedor.pas' {DmVendedor: TDataModule},
  UnitClasseVendedor in 'Controles\UnitClasseVendedor.pas',
  UnitCadastroVendedor in 'Cenarios\UnitCadastroVendedor.pas' {FormCadastroVendedor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TDmVendedor, DmVendedor);
  Application.CreateForm(TFormCadastroVendedor, FormCadastroVendedor);
  Application.Run;
end.
