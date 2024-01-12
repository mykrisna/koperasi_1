unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  DBGrids, DBCtrls, Menus, MaskEdit, ExtCtrls, db;

type

  { TFbrg }

  TFbrg = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    DBGrid1: TDBGrid;
    cari: TEdit;
    harga_jual: TEdit;
    Label6: TLabel;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    rowid: TEdit;
    harga_beli: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    nmbrg: TEdit;
    kdbrg: TEdit;
    PageControl1: TPageControl;
    PopupMenu1: TPopupMenu;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure cariKeyPress(Sender: TObject; var Key: char);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure harga_beliKeyPress(Sender: TObject; var Key: char);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
  private

  public

  end;

var
  Fbrg: TFbrg;

implementation

uses
  dm,unit5,unit8;

  {$R *.lfm}

  { TFbrg }

procedure TFbrg.Button1Click(Sender: TObject);
var
  bm : TBookMark;
begin
  bm := dm1.dtbrg.GetBookmark;
if rowid.Text = '' then
 begin
   try
   with dm1.sqlexec do begin
       close;
       sql.Clear;
       sql.Add('SELECT COUNT(kd_brg) AS hitung FROM tb_brg WHERE kd_brg = '+quotedstr(kdbrg.Text)+';');
       open;
   end;

  if kdbrg.Text = '' then
  begin
   showmessage('Kode barang harus diisi');
  end else begin
  if dm1.sqlexec.FieldByName('hitung').AsInteger > 0 then begin
   showmessage('Kode barang ini telah terdaftar');
  end else begin
    if nmbrg.Text = '' then
    begin
      showmessage('Nama barang harus diisi');
    end else begin
      if ComboBox1.Text = '' then
      begin
        showmessage('Pilih Satuan barang');
      end else begin
          if harga_beli.Text = '0' then
          begin
            showmessage('Harga beli barang harus diisi');
          end else begin
              if harga_jual.Text = '0' then
              begin
                showmessage('Harga jual barang harus diisi');
              end else begin
                  if strtofloat(harga_jual.Text) <= strtofloat(harga_beli.Text) then
                  begin
                    showmessage('Harga jual harus lebih dari harga beli');
                  end else begin
                    with dm1.sqlexec do
                    begin
                      close;
                      sql.clear;
                      sql.Add('insert into tb_brg(kd_brg,nama_brg,uom,harga_beli,harga_jual) values('+quotedstr(kdbrg.Text)+','+quotedstr(nmbrg.Text)+','+quotedstr(Combobox1.Text)+','+quotedstr(harga_beli.Text)+','+quotedstr(harga_jual.Text)+');');
                      execsql;
                    end;
                  //showmessage('Data berhasil disimpan');
                      kdbrg.Text:= '';
                      nmbrg.Text:= '';
                      harga_beli.Text:= '0';
                      harga_jual.Text:= '0';
                      ComboBox1.Text := '';
                      dm1.dtbrg.Refresh;
                      dm1.dtbrg.GotoBookmark(bm);
                  end;
              end;
          end;
      end;
    end;
  end;
 end;

  except on e:exception do begin
      showmessage('Gagal Menyimpan error : '+e.message);
    end;
  end;
 end else begin // update data
     if nmbrg.Text = '' then
    begin
      showmessage('Nama barang harus diisi');
    end else begin
      if ComboBox1.Text = '' then
      begin
        showmessage('Pilih Satuan barang');
      end else begin
          if harga_beli.Text = '0' then
          begin
            showmessage('Harga beli barang harus diisi');
          end else begin
              if harga_jual.Text = '0' then
              begin
                showmessage('Harga jual barang harus diisi');
              end else begin
                  if strtofloat(harga_jual.Text) <= strtofloat(harga_beli.Text) then
                  begin
                    showmessage('Harga jual harus lebih dari harga beli');
                  end else begin
                      with dm1.sqlexec do begin
                          close;
                          sql.Clear;
                          sql.Add('update tb_brg set nama_brg='+quotedstr(nmbrg.Text)+',uom='+quotedstr(combobox1.Text)+',harga_beli='+quotedstr(harga_beli.Text)+',harga_jual='+quotedstr(harga_jual.Text)+' where rowid = '+quotedstr(rowid.Text)+';');
                          execsql;
                      end;
                   dm1.dtbrg.Refresh;
                   rowid.Text := '';
                   kdbrg.Text := '';
                   nmbrg.Text := '';
                   ComboBox1.Text := '';
                   harga_beli.Text := '0';
                   harga_jual.Text := '0';
                  end;
              end;
          end;
      end;
    end;
 end;
end;

procedure TFbrg.Button2Click(Sender: TObject);
begin
  try
    with dm1.dtbrg do begin
      close;
      sql.Clear;
      sql.Add('CALL brg('+quotedstr('%'+cari.Text+'%')+');');
      open;
    end;
  except on e:exception do begin
    showmessage('Error : '+e.Message);
  end;
end;
end;

procedure TFbrg.Button3Click(Sender: TObject);
begin

end;

procedure TFbrg.cariKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
      begin
          try
        with dm1.dtbrg do begin
          close;
          sql.Clear;
          sql.Add('CALL brg('+quotedstr('%'+cari.Text+'%')+');');
          open;
        end;
      except on e:exception do begin
        showmessage('Data gagal disimpan dengan Error : '+e.Message);
      end;
    end;
  end;
end;

procedure TFbrg.DBGrid1DblClick(Sender: TObject);
begin
  Finputstock.Label1.Caption := dm1.dtbrg.FieldByName('nama_brg').AsString;
  Finputstock.ShowModal;
end;

procedure TFbrg.FormActivate(Sender: TObject);
begin

end;

procedure TFbrg.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  dm1.dtbrg.Active := false;
end;

procedure TFbrg.harga_beliKeyPress(Sender: TObject; var Key: char);
begin
  if not (key in['0'..'9',#8,#13,#32]) then
   begin
   key:=#0;
   showmessage('inputan hanya angka');
   end;
end;

procedure TFbrg.MenuItem1Click(Sender: TObject);
begin
  PageControl1.ActivePage := TabSheet1 ;
  rowid.Text := dm1.dtbrg.FieldByName('rowid').AsString;
  kdbrg.Text := dm1.dtbrg.FieldByName('kd_brg').AsString;
  nmbrg.Text := dm1.dtbrg.FieldByName('nama_brg').AsString;
  ComboBox1.Text := dm1.dtbrg.FieldByName('uom').AsString;
  harga_beli.Text := dm1.dtbrg.FieldByName('harga_beli').AsString;
  harga_jual.Text := dm1.dtbrg.FieldByName('harga_jual').AsString;
end;

procedure TFbrg.MenuItem2Click(Sender: TObject);
begin
   if messagedlg('Hapus Data ini ?',mtconfirmation,[mbYes]+[mbNo],0)=mrYes then
    begin
    with dm1.sqlexec do begin
      close;
      sql.Clear;
      sql.Add('delete from tb_brg where rowid = '+quotedstr(dm1.dtbrg.FieldByName('rowid').AsString));
      execsql;
    end;
    dm1.dtbrg.Refresh;
    end;
end;

procedure TFbrg.MenuItem3Click(Sender: TObject);
begin
  Finputstock.Label1.Caption := dm1.dtbrg.FieldByName('nama_brg').AsString;
  Finputstock.ShowModal;
end;

procedure TFbrg.MenuItem4Click(Sender: TObject);
begin
  with dm1.audit do begin
    close;
    sql.Clear;
    sql.Add('CALL audit_brg('+dm1.dtbrg.FieldByName('id_brg').AsString+');');
    open;
  end;
  Faudit.ShowModal;
end;

end.
