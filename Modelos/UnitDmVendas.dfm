object DmVendas: TDmVendas
  Height = 1470
  Width = 1960
  PixelsPerInch = 168
  object Conexao: TIBDatabase
    DatabaseName = 
      'F:\Treinamentos\Desktop\Delphi\Estudos_POO_Delphi\Controle_Venda' +
      's\DB_CV.FDB'
    LoginPrompt = False
    ServerType = 'IBServer'
    Left = 72
    Top = 72
  end
  object Transacao: TIBTransaction
    Left = 200
    Top = 72
  end
  object QueryAcesso: TIBQuery
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 352
    Top = 72
  end
end
