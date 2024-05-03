unit UnitConsultaComissoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TFormConsultaComissoes = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBoxVendedor: TComboBox;
    DateTimeInicial: TDateTimePicker;
    DateTimeFinal: TDateTimePicker;
    ButtonVerificar: TButton;
    Label4: TLabel;
    Label5: TLabel;
    EditSalarioBruto: TEdit;
    EditSalarioLiquido: TEdit;
    Label6: TLabel;
    EditComissao: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ButtonVerificarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormConsultaComissoes: TFormConsultaComissoes;

implementation

{$R *.dfm}

uses UnitClasseVendedores;

procedure TFormConsultaComissoes.ButtonVerificarClick(Sender: TObject);

var
  vendedor : TVendedor;
  salarioBruto, salarioLiquido, comissao : Real;

begin
  if (ComboBoxVendedor.Text <> '') and (DateTimeInicial.Date <> 0) and
     (DateTimeFinal.Date <> 0) then
  begin
    vendedor := (ComboBoxVendedor.Items.Objects[ComboBoxVendedor.ItemIndex] as
      TVendedor);
    salarioBruto := vendedor.SalarioBruto;
    salarioLiquido := vendedor.CalcularSalarioLiquido(DateTimeInicial.DateTime, DateTimeFinal.DateTime);
    comissao := salarioLiquido - salarioBruto;

    EditSalarioBruto.Text := FloatToStr(salarioBruto);
    EditSalarioLiquido.Text := FloatToStr(salarioLiquido);
    EditComissao.Text := FloatToStr(comissao);
  end;
end;

procedure TFormConsultaComissoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TFormConsultaComissoes.FormCreate(Sender: TObject);

var
  listVendedores : TList;
  vendedor : TVendedor;
  auxiliar : Integer;

begin
  listVendedores := TVendedor.ObterListaVendedoresAtivos;

  for auxiliar := 0 to listVendedores.Count - 1 do
  begin
    vendedor := listVendedores[auxiliar];
    ComboBoxVendedor.AddItem(vendedor.Nome, vendedor);
  end;
end;

end.
