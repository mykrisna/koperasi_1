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
  Forms, unit1, dm, zcomponent, unit2, unit4, unit5, indylaz, unit3, unit6,
  unit7
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='KoperasiTTA';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFlogin, Flogin);
  Application.CreateForm(Tdm1, dm1);
  Application.CreateForm(TFtr, Ftr);
  Application.CreateForm(TFbrg, Fbrg);
  Application.CreateForm(TFinputstock, Finputstock);
  Application.CreateForm(TFrep, Frep);
  Application.CreateForm(TFcekbrg, Fcekbrg);
  Application.CreateForm(TFpending, Fpending);
  //Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

