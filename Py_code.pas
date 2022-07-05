unit Py_code;

interface
  Function GetTheLink(Link : string; UseProxy : boolean) : string;

implementation
uses
  Main, S_Const;

const
  RequestPrefix = 'from requests import get' + #13#10;

Function GetTheLink(Link : string; UseProxy : boolean) : string;
begin
  if not UseProxy then
    result := RequestPrefix + 'print(get("' + Link + '", verify = False).text)'
  else
    begin
      // setting up proxy params
    end;
end;

end.
