program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, unit1, dm, zcomponent, unit2, Unit3, unit4
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFlogin, Flogin);
  Application.CreateForm(Tdm1, dm1);
  Application.CreateForm(TFtr, Ftr);
  Application.CreateForm(TForm1, Form1);
  //Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

