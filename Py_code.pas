unit Py_code;

interface
  Function GetTheLink(Link : string; UseProxy : boolean) : string;

implementation
uses
  Main, S_Const, System.SysUtils;


Function GetTheLink(Link : string; UseProxy : boolean) : string;
{Getting links w/wo proxy
and output for python code shoulb be like

no Proxy:
//      from requests import get
//      print(get('https://icetrade.by/tenders/all/view/111', verify = False).text)

Proxy w NOA
//      import requests
//      session = requests.Session()
//      session.proxies = {
//         'http': '5.44.54.16:8080',
//      }
//      url = 'https://icetrade.by/tenders/all/view/111'
//      print(session.get(url, verify = False).text)

{Proxy w authorization
//      import requests
//      session = requests.Session()
//      session.proxies = {
//         'http': 'http://user:pass@5.44.54.16:8080/',
//      }
//      url = 'https://icetrade.by/tenders/all/view/111'
//      print(session.get(url, verify = False).text)


var
  ProxyType : string;
begin
  if not UseProxy then
    result := Const_RequestPrefix + 'print(get("' + Link + '", verify = False).text)'
  else
    with Harvy do
      begin
        ProxyType := CMB_ProxyType.Items[CMB_ProxyType.ItemIndex];  // Getting selected proxy type
        if (length(Trim(Edt_ProxyUsername.Text)) = 0) and (length(Trim(Edt_ProxyPassword.Text)) = 0) then  // Proxy w no authorization
          result := Const_ProxyNA + '   ''' + ProxyType + ''': ''' + Edt_ProxyServerIP.Text
            + ':' + Edt_ProxyPortNo.Text + ''',' + #13#10 + '}' + #13#10 + 'url = ''' + Link
            + '''' + #13#10 + 'print(session.get(url, verify = False).text)'
        else  // Proxy w authorization
          result := Const_ProxyNA + '   ''' + ProxyType + ''': ''' + trim(ProxyType) + '://'
            + Edt_ProxyUsername.Text + ':' + Edt_ProxyPassword.Text + '@' + Edt_ProxyServerIP.Text
            + ':' + Edt_ProxyPortNo.Text + '/'',' + #13#10 + '}' + #13#10 + 'url = ''' + Link + ''''
            + #13#10 + 'print(session.get(url, verify = False).text)';
      end;
end;

end.
