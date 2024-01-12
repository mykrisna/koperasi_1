DROP PROCEDURE IF EXISTS audit_brg;
DELIMITER //
create procedure audit_brg
(
IN in_brg VARCHAR(100)
)
Begin
SET @stok = 0;
SET @jual = 0;
SELECT id_brg,tgl,keterangan,trid,nama_brg,stok,
case when trid = 0 then stok ELSE 0 END stock_masuk,
case when trid > 0 then stok ELSE 0 END jual,
( (@stok := @stok + case when trid = 0 then stok ELSE 0 END) -
  (@jual := @jual + case when trid > 0 then stok ELSE 0 END) )AS sisa,harga_beli,harga_jual,
(harga_jual - harga_beli) AS margin,total_jual,uom
FROM (
		SELECT id_brg,'Stock' as keterangan,0 as trid,B.nama_brg,A.qty AS stok,A.uom,A.crdt AS tgl,
		0 AS harga_beli,0 AS harga_jual,0 AS total_jual
		FROM tb_stock A
		LEFT JOIN tb_brg B ON B.rowid = A.id_brg
		WHERE A.id_brg = in_brg
		UNION All
		SELECT id_brg,'Sold' AS keterangan,A.trid,C.nama_brg,A.qty AS terjual,A.uom,B.crdt AS tgl,
		A.harga_beli,A.harga_jual,(A.qty * A.harga_jual) AS total_jual
		FROM tb_tr A
		LEFT JOIN tb_pay B ON B.trid = A.trid
		LEFT JOIN tb_brg C ON C.rowid = A.id_brg
		WHERE A.id_brg = in_brg
) AS tb_temp ORDER BY tgl,trid;
end;
//

