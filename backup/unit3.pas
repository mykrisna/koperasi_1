unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Calendar,
  EditBtn, RLReport, RLPreview, RLXLSFilter, ZReport;

type

  { TFrep }

  TFrep = class(TForm)
    Button1: TButton;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLReport1: TRLReport;
    RLXLSFilter1: TRLXLSFilter;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RLBand1AfterPrint(Sender: TObject);
    procedure RLPreview1Click(Sender: TObject);
  private

  public

  end;

var
  Frep: TFrep;

implementation
uses
  dm;

{$R *.lfm}

{ TFrep }

procedure TFrep.FormCreate(Sender: TObject);
begin

end;

procedure TFrep.Button1Click(Sender: TObject);
begin
  with dm1.laporan do begin
    close;
    sql.Clear;
    sql.Add('SELECT A.trid,B.kd_brg,B.nama_brg,A.harga_beli,A.harga_jual,A.qty,A.uom,(A.harga_jual * A.qty) as total_jual,'+
            '((A.harga_jual - A.harga_beli) * A.qty) AS margin '+
            'FROM tb_tr A '+
            'LEFT JOIN tb_brg B ON B.rowid = A.id_brg '+
            'LEFT JOIN tb_pay C ON C.trid = A.trid '+
            'where C.crdt between '+quotedstr(DateEdit1.Text)+' and '+quotedstr(DateEdit2.Text)+
            ' ORDER BY A.trid;');
    open;
  end;

  with dm1.sumjual do begin
    close;
    sql.Clear;
    sql.Add('SELECT sum(A.harga_jual * A.qty) as total_penjual,sum((A.harga_jual - A.harga_beli) * A.qty) AS total_margin '+
            'FROM tb_tr A '+
            'LEFT JOIN tb_brg B ON B.rowid = A.id_brg '+
            'LEFT JOIN tb_pay C ON C.trid = A.trid '+
            'where C.crdt between '+quotedstr(DateEdit1.Text)+' and '+quotedstr(DateEdit2.Text)+
            ' ORDER BY A.trid;');
    open;
  end;

  dm1.laporan.Active := true;
  dm1.sumjual.Active := true;
  Frep.RLReport1.Preview();
end;

procedure TFrep.RLBand1AfterPrint(Sender: TObject);
begin

end;

procedure TFrep.RLPreview1Click(Sender: TObject);
begin

end;

end.

