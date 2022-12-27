unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UCliente;

type
  TForm1 = class(TForm)
    Button2: TButton;
    Edit1: TEdit;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.Button2Click(Sender: TObject);
var
  Cliente : TCliente;
begin
  Cliente := TCliente.Create;
  try
    Cliente.Nome := 'Jean';
    Cliente.Telefone := 'Telefone POO';
    Cliente.Endereco := 'Endereco POO';
    Cliente.Cidade := 'Cidade POO';
    Cliente.DataNascimento := StrToDateTime(Edit1.Text);

    Cliente.CadastrarCliente;
    Cliente.CriarFinanceiro;

    ShowMessage(Cliente.Endereco);

  finally
    Cliente.Free;
  end;
end;
end.
