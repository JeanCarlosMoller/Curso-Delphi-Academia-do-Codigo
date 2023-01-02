unit ZC4B.Get;

interface

uses
  RESTRequest4D,
  ZC4B.Interfaces,
  System.JSON;

type
  TZC4BGet = class(TInterfacedObject, iZC4BGet)
  private
    [weak]
    FParent: iZC4B;
    FContent : TJsonObject;
  public
    constructor Create(Parent: iZC4B);
    destructor Destroy; override;
    class function New(Parent: iZC4B): iZC4BGet;

    function ZipCode(const aZipCode : string): iZC4BGet;
    function ToJson: TJsonObject;
    function &End: iZC4B;

  end;

implementation

{ TZC4BGet }

function TZC4BGet.&End: iZC4B;
begin
  result := FParent;
end;

constructor TZC4BGet.Create(Parent: iZC4B);
begin
  FParent := Parent;
end;

destructor TZC4BGet.Destroy;
begin

  inherited;
end;

function TZC4BGet.ToJson: TJSONObject;
begin
  result := FContent;
end;

function TZC4BGet.ZipCode(const aZipCode : string): iZC4BGet;
var
  LResponse: IResponse;
begin
  result := Self;
  LResponse:=
    TRequest.New.BaseURL(FParent.Credential.BaseURL+'/'+aZipCode+'/json')
      .ContentType('application/json')
      .Accept('*/*')
    .Get;

  if LResponse.StatusCode = 200 then
     FContent:= TJSONObject.ParseJSONValue(LResponse.Content) as TJSONObject;
end;

class function TZC4BGet.New(Parent: iZC4B): iZC4BGet;
begin
  result := Self.Create(Parent);
end;

end.
