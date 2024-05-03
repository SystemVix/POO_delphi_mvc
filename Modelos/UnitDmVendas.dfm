object DmVendas: TDmVendas
  Height = 1470
  Width = 1960
  PixelsPerInch = 168
  object Conexao: TIBDatabase
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
