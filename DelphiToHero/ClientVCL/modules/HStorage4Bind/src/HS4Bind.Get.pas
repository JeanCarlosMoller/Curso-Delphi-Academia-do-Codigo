unit HS4Bind.Get;

interface

uses
  System.Net.URLClient,
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  Vcl.ExtCtrls,
  Vcl.Imaging.jpeg,
  Vcl.Graphics,
  HS4Bind.Interfaces;

type
  THS4bindGet = class(TInterfacedObject, iHS4BindGet)
    private
      FParent : iHS4Bind;
      FFileName : string;
    procedure GetImageByUrl(URL: string; APicture: TPicture);
    public
      constructor Create(Parent : iHS4Bind);
      destructor Destroy; override;
      class function New (aParent : iHS4Bind): iHS4BindGet;

      function Get(var aImage : TImage) : iHS4BindGet;
      function FileName(aName : string) : iHS4BindGet;
  end;

implementation

uses
  System.Classes;

{ THS4bindGet }

constructor THS4bindGet.Create(Parent: iHS4Bind);
begin
  FParent:= Parent;
end;

destructor THS4bindGet.Destroy;
begin

  inherited;
end;

function THS4bindGet.FileName(aName: string): iHS4BindGet;
begin
  Result:= Self;
  FFileName:= aName;
end;

function THS4bindGet.Get(var aImage : TImage) : iHS4BindGet;
begin
  result:= self;
  if pos('http', FFileName) > 0  then
   begin
     GetImageByUrl(FFileName, aImage.Picture);
   end else
    begin
      aImage.Picture.LoadFromFile(FFileName);
    end;
end;

procedure THS4bindGet.GetImageByUrl(URL: string; APicture: TPicture);
var
  Strm: TMemoryStream;
  vIdHTTP : TIdHTTP;
begin
  Strm := TMemoryStream.Create;
  vIdHTTP := TIdHTTP.Create(nil);
  try
    if FParent.Credential.Token <> '' then
      vIdHTTP
      .Request
      .CustomHeaders
      .AddValue('Authorization', FParent.Credential.Token);

    vIdHTTP.Get(URL, Strm);
    if (Strm.Size > 0) then
    begin
      Strm.Position := 0;
      APicture.LoadFromStream(Strm);
    end;
  finally
    Strm.Free;
    vIdHTTP.Free;
  end;
end;

class function THS4bindGet.New(aParent : iHS4Bind): iHS4BindGet;
begin
  result:= Self.Create(aParent);
end;

end.

