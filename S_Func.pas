unit S_Func;

interface
  Function ShoudWeParce : boolean;
  Function MailNotify : Boolean;
  Function ScanPage (HtmlBody: string; LnkID : string) : string;
  Function LineStrip (Line, SepBy : string) : string;
  Function CreateInsText (data: array of string; len : integer) : string;

implementation
uses
  Main, S_Proc, Py_code, Vcl.Dialogs, System.SysUtils, S_Const;


Function ShoudWeParce : boolean;
{checking if we can parse in normal or test mode
 checking DB connection and TestMode flag
 if False - can't Parce}
begin
  if Harvy.ChB_TestMode.Checked = True Then
      result := True
  else if not Harvy.MainConnection.Connected then
    begin
      MessageDlg(Const_ErrDB, mtError, [mbOk] , 0);
      result := False;
      DBConnection;
    end
  else if Harvy.MainConnection.Connected then
    result := True;
end;


Function MailNotify : boolean;
{If needed send message to email as task complete alert}
var
  MessageText : string;
begin
  if harvy.Chck_ReparseCheck.Checked = True then
    MessageText := Const_MesReP
  else
    MessageText := Const_MesNoRep;

  MessageText := MessageText + ' Where found ' + Harvy.Edt_DataFounded.Text + ' data records from ' + Harvy.Edt_LinkScaned.Text + ' links.';

  with Harvy.IdSMTP do
  begin  // Setting up Mailing params
    Host := Harvy.Edt_MailHost.Text;  // Mail host; f.e. - 'smtp.Rambler.ru';
    Username := Harvy.Edt_MailUsername.Text;  // Sender username //
    Password := Harvy.Edt_MailPass.Text;  //
    Port := strtoint(Harvy.Edt_MailPort.Text);  // Port no; f.e. - 587;
  end;

  with Harvy.IdMessage do
  begin  // Creating mail "Body"
    Subject := 'Parce Compleet';  // Mail subject
    Recipients.EMailAddresses := Harvy.Edt_MailTo.Text;  // Mail recipient
    From.Address := Harvy.Edt_MailUsername.Text;  // Mail sender
    Body.Text:= MessageText;  // Mail text
    From.Name:= 'Harvy';  // Sender's name ))
  end;

  try
      Harvy.idSMTP.connect;  // establishing connection
      Harvy.idSMTP.Send(Harvy.idmessage);  // Mail send
      result := True;
  Except on E:Exception do
    begin
      MessageDlg(Const_ErrMail, mtError, [mbOk] , 0);  // if not succeed
      result := False;
    end;
  end;
end;


Function LineStrip (Line, SepBy : string) : string;  // SepBy - stop simbol
var
  i : integer;  // Simple iterator
begin
  delete(Line, ansipos(SepBy, Line), length(Line));
  for i := 1 to 8 do
    if ansipos(Const_StrToReplace[i], Line) > 0 then
      Line := StringReplace(Line, Const_StrToReplace[i], ' ', [rfReplaceAll]);
  result := trim(Line);
end;


Function ScanPage (HtmlBody: string; LnkID : string) : {array [1..10] of} string;
var
  i : integer;  // simple iterator
  TempStr : string;  // temp string holder
  MainInfo : array[1..5] of string;  // Hold main info
  AddInfo : array[1..4] of string;  // Holding additional info 1-id; 2-Property name; 3-property text; 4-property value;
  StopPos : integer;
begin
  DataFoundUpd;
  CurrPosUpd;
  MainInfo[1] := LnkID;
  Harvy.Mem_PyOut.Clear;
  delete(HtmlBody, 1, ansipos('<div class="ocB w100">', HtmlBody)); {trimming unnecessary}
  delete(HtmlBody, ansipos('</tbody></table>', HtmlBody), length(HtmlBody));
  for i := 1 to 4 do  // Grabbing info
    {1st & 2nd lines has no system in data so grab manually, 3&4 - routine work}
    begin
      if (i = 1) and (ansipos(Const_GeneralInfo[1], HtmlBody) > 0) then
        TempStr := LineStrip(copy(HtmlBody, ansipos(Const_GeneralInfo[1], HtmlBody) + 19, ansipos('</h1>', HtmlBody)), '</')
      else if (i = 2) and (ansipos(Const_GeneralInfo[2], HtmlBody) > 0) then
        TempStr := LineStrip(copy(HtmlBody, ansipos(Const_GeneralInfo[2], HtmlBody) + 3, ansipos('</b>', HtmlBody)), '</')
      else if ansipos(Const_GeneralInfo[i], HtmlBody) > 0 then
        begin
          TempStr := copy(HtmlBody, ansipos(Const_GeneralInfo[i], HtmlBody) + length(Const_GeneralInfo[i]), ansipos('</tr>', HtmlBody));
          delete(TempStr, 1, ansipos(Const_PropDesc, TempStr) + 16);
          TempStr := LineStrip(TempStr, '</');
        end;
      MainInfo[i+1] := TempStr;  // writing data
    end;

  DataSorter(MainInfo, 5);

  StopPos := ansipos(MainInfo[5], HtmlBody) + length(MainInfo[5]);
  TempStr := copy(HtmlBody, StopPos, length(HtmlBody));

  while ansipos(Const_PropDesc, TempStr) > 0 do
  begin
    TempStr := copy(TempStr, ansipos(Const_PropName, TempStr) + 17, ansipos(Const_PropNameRU, TempStr));
    StopPos := StopPos + length(TempStr);

    AddInfo[1] := LnkID;
    AddInfo[2] := copy(TempStr, 1, ansipos('">', TempStr)-1);
    AddInfo[3] := LineStrip(copy(TempStr, ansipos(Const_PropNameRU, TempStr) + 16, ansipos('</td>', TempStr)), '</td>');
    StopPos := StopPos + ansipos(Const_PropNameRU, TempStr) + 16;
    AddInfo[4] := LineStrip(copy(TempStr, ansipos(Const_PropDesc, TempStr) + 16, ansipos('</td>', TempStr)), '</td>');

    TempStr := copy(HtmlBody, StopPos, length(HtmlBody));

    if (length(AddInfo[2]) <> 0) and (length(AddInfo[4]) <> 0)then
      DataSorter(AddInfo, 4);
  end;
end;


Function CreateInsText (data: array of string; len : integer) : string;
var
  i : integer;
  TempText : string;
begin
  if len = 4
    then TempText := Const_DetaildUpd
  else if len = 5
    then TempText := Const_GeneralUpd;

  for i := 0 to len - 2 do
    TempText := TempText + data[i] + ''',''';

  TempText := TempText + data[len-1] + ''');';
  result := TempText;
end;


end.
