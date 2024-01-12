unit Unit8;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids;

type

  { TFaudit }

  TFaudit = class(TForm)
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Faudit: TFaudit;

implementation
uses
  dm;

{$R *.lfm}

{ TFaudit }

procedure TFaudit.FormCreate(Sender: TObject);
begin

end;

end.

