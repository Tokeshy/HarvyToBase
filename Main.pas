unit Main;
{System requirements:
for current settings of Python engine and used DLL (python310.dll)
python v.3.10.5 x32 needed you may also install "requests" lib for normal work
you can change it by playing w "Py_Engine" settings}

{DB short description:
in general You can find DB files in project files (DBmodel.mwb - model file;
GenerateShema.sql - file for creation of shema).
tables:
badlinks - Table f only contains not working links, wich can become working w time
    | ID - inner id  |  BadLinkId - bad link it self
generalinfo - Table f general info storing
    | LinkID - link | DealID - ID in IceTrade structure  | StatusInfo - Deal Status info
    | Industry - Deal lot industry  | ShortDesc - short description of Lot for deal
dealdetailedinfo - Table f all the founded info about deal
    | ID - auto increment id number  | LinkID - PK f deal | PropertyName - Property name
    | PropertyValue - contain value it self
 }
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, DBAccess, MyAccess, Data.DB, IdAntiFreezeBase, Vcl.IdAntiFreeze,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  Vcl.ComCtrls, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP, IdMessage, IdUserPassProvider, MyDacVcl, S_Func, S_Proc, PythonEngine,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdIntercept, Vcl.PythonGUIInputOutput, S_Const;

type
  THarvy = class(TForm)
    MainConnection: TMyConnection;
    AddCommand: TMyCommand;
    Btn_Scan: TButton;
    Lbl_CurrPos: TLabel;
    Lbl_DataFounded: TLabel;
    Edt_DataFounded: TEdit;
    Edt_CurrPos: TEdit;
    Lbl_frf: TLabel;
    Lbl_frc: TLabel;
    Edt_LinkScaned: TEdit;
    Edt_Total: TEdit;
    PB_TotalProgress: TProgressBar;
    Grp_ScanBox: TGroupBox;
    Edt_ScanFrom: TEdit;
    Edt_ScanTo: TEdit;
    Lbl_ScanFrom: TLabel;
    Lbl_ScanTo: TLabel;
    InfoGroup: TGroupBox;
    Chck_ReparseCheck: TCheckBox;
    IdMessage: TIdMessage;
    IdSMTP: TIdSMTP;
    Btn_Options: TButton;
    PgC_Params: TPageControl;
    PG_ScanParams: TTabSheet;
    PG_ProxyParams: TTabSheet;
    Lbl_ProxyServer: TLabel;
    Lbl_ProxyPort: TLabel;
    Lbl_ProxyUsername: TLabel;
    Lbl_ProxyPassword: TLabel;
    Edt_ProxyServerIP: TEdit;
    Edt_ProxyPortNo: TEdit;
    Edt_ProxyUsername: TEdit;
    Edt_ProxyPassword: TEdit;
    Chck_UseProxy: TCheckBox;
    PG_MailingParams: TTabSheet;
    Edt_MailHost: TEdit;
    Lbl_MailHost: TLabel;
    Lbl_MailUsername: TLabel;
    Edt_MailUsername: TEdit;
    Lbl_MailPass: TLabel;
    Edt_MailPass: TEdit;
    Chck_Mailing: TCheckBox;
    Lbl_MailPort: TLabel;
    Edt_MailPort: TEdit;
    PG_DBConnectionParams: TTabSheet;
    Lbl_DBServer: TLabel;
    Edt_DBServerIP: TEdit;
    Lbl_DBUsername: TLabel;
    Edt_DBUsername: TEdit;
    Lbl_DBPort: TLabel;
    Edt_DBPortNo: TEdit;
    Lbl_DBShema: TLabel;
    Edt_MailTo: TEdit;
    Lbl_MailTo: TLabel;
    Btn_DBConnect: TButton;
    Btn_DBDisconnect: TButton;
    ChB_TestMode: TCheckBox;
    Mem_PyOut: TMemo;
    Py_Engine: TPythonEngine;
    Py_GUIInOut: TPythonGUIInputOutput;
    Edt_Schema: TEdit;
    Grp_DBParams: TGroupBox;
    procedure Btn_ScanClick(Sender: TObject);
    procedure Edt_ScanToClick(Sender: TObject);
    procedure Edt_ScanFromClick(Sender: TObject);
    procedure Btn_OptionsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Btn_DBConnectClick(Sender: TObject);
    procedure Btn_DBDisconnectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Harvy: THarvy;
  at, icetable, iceorder, icedocs : String;

implementation

{$R *.dfm}


{######################################################################}

procedure THarvy.Edt_ScanToClick(Sender: TObject);
begin
  Edt_ScanTo.Clear;
end;

procedure THarvy.Btn_DBConnectClick(Sender: TObject);
begin
  with MainConnection do
    begin
      if connected
        then connected := False;
      try
        connected := True;
        Edt_DBServerIP.Text := server;
        Edt_DBUsername.Text := username;
        Edt_DBPortNo.Text := inttostr(port);
        Edt_Schema.Text := database;
        messagedlg('Connection succeeded.', mtInformation, [mbOK], 0);
      except
        messagedlg('Failed to connect to DB.', mtError, [mbOK], 0);
      end;
    end;
end;

procedure THarvy.Btn_DBDisconnectClick(Sender: TObject);
begin
  if MainConnection.Connected
    then MainConnection.Connected := False;
  messagedlg('Disconnected from DB.', mtInformation, [mbOK], 0);
end;

procedure THarvy.Btn_OptionsClick(Sender: TObject);
begin
  if Btn_Options.Caption = '>>>' then
    ExpDefSize
  else
    RestoreDefSize;
end;


procedure THarvy.FormShow(Sender: TObject);
begin
  RestoreDefSize;
end;


procedure THarvy.Edt_ScanFromClick(Sender: TObject);
begin
  Edt_ScanFrom.Clear;
end;


procedure THarvy.Btn_ScanClick(Sender: TObject);
begin
  {checking if connected to DB and is it test mode}
  if ShoudWeParce then
    LetSParse;

    {�������� � ������ ����������� DLL
    ������������� ��� ������� ���� �� ���������� � ����� � exe
    �������������� ���� ���� ������ ��� PythonEngine ��� ���� � DLL}

  //showmessage(string(MainConnection. .Connected));
  {����� �������� ������ ������, ���� ��� ������ 16000 ������ � BadLink, ����� - ������� ������}
  {BadLink - ����� � ��}
  {������� = ID}
  {�������}
  {��������� �� ������������ BD}


  {ID � ��� ����, ����� ���� ������ ��������� � ����� ������
  }


  { ������� ����� ��� ��������� ������ (� ����� � �� �����))  }

 { DataCount.Text:='0';
  PB.Max:=strtoint(ToEd.Text);
  PBED.Text:=ToEd.Text;
  aLink:='http://www.icetrade.by/tenders/all/view/';
  }

end;

end.
