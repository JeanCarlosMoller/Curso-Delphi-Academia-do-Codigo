unit HS4Bind.Credential;

interface

uses
  HS4bind.Interfaces;


type
  THS4BindCredential = class(TInterfacedObject, iHS4BindCredential)
    private
      [weak]
      FParent : iHS4Bind;
      FBaseURL : string;
      FToken : string;
      FEndPoint : string;
    public
      constructor Create(Parent : iHS4Bind);
      destructor Destroy; override;
      class function New(aParent : iHS4Bind) : iHS4BindCredential;

      function BaseURL(const aValue : string) : iHS4BindCredential; overload;
      function BaseURL : string; overload;
      function Token(aValue : string) : iHS4BindCredential; overload;
      function Token : string; overload;
      function &End : iHS4Bind;
  end;


implementation

{ THS4BindCredential }

function THS4BindCredential.BaseURL(const aValue : string) : iHS4BindCredential;
begin
  Result:= Self;
  FBaseURL:= aValue;
end;

function THS4BindCredential.&End: iHS4Bind;
begin
  Result:= FParent;
end;

function THS4BindCredential.BaseURL: string;
begin
  Result:= FBaseURL;
end;

constructor THS4BindCredential.Create(Parent: iHS4Bind);
begin
  FParent:= Parent;
end;

destructor THS4BindCredential.Destroy;
begin

  inherited;
end;

class function THS4BindCredential.New(aParent: iHS4Bind): iHS4BindCredential;
begin
  result:= Self.Create(aParent);
end;

function THS4BindCredential.Token: string;
begin
  Result := FToken;
end;

function THS4BindCredential.Token(aValue: string): iHS4BindCredential;
begin
  Result := self;
  FToken := aValue;
end;

end.

