unit ZC4B.Credential;

interface

uses
  ZC4B.Interfaces;

type
  ZC4BCredential = class(TInterfacedObject, iZC4BCredential)
    private
      [weak]
      FParent : iZC4B;
      FBaseURL : string;
    public
      constructor Create(Parent : iZC4B);
      destructor Destroy; override;
      class function New(Parent : iZC4B) : iZC4BCredential;

      function BaseURL(const aValue : string) : iZC4BCredential; overload;
      function BaseURL : string; overload;
      function &End : iZC4B;
  end;

implementation

{ ZC4BCredential }

function ZC4BCredential.BaseURL(const aValue : string) : iZC4BCredential;
begin
  result:= self;
  FBaseURL:= aValue;
end;

function ZC4BCredential.&End: iZC4B;
begin
  Result:= FParent;
end;

function ZC4BCredential.BaseURL: string;
begin
  result:= FBaseURL;
end;

constructor ZC4BCredential.Create(Parent: iZC4B);
begin
  FParent:= Parent;
end;

destructor ZC4BCredential.Destroy;
begin

  inherited;
end;

class function ZC4BCredential.New(Parent: iZC4B): iZC4BCredential;
begin
  result:= self.Create(Parent);
end;

end.
