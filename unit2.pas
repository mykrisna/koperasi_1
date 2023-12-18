unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, process, Forms, FileUtil, Controls, Graphics, Dialogs,
  ExtCtrls, ComCtrls, DBGrids, StdCtrls, Buttons, SpkToolbar, spkt_Tab,
  spkt_Pane, spkt_Buttons, RLReport, Printers, Menus, EditBtn, IdHTTP,
  fphttpclient, opensslsockets, StrUtils;

type

  { TFtr }

  TFtr = class(TForm)
    btncari: TBitBtn;
    Button2: TButton;
    DBGrid1: TDBGrid;
    bayar: TEdit;
    MenuItem1: TMenuItem;
    PopupMenu1: TPopupMenu;
    SpkLargeButton2: TSpkLargeButton;
    SpkLargeButton3: TSpkLargeButton;
    btnpending: TSpkLargeButton;
    total_bayar: TEdit;
    stock: TEdit;
    IdHTTP1: TIdHTTP;
    kdtrn: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label5: TLabel;
    Lhargatotal: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Lkembali: TLabel;
    Panel1: TPanel;
    Process1: TProcess;
    qty: TEdit;
    kd_brg: TEdit;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Lsatuan: TLabel;
    Lharga: TLabel;
    Lbrg: TLabel;
    PageControl1: TPageControl;
    SpkLargeButton1: TSpkLargeButton;
    addtr: TSpkLargeButton;
    SpkLargeButton6: TSpkLargeButton;
    SpkPane1: TSpkPane;
    SpkPane2: TSpkPane;
    SpkTab1: TSpkTab;
    SpkTab2: TSpkTab;
    SpkToolbar1: TSpkToolbar;
    Splitter1: TSplitter;
    TabSheet1: TTabSheet;
    procedure bayarKeyPress(Sender: TObject; var Key: char);
    procedure BitBtn1Click(Sender: TObject);
    procedure btncariClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure kd_brgKeyPress(Sender: TObject; var Key: char);
    procedure MenuItem1Click(Sender: TObject);
    procedure qtyKeyPress(Sender: TObject; var Key: char);
    procedure SpkLargeButton1Click(Sender: TObject);
    procedure addtrClick(Sender: TObject);
    procedure SpkLargeButton2Click(Sender: TObject);
    procedure SpkLargeButton3Click(Sender: TObject);
    procedure btnpendingClick(Sender: TObject);
    procedure SpkLargeButton6Click(Sender: TObject);
    procedure SpkLargeButton7Click(Sender: TObject);
    procedure SpkLargeButton8Click(Sender: TObject);
    procedure SpkLargeButton9Click(Sender: TObject);
  private

  public

  end;

var
  Ftr: TFtr;

implementation

uses
  unit1,unit4,unit3,dm,unit6,unit7;
{$R *.lfm}

{ TFtr }


procedure TFtr.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;

procedure TFtr.kd_brgKeyPress(Sender: TObject; var Key: char);
begin
  try
  if key = #13 then
  begin
      with dm1.sqlexec do begin
       close;
       sql.Clear;
       sql.Add('SELECT A.nama_brg,(ifnull(B.stock,0) - ifnull(jual,0)) AS stock,A.uom,A.harga_jual '+
               'FROM tb_brg A '+
               'LEFT JOIN (SELECT id_brg,SUM(qty) AS stock FROM tb_stock GROUP BY id_brg)B ON B.id_brg = A.rowid '+
               'LEFT JOIN (SELECT id_brg,sum(qty) AS jual FROM tb_tr_temp WHERE sts = 1 GROUP BY id_brg)C ON C.id_brg = A.rowid '+
               'WHERE kd_brg = '+quotedstr(kd_brg.Text)+';');
       open;
     end;
     Lbrg.Caption := dm1.sqlexec.FieldByName('nama_brg').AsString;
     Lharga.Caption := dm1.sqlexec.FieldByName('harga_jual').AsString;
     Lsatuan.Caption := dm1.sqlexec.FieldByName('uom').AsString;
     stock.text := dm1.sqlexec.FieldByName('stock').AsString;
  end;

  except on e:exception do begin
   showmessage('Get data error : '+e.Message);
  end;
end;
end;
procedure TFtr.MenuItem1Click(Sender: TObject);
begin
  try
  if messagedlg('Hapus Item ini ?',mtconfirmation,[mbYes]+[mbNo],0)=mrYes then
    begin
      with dm1.sqlexec do begin
       close;
       sql.Clear;
       sql.Add('delete from tb_tr_temp where rowid = '+quotedstr(dm1.tb_tr_temp.FieldByName('rowid').AsString));
       execsql;
      end;

      with dm1.tb_tr_temp do begin
         close;
         sql.Clear;
         sql.add('SELECT A.rowid,A.trid,A.id_brg,B.nama_brg,A.harga_beli,A.harga_jual,A.qty,A.uom,A.crid,A.crdt,A.sts,(A.harga_jual * A.qty) as total '+
                 'FROM tb_tr_temp A '+
                 'LEFT JOIN tb_brg B ON B.rowid = A.id_brg '+
                 'where A.trid = '+quotedstr(kdtrn.Text)+' and A.sts = 1;');
         open;
      end;
    end;

  except on e:exception do begin
    showmessage(e.Message);
  end;
end;
end;
procedure TFtr.qtyKeyPress(Sender: TObject; var Key: char);
begin
  if not (key in['0'..'9',#8,#13,#32]) then
   begin
   key:=#0;
   showmessage('inputan hanya angka');
   end;

  if key = #13 then
  begin
     Button2.Click;
  end;
end;

procedure TFtr.BitBtn1Click(Sender: TObject);
begin

end;

procedure TFtr.btncariClick(Sender: TObject);
begin
  dm1.dtcaribrg.Active := true;
  Fcekbrg.ShowModal;
end;

procedure TFtr.bayarKeyPress(Sender: TObject; var Key: char);
begin
  try
  if not (key in['0'..'9',#8,#13,#32]) then
   begin
   key:=#0;
   showmessage('inputan hanya angka');
   end;

  if key = #13 then
  begin
      if strtofloat(bayar.Text) < strtofloat(total_bayar.Text) then begin
      Lkembali.Caption := '0';
      end else begin
      //Lkembali.Caption := floattostr(strtofloat(bayar.Text) - strtofloat(total_bayar.Text));
      Lkembali.Caption := Trim('Rp.'+(AnsiReplaceStr(FormatFloat('#,##0',Variant(floattostr(strtofloat(bayar.Text) - strtofloat(total_bayar.Text)))),',','.'))+',-');
      end;
  end;

  except on e:exception do begin
      showmessage(e.Message);
      bayar.Text := '0';
      end;
  end;
end;

procedure TFtr.Button1Click(Sender: TObject);
begin

end;

procedure TFtr.Button2Click(Sender: TObject);
begin
  if kdtrn.Text = '' then
  begin
     showmessage('Kode transaksi kosong');
  end else begin
     if kd_brg.Text = '' then
     begin
       showmessage('Kode barang kosong');
     end else begin
         if strtoint(qty.Text) > strtoint(stock.Text) then
         begin
           showmessage('Stok barang tidak cukup, stok saat ini '+stock.Text);
         end else begin
             with dm1.sqlexec do begin
              close;
              sql.Clear;
              sql.Add('INSERT INTO tb_tr_temp(trid,id_brg,harga_beli,harga_jual,qty,uom,crdt,sts) '+
                      'SELECT '+quotedstr(kdtrn.Text)+',rowid,harga_beli,harga_jual,'+quotedstr(qty.Text)+',uom,curdate(),1 FROM tb_brg WHERE kd_brg = '+quotedstr(kd_brg.Text)+';');
              execsql;
              end;

              with dm1.tb_tr_temp do begin
                 close;
                 sql.Clear;
                 sql.add('SELECT A.rowid,A.trid,A.id_brg,B.kd_brg,B.nama_brg,A.harga_beli,A.harga_jual,A.qty,A.uom,A.crid,A.crdt,A.sts,(A.harga_jual * A.qty) as total '+
                         'FROM tb_tr_temp A '+
                         'LEFT JOIN tb_brg B ON B.rowid = A.id_brg '+
                         'where A.trid = '+quotedstr(kdtrn.Text)+' and A.sts = 1;');
                 open;
              end;

              with dm1.sqlexec do begin
                 close;
                 sql.Clear;
                 sql.add('SELECT SUM(harga_jual * qty) AS harga_jual FROM tb_tr_temp '+
                         'where trid = '+quotedstr(kdtrn.Text)+' and sts = 1;');
                 open;
              end;
              //Lhargatotal.Caption := dm1.sqlexec.FieldByName('harga_jual').AsString;
              Lhargatotal.Caption := Trim('Rp.'+(AnsiReplaceStr(FormatFloat('#,##0',Variant(dm1.sqlexec.FieldByName('harga_jual').AsString)),',','.'))+',-');
              total_bayar.Text := dm1.sqlexec.FieldByName('harga_jual').AsString;
              kd_brg.Text := '';
              qty.Text := '1';
              Lbrg.Caption := '...';
              Lharga.Caption := '...';
              Lsatuan.Caption := '...';
              kd_brg.SetFocus;
         end;
     end;
  end;
end;

procedure TFtr.SpkLargeButton1Click(Sender: TObject);
begin
  dm1.uom.First;
  while not dm1.uom.Eof do
  begin
    Fbrg.ComboBox1.Items.Add(dm1.uom.FieldByName('uom').AsString);
    dm1.uom.Next;
  end;
  dm1.dtbrg.Active := true;
  Fbrg.Show;
end;

procedure TFtr.addtrClick(Sender: TObject);
Var
  params : TStringList;
  res : TStringStream;
begin
  try
    params := TStringList.Create;
    params.Add('a='+'hello');
    res := TStringStream.Create('');
    //idhttp1.POST('http://127.0.0.1/koperasi/welcome/id_tr', params, res);
    idhttp1.POST(dm1.url.FieldByName('url_id').AsString, params, res);
    kdtrn.Text:= res.DataString;
    res.Free;
    params.free;
    kd_brg.SetFocus;
    addtr.Enabled := false;
    btnpending.Enabled := false;
  except on e:exception do begin
    showmessage('ID transaksi gagal error :'+e.Message);
  end;
end;
end;
procedure TFtr.SpkLargeButton2Click(Sender: TObject);
Var
  params : TStringList;
  res : TStringStream;
begin
  try
  if kdtrn.Text = '' then begin
     showmessage('No Transaksi kosong,klik tombol transaksi baru');
  end else begin
  if strtofloat(total_bayar.Text) <= 0 then begin
     showmessage('Tidak ada transaksi untuk disimpan');
  end else begin
  if bayar.Text = '' then begin
     showmessage('Nominal bayar belum diisi');
  end else begin
     if strtofloat(bayar.Text) <= 0 then begin
         showmessage('Nominal bayar belum diisi');
  end else begin
     if strtofloat(bayar.Text) < strtofloat(total_bayar.Text) then begin
         showmessage('Nominal bayar tidak sesuai');
         end else begin

      with dm1.sqlexec do begin
         close;
         sql.Clear;
         sql.Add('CALL transaksi('+quotedstr(kdtrn.Text)+');');
         execsql;
      end;

      with dm1.sqlexec do begin
         close;
         sql.Clear;
         sql.Add('insert into tb_pay(trid,total_price,pay,crdt) values ('+
                 quotedstr(kdtrn.Text)+','+quotedstr(total_bayar.Text)+','+quotedstr(bayar.Text)+',curdate());');
         execsql;
      end;

      params := TStringList.Create;
      params.Add('id='+kdtrn.Text);
      res := TStringStream.Create('');
      //idhttp1.POST('http://127.0.0.1/escpos-php-development/example/cetak.php', params, res);
      idhttp1.POST(dm1.url.FieldByName('url_printer').AsString, params, res);
      showmessage(res.DataString);
      res.Free;
      params.free;

      bayar.Text := '0';
      Lhargatotal.Caption:= '0';
      Lkembali.Caption:= '0';
      addtr.Enabled := true;
      kdtrn.Text := '';
      btnpending.Enabled := true;

      with dm1.tb_tr_temp do begin
                 close;
                 sql.Clear;
                 sql.add('SELECT A.rowid,A.trid,A.id_brg,B.nama_brg,A.harga_beli,A.harga_jual,A.qty,A.uom,A.crid,A.crdt,A.sts,(A.harga_jual * A.qty) as total '+
                         'FROM tb_tr_temp A '+
                         'LEFT JOIN tb_brg B ON B.rowid = A.id_brg '+
                         'where A.trid = '+quotedstr(kdtrn.Text)+';');
                 open;
              end;
         end;
      end;
  end;
  end;
  end;
  except on e:exception do begin
   showmessage('Printer error : '+e.Message);
  end;
  end;
end;

procedure TFtr.SpkLargeButton3Click(Sender: TObject);
begin
  if kdtrn.Text = '' then
  begin
    showmessage('Tidak ada transaksi untuk dibatalkan');
  end else begin
  if messagedlg('Transaksi ini akan dibatalkan,lanjutkan ?',mtconfirmation,[mbYes]+[mbNo],0)=mrYes then
    begin
  with dm1.sqlexec do begin
   close;
   sql.Clear;
   sql.Add('delete from tb_tr_temp where trid = '+quotedstr(kdtrn.Text)+';');
   execsql;
  end;
  dm1.tb_tr_temp.Close;
  dm1.tb_tr_temp.Open;
  kd_brg.Text := '';
  kdtrn.Text := '';
  qty.Text := '1';
  total_bayar.Text := '0';
  Lbrg.Caption := '...';
  Lharga.Caption := '...';
  Lsatuan.Caption := '...';
  Lhargatotal.Caption := '...';
  btnpending.Enabled := true;
  addtr.Enabled := true;
  kd_brg.SetFocus;
  end;
  end;
end;

procedure TFtr.btnpendingClick(Sender: TObject);
begin
  dm1.pending.Active := true;
  Fpending.showmodal;
end;

procedure TFtr.SpkLargeButton6Click(Sender: TObject);
begin
  Frep.ShowModal;
end;

procedure TFtr.SpkLargeButton7Click(Sender: TObject);
begin

end;

procedure TFtr.SpkLargeButton8Click(Sender: TObject);
begin

end;

procedure TFtr.SpkLargeButton9Click(Sender: TObject);
begin

end;

end.

