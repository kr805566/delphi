object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 310
  Top = 225
  Height = 291
  Width = 604
  object MSConnection1: TMSConnection
    Database = 'H107_20160304_000001'
    Options.KeepDesignConnected = False
    Username = 'AP01'
    Server = '.\sqlexpress'
    Connected = True
    AfterConnect = MSConnection1AfterConnect
    BeforeConnect = MSConnection1BeforeConnect
    AfterDisconnect = MSConnection1AfterDisconnect
    OnError = MSConnection1Error
    LoginPrompt = False
    Left = 71
    Top = 49
    EncryptedPassword = 'CEFFCEFFCFFFCCFFCEFFCEFFCFFFCCFF'
  end
  object MSConnection2: TMSConnection
    Database = 'HOTELB_PLC'
    Options.KeepDesignConnected = False
    Username = 'AP01'
    Server = '.\sqlexpress'
    BeforeConnect = MSConnection2BeforeConnect
    OnError = MSConnection2Error
    LoginPrompt = False
    Left = 175
    Top = 57
    EncryptedPassword = 'CEFFCEFFCFFFCCFFCEFFCEFFCFFFCCFF'
  end
end
