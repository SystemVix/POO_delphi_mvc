unit UnitCadastroVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TFormCadastroVendas = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EditVenda: TEdit;
    EditValor: TEdit;
    DateTimeData: TDateTimePicker;
    ComboBoxVendedor: TComboBox;
    ButtonGravar: TButton;
    ButtonCancelar: TButton;
    procedure ButtonCancelarClick(Sender: TObject);
    procedure EditVendaExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastroVendas: TFormCadastroVendas;

implementation

{$R *.dfm}

uses UnitClasseVendas, UnitClasseVendedores;

var
  venda : TVenda;

procedure TFormCadastroVendas.ButtonCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCadastroVendas.ButtonGravarClick(Sender: TObject);
begin
  if (EditVenda.Text <> '') and
     (DateTimeData.Date <> 0) and
     (EditValor.Text <> '') and
     (ComboBoxVendedor.Text <> '') then
  begin
    venda.Numero := StrToInt(EditVenda.Text);
    venda.Data := DateTimeData.Date;
    venda.Valor := StrToFloat(EditValor.Text);
    venda.Vendedor := (ComboBoxVendedor.Items.Objects[ComboBoxVendedor.ItemIndex] as TVendedor);

    if venda.Gravar then
    begin
      EditVenda.Clear;
      DateTimeData.Date := Date;
      EditValor.Clear;
      ComboBoxVendedor.Text := '';
      EditVenda.SetFocus;
      venda.Clear;
    end
    else
    begin
      DateTimeData.SetFocus;
    end;
  end
  else
  begin
    ShowMessage('Campos inválidos!');
  end;
end;

procedure TFormCadastroVendas.EditVendaExit(Sender: TObject);
begin
  if EditVenda.Text = '' then
  begin
    DateTimeData.Date := Date;
    EditValor.Clear;
    ComboBoxVendedor.Text := '';
  end
  else
  begin
    if venda.Buscar(StrToInt(EditVenda.Text)) then
    begin
      DateTimeData.Date := venda.Data;
      EditValor.Text := FloatToStr(venda.Valor);
      ComboBoxVendedor.Text := venda.Vendedor.Nome;
    end;
  end;
end;

procedure TFormCadastroVendas.FormCreate(Sender: TObject);

var
  listaVendedores : TList;
  vendedor : TVendedor;
  auxiliar : Integer;

begin
  venda := TVenda.Create;
  listaVendedores := TVendedor.ObterListaVendedoresAtivos;

  for auxiliar := 0 to listaVendedores.Count - 1 do
  begin
    vendedor := listaVendedores[auxiliar];
    ComboBoxVendedor.AddItem(vendedor.Nome, vendedor);
  end;
end;

procedure TFormCadastroVendas.FormDestroy(Sender: TObject);
begin
  venda.Free;
end;

end.
