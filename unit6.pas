unit Unit6;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBGrids;

type

  { TFcekbrg }

  TFcekbrg = class(TForm)
    cari: TEdit;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    procedure cariKeyPress(Sender: TObject; var Key: char);
    procedure DBGrid1DblClick(Sender: TObject);
  private

  public

  end;

var
  Fcekbrg: TFcekbrg;

implementation
uses
  dm,unit2;
{$R *.lfm}

{ TFcekbrg }

procedure TFcekbrg.cariKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
  begin
        try
          with dm1.dtcaribrg do begin
            close;
            sql.Clear;
            sql.Add('select * from (SELECT A.rowid,A.kd_brg,A.nama_brg,(ifnull(B.stock,0) - ifnull(jual,0)) AS stock,A.uom,A.sts,A.harga_beli,A.harga_jual,(A.harga_jual - A.harga_beli) AS defiasi '+
                    'FROM tb_brg A '+
                    'LEFT JOIN (SELECT id_brg,SUM(qty) AS stock FROM tb_stock GROUP BY id_brg)B ON B.id_brg = A.rowid '+
                    'LEFT JOIN (SELECT id_brg,sum(qty) AS jual FROM tb_tr GROUP BY id_brg)C ON C.id_brg = A.rowid where A.kd_brg LIKE '+quotedstr('%'+cari.Text+'%')+' OR A.nama_brg LIKE '+quotedstr('%'+cari.Text+'%')+') as tb_brg where stock > 0 ORDER BY nama_brg;');
            open;
          end;
        except on e:exception do begin
          showmessage('Error : '+e.Message);
        end;
      end;
  end;
end;

procedure TFcekbrg.DBGrid1DblClick(Sender: TObject);
begin
  ftr.kd_brg.Text := dm1.dtcaribrg.FieldByName('kd_brg').AsString;
  with dm1.sqlexec do begin
       close;
       sql.Clear;
       sql.Add('SELECT A.nama_brg,(ifnull(B.stock,0) - ifnull(jual,0)) AS stock,A.uom,A.harga_jual '+
               'FROM tb_brg A '+
               'LEFT JOIN (SELECT id_brg,SUM(qty) AS stock FROM tb_stock GROUP BY id_brg)B ON B.id_brg = A.rowid '+
               'LEFT JOIN (SELECT id_brg,sum(qty) AS jual FROM tb_tr_temp WHERE sts = 1 GROUP BY id_brg)C ON C.id_brg = A.rowid '+
               'WHERE kd_brg = '+quotedstr(ftr.kd_brg.Text)+';');
       open;
     end;
     ftr.Lbrg.Caption := dm1.sqlexec.FieldByName('nama_brg').AsString;
     ftr.Lharga.Caption := dm1.sqlexec.FieldByName('harga_jual').AsString;
     ftr.Lsatuan.Caption := dm1.sqlexec.FieldByName('uom').AsString;
     ftr.stock.text := dm1.sqlexec.FieldByName('stock').AsString;
  close;
end;

end.

