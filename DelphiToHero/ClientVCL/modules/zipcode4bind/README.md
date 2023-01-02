# ZipCode4Bind

Biblioteca para trabalhar com recurso de busca de CEP junto com o Framework [**Bind4D**](https://github.com/bittencourtthulio/Bind4D).

## ⚡️ Como utilizar o ZipCode4Bind

## Implementar classe de serviços para que possa passar os parametros necessários.

```delphi
unit Model.DAO.Register;

interface

type
  TModelServicesRegister = class
    private
      procedure RegisterZipCode4B;
    public
      constructor Create;
      destructor Destroy; override;
  end;
  
var
  aServicesRegister : TModelServicesRegister;  

implementation 

uses
  Bind4D;
   
constructor TModelServicesRegister.Create;
begin
  RegisterZipCode4B;
end; 

destructor TModelServicesRegister.Destroy;
begin
  inherited;
end;

procedure TModelServicesRegister.RegisterZipCode4B;
begin
  TBind4D.New
    .ZipCode4B
     .Credential
       .BaseURL('viacep.com.br/ws');
end;

initialization
  aServicesRegister := TModelServicesRegister.Create;
finalization
  aServicesRegister.Free;
end.
```

## Atributo do formulario.

[ComponentZipCode(zcNull)]

## Types.

<b>zcNull</b> - Não realiza busca.<br>
<b>zcCEP</b> - Informa ao componente o CEP que deseja buscar.<br>
<b>zcLogradouro</b> - Popula o campo com o nome do Logradouro retornado na consulta.<br>
<b>zcComplemento</b> - Popula o campo com o Complemento do Endereço retornado na consulta.<br>
<b>zcBairro</b> - Popula o campo com o nome do Bairro retornado na consulta.<br>
<b>zcCidade</b> - Popula o campo com o nome da Cidade retornada na consulta.<br>
<b>zcEstado</b> - Popula o campo com a UF do Estado retornado na consulta.<br>
<b>zcIBGE</b> - Popula o campo com o codigo deo IBGE retornado na consulta.<br>
<b>zcDDD</b> - Popula o campo com o DDD da Localidade retornado na consulta.<br>


## Neste atributo o componente vai pegar o valor do campo informado.
```delphi
[ComponentZipCode(zcCEP)]
edCep: TEdit;
```
## Nestes metodos o componente vai popular os devidos campos com os dados retornados da API de busca.

```
[ComponentZipCode(zcLogradouro)]
edEnde: TEdit;

[ComponentZipCode(zcBairro)]
edBair: TEdit;

[ComponentZipCode(zcComplemento)]
edComp: TEdit;

[ComponentZipCode(zcCidade)]
edCida: TEdit;

[ComponentZipCode(zcEstado)]
edEsta: TEdit;
```

## Modo de Utilizar.

```delphi

unit Unit1;

interface

uses
  Bind4D,
  Bind4D.Attributes;
  
type
  TFormPessoa = class(TForm)  
  lblCep : TLabel;

  [ComponentZipCode(zcCEP)]
  edCep: TEdit; 
  
    procedure btnCepClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  
var
  form: TForm;

implementation

{$R *.dfm}  

end.
  
```


