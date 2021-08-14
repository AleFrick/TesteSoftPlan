object frmHistorico: TfrmHistorico
  Left = 0
  Top = 0
  Caption = 'Hist'#243'rico de Download'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
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
    Height = 70
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 633
      Height = 68
      Align = alClient
      Alignment = taCenter
      Caption = 'Historico de Download'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 22
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitHeight = 64
    end
    object lblDataInicial: TLabel
      Left = 324
      Top = 34
      Width = 53
      Height = 13
      Caption = 'Data Inicial'
    end
    object lblDataFinal: TLabel
      Left = 449
      Top = 34
      Width = 48
      Height = 13
      Caption = 'Data Final'
    end
    object dtpDataInicial: TDateTimePicker
      Left = 324
      Top = 46
      Width = 120
      Height = 21
      Date = 44422.535889131940000000
      Time = 44422.535889131940000000
      TabOrder = 0
    end
    object dtpDataFinal: TDateTimePicker
      Left = 449
      Top = 46
      Width = 120
      Height = 21
      Date = 44422.535967928240000000
      Time = 44422.535967928240000000
      TabOrder = 1
    end
    object Button1: TButton
      Left = 575
      Top = 33
      Width = 50
      Height = 36
      Caption = 'Filtrar'
      TabOrder = 2
      OnClick = Button1Click
    end
    object rdgFiltroData: TRadioGroup
      Left = 6
      Top = 31
      Width = 315
      Height = 36
      Caption = 'Filtrar por:'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Data de Inicio'
        'Data de Termino'
        'Todos downloads')
      TabOrder = 3
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 70
    Width = 635
    Height = 229
    Align = alClient
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAINICIO'
        Title.Caption = 'Data de Inicio'
        Width = 105
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAFIM'
        Title.Caption = 'Data de Termino'
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'URL'
        Title.Caption = 'Url'
        Width = 486
        Visible = True
      end>
  end
  object cnnConexao: TFDConnection
    Params.Strings = (
      'Database=D:\Dropbox\Teste softPlan\softplan.db'
      'ConnectionDef=SQLite_Demo')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 104
  end
  object FDQuery1: TFDQuery
    IndexFieldNames = 'CODIGO;DATAINICIO;DATAFIM;URL'
    Connection = cnnConexao
    SQL.Strings = (
      'select CODIGO, DATAINICIO, DATAFIM,URL from logdownload'
      'ORDER BY CODIGO DESC')
    Left = 128
    Top = 112
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 312
    Top = 152
  end
end
