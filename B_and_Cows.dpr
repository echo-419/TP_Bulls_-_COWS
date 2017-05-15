program B_and_Cows;

uses
  Vcl.Forms,
  Bulls_and_C in 'Bulls_and_C.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
