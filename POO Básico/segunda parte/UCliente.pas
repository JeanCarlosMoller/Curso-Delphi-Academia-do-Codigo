unit UCliente;

interface

uses
  System.Classes;

type
  TClasseAmiga = class
    strict private
      Teste : String;

    public
      procedure TesteDeSoftware;
  end;

type
  TCliente = class
  private
    FDataNascimento: TDateTime;
    FNome: String;
    FEndereco: String;
    FTelefone: String;

    procedure SetDataNascimento(const Value: TDateTime);
    procedure SetNome(const Value: String);
    procedure SetEndereco(const Value: String);
    procedure SetTelefone(const Value: String);
    function GetEndereco: String;

  public

    Cidade: String;
    UF: String;
    Saldo : Currency;

    constructor Create;
    procedure CadastrarCliente;
    procedure CriarFinanceiro;

    function Idade : Integer;

    property Nome : String read FNome write SetNome;
    property DataNascimento : TDateTime read FDataNascimento write SetDataNascimento;
    property Telefone: String read FTelefone write SetTelefone;
    property Endereco: String read GetEndereco write SetEndereco;

  end;

implementation

uses
  System.SysUtils;



{ TCliente }

constructor TCliente.create;
begin
  UF := 'RJ';
  Saldo := 1000;
end;

procedure TCliente.CadastrarCliente;

 var
  Lista: TStringList;

begin
  Lista := TStringList.Create;

  try
    Lista.Add('Nome: ' + Nome);
    Lista.Add('Telefone: ' + Telefone);
    Lista.Add('Endereço: ' + Endereco);
    Lista.Add('Cidade: ' + Cidade);
    Lista.Add('UF: ' + UF);
    Lista.SaveToFile('Cliente.txt');

  finally
    Lista.Free;
  end;
end;

procedure TCliente.CriarFinanceiro;
begin

end;

function TCliente.GetEndereco: String;
begin
  Result := FEndereco + ' | Santa Catarina / Brasil';
end;

procedure TCliente.SetEndereco(const Value: String);
begin
  FEndereco := Value;
end;

function TCliente.Idade: Integer;

begin
  Result := Trunc((Now - FDataNascimento) / 365.25);
end;

procedure TCliente.SetDataNascimento(const Value: TDateTime);

begin
  FDataNascimento := Value;
end;

procedure TCliente.SetNome(const Value: String);
begin

  if Value = '' then
  raise Exception.Create('Nome não pode ser nulo ');


  FNome := Value;
end;

procedure TCliente.SetTelefone(const Value: String);
begin
  FTelefone := Value;
end;

{ TClasseAmiga }

procedure TClasseAmiga.TesteDeSoftware;
var
  aClasse : TCliente;
begin


end;

end.
