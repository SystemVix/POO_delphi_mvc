unit UnitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFormPrincipal = class(TForm)
    MenuPrincipal: TMainMenu;
    MenuCadastros: TMenuItem;
    MenuCadastrosVendedores: TMenuItem;
    MenuCadastrosVendas: TMenuItem;
    MenuConsultas: TMenuItem;
    MenuConsultasComissoes: TMenuItem;
    MenuSair: TMenuItem;
    procedure MenuCadastrosVendedoresClick(Sender: TObject);
    procedure MenuCadastrosVendasClick(Sender: TObject);
    procedure MenuSairClick(Sender: TObject);
    procedure MenuConsultasComissoesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

uses UnitCadastroVendas, UnitCadastroVendedores, UnitConsultaComissoes;

procedure TFormPrincipal.MenuCadastrosVendasClick(Sender: TObject);
var
  formCadastro : TFormCadastroVendas;
begin
  formCadastro := TFormCadastroVendas.Create(Application);
end;

procedure TFormPrincipal.MenuCadastrosVendedoresClick(Sender: TObject);

var
  formCadastro : TFormCadastroVendedores;
begin
  formCadastro := TFormCadastroVendedores.Create(Application);
end;

procedure TFormPrincipal.MenuConsultasComissoesClick(Sender: TObject);
var
  formConsulta : TFormConsultaComissoes;
begin
  formConsulta := TFormConsultaComissoes.Create(Application);
end;

procedure TFormPrincipal.MenuSairClick(Sender: TObject);
begin
  Close;
end;

end.
