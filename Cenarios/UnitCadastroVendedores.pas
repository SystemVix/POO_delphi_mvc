unit UnitCadastroVendedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormCadastroVendedores = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EditMatricula: TEdit;
    EditNome: TEdit;
    EditSalarioBruto: TEdit;
    EditPercentualComissao: TEdit;
    ButtonGravar: TButton;
    ButtonCancelar: TButton;
    procedure ButtonCancelarClick(Sender: TObject);
    procedure EditMatriculaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonGravarClick(Sender: TObject);
    procedure EditSalarioBrutoKeyPress(Sender: TObject; var Key: Char);
    procedure EditSalarioBrutoExit(Sender: TObject);
    procedure EditPercentualComissaoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastroVendedor: TFormCadastroVendedores;

implementation

{$R *.dfm}

uses UnitClasseVendedores;

var
  vendedor : TVendedor;

procedure TFormCadastroVendedores.ButtonCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCadastroVendedores.ButtonGravarClick(Sender: TObject);
begin
  if (EditMatricula.Text <> '') and
     (EditNome.Text <> '') and
     (EditSalarioBruto.Text <> '') and
     (EditPercentualComissao.Text <> '') then
  begin
    vendedor.Matricula := EditMatricula.Text;
    vendedor.Nome := EditNome.Text;
    vendedor.SalarioBruto := StrToFloat(EditSalarioBruto.Text);
    vendedor.PercentualComissao := StrToFloat(EditPercentualComissao.Text);

    if vendedor.Gravar then
    begin
      EditMatricula.Clear;
      EditNome.Clear;
      EditSalarioBruto.Clear;
      EditPercentualComissao.Clear;
      EditMatricula.SetFocus;
      vendedor.Clear;
    end
    else
    begin
      EditNome.SetFocus;
    end;
  end
  else
  begin
    ShowMessage('Campos inválidos!');
  end;
end;

procedure TFormCadastroVendedores.EditMatriculaChange(Sender: TObject);
begin
  if Length(EditMatricula.Text) <> 4 then
  begin
    EditNome.Clear;
    EditSalarioBruto.Clear;
    EditPercentualComissao.Clear;
    vendedor.Clear;
  end
  else
  begin
    if vendedor.Buscar(EditMatricula.Text) then
    begin
      EditNome.Text := vendedor.Nome;
      EditSalarioBruto.Text := FloatToStr(vendedor.SalarioBruto);
      EditPercentualComissao.Text := FloatToStr(vendedor.PercentualComissao);
    end;
  end;
end;

procedure TFormCadastroVendedores.EditPercentualComissaoExit(Sender: TObject);
begin
  if EditSalarioBruto.Text <> '' then
  begin
    try
      StrToFloat(EditPercentualComissao.Text);
    except
      begin
        ShowMessage('Valor inválido!');
        EditPercentualComissao.SetFocus;
      end;
    end;
  end;
end;

procedure TFormCadastroVendedores.EditSalarioBrutoExit(Sender: TObject);
begin
  if EditSalarioBruto.Text <> '' then
  begin
    try
      StrToFloat(EditSalarioBruto.Text);
    except
      begin
        ShowMessage('Valor inválido!');
        EditSalarioBruto.SetFocus;
      end;
    end;
  end;
end;

procedure TFormCadastroVendedores.EditSalarioBrutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (VarIsNumeric(Key) or (Key = #9) or (Key = ',') or (Key = #8)) then
  begin
    Key := #0;
  end;
end;

procedure TFormCadastroVendedores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := TCloseAction.caFree; // action := caFree;
end;

procedure TFormCadastroVendedores.FormCreate(Sender: TObject);
begin
  vendedor := TVendedor.Create;
end;

procedure TFormCadastroVendedores.FormDestroy(Sender: TObject);
begin
  vendedor.Free;
end;

end.
