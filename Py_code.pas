unit Py_code;

interface
  Function GetTheLink(Link : string; UseProxy : boolean) : string;

implementation
uses
  Main, S_Const, System.SysUtils;


Function GetTheLink(Link : string; UseProxy : boolean) : string;
var
  ProxyType : string;
begin
  if not UseProxy then
    result := Const_RequestPrefix + 'print(get("' + Link + '", verify = False).text)'
  else
    with Harvy do
      begin
        if CMB_ProxyType.ItemIndex = 0 then
          ProxyType := '   ''http'''
        else if CMB_ProxyType.ItemIndex = 1 then
          ProxyType := '   ''https''';

        if (length(Trim(Edt_ProxyUsername.Text)) = 0) and (length(Trim(Edt_ProxyPassword.Text)) = 0) then  // Proxy w no authorization
          result := Const_ProxyNA + ProxyType + ': ''' + Edt_ProxyServerIP.Text + ':' + Edt_ProxyPortNo.Text +
            ''',' + #13#10 + '}' + #13#10 + 'url = ''' + Link + '''' + #13#10 +
            'print(session.get(url, verify = False).text)';

        //else

      end;
end;

end.
