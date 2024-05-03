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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastroVendas: TFormCadastroVendas;

implementation

{$R *.dfm}

end.
