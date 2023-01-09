unit MonolitoFinanceiro.Model.Conexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdmConexao = class(TDataModule)
    FDQuery1: TFDQuery;
    SQLConexao: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
     const ARQUIVOCONFIGURACAO = 'MonolitoFinanceiro.cfg';
  public
    { Public declarations }
    procedure CarregarConfiguracoes;
    procedure Conectar;
    procedure Desconectar;
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TdmConexao.CarregarConfiguracoes;
var
  ParametroNome, ParametroValor : String;
  Contador : Integer;
  ListaParametros : TStringList;
begin
  SQLConexao.Params.Clear;
  if not FileExists(ARQUIVOCONFIGURACAO) then
    raise Exception.Create('Arquivo de configura��o n�o encontrado!');
  ListaParametros := TStringList.Create;
  try
    ListaParametros.LoadFromFile(ARQUIVOCONFIGURACAO);
                         //Esse pred seria a mesma coisa que fazer ListaParametros.Count -1
    for Contador := 0 to Pred(ListaParametros.Count) do
    begin
      if ListaParametros[Contador].IndexOf('=') > 0 then
      begin
        ParametroNome := ListaParametros[Contador].Split(['='])[0].Trim;
        ParametroNome := ListaParametros[Contador].Split(['='])[1].Trim;
        SQLConexao.Params.Add(ParametroNome + '=' + ParametroValor);
      end;
    end;

  finally
    ListaParametros.Free;

  end;


end;

procedure TdmConexao.Conectar;
begin
  SQLConexao.Connected;
end;

procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin
  CarregarConfiguracoes;
  Conectar;
end;

procedure TdmConexao.Desconectar;
begin
  SQLConexao.Connected := False;
end;

end.
