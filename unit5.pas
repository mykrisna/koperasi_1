unit Unit5;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFinputstock }

  TFinputstock = class(TForm)
    Button1: TButton;
    stok: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure stokKeyPress(Sender: TObject; var Key: char);
  private

  public

  end;

var
  Finputstock: TFinputstock;

implementation
uses
  dm;

{$R *.lfm}

{ TFinputstock }

procedure TFinputstock.Button1Click(Sender: TObject);
var
  rowid,uom : string;
begin
  rowid := dm1.dtbrg.FieldByName('rowid').AsString;
  uom := dm1.dtbrg.FieldByName('uom').AsString;
  if stok.Text = '0' then
  begin
    showmessage('Stok harus diisi');
  end else Begin
      if stok.Text = '' then
      begin
         showmessage('Stok harus diisi');
      end else Begin
         with dm1.sqlexec do begin
            close;
            sql.Clear;
            sql.Add('insert into tb_stock(id_brg,qty,uom,crdt) values('+quotedstr(rowid)+','+quotedstr(stok.Text)+','+quotedstr(uom)+',CURDATE())');
            execsql;
          end;
            stok.Text := '0';
            dm1.dtbrg.Refresh;
            close;
      end
  end;
end;

procedure TFinputstock.stokKeyPress(Sender: TObject; var Key: char);
var
  rowid,uom : string;
begin
  if not (key in['0'..'9',#8,#13,#32]) then
   begin
   key:=#0;
   showmessage('inputan hanya angka');
   end;

  if key = #13 then
  begin
      rowid := dm1.dtbrg.FieldByName('rowid').AsString;
  uom := dm1.dtbrg.FieldByName('uom').AsString;
  if stok.Text = '0' then
  begin
    showmessage('Stok harus diisi');
  end else Begin
      if stok.Text = '' then
      begin
         showmessage('Stok harus diisi');
      end else Begin
         with dm1.sqlexec do begin
            close;
            sql.Clear;
            sql.Add('insert into tb_stock(id_brg,qty,uom) values('+quotedstr(rowid)+','+quotedstr(stok.Text)+','+quotedstr(uom)+')');
            execsql;
          end;
            stok.Text := '0';
            dm1.dtbrg.Refresh;
            close;
      end
  end;
  end;
end;

end.

