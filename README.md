# HarvyToBase
 IceTrade parcer to form a procurement database for further local use.
 
 System requirements:
   for current settings of Python engine and used DLL (python310.dll) python v.3.10.5 x32 needed you may also install "requests" lib for normal work you can change it by playing w "Py_Engine" settings}

 DB short description:
   in general You can find DB files in project files (DBmodel.mwb - model file; GenerateShema.sql - file for creation of shema).
 Tables:
   badlinks - Table f only contains not working links, wich can become working w time
     | ID - inner id  |  BadLinkId - bad link it self 
   generalinfo - Table f general info storing
     | LinkID - link | DealID - ID in IceTrade structure | StatusInfo - Deal Status info | Industry - Deal lot industry | ShortDesc - short description of Lot for deal
   dealdetailedinfo - Table f all the founded info about deal
     | ID - auto increment id number | LinkID - PK f deal | PropertyName - Property name | PropertyValue - contain value it self
