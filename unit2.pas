unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  DBGrids, StdCtrls, Buttons, SpkToolbar, spkt_Tab, spkt_Pane, spkt_Buttons;

type

  { TFtr }

  TFtr = class(TForm)
    BitBtn1: TBitBtn;
    DBGrid1: TDBGrid;
    bayar: TEdit;
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
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Lkembali: TLabel;
    Panel1: TPanel;
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
    SpkLargeButton2: TSpkLargeButton;
    SpkLargeButton3: TSpkLargeButton;
    SpkLargeButton4: TSpkLargeButton;
    SpkLargeButton5: TSpkLargeButton;
    SpkLargeButton6: TSpkLargeButton;
    SpkPane1: TSpkPane;
    SpkPane2: TSpkPane;
    SpkTab1: TSpkTab;
    SpkTab2: TSpkTab;
    SpkToolbar1: TSpkToolbar;
    Splitter1: TSplitter;
    TabSheet1: TTabSheet;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure SpkLargeButton1Click(Sender: TObject);
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
  unit1,unit4,dm;
{$R *.lfm}

{ TFtr }

procedure TFtr.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;

procedure TFtr.SpkLargeButton1Click(Sender: TObject);
begin
  dm1.uom.First;
  while not dm1.uom.Eof do
  begin
    Fbrg.ComboBox1.Items.Add(dm1.uom.FieldByName('uom').AsString);
    dm1.uom.Next;
  end;
  Fbrg.Show;
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

