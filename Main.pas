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
  IdIntercept, Vcl.PythonGUIInputOutput;

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

const
  IceLink = 'http://www.icetrade.by/tenders/all/view/';
  ErrDB = 'No connection to DB! Check DB parameters.';
  ErrMail = 'Message wasn''t sent.';
  MailMessageReP = 'Re-parcing compleet, bad links (after re-parsing) saved.';
  MailMessageNoRep = 'Parcing compleet, badLinks (no re-parsing) saved.';
implementation

{$R *.dfm}


{######################################################################}


function ParceIt (i:integer) :string;
var ind, shdesc, custom, ccont, ordprice, orderyear, link, Typeos, ordate, findate, startdate, PayerNo,
    lot, lott, amountPrice, place, Term, SceOfF, codeok, LotNo, lotCur,
    LNKtdk, RecNO, Cutted, PreCutted:string;
    lotCount, L, J, docCount, DC :integer;
begin
  icetable:=''; iceorder:=''; icedocs:='';
  icetable:='INSERT INTO `icetrade`.`icetable` (`ID`, `Industry`, `ShortDescription`, `Customer`, `CustomerContact`, `OrderDate`, `FinalDate`, `OrderPrice`, `Link`, `PayerNo`, `Type`) VALUES (';
 //iceorder:='INSERT INTO `icetrade`.`iceorder` (`IceID`, `lot`, `AmountPrice`, `Place`, `LotTerm`, `SourceOfFinance`, `Code`, `LotNo`) VALUES (';
 // icedocs:='INSERT INTO `icetrade`.`icedocs` (`idDocs`, `LinkToDoc`, `RecNo`) VALUES (';
   ind:=''; shdesc:=''; custom:=''; ccont:=''; ordprice:=''; orderyear:=''; link:=''; Typeos:='';
   ordate:=''; findate:=''; startdate:=''; PayerNo:='';
   lot:=''; amountPrice:=''; place:=''; Term:=''; SceOfF:=''; codeok:=''; LotNo:='';
   LNKtdk:=''; RecNO:='';
    ind:=at; shdesc:=at; custom:=at; ccont:=at; ordprice:=at; orderyear:=at; link:=at; Typeos:=at;
    ordate:=at; findate:=at; startdate:=at; PayerNo:=at;
    lot:=at; amountPrice:=at; place:=at; Term:=at; SceOfF:=at; codeok:=at; LotNo:=at;
    LNKtdk:=at; RecNO:=at;

    ////// iceTable
      icetable:=icetable+#039+inttostr(i)+#039+', '+#039;
        delete (ind, 1, (ansipos('�������',ind)-1));
        delete (ind, (ansipos('������� �������� �������� �������',ind)-1), Length(ind));
        delete (ind, 1, (ansipos('<td class="afv">',ind)+(Length('<td class="afv">'))));
        delete (ind, (ansipos('</td>',ind)-1), Length(ind));
        ind:= StringReplace(ind, #$9, '', [rfReplaceAll]); //������� ���������
        ind:= StringReplace(ind, '  ', '', [rfReplaceAll]); //������� ������ �������
          ind:=StringReplace(ind, #13, '', [rfReplaceAll, rfIgnoreCase]);
          ind:=StringReplace(ind, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
           ind:=StringReplace(ind, '&gt;', '\', [rfReplaceAll, rfIgnoreCase]);
      icetable:=icetable+ind+#039+', '+#039;

        delete (shdesc, 1, (ansipos('������� �������� �������� �������',shdesc)-1));
        delete (shdesc, (ansipos('�������� � ���������, ������������',shdesc)-1), Length(shdesc));
        delete (shdesc, 1, (ansipos('<td class="afv">',shdesc)+(Length('<td class="afv">'))));
        delete (shdesc, (ansipos('</td>',shdesc)-1), Length(shdesc));
        shdesc:= StringReplace(shdesc, #$9, '', [rfReplaceAll]); //������� ���������
        shdesc:= StringReplace(shdesc, '  ', '', [rfReplaceAll]); //������� ������ �������
          shdesc:=StringReplace(shdesc, #13, '', [rfReplaceAll, rfIgnoreCase]);
          shdesc:=StringReplace(shdesc, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
      icetable:=icetable+shdesc+#039+', '+#039;

      if ansipos('������ ������������',custom)>0 then
        begin
          Typeos:='��������';
          delete (custom, 1, (ansipos('������ ������������',custom)-1));
          delete (custom, (ansipos('�������, ����� � ��������,',custom)-1), Length(custom));
          delete (custom, 1, (ansipos('<td class="afv">',custom)+(Length('<td class="afv">'))));
          delete (custom, (ansipos('</td>',custom)-1), Length(custom));
          custom:= StringReplace(custom, #$9, '', [rfReplaceAll]); //������� ���������
          custom:= StringReplace(custom, '  ', '', [rfReplaceAll]); //������� ������ �������
            custom:=StringReplace(custom, #13, '', [rfReplaceAll, rfIgnoreCase]);
            custom:=StringReplace(custom, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
            custom:=StringReplace(custom, '<br>', ';', [rfReplaceAll, rfIgnoreCase]);
                delete (ccont, 1, (ansipos('�������, ����� � ��������, ������ ��������� ����������',ccont)-1));
                delete (ccont, (ansipos('�������� ���������� �� ��������� �������',ccont)-1), Length(ccont));
                delete (ccont, 1, (ansipos('<td class="afv">',ccont)+(Length('<td class="afv">'))));
                delete (ccont, (ansipos('</td>',ccont)-1), Length(ccont));
                ccont:= StringReplace(ccont, #$9, '', [rfReplaceAll]); //������� ���������
                ccont:= StringReplace(ccont, '  ', '', [rfReplaceAll]); //������� ������ �������
	                ccont:=StringReplace(ccont, #13, '', [rfReplaceAll, rfIgnoreCase]);
                  ccont:=StringReplace(ccont, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
                  ccont:= StringReplace(ccont, '<br>', ';', [rfReplaceAll, rfIgnoreCase]);
                    delete (ordate, 1, (ansipos('���� ���������� �����������',ordate)-1));
                    delete (ordate, (ansipos('���� � ����� ������ ������ �����������',ordate)-1), Length(ordate));
                    delete (ordate, 1, (ansipos('<td class="afv">',ordate)+(Length('<td class="afv">'))));
                    delete (ordate, (ansipos('</td>',ordate)-1), Length(ordate));
                    ordate:= StringReplace(ordate, #$9, '', [rfReplaceAll]); //������� ���������
                    ordate:= StringReplace(ordate, '  ', '', [rfReplaceAll]); //������� ������ �������
                    ordate:=StringReplace(ordate, #13, '', [rfReplaceAll, rfIgnoreCase]);
                    ordate:=StringReplace(ordate, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
                    ordate:=string(formatdatetime('yyyy-mm-dd', strtodate(ordate)));
        end else
          begin
            Typeos:='�����������';
            delete (custom, 1, (ansipos('������������ ������������ �����������',custom)-1));
            delete (custom, (ansipos('�������, ��� � ��������,',custom)-1), Length(custom));
            delete (custom, 1, (ansipos('<td class="afv">',custom)+(Length('<td class="afv">'))));
            delete (custom, (ansipos('</td>',custom)-1), Length(custom));
            custom:= StringReplace(custom, #$9, '', [rfReplaceAll]); //������� ���������
            custom:= StringReplace(custom, '  ', '', [rfReplaceAll]); //������� ������ �������
              custom:=StringReplace(custom, #13, '', [rfReplaceAll, rfIgnoreCase]);
              custom:=StringReplace(custom, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
              custom:=StringReplace(custom, '<br>', ';', [rfReplaceAll, rfIgnoreCase]);
                delete (ccont, 1, (ansipos('�������, ��� � �������� (���� ������� �������) �������������� ����',ccont)-1));
                delete (ccont, (ansipos('�������� ���������� �� ��������� �������',ccont)-1), Length(ccont));
                delete (ccont, 1, (ansipos('<td class="afv">',ccont)+(Length('<td class="afv">'))));
                delete (ccont, (ansipos('</td>',ccont)-1), Length(ccont));
                ccont:= StringReplace(ccont, #$9, '', [rfReplaceAll]); //������� ���������
                ccont:= StringReplace(ccont, '  ', '', [rfReplaceAll]); //������� ������ �������
                ccont:= StringReplace(ccont, '<br>', ';', [rfReplaceAll, rfIgnoreCase]);
	                ccont:=StringReplace(ccont, #13, '', [rfReplaceAll, rfIgnoreCase]);
                  ccont:=StringReplace(ccont, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
                    delete (ordate, 1, (ansipos('���� ���������� �����������',ordate)-1));
                    delete (ordate, (ansipos('���� � ����� ������ ������ �����������',ordate)-1), Length(ordate));
                    delete (ordate, 1, (ansipos('<td class="afv">',ordate)+(Length('<td class="afv">'))));
                    delete (ordate, (ansipos('</td>',ordate)-1), Length(ordate));
                    ordate:= StringReplace(ordate, #$9, '', [rfReplaceAll]); //������� ���������
                    ordate:= StringReplace(ordate, '  ', '', [rfReplaceAll]); //������� ������ �������
                    ordate:=StringReplace(ordate, #13, '', [rfReplaceAll, rfIgnoreCase]);
                    ordate:=StringReplace(ordate, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
                    ordate:=string(formatdatetime('yyyy-mm-dd', strtodate(ordate)));
          end;
      icetable:=icetable+custom+#039+', '+#039+ccont+#039+', '+#039+ordate+#039+', '+#039;

      if ansipos('����� ������ �����������',findate)>0 then
      begin
        delete (findate, 1, (ansipos('���� � ����� ��������� ������ �����������',findate)-1));
        delete (findate, (ansipos('����� ������ �����������',findate)-1), Length(findate));
        delete (findate, 1, (ansipos('<td class="afv">',findate)+(Length('<td class="afv">'))));
          if ansipos('&nbsp;',findate)>0 then delete (findate, (ansipos('&nbsp;',findate)), Length(findate));
          if ansipos('</td>',findate)>0 then delete (findate, (ansipos('</td>',findate)), Length(findate));
        findate:= StringReplace(findate, #$9, '', [rfReplaceAll]); //������� ���������
        findate:= StringReplace(findate, '  ', '', [rfReplaceAll]); //������� ������ �������
         findate:=StringReplace(findate, #13, '', [rfReplaceAll, rfIgnoreCase]);
         findate:=StringReplace(findate, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
        findate:=string(formatdatetime('yyyy-mm-dd', strtodate(findate)));
      end else if (ansipos('����� ��������������� ��������� �������',findate)>0) then
        begin
          delete (findate, 1, (ansipos('���� � ����� ��������� ������ �����������',findate)-1));
          delete (findate, (ansipos('����� ��������������� ��������� �������',findate)-1), Length(findate));
          delete (findate, 1, (ansipos('<td class="afv">',findate)+(Length('<td class="afv">'))));
            if ansipos('&nbsp;',findate)>0 then delete (findate, (ansipos('&nbsp;',findate)), Length(findate));
            if ansipos('</td>',findate)>0 then delete (findate, (ansipos('</td>',findate)), Length(findate));
          findate:= StringReplace(findate, #$9, '', [rfReplaceAll]); //������� ���������
          findate:= StringReplace(findate, '  ', '', [rfReplaceAll]); //������� ������ �������
           findate:=StringReplace(findate, #13, '', [rfReplaceAll, rfIgnoreCase]);
           findate:=StringReplace(findate, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
          findate:=string(formatdatetime('yyyy-mm-dd', strtodate(findate)));
        end;
      icetable:=icetable+findate+#039+', '+#039;

     if (ansipos('����� ��������������� ��������� �������',ordprice)>0) then
     begin
        delete (ordprice, 1, (ansipos('����� ��������������� ��������� �������',ordprice)-1));
        delete (ordprice, (ansipos('���������� � ������� ����������',ordprice)-1), Length(ordprice));
          delete (ordprice, 1, (ansipos('<span class="nw">',ordprice)+(Length('<span class="nw">')-1)));
          delete (ordprice, (ansipos('</span>',ordprice)), Length(ordprice));
        ordprice:= StringReplace(ordprice, #$9, '', [rfReplaceAll]); //������� ���������
        ordprice:= StringReplace(ordprice, '  ', '', [rfReplaceAll]); //������� ������ �������
        ordprice:= StringReplace(ordprice, ' ', '', [rfReplaceAll]); //������� ������ �������
          ordprice:=StringReplace(ordprice, #13, '', [rfReplaceAll, rfIgnoreCase]);
          ordprice:=StringReplace(ordprice, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
          if length(trim(ordprice))<1 then ordprice:='-';
     end else if (ansipos('���� ���������� ������������ � ������������',ordprice)>0) then
        begin
          delete (ordprice, 1, (ansipos('���� ���������� ������������ � ������������ ��� ���������������� ����������������� ������ ����������',ordprice)-1));
          delete (ordprice, (ansipos('���� � ����� ��������� ������ �����������',ordprice)-1), Length(ordprice));
          delete (ordprice, 1, (ansipos('<span class="nw">',ordprice)+(Length('<span class="nw">')-1)));
          delete (ordprice, (ansipos('</span>',ordprice)), Length(ordprice));
          ordprice:= StringReplace(ordprice, #$9, '', [rfReplaceAll]); //������� ���������
          ordprice:= StringReplace(ordprice, '  ', '', [rfReplaceAll]); //������� ������ �������
          ordprice:= StringReplace(ordprice, ' ', '', [rfReplaceAll]); //������� ������ �������
          ordprice:=StringReplace(ordprice, #13, '', [rfReplaceAll, rfIgnoreCase]);
          ordprice:=StringReplace(ordprice, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
          if length(trim(ordprice))<1 then ordprice:='-';
        end;
     icetable:=icetable+ordprice+#039+', '+#039+'http://www.icetrade.by/tenders/all/view/'+inttostr(i)+#039+', '+#039;

     if Typeos='��������' then
     begin
      PayerNo:=trim(custom);
      delete (PayerNo, 1, (length(PayerNo)-9));
     end else if  Typeos='�����������' then PayerNo:=' - ';
      icetable:=icetable+PayerNo+#039+', '+#039+Typeos+#039+');';
    //////// iceTable ends
    //////// iceorder comes
    Harvy.LotMem.Clear;
    delete (lot, 1, (ansipos('<td colspan="2" id="lotsContainer" style="padding:0px;">',lot)-1));
    delete (lot, (ansipos(('$('+#039+'#lots_list #all'+#039+').click(function(){'),lot)-1), Length(ordprice));
    lott:=lot;
    lotCount:=0;
      while pos('<tr id="lotRow',lott)>0 do
      begin
        lotCount:=lotCount+1;
        delete(lott,pos('<tr id="lotRow',lott),length('<tr id="lotRow'));
      end;
      for L := 1 to lotCount do
        begin
          lott:=lot;
          if L<lotCount then
          begin
              delete (lott, 1, (ansipos('<tr id="lotRow'+inttostr(L), lott))-1);
              delete (lott, (ansipos('<tr id="lotRow'+inttostr(L+1), lott)-1), Length(lott)); // ������ ��� ��� ������
             // showmessage('way1');
          end else if L=lotCount then
           begin
              delete (lott, 1, (ansipos('<tr id="lotRow'+inttostr(L), lott))-1);
              delete (lott, (ansipos(('#lots_list #all'),lott)-1), Length(lott));
             //  showmessage('way2');
           end;
          lotCur:=lott;
          delete (lotCur, 1, (ansipos('<td class="">',lotCur)+length('<td class="">')));
          delete (lotCur, (ansipos('</td>',lotCur)), Length(lotCur));
              lotCur:= StringReplace(lotCur, #$9, '', [rfReplaceAll]); //������� ���������
              lotCur:=StringReplace(lotCur, #13, '', [rfReplaceAll, rfIgnoreCase]);
              lotCur:=StringReplace(lotCur, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
              lotCur:=StringReplace(lotCur, '<br>', ';', [rfReplaceAll, rfIgnoreCase]);

          iceorder:='INSERT INTO `icetrade`.`iceorder` (`IceID`, `lot`, `AmountPrice`, `Place`, `LotTerm`, `SourceOfFinance`, `Code`, `LotNo`) VALUES ('+#039+inttostr(i)+#039+', '+#039+trim(lotCur)+#039+', '+#039;

          amountPrice:=lott;
        delete (amountPrice, 1, (ansipos('<span class="nw">',amountPrice)+length('<span class="nw">')-1));
        delete (amountPrice, (ansipos('</td>',amountPrice)), Length(amountPrice));
          amountPrice:=StringReplace(amountPrice, #13, '', [rfReplaceAll, rfIgnoreCase]);
          amountPrice:=StringReplace(amountPrice, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
            amountPrice:=StringReplace(amountPrice, ' ', '', [rfReplaceAll, rfIgnoreCase]);
            amountPrice:= StringReplace(amountPrice, #$9, '', [rfReplaceAll]); //������� ���������
            amountPrice:=StringReplace(amountPrice, '</span>&nbsp;', ' ', [rfReplaceAll, rfIgnoreCase]);
            amountPrice:=StringReplace(amountPrice, '<br>', '', [rfReplaceAll, rfIgnoreCase]);
            amountPrice:=StringReplace(amountPrice, '<br/>', '', [rfReplaceAll, rfIgnoreCase]);
            amountPrice:=StringReplace(amountPrice, ',<spanclass="nw">', '; ', [rfReplaceAll, rfIgnoreCase]);
            amountPrice:=StringReplace(amountPrice, '<spanclass="nw">', '; ', [rfReplaceAll, rfIgnoreCase]);

          if length(trim(amountPrice))<1 then amountPrice:='-';
          iceorder:=iceorder+trim(amountPrice)+#039+', '+#039;
        if L=1 then
        begin
        place:=lott;
        if (ansipos('����� �������� ������, ���������� �����, �������� �����',Place)>0) then
          begin
        delete (place, 1, (ansipos('����� �������� ������, ���������� �����, �������� �����',place)-1));
        delete (place, (ansipos('�������� ��������������',place)-1), Length(place));
        delete (place, 1, (ansipos('<div>',place)+(Length('<div>')-1)));
        delete (place, (ansipos('</div>',place)), Length(place));
          place:=StringReplace(place, #13, '', [rfReplaceAll, rfIgnoreCase]);
          place:=StringReplace(place, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
            place:=StringReplace(place, '&nbsp;', ' ', [rfReplaceAll, rfIgnoreCase]);
            place:=StringReplace(place, '<br>', '', [rfReplaceAll, rfIgnoreCase]);
            place:=StringReplace(place, '<span class="nw">', '; ', [rfReplaceAll, rfIgnoreCase]);
          if length(trim(place))<1 then amountPrice:='-';
        end else if (ansipos('����� ���������� ������',Place)>0) then
          begin
          delete (place, 1, (ansipos('����� ���������� ������',place)-1));
          delete (place, 1, (ansipos('<div>',place)+(Length('<div>')-1)));
          delete (place, (ansipos('</div>',place)), Length(place));
          place:=StringReplace(place, #13, '', [rfReplaceAll, rfIgnoreCase]);
          place:=StringReplace(place, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
            place:=StringReplace(place, '&nbsp;', ' ', [rfReplaceAll, rfIgnoreCase]);
            place:=StringReplace(place, '<br>', '', [rfReplaceAll, rfIgnoreCase]);
            place:=StringReplace(place, '<span class="nw">', '; ', [rfReplaceAll, rfIgnoreCase]);
          if length(trim(place))<1 then amountPrice:='-';
           end;
          end;
         if L<>1 then place:='-';

          iceorder:=iceorder+trim(place)+#039+', '+#039;

         if L=1 then
        begin
          Term:=lott;
          if (ansipos('���� ���������� ������',Term)>0) then
          begin
            delete (Term, 1, (ansipos('���� ���������� ������',Term)-1));
            delete (Term, 1, (ansipos('<div>',Term)+(Length('<div>'))));
            delete (term, ansipos('</div>', Term), length(Term));
              Term:= StringReplace(Term, #$9, '', [rfReplaceAll]); //������� ���������
              Term:= StringReplace(Term, '  ', '', [rfReplaceAll]); //������� ������ �������
              Term:=StringReplace(Term, #13, '', [rfReplaceAll, rfIgnoreCase]);
              Term:=StringReplace(Term, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
              Term:=StringReplace(Term, '<br>', ';', [rfReplaceAll, rfIgnoreCase]);
              Term:=StringReplace(Term, '/th> <td colspan="3" >', ';', [rfReplaceAll, rfIgnoreCase]);
            end else if (ansipos('���� ��������',Term)>0) then
            begin
              delete (Term, 1, (ansipos('���� ��������',Term)-1));
              delete (Term, 1, (ansipos('<td colspan="3">',Term)+(Length('<td colspan="3">'))));
              delete (term, ansipos('</td>', Term), length(Term));
                Term:= StringReplace(Term, #$9, '', [rfReplaceAll]); //������� ���������
                Term:= StringReplace(Term, '  ', '', [rfReplaceAll]); //������� ������ �������
                Term:=StringReplace(Term, #13, '', [rfReplaceAll, rfIgnoreCase]);
                Term:=StringReplace(Term, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
                Term:=StringReplace(Term, '<br>', ';', [rfReplaceAll, rfIgnoreCase]);
                Term:=StringReplace(Term, '/th> <td colspan="3" >', ';', [rfReplaceAll, rfIgnoreCase]);
            end;
        end;
        if L<>1 then Term:='-';
           iceorder:=iceorder+trim(Term)+#039+', '+#039;

        if L=1 then
        begin
        SceOfF:=lott;
          delete (SceOfF, 1, (ansipos('�������� ��������������',SceOfF)-1));
          delete (SceOfF, 1, (ansipos('<div>',SceOfF)+(Length('<div>'))));
          delete (SceOfF, ansipos('</div>', SceOfF), length(SceOfF));
            SceOfF:= StringReplace(SceOfF, #$9, '', [rfReplaceAll]); //������� ���������
            SceOfF:= StringReplace(SceOfF, '  ', '', [rfReplaceAll]); //������� ������ �������
            SceOfF:=StringReplace(SceOfF, #13, '', [rfReplaceAll, rfIgnoreCase]);
            SceOfF:=StringReplace(SceOfF, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
            SceOfF:=StringReplace(SceOfF, '<br>', ';', [rfReplaceAll, rfIgnoreCase]);
        end;
        if L<>1 then SceOfF:='-';
        iceorder:=iceorder+SceOfF+#039+', '+#039;

        if L=1 then
        begin
        codeok:=lott;
          delete (codeok, 1, (ansipos('��� ����',codeok)-1));
          delete (codeok, 1, (ansipos('<td colspan="3">',codeok)+(Length('<td colspan="3">'))));
          delete (codeok, ansipos('</td>', codeok), length(codeok));
            codeok:= StringReplace(codeok, #$9, '', [rfReplaceAll]); //������� ���������
            codeok:= StringReplace(codeok, '  ', '', [rfReplaceAll]); //������� ������ �������
            codeok:=StringReplace(codeok, #13, '', [rfReplaceAll, rfIgnoreCase]);
            codeok:=StringReplace(codeok, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
            codeok:=StringReplace(codeok, '<br>', ';', [rfReplaceAll, rfIgnoreCase]);
              codeok:=StringReplace(codeok, '<div>', '', [rfReplaceAll, rfIgnoreCase]);
              codeok:=StringReplace(codeok, '</div>', '', [rfReplaceAll, rfIgnoreCase]);
              codeok:=StringReplace(codeok, '<tdcolspan="3">', '', [rfReplaceAll, rfIgnoreCase]);
        end;
        if L<>1 then codeok:='-';
        iceorder:=iceorder+trim(codeok)+#039+', '+#039+inttostr(L)+#039+');';
          Harvy.LotMem.lines.add(iceorder); {����������� ������ ����� �����}
        end;
    //////// iceOrder ends
    //////// iceDocs comes
    Harvy.DocsMem.Clear;
    LNKtdk:=at;
    if (ansipos('<td class="vac af af-files files afv">',LNKtdk)>0) then
    begin
      PreCutted:='';
      delete(LNKtdk, 1, ansipos('<td class="vac af af-files files afv">', LNKtdk)-length('<td class="vac af af-files files afv">'));   // added
      cutted:=LNKtdk;
      DocCount:=0;
      while pos('<td class="vac af af-files files afv">',LNKtdk)>0 do
      begin
        DocCount:=DocCount+1;
        delete(LNKtdk,pos('<td class="vac af af-files files afv">',LNKtdk),length('<td class="vac af af-files files afv">'));
      end;
      for DC := 1 to DocCount do
      begin
        icedocs:='INSERT INTO `icetrade`.`icedocs` (`idDocs`, `LinkToDoc`, `RecNo`) VALUES (';
        icedocs:=icedocs+#039+inttostr(i)+#039+', '+#039;

        if PreCutted='' then
          begin
            if (ansipos('<a target="blank" href="',LNKtdk)>0) then
            begin
              delete(cutted, 1, (ansipos('<a target="blank" href="',cutted)+length('<a target="blank" href="'))-1);
              delete(cutted, ansipos('n=',cutted)+2, length(cutted));
              cutted:=StringReplace(cutted, 'amp;', '', [rfReplaceAll, rfIgnoreCase]);
              PreCutted:=cutted;
              cutted:=cutted+inttostr(DC-1);
            end else  if (ansipos('<a class="modal" href="',LNKtdk)>0) then
            begin
              delete(cutted, 1, (ansipos('<a class="modal" href="',cutted)+length('<a class="modal" href="'))-1);
              delete(cutted, ansipos('n=',cutted)+2, length(cutted));
              cutted:=StringReplace(cutted, 'amp;', '', [rfReplaceAll, rfIgnoreCase]);
              PreCutted:=cutted;
              cutted:=cutted+inttostr(DC-1);
            end;
          end else begin
            cutted:=PreCutted+inttostr(DC-1);
          end;
          icedocs:=icedocs+cutted+#039+', '+#039+inttostr(DC)+#039+');';
          Harvy.DocsMem.Lines.Add(trim(icedocs));
      end;

    end;
end;

/////////////////

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

    {�������� � ������ DLL
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

  ������ �� ������� ������� � ���������� �������� - ��������� ��� ��������� ����� �������������}


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
  AssignFile(BLL, 'c:\BadLinks.txt');
  Rewrite(BLL);
   for i:=strtoint(FromEd.Text) to strtoint(ToEd.Text) do begin
    PB.Position:=i;
      try
       // Delay (2000); // ������� ��� ������ ����������
        CurPosEd.Text:=inttostr(i);
        DCED.Text:=inttostr(i);
        Link:=aLink+inttostr(i);
        a:=dfr.Get(Link);
        at:=a;
         if (ansipos('�������',at)>0) Then
          begin
            DataCount.Text:=inttostr(strtoint(DataCount.Text)+1);
            parceIt(i);
              AddCommand.SQL.Clear;
              AddCommand.SQL.Text:=icetable;
              AddCommand.Execute;
              Delay(10);
                for J := 0 to LotMem.Lines.Count-1 do
                  begin
                    AddCommand.SQL.Clear;
                    AddCommand.SQL.Text:=Harvy.LotMem.Lines[J];
                    AddCommand.Execute;
                    Delay(10);
                  end;
                 if DocsMem.Lines.Count>0 then
                  for J := 0 to DocsMem.Lines.Count-1 do
                   begin
                    AddCommand.SQL.Clear;
                    AddCommand.SQL.Text:=DocsMem.Lines[J];
                    AddCommand.Execute;
                    Delay(10);
                   end;
          end;


          except
        Writeln(BLL,inttostr(i));
      end;
  end;

    Append(BLL);
    CloseFile(BLL);
    // ReParse
    if ReparseCheck.Checked = true then begin
      AssignFile(BadP1, 'c:\BadLinksActual.txt');
      Rewrite(BadP1);
      BadMemo.Lines.LoadFromFile('c:\BadLinks.txt');
      PB.Max:=BadMemo.Lines.Count;
      PBED.Text:=inttostr(PB.Max);
      aLink:=icelink;
        for i:= 0 to BadMemo.Lines.Count do begin
        try
          Link:=aLink+BadMemo.Lines[i];
          a:=dfr.Get(Link);
          at:=a;
          if (ansipos('�������',at)>0) Then
          begin
            DataCount.Text:=inttostr(strtoint(DataCount.Text)+1);
            parceIt(i);
              AddCommand.SQL.Clear;
              AddCommand.SQL.Text:=icetable;
              AddCommand.Execute;
              Delay(10);
                for J := 0 to LotMem.Lines.Count-1 do
                  begin
                    AddCommand.SQL.Clear;
                    AddCommand.SQL.Text:=Harvy.LotMem.Lines[J];
                    AddCommand.Execute;
                    Delay(10);
                  end;
                 if DocsMem.Lines.Count>0 then
                  for J := 0 to DocsMem.Lines.Count-1 do
                   begin
                    AddCommand.SQL.Clear;
                    AddCommand.SQL.Text:=DocsMem.Lines[J];
                    AddCommand.Execute;
                    Delay(10);
                   end;
          end;
            except
      Writeln(BadP1, BadMemo.Lines[i]);
     end;
  end;
   Append(BadP1);
   CloseFile(BadP1);}

end;

end.
