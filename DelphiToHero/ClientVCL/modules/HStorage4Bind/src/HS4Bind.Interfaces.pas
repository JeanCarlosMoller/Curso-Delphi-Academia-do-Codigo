unit HS4Bind.Interfaces;

interface

uses
  System.Classes,
  {$IFDEF HAS_FMX}
    FMX.Objects;
  {$ELSE}
    Vcl.ExtCtrls;
  {$ENDIF}

type
  iHS4bindSend = interface;
  iHS4BindGet = interface;
  iHS4BindCredential = interface;

  iHS4Bind = interface
  ['{9AF66D6B-D72D-4918-88F7-C65043C46079}']
  function SendFile : iHS4bindSend;
  function GetFile : iHS4BindGet;
  function Credential : iHS4BindCredential;
  end;

  iHS4bindSend = interface
  ['{09E77C1A-3405-4210-BA2D-52B246F9D7F7}']
  function Send : iHS4bindSend;
  function FileName( aValue : String ) : iHS4bindSend;
  function ContentType( aValue : String ) : iHS4bindSend;
  function EndPoint(aValue : string) : iHS4bindSend;
  function Path(aValue : string) : iHS4bindSend;
  function FileStream( aValue : TBytesStream ) : iHS4bindSend; overload;
  function FileStream( aValue : TImage ) : iHS4bindSend; overload;
  function ToString : string;
  end;

  iHS4BindGet = interface
  ['{9D869884-D8A3-4BF0-8826-07CFFCD48695}']
  function Get(var aImage : TImage) : iHS4BindGet;
  function FileName(aName : string) : iHS4BindGet;
  end;

  iHS4BindCredential = interface
  ['{73FC2594-C32E-48A4-A8AE-82CD8ED26F27}']
  function BaseURL(const aValue : string) : iHS4BindCredential; overload;
  function BaseURL : string; overload;
  function Token(aValue : string) : iHS4BindCredential; overload;
  function Token : string; overload;
  function &End : iHS4Bind;
  end;

implementation

end.

