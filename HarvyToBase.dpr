program HarvyToBase;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Harvy},
  S_Proc in 'S_Proc.pas',
  S_Func in 'S_Func.pas',
  Py_code in 'Py_code.pas',
  S_Const in 'S_Const.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THarvy, Harvy);
  Application.Run;
end.
