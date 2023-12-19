<?php
$id = $_POST['id'];
require __DIR__ . '/../../vendor/autoload.php';

use Mike42\Escpos\Printer;
use Mike42\Escpos\PrintConnectors\WindowsPrintConnector;

$conn = mysqli_connect('127.0.0.1', 'root', '', 'db_006');

if (!$conn) {
    die("Koneksi gagal: " . mysqli_connect_error());
}

$sql = 'SELECT B.nama_brg, A.qty, A.harga_jual, (A.qty * A.harga_jual) AS total 
        FROM tb_tr A
        LEFT JOIN tb_brg B ON B.rowid = A.id_brg 
        WHERE A.trid = ' . $id . ';';

$harga = 'SELECT total_price,pay,(pay - total_price) AS kembali FROM tb_pay WHERE trid = ' . $id . ';';

$query = mysqli_query($conn, $sql);
$price = mysqli_query($conn, $harga);

if (!$query) {
    die("Error in query: " . mysqli_error($conn));
}

try {
    /*
    $connector = new WindowsPrintConnector("ZJ-80");
    $printer = new Printer($connector);

    // detail belanja

    $printer->initialize();
    $printer->setFont(Printer::FONT_A);
    $printer->text("KOPERASI KARYAWAN TOP AND TOP APPAREL" . "\n");
    $printer->text(date('d/m/Y H:i:s') . "                   " . $id . "\n");
    $printer->text("------------------------------------------------" . "\n");
    while ($row = mysqli_fetch_assoc($query)) {
        $printer->text($row['nama_brg'] . "\n");
        //$printer->text($row['nama_brg'] . "    " . $row['qty'] . "    " . number_format($row['harga_jual'], 0, '.', ',') . "    " . number_format($row['total'], 0, '.', ',') . "\n");
        $printer->text($row['qty'] . ' x ' . number_format($row['harga_jual'], 0, '.', ',') . ' = ' . number_format($row['total'], 0, '.', ',') . "\n");
    }
    $printer->text("------------------------------------------------" . "\n");
    $printer->setLineSpacing(5);
    $printer->text("\n");

    $printer->initialize();
    $printer->setFont(Printer::FONT_A);
    $printer->setJustification(Printer::JUSTIFY_RIGHT);
    while ($line = mysqli_fetch_assoc($price)) {
        $printer->text("TOTAL    :    " . number_format($line['total_price'], 0, '.', ',') . "\n");
        $printer->text("TUNAI    :    " . number_format($line['pay'], 0, '.', ',') . "\n");
        $printer->text("KEMBALI  :     " . number_format($line['kembali'], 0, '.', ',') . "\n");
    }
    $printer->setLineSpacing(5);
    $printer->text("\n");

    $printer->initialize();
    $printer->setFont(Printer::FONT_A);
    $printer->setJustification(Printer::JUSTIFY_CENTER);
    $printer->text("TERIMA KASIH" . "\n");
    $printer->text("BELANJA HEMAT DI KOPKAR TOP AND TOP APPAREL" . "\n");
    $printer->setLineSpacing(5);
    $printer->text("\n");

    $printer->cut();
    $printer->close();
*/
    echo "Berhasil cetak struk belanja ID Transaksi : " . $id;
    mysqli_close($conn);
} catch (Exception $e) {
    echo "Couldn't print to this printer: " . $e->getMessage() . "\n";
}
