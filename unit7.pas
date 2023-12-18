unit Unit7;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids,StrUtils;

type

  { TFpending }

  TFpending = class(TForm)
    DBGrid1: TDBGrid;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Fpending: TFpending;

implementation
uses
  dm,unit2;

{$R *.lfm}

{ TFpending }

procedure TFpending.FormCreate(Sender: TObject);
begin

end;

procedure TFpending.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  dm1.pending.Active := false;
end;

procedure TFpending.DBGrid1DblClick(Sender: TObject);
begin
  ftr.addtr.Enabled := false;
  ftr.kdtrn.Text := dm1.pending.FieldByName('trid').AsString;
  with dm1.tb_tr_temp do begin
     close;
     sql.Clear;
     sql.add('SELECT A.rowid,A.trid,A.id_brg,B.kd_brg,B.nama_brg,A.harga_beli,A.harga_jual,A.qty,A.uom,A.crid,A.crdt,A.sts,(A.harga_jual * A.qty) as total '+
             'FROM tb_tr_temp A '+
             'LEFT JOIN tb_brg B ON B.rowid = A.id_brg '+
             'where A.trid = '+quotedstr(ftr.kdtrn.Text)+' and A.sts = 1;');
     open;
  end;

  with dm1.sqlexec do begin
     close;
     sql.Clear;
     sql.add('SELECT SUM(harga_jual * qty) AS harga_jual FROM tb_tr_temp '+
             'where trid = '+quotedstr(ftr.kdtrn.Text)+' and sts = 1;');
     open;
  end;
  //Lhargatotal.Caption := dm1.sqlexec.FieldByName('harga_jual').AsString;
  ftr.Lhargatotal.Caption := Trim('Rp.'+(AnsiReplaceStr(FormatFloat('#,##0',Variant(dm1.sqlexec.FieldByName('harga_jual').AsString)),',','.'))+',-');
  ftr.total_bayar.Text := dm1.sqlexec.FieldByName('harga_jual').AsString;
  ftr.kd_brg.Text := '';
  ftr.qty.Text := '1';
  ftr.Lbrg.Caption := '...';
  ftr.Lharga.Caption := '...';
  ftr.Lsatuan.Caption := '...';
  ftr.kd_brg.SetFocus;
  close;
end;

end.

