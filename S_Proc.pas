unit S_Proc;

interface
  Procedure Delay(mSec:Cardinal);
  Procedure RestoreDefSize;
  Procedure ExpDefSize;
  Procedure LetSParse;
//  Procedure MailNotify;  // +
  Procedure BLSorter (BadLink : string);
  Procedure DataSorter(Data : array of string; Len : integer);
  Procedure DataFoundUpd;
  Procedure CurrPosUpd;


implementation
uses
  Winapi.Windows, Vcl.Forms, System.SysUtils, Vcl.Dialogs,
  Main, S_Func, Py_code, S_Const;


Procedure Delay(mSec:Cardinal);
{Sleep Alternative
difference is not make APP Freeze}
Var
  TargetTime : Cardinal;
Begin
  TargetTime := GetTickCount + mSec;
  While TargetTime > GetTickCount Do
    begin
      Application.ProcessMessages;
      Sleep(1);
      If Application.Terminated then Exit;
    end;
End;


Procedure RestoreDefSize;
{Just restoring default size of window}
begin
  Harvy.ClientWidth := 520;
  Harvy.ClientHeight := 138;
  Harvy.Btn_Options.Caption := '>>>'
end;


Procedure ExpDefSize;
{Big size of window for advance mode}
begin
    Harvy.ClientWidth := 784;
    Harvy.ClientHeight := 199;
    Harvy.Btn_Options.Caption := '<<<'
end;


{Procedure SetProxyParams;
{Setting Proxy Params if needed}
{begin
 { if Harvy.Chck_UseProxy.Checked = True then
    with Harvy.IdHTTP_Main.ProxyParams do
      begin
        ProxyServer := Harvy.Edt_ProxyServerIP.Text;
        ProxyPort := strtoint(Harvy.Edt_ProxyPortNo.Text);
        ProxyUsername := Harvy.Edt_ProxyUsername.Text;
        ProxyPassword := Harvy.Edt_ProxyPassword.Text;
      end; }
{end; }


Procedure LetSParse; // (IsItTest : boolean);
{Here we parse links}
var
  i : integer;
  PageHolder : string;
  PyCommand : string;
begin
  with Harvy do
    Edt_Total.Text := inttostr(strtoint(Edt_ScanTo.text) - strtoint(Edt_ScanFrom.text) + 1);
  CurrPosUpd;

  for i := strtoint(Harvy.Edt_ScanFrom.text) to strtoint(Harvy.Edt_ScanTo.text) do  // Page iterator for ours range
  begin
    Harvy.Mem_PyOut.Clear;
    PyCommand := GetTheLink(IceLink + inttostr(i), Harvy.Chck_UseProxy.Checked);  // mixing Python command
    // Harvy.Py_Engine.LoadDll; // if APP crashed on start uncomment & Play !!!
    Harvy.Py_Engine.ExecString(PyCommand);
    PageHolder := Harvy.Mem_PyOut.Lines.Text;  // rewriting of temp STR by actual value

    if Length(PageHolder) > 16600 then
      ScanPage(PageHolder, inttostr(i))  // Try to scan pages
    else
      BLSorter(inttostr(i)); // othercase means empty page so send it to BadLinks
    Delay (2000);  // just trying to fake an IP block))
  end;
end;


Procedure BLSorter(BadLink : string);
{Just sorting Bad links dependenly from App mode (Test\Normal)}
begin
  if Harvy.ChB_TestMode.Checked = True Then
    showmessage('Link for ID ' + BadLink + ' is broken');
  // написать для else запись в БД ч-з try..else

end;


Procedure DataSorter(Data : array of string; Len : integer);
var
  i : integer;  // simple iterator
begin
  if Harvy.ChB_TestMode.Checked = True Then
    for i := 1 to Len do
      showmessage(Data[i-1]);
   {else
     case len of
        4 : begin #########

            end;

        5 : begin

            end;
     end;   }
 // else  //написать для else запись в БД

end;


Procedure DataFoundUpd;
begin
  Harvy.Edt_DataFounded.Text := inttostr(strtointdef(Harvy.Edt_DataFounded.Text, 0) + 1);
end;


Procedure CurrPosUpd;
begin
  Harvy.Edt_CurrPos.Text := inttostr(strtointdef(Harvy.Edt_CurrPos.Text, 0) + 1);
  Harvy.Edt_LinkScaned.Text := inttostr(strtointdef(Harvy.Edt_LinkScaned.Text, 0) + 1);
  {написать также для прогресбар"а}
end;

end.
