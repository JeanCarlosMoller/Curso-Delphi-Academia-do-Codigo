unit HS4Bind.Send;

interface

uses
  RESTRequest4D,
  HS4Bind.Interfaces,
  System.Classes,
  Vcl.ExtCtrls;

type
  THS4BindSend = class(TInterfacedObject, iHS4BindSend)
    private
      FParent : iHS4Bind;
      FFileName : String;
      FContentType : String;
      FFileStream : TBytesStream;
      FEndPoint : string;
      FContent : string;
      FPath : string;
    public
      constructor Create(Parent : iHS4Bind);
      destructor Destroy; override;
      class function New (aParent : iHS4Bind): iHS4BindSend;
      function Send : iHS4BindSend;

      function FileName( aValue : String ) : iHS4BindSend;
      function ContentType( aValue : String ) : iHS4BindSend;
      function EndPoint(aValue : string) : iHS4BindSend;
      function Path(aValue : string) : iHS4BindSend;
      function FileStream( aValue : TBytesStream ) : iHS4BindSend; overload;
      function FileStream( aValue : TImage ) : iHS4BindSend; overload;
      function ToString : string;
  end;

implementation

{ THS4BindSend }

function THS4BindSend.ContentType(aValue: String): iHS4BindSend;
begin
  Result:= Self;
  FContentType:= aValue;
end;

constructor THS4BindSend.Create(Parent : iHS4Bind);
begin
  FParent:= Parent;
end;

destructor THS4BindSend.Destroy;
begin

  inherited;
end;

function THS4BindSend.EndPoint(aValue: string): iHS4BindSend;
begin
  result:= self;
  FEndPoint:= aValue;
end;

function THS4BindSend.FileName(aValue: String): iHS4BindSend;
begin
  Result:= Self;
  FFileName:= aValue;
end;

function THS4BindSend.FileStream(aValue: TBytesStream): iHS4BindSend;
begin
  Result := Self;
  FFileStream := aValue;
end;

function THS4BindSend.FileStream(aValue: TImage): iHS4BindSend;
begin
  Result := Self;
  if not Assigned(FFileStream) then
    FFileStream := TBytesStream.Create();
  {$IFDEF HAS_FMX}
    aValue.Bitmap.SaveToStream(FFileStream);
  {$ELSE}
    aValue.Picture.SaveToStream(FFileStream);
  {$ENDIF}
end;

class function THS4BindSend.New(aParent : iHS4Bind): iHS4BindSend;
begin
  Result:= Self.Create(aParent);
end;

function THS4BindSend.Path(aValue: string): iHS4BindSend;
begin
  Result:= Self;
  FPath:= aValue;
end;

function THS4BindSend.Send : iHS4BindSend;
var
  LResponse: IResponse;
  lHost : string;
begin
  Result:= Self;

  lHost:= copy(FParent.Credential.BaseURL,(pos('//',FParent.Credential.BaseURL)+2), length(FParent.Credential.BaseURL));
  lHost:= copy(lHost,0,(pos(':',lHost)-1));

  LResponse :=
  TRequest.New.BaseURL(FParent.Credential.BaseURL+FEndPoint)
    .Token(FParent.Credential.Token)
    .ContentType(FContentType)
    .AddHeader('FileName', FFileName)
    .AddHeader('Path', FPath)
    .AddHeader('Host', lHost)
    .Accept('*/*')
    .AddBody(FFileStream)
    .Post;

  if LResponse.StatusCode = 201 then
     FContent:= FParent.Credential.BaseURL + LResponse.Content;
end;

function THS4BindSend.ToString: string;
begin
  Result:= FContent;
end;

end.

