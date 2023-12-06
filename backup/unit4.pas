unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  DBGrids, DBCtrls;

type

  { TFbrg }

  TFbrg = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    DBGrid1: TDBGrid;
    cari: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    nmbrg: TEdit;
    kdbrg: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private

  public

  end;

var
  Fbrg: TFbrg;

implementation

uses
  dm;

  {$R *.lfm}

  { TFbrg }

procedure TFbrg.Button1Click(Sender: TObject);
begin
  try
  if kdbrg.Text = '' then
  begin
  showmessage('Kode barang harus diisi');
  end else begin
    if nmbrg.Text = '' then
    begin
    showmessage('Nama barang harus diisi');
    end else begin
      with dm1.sqlexec do
      begin
        close;
        sql.clear;
        sql.Add('insert into tb_brg(kd_brg,nama_brg) values('+quotedstr(kdbrg.Text)+','+quotedstr(nmbrg.Text)+');');
        execsql;
      end;
      showmessage('Data berhasil disimpan');
      kdbrg.Text:= '';
      nmbrg.Text:= '';
      dm1.dtbrg.Close;
      dm1.dtbrg.Open;
    end;
  end;
  except on e:exception do begin
    showmessage('Gagal Menyimpan error : '+e.message);
  end;
  end;
end;

procedure TFbrg.Button3Click(Sender: TObject);
begin

end;

end.
