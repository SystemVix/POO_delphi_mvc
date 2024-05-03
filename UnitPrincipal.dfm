object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'Controle de Vendas'
  ClientHeight = 778
  ClientWidth = 1108
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MenuPrincipal
  PixelsPerInch = 168
  TextHeight = 30
  object MenuPrincipal: TMainMenu
    Left = 172
    Top = 250
    object MenuCadastros: TMenuItem
      Caption = 'Cadastros'
      object MenuCadastrosVendedores: TMenuItem
        Caption = 'Vendedores'
        OnClick = MenuCadastrosVendedoresClick
      end
      object MenuCadastrosVendas: TMenuItem
        Caption = 'Vendas'
        OnClick = MenuCadastrosVendasClick
      end
    end
    object MenuConsultas: TMenuItem
      Caption = 'Consultas'
      object MenuConsultasComissoes: TMenuItem
        Caption = 'Comiss'#245'es'
        OnClick = MenuConsultasComissoesClick
      end
    end
    object MenuSair: TMenuItem
      Caption = 'Sair'
      OnClick = MenuSairClick
    end
  end
end
