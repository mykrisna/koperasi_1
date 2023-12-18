unit dm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, odbcconn, mysql80conn, ZConnection, ZDataset;

type

  { Tdm1 }

  Tdm1 = class(TDataModule)
    d1: TDataSource;
    d2: TDataSource;
    d3: TDataSource;
    d4: TDataSource;
    d5: TDataSource;
    d6: TDataSource;
    dtcaribrg: TZQuery;
    sumjual: TZQuery;
    dtrtemp: TDataSource;
    dbconn: TZConnection;
    dtlaporan: TDataSource;
    pending: TZQuery;
    url: TZQuery;
    q1: TZQuery;
    dtbrg: TZQuery;
    sqlexec: TZQuery;
    uom: TZQuery;
    tb_tr_temp: TZQuery;
    laporan: TZQuery;
    procedure dbconnAfterConnect(Sender: TObject);
    procedure SQLConnector1AfterConnect(Sender: TObject);
  private

  public

  end;

var
  dm1: Tdm1;

implementation

{$R *.lfm}

{ Tdm1 }

procedure Tdm1.SQLConnector1AfterConnect(Sender: TObject);
begin

end;

procedure Tdm1.dbconnAfterConnect(Sender: TObject);
begin
  url.Active := true;
  uom.Active := true;
end;

end.

