object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 426
  Width = 561
  object FDQuery1: TFDQuery
    Connection = SQLConexao
    SQL.Strings = (
      'Select * from usuarios')
    Left = 40
    Top = 112
  end
  object SQLConexao: TFDConnection
    Left = 72
    Top = 56
  end
end
