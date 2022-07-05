unit Main;

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
    LotMem: TMemo;
    DocsMem: TMemo;
    BadMemo: TMemo;
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
    Lbl_DBPassword: TLabel;
    Edt_DBPassword: TEdit;
    Lbl_DBPort: TLabel;
    Edt_DBPortNo: TEdit;
    Cmb_DBConnection: TComboBox;
    Lbl_DBShema: TLabel;
    Edt_MailTo: TEdit;
    Lbl_MailTo: TLabel;
    Btn_DBConnect: TButton;
    Btn_DBDisconnect: TButton;
    ChB_TestMode: TCheckBox;
    Mem_PyOut: TMemo;
    Py_Engine: TPythonEngine;
    Py_GUIInOut: TPythonGUIInputOutput;
    procedure Btn_ScanClick(Sender: TObject);
    procedure Edt_ScanToClick(Sender: TObject);
    procedure Edt_ScanFromClick(Sender: TObject);
    procedure Btn_OptionsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
var
  aLink, Link, a, M :String;
  BLL, BadP1 :textFile;
  i, TC, J :Integer;
  label GotoLabel;
begin
  {checking if connected to DB and is it test mode}
  if ShoudWeParce then
    LetSParse;

    {�������� � ������ ����������� DLL
    ������������� ��� ������� ���� �� ���������� � ����� � exe
    �������������� ���� ���� ������ ��� PythonEngine ��� ���� � DLL}

    {���������:
    ����� ��������� ������������ ������ ������ ������ ������ - x32 vs x 64
    ���� ��������� ���������� ��� �������  ����� � �� "�����"  �� �� ���� ����� ����� �������� requests}

  //showmessage(string(MainConnection. .Connected));
  {����� �������� ������ ������, ���� ��� ������ 16000 ������ � BadLink, ����� - ������� ������}
  {BadLink - ����� � ��}
  {������� = ID}
  {�������}
  {��������� �� ������������ BD}

   {����� ������ ��������
   ���� ������� - ���������� ��� �������� ������ ������������� ��}

  {ID � ��� ����, ����� ���� ������ ��������� � ����� ������
  }

  {������������ ���������� � ��:
  �������� ������ � ��������

  ������ �� ������� ������� � ���������� �������� - ��������� ��� ��������� ����� �������������:
  ��� �������  |  ��������� ��������
  ID  |  ��� �������  |  ������� ��������  |  �������� �������

  ID   |  PropertyName  |  PropertyValue:
  �������� � ���������
  �������� ���������� � �������� �������

  ���� (������� �������; ���������� ���������; ������)

  ���������� ���������}


  {��������� ����������:
  �������
  �������� ������� (����\���������)
  ���������

  �������� ����� ����� ����������� ������� ������ ���������� ��� + ���� ������������

  }

 { DataCount.Text:='0';
  PB.Max:=strtoint(ToEd.Text);
  PBED.Text:=ToEd.Text;
  aLink:='http://www.icetrade.by/tenders/all/view/';
  }

end;

end.
