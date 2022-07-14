unit S_Const;
{It may be ugly, so hidden here )) }

interface

const
{Messages}
  Const_ErrDB = 'No connection to DB! Check DB parameters.';
  Const_ErrMail = 'Message wasn''t sent.';
  Const_MesReP = 'Re-parcing compleet, bad links (after re-parsing) saved.';
  Const_MesNoRep = 'Parcing compleet, badLinks was saved.';
  Const_WorkDone = 'Work done - parsing complete';

{Links}
  Const_IceLink = 'https://icetrade.by/tenders/all/view/';
  Const_DllLink = 'https://github.com/Tokeshy/HarvyToBase/raw/main/DLL/python310.dll';
  Const_FreeProxy = 'https://spys.one/en/';

{services}
  Const_PropName = '<tr class="af af-';
  Const_PropNameRU = '<td class="lft">';
  Const_PropDesc = '<td class="afv">';
  Const_StrToReplace : array[1..8] of string = ('&quot;', '<br />', '<strong>',
    '</strong>', '&nbsp;', '<span class="nw">', '</span>', Const_PropNameRU);  // traces of HTML to clean))
  Const_GeneralInfo : array[1..4] of string = ('��������� ������� �', '<b>',
    '�������', '������� �������� �������� �������');

{Py_Code section}
  Const_RequestPrefix = 'from requests import get' + #13#10;
  Const_ProxyNA = 'import requests' + #13#10 + 'session = requests.Session()'
    + #13#10 + 'session.proxies = {' + #13#10;
  Const_ProxyWA = '';

{MySQL section}
  Const_BLUpd = 'INSERT INTO `icetradesch`.`badlinks` (`BadLinkID`) VALUES (''';
  Const_DetaildUpd = 'INSERT INTO `icetradesch`.`dealdetailedinfo` (`LinkID`, `PropertyName`, `PropNameExt`, `PropertyValue`) VALUES (''';
  Const_GeneralUpd = 'INSERT INTO `icetradesch`.`generalinfo` (`LinkID`, `DealID`, `StatusInfo`, `Industry`, `ShortDesc`) VALUES (''';
  Const_BLDel = 'DELETE FROM `icetradesch`.`badlinks` WHERE (`ID` = ''';

{Elemets lists}
  Const_GRPBoxLst : array[1..3] of string = ('Grp_InfoGroup', 'Grp_ScanBox', 'Grp_DBParams');
  Const_LblLst : array[1..20] of string = ('Lbl_CurrPos', 'Lbl_DataFounded', 'Lbl_frc', 'Lbl_frf', 'Lbl_ScanFrom', 'Lbl_ScanTo',
    'Lbl_ProxyServer', 'Lbl_ProxyPort', 'Lbl_ProxyUsername', 'Lbl_ProxyPassword', 'Lbl_ProxyType', 'Lbl_MailHost', 'Lbl_MailUsername',
    'Lbl_MailPass', 'Lbl_MailPort', 'Lbl_MailTo', 'Lbl_DBServer', 'Lbl_DBUsername', 'Lbl_DBPort', 'Lbl_DBShema' );
  Const_BtnLst : array[1..4] of string = ('Btn_Scan', 'Btn_PickUpProxy', 'Btn_DBDisconnect', 'Btn_DBConnect');
  Const_ChckLst : array[1..4] of string = ('Chck_ReparseCheck', 'ChB_TestMode', 'Chck_UseProxy', 'Chck_Mailing');
  Const_PGCLst : array[1..4] of string = ('PG_ScanParams', 'PG_ProxyParams', 'PG_MailingParams', 'PG_DBConnectionParams');

{Translation}
  Const_GRPBTrLst : array[1..3] of array[0..1] of string = (('Information about the progress of the scan', '���������� � ���� ������������'),
    ('Scan range', '�������� ������������'), ('Current params', '������� �����.'));
  Const_LblTrLst : array[1..20] of array[0..1] of string = (('Current position:', '������� �������:'), ('Data founded:', '������� ������:'),
    ('from', '��'), ('from', '��'), ('Start index', '��������� ������'), ('Final index', '��������� ������'), ('Server', '������'),
    ('Port', '����'), ('Username', '��� �����.'), ('Password', '������'), ('Proxy type', '��� Proxy'), ('Host', '����'), ('Username', '��� �����.'),
    ('Password', '������'), ('Port', '����'), ('Mail to', '����������'), ('Server', '������'), ('Username', '��� �����.'), ('Port', '����'), ('Database','��� ��'));
  Const_BtnTrLst : array[1..4] of array[0..1] of string = (('Scan', '�����������'), ('Pick up proxy', '������. Proxy'),
    ('Disconnect', '����.'), ('Connect', '�����.'));
  Const_ChckTrLst : array[1..4] of array[0..1] of string = (('Bad link''s re-parse', '��������� Bad Link''��'), ('Test mode (no DB)', '�������� ����� (no DB)'),
    ('Use Proxy', '���. ������'), ('e-Mail alert', '����������� �� �����'));
  Const_PGCTrLst : array[1..4] of array[0..1] of string = (('Scan params', '������������'), ('Proxy', 'Proxy'), ('Notify', '�������.'), ('DB', '��'));

implementation

end.
