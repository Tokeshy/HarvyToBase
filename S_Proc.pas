unit S_Proc;

interface
  Procedure Proc_Delay(mSec:Cardinal);
  Procedure Proc_RestoreDefSize;
  Procedure Proc_ExpDefSize;
  Procedure Proc_LetSParse;
//  Procedure MailNotify;  // +
  Procedure Proc_BLSorter (BadLink : string);
  Procedure Proc_DataSorter(Data : array of string; Len : integer);
  Procedure Proc_DataFoundUpd;
  Procedure Proc_CurrPosUpd;
  Procedure Proc_DBConnection;
  Procedure Proc_ExecSQL(InsText : string);
  Procedure Proc_GetDll(Location : string);
  Procedure Proc_IsItReParse;
  Procedure Proc_GetPage(Postfix, dbID : string; UseProxy, IsReParse : boolean);


implementation
uses
  Winapi.Windows, Vcl.Forms, System.SysUtils, Vcl.Dialogs,
  Main, S_Func, Py_code, S_Const,
  ShellAPI, System.UITypes;


Procedure Proc_Delay(mSec:Cardinal);
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


Procedure Proc_RestoreDefSize;
{Just restoring default size of window}
begin
  Harvy.ClientWidth := 520;
  Harvy.ClientHeight := 138;
  Harvy.Btn_Options.Caption := '>>>'
end;


Procedure Proc_ExpDefSize;
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


Procedure Proc_GetPage(Postfix, dbID : string; UseProxy, IsReParse : boolean);
var
  PyCommand : string;
  PageHolder : string;
begin
  Harvy.Mem_PyOut.Clear;
  PyCommand := GetTheLink(Const_IceLink + Postfix, UseProxy);  // mixing Python command
  Harvy.Py_Engine.ExecString(PyCommand);
  PageHolder := Harvy.Mem_PyOut.Lines.Text;  // rewriting of temp STR by actual value

  if not IsReParse then  // Regular parsing
    if Length(PageHolder) > 16600 then   // it means page is not empty
      Fnc_ScanPage(PageHolder, Postfix)  // Try to scan pages
    else
      Proc_BLSorter(Postfix) // othercase means empty page so send it to BadLinks
  else  // work w links from DB
    if Length(PageHolder) > 16600 then
      begin
        Fnc_ScanPage(PageHolder, Postfix);
        Proc_ExecSQL(Const_BLDel + dbID +''');');
      end;

  Proc_Delay (1500);  // just trying to fake an IP block))
end;


Procedure Proc_LetSParse;
{Here we parse links}
var
  i : integer;
  UseProxy, ReParse : boolean;
begin
  UseProxy := Harvy.Chck_UseProxy.Checked;
  ReParse := Harvy.Chck_ReparseCheck.Checked;

  with Harvy do
    begin
      Edt_Total.Text := inttostr(strtointdef(Edt_ScanTo.text, 0) - strtointdef(Edt_ScanFrom.text, 0) + 1);
      PB_TotalProgress.max := strtointdef(Edt_Total.Text, 0);
    end;

  if not ReParse then
    for i := strtoint(Harvy.Edt_ScanFrom.text) to strtoint(Harvy.Edt_ScanTo.text) do  // Page iterator for ours range
      Proc_GetPage(inttostr(i), '-', UseProxy, ReParse)

  else if ReParse then
    with Harvy.BL_Table do
      begin
        CachedUpdates := True;  // not shure it's needed here check out tomorrow ))
        if not Connection.Connected then
          Connection.Connected := True;
        if not active then
          Active := True;
        TableName := 'badlinks';
        open;
        while not Eof do
        begin
          Proc_GetPage(FieldByName('BadLinkID').AsString, FieldByName('ID').AsString, UseProxy, ReParse);
          next;
        end;
        close;
      end;

    messagedlg(Const_WorkDone, mtInformation, [mbOK], 0);
end;


Procedure Proc_BLSorter(BadLink : string);
{Just sorting Bad links dependenly from App mode (Test\Normal)}
begin
  Proc_CurrPosUpd;
  if Harvy.ChB_TestMode.Checked = True Then
    showmessage('Link for ID ' + BadLink + ' is broken')
  else
    Proc_ExecSQL(Const_BLUpd + BadLink + ''');');
end;


Procedure Proc_DataSorter(Data : array of string; Len : integer);
{if testmode - just show in message, othercase writing to DB}
var
  i : integer;  // simple iterator
begin
  if Harvy.ChB_TestMode.Checked = True Then
    for i := 1 to Len do
      showmessage(Data[i-1])
  else
    Proc_ExecSQL(Fnc_CreateInsText(Data, Len));
end;


Procedure Proc_DataFoundUpd;
{visual part update))}
begin
  Harvy.Edt_DataFounded.Text := inttostr(strtointdef(Harvy.Edt_DataFounded.Text, 0) + 1);
end;


Procedure Proc_CurrPosUpd;
{}
begin
  with Harvy do
    begin
      Edt_CurrPos.Text := inttostr(strtointdef(Harvy.Edt_CurrPos.Text, 0) + 1);
      Edt_LinkScaned.Text := inttostr(strtointdef(Harvy.Edt_LinkScaned.Text, 0) + 1);
      PB_TotalProgress.position := PB_TotalProgress.position + 1;
    end;
end;


Procedure Proc_DBConnection;
{Setting up connection w DB}
begin
  with Harvy.MainConnection do
    begin
      if connected
        then connected := False;
      try
        connected := True;
        Harvy.Edt_DBServerIP.Text := server;
        Harvy.Edt_DBUsername.Text := username;
        Harvy.Edt_DBPortNo.Text := inttostr(port);
        Harvy.Edt_Schema.Text := database;
        messagedlg('Connection succeeded.', mtInformation, [mbOK], 0);
      except
        messagedlg('Failed to connect to DB.', mtError, [mbOK], 0);
      end;
    end;
end;


Procedure Proc_ExecSQL(InsText : string);
{just exec SQL ))}
begin
  try
    with Harvy.AddCommand do
      begin
        if not connection.connected
          then connection.connected := True;
        if not autocommit
          then autocommit := True;
        SQL.Clear;
        SQL.Text := InsText;
        Execute;
      end;
  except
    {make log file ?}
  end;
end;


Procedure Proc_GetDll(Location : string);
{if no DLL - download it}
var
  MessageText : string;
begin
  MessageText := 'Download DLL into ' + Location +' and re-try after.';
  messagedlg(MessageText, mtInformation, [mbOK], 0);
  ShellExecute(0, 'open', Const_DllLink, '', '', SW_SHOWNORMAL);
end;


Procedure Proc_IsItReParse;
{Just playng w visualisation )))}
begin
  with Harvy do
    if Chck_ReparseCheck.Checked then
      begin
        ChB_TestMode.Checked := False;
        ChB_TestMode.Enabled := False;
        Edt_ScanFrom.Enabled := False;
        Edt_ScanTo.Enabled := False;
      end
    else
      begin
        ChB_TestMode.Enabled := True;
        Edt_ScanFrom.Enabled := True;
        Edt_ScanTo.Enabled := True;
      end;
end;

end.
