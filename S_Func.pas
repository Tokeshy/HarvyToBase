unit S_Func;

interface
  Function ShoudWeParce : boolean;  // +
  Function MailNotify : Boolean;  // +
  Function ScanPage (HtmlBody: string) : {array[1..10] of }string;  {�������� ������ ���������� �������� ������
  ������ �� ����� �������� ������ ��������, � ��������������� ����� �� ������ ���������}

implementation
uses
  Main, S_Proc, Py_code, Vcl.Dialogs, System.SysUtils;


Function ShoudWeParce : boolean;
{checking if we can parse in normal or test mode
 checking DB connection and TestMode flag
 if False - can't Parce}
begin
  if Harvy.ChB_TestMode.Checked = True Then
      result := True
  else if not Harvy.MainConnection.Connected then
    begin
      MessageDlg(ErrDB, mtError, [mbOk] , 0);
      result := False
    end;
end;


Function MailNotify : boolean;
{If needed send message to email as task complete alert}
var
  MessageText : string;
begin
  if harvy.Chck_ReparseCheck.Checked = True then
    MessageText := MailMessageReP
  else
    MessageText := MailMessageNoReP;

  MessageText := MessageText + ' Where found ' + Harvy.Edt_DataFounded.Text + ' data records from ' + Harvy.Edt_LinkScaned.Text + ' links.';

  with Harvy.IdSMTP do
  begin  // Setting up Mailing params
    Host := Harvy.Edt_MailHost.Text;  // Mail host; f.e. - 'smtp.Rambler.ru';
    Username := Harvy.Edt_MailUsername.Text;  // Sender username //  'PtahinEugen@Rambler.ru';
    Password := Harvy.Edt_MailPass.Text;  // 'Vakamaka4';
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
      MessageDlg(ErrMail, mtError, [mbOk] , 0);  // if not succeed
      result := False;
    end;
  end;
end;


Function ScanPage (HtmlBody: string) : {array [1..10] of} string;
begin


end;

end.
