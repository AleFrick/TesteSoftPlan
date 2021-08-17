object frmDownload: TfrmDownload
  Left = 0
  Top = 0
  Caption = 'Gerenciador de Download'
  ClientHeight = 141
  ClientWidth = 635
  Color = clBtnFace
  Constraints.MaxHeight = 180
  Constraints.MinHeight = 180
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 58
    Align = alTop
    TabOrder = 0
    DesignSize = (
      635
      58)
    object edtUrl: TLabeledEdit
      Left = 3
      Top = 19
      Width = 627
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 87
      EditLabel.Height = 13
      EditLabel.Caption = 'Url para download'
      TabOrder = 0
      Text = 
        'https://az764295.vo.msecnd.net/stable/78a4c91400152c0f27ba4d363e' +
        'b56d2835f9903a/VSCodeUserSetup-x64-1.43.0.exe'
    end
    object ckbOpcao: TCheckBox
      Left = 3
      Top = 40
      Width = 193
      Height = 16
      Caption = 'Fechar automaticamente'
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 100
    Width = 635
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      635
      41)
    object btnBaixar: TButton
      Left = 419
      Top = 6
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Iniciar Download'
      TabOrder = 0
      OnClick = btnBaixarClick
    end
    object Button2: TButton
      Left = 525
      Top = 6
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Parar Download'
      TabOrder = 1
      OnClick = Button2Click
    end
    object btnMensagem: TButton
      Left = 7
      Top = 6
      Width = 100
      Height = 25
      Caption = 'Exibir mensagem'
      TabOrder = 2
      OnClick = btnMensagemClick
    end
    object Button1: TButton
      Left = 113
      Top = 6
      Width = 100
      Height = 25
      Caption = 'Exibir Hist'#243'rico'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 58
    Width = 635
    Height = 42
    Align = alClient
    TabOrder = 2
    DesignSize = (
      635
      42)
    object lblStatus: TLabel
      Left = 7
      Top = 2
      Width = 59
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Baixando ...'
    end
    object lblPorcentagem: TLabel
      Left = 607
      Top = 6
      Width = 17
      Height = 13
      Alignment = taRightJustify
      Caption = '0%'
    end
    object pbProgresso: TProgressBar
      Left = 6
      Top = 19
      Width = 618
      Height = 17
      Anchors = [akLeft, akRight]
      TabOrder = 0
    end
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 488
    Top = 8
  end
  object IdHTTP1: TIdHTTP
    OnWork = IdHTTP1Work
    OnWorkBegin = IdHTTP1WorkBegin
    OnWorkEnd = IdHTTP1WorkEnd
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 536
    Top = 8
  end
  object dlgSave: TSaveDialog
    Left = 592
    Top = 8
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 552
    Top = 96
  end
  object cnnConexao: TFDConnection
    Params.Strings = (
      'Database='
      'ConnectionDef=SQLite_Demo')
    Left = 352
  end
  object driver: TFDPhysSQLiteDriverLink
    Left = 376
    Top = 65528
  end
  object FDQuery1: TFDQuery
    Connection = cnnConexao
    Left = 424
    Top = 65528
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = []
    Left = 360
    Top = 40
  end
end
