unit Py_code;

interface
  Function GetTheLink(Link : string) : string;

implementation
uses
  Main;

//const
  //ChkLink = 'print("hello World")';
    // +
Function GetTheLink(Link : string) : string;
begin
  result := 'from requests import get' + #13#10 + 'print(get("' + Link + '", verify = False).text)';
end;

end.
