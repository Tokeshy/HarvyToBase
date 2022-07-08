unit S_Const;
{It may be ugly, so hidden here )) }

interface

const
  IceLink = 'http://www.icetrade.by/tenders/all/view/';
  ErrDB = 'No connection to DB! Check DB parameters.';
  ErrMail = 'Message wasn''t sent.';
  MailMessageReP = 'Re-parcing compleet, bad links (after re-parsing) saved.';
  MailMessageNoRep = 'Parcing compleet, badLinks (no re-parsing) saved.';

  PropName = '<tr class="af af-';
  PropNameRU = '<td class="lft">';
  PropDesc = '<td class="afv">';

  StrToReplace : array[1..8] of string = ('&quot;', '<br />', '<strong>',
    '</strong>', '&nbsp;', '<span class="nw">', '</span>', PropNameRU);  // traces of HTML to clean))

  GeneralInfo : array[1..4] of string = ('Процедура закупки №', '<b>',
    'Отрасль', 'Краткое описание предмета закупки');

{Py_Code section}
  RequestPrefix = 'from requests import get' + #13#10;

{MySQL section}
  BLUpd = 'INSERT INTO `icetradesch`.`badlinks` (`BadLinkID`) VALUES (''';
  DetaildUpd = 'INSERT INTO `icetradesch`.`dealdetailedinfo` (`LinkID`, `PropertyName`, `PropNameExt`, `PropertyValue`) VALUES (''';
  GeneralUpd = 'INSERT INTO `icetradesch`.`generalinfo` (`LinkID`, `DealID`, `StatusInfo`, `Industry`, `ShortDesc`) VALUES (''';

implementation

end.
