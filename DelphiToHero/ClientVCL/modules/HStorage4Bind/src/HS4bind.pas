unit HS4bind;

interface

uses
  HS4Bind.Interfaces;

type
  THS4Bind = class(TInterfacedObject, iHS4Bind)
    private
      FCredencial : iHS4BindCredential;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iHS4Bind;
      function Credential : iHS4BindCredential;
      function SendFile : iHS4BindSend;
      function GetFile : iHS4BindGet;
  end;

implementation

uses
  HS4Bind.Send,
  HS4Bind.Get,
  HS4Bind.Credential;

{ THS4Bind }

constructor THS4Bind.Create;
begin

end;

function THS4Bind.Credential: iHS4BindCredential;
begin
  if not Assigned(FCredencial) then
    FCredencial := THS4BindCredential.New(Self);

  Result := FCredencial;
end;

destructor THS4Bind.Destroy;
begin

  inherited;
end;

function THS4Bind.GetFile: iHS4BindGet;
begin
  Result:= THS4BindGet.new(Self);
end;

class function THS4Bind.New: iHS4Bind;
begin
  Result:= self.Create;
end;

function THS4Bind.SendFile: iHS4BindSend;
begin
  Result:= THS4BindSend.new(Self);
end;

end.