unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  ExtCtrls, LCLType;

type

  { TFlogin }

  TFlogin = class(TForm)
    Blogin: TButton;
    nama: TEdit;
    notif: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    sandi: TEdit;
    procedure BloginClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sandiEnter(Sender: TObject);
    procedure sandiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sandiKeyPress(Sender: TObject; var Key: char);

  private

  public

  end;

var
  Flogin: TFlogin;

implementation

uses
  dm,Unit2,Unit4,BCrypt;

{$R *.lfm}

{ TFlogin }

procedure TFlogin.FormCreate(Sender: TObject);
begin

end;

procedure TFlogin.sandiEnter(Sender: TObject);
begin

end;

procedure TFlogin.sandiKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TFlogin.sandiKeyPress(Sender: TObject; var Key: char);
//var s:string;
begin
  if key = #13 then
  begin
      Blogin.Click;
  end;
end;


procedure TFlogin.BloginClick(Sender: TObject);
begin
  try
    dm1.dbconn.connected := true;
    if nama.Text = '' then
    begin
       notif.Caption:='Username mohon diisi';
       notif.Visible := true;
    end else begin
    if sandi.Text = '' then
      begin
         notif.Caption:='Password mohon diisi';
         notif.Visible := true;
    end else Begin
      with dm1.sqlexec do begin
               close;
               sql.Clear;
               sql.Add('select count(id_usr) as usr from tb_usr where nama = '+quotedstr(nama.Text)+' and sandi = '+quotedstr(sandi.text));
               execsql;
          end;
          dm1.sqlexec.Active := true;
          if dm1.sqlexec.fieldbyname('usr').text = '0' then
             begin
                notif.Caption:='Login Gagal';
                notif.Visible := true;
             end else
             begin
                  Flogin.Hide;
                  ftr.showmodal;
                  notif.Caption:='';
                  notif.Visible := false;
             end;
             end;
    end;
    except on e:exception do
    begin
      showmessage('Koneksi Ke db gagal, aplikasi akan ditutup');
      Application.Terminate;
    end;
  end;
end;

procedure TFlogin.Button1Click(Sender: TObject);
begin

end;

end.

