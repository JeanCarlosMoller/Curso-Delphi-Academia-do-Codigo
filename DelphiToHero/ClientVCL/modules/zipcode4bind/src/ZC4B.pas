unit ZC4B;

interface

uses
  ZC4B.Interfaces;

type
  TZC4B = class(TInterfacedObject, iZC4B)
    private
      FCredencial : iZC4BCredential;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iZC4B;
      function Credential : iZC4BCredential;
      function GetZipCode : iZC4BGet;
  end;

implementation

uses
  ZC4B.Get, ZC4B.Credential;

{ TZC4B }

constructor TZC4B.Create;
begin

end;

function TZC4B.Credential: iZC4BCredential;
begin
  if not Assigned(FCredencial) then
    FCredencial := ZC4BCredential.New(Self);

  Result := FCredencial;
end;

destructor TZC4B.Destroy;
begin

  inherited;
end;

function TZC4B.GetZipCode: iZC4BGet;
begin
  result:= TZC4BGet.New(Self);
end;

class function TZC4B.New: iZC4B;
begin
  Result:= Self.Create;
end;

end.
