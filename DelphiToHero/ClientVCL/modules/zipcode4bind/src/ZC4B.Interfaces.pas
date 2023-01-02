unit ZC4B.Interfaces;

interface

uses
  System.JSON;

type
  iZC4BGet = interface;
  iZC4BCredential = interface;

  iZC4B = interface
    ['{C629890E-E87F-401D-AE23-4183775F782A}']
    function Credential: iZC4BCredential;
    function GetZipCode: iZC4BGet;
  end;

  iZC4BGet = interface
    ['{58943FD8-4D80-49D5-906F-62F20947B5BC}']
    function ZipCode(const aZipCode : string): iZC4BGet;
    function ToJson: TJSONObject;
    function &End : iZC4B;
  end;

  iZC4BCredential = interface
    ['{3AF59953-C1E3-4C21-ACFB-421E9D76EFB5}']
    function BaseURL(const aValue: string): iZC4BCredential; overload;
    function BaseURL: string; overload;
    function &End: iZC4B;
  end;

implementation

end.
