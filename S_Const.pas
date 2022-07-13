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
  Const_GeneralInfo : array[1..4] of string = ('Процедура закупки №', '<b>',
    'Отрасль', 'Краткое описание предмета закупки');

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

implementation

end.
