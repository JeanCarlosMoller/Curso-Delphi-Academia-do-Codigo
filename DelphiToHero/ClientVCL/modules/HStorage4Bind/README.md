# HStorage4Bind

Biblioteca para trabalhar com recurso de trafego de arquivos junto com as Structures:

[**Bind4D**](https://github.com/bittencourtthulio/Bind4D).<br>
[**Octet-Stream**](https://github.com/HashLoad/horse-octet-stream).<br>


### ⚡️ Como utilizar o HStorage4Bind

## Implementar classe de serviços para que possa passar os parametros necessários.

```delphi
unit Model.DAO.Register;

interface

type
  TModelServicesRegister = class
    private
      procedure RegisterHorseStream;
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
  RegisterHorseStream;
end; 

destructor TModelServicesRegister.Destroy;
begin
  inherited;
end;

procedure TModelServicesRegister.RegisterHorseStream;
begin
  TBind4D.New
    .HSD4Service
    .Credential
      .BaseURL('http://localhost:9000');
end;

initialization
  aServicesRegister := TModelServicesRegister.Create;
finalization
  aServicesRegister.Free;
end.
```

## Atributo do formulario.

[HorseStorage('jpg', 'application/octet-stream', '/public/stream', 'pessoas')]

<b>'jpg'</b> - Formato do arquivo. Podendo variar conforme o tipo de arquivo que deseja trafegar (.Jpg, .Png, .Pdf, .Doc ...).<br>
<b>'application/octet-stream'</b> - Content Type utilitado pelo Octet Stream do Horse para trafego de arquivos.<br>
<b>'/public/stream'</b> - EndPoint.<br>
<b>'pessoas'</b> - Nome da pasta aonde o arquivo será salvo no servidor.<br>


## Modo de Utilizar.

```delphi

unit Unit1;

interface

uses
  Bind4D,
  Bind4D.Attributes;
  
type
  TFormPessoa = class(TForm)  

  [HorseStorage('jpg', 'application/octet-stream', '/public/stream', 'pessoas')]
  Image1: TImage;
  
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


