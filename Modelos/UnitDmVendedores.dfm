object DmVendedor: TDmVendedor
  Height = 1470
  Width = 1960
  PixelsPerInch = 168
  object Conexao: TIBDatabase
    LoginPrompt = False
    ServerType = 'IBServer'
    Left = 56
    Top = 56
  end
  object Transacao: TIBTransaction
    Left = 240
    Top = 56
  end
  object QueryAcesso: TIBQuery
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 432
    Top = 56
  end
end
