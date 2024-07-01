<?php
// Ambil data order dari variabel $data_orders yang diberikan oleh controller
$data_orders = $data_orders;
$start_date = isset($start_date) ? $start_date : '';
$end_date = isset($end_date) ? $end_date : '';
?>

<h2>
    <center>Laporan Penjualan Kain Tenun</center>
</h2>

<?php if ($start_date && $end_date) : ?>
    <h4 style="text-align: center;">
        Periode <?php echo date('j F Y', strtotime($start_date)) . ' - ' . date('j F Y', strtotime($end_date)); ?>
    </h4>
<?php endif; ?>
<hr />

<table border="1" width="100%" style="text-align:center;">
    <tr>
        <th>No</th>
        <th>Nama Pembeli</th>
        <th>Produk</th>
        <th>Jumlah</th>
        <th>Total Pembelian</th>
    </tr>

    <?php
    $total_penjualan = 0;
    if ($data_orders) {
        $no = 1;
        foreach ($data_orders as $order) {
            $total_pembelian = $order->harga * $order->jumlah;
            $total_penjualan += $total_pembelian;
    ?>
            <tr>
                <td><?php echo $no++; ?></td>
                <td><?php echo $order->name; ?></td>
                <td><?php echo $order->nama_brg; ?></td>
                <td><?php echo $order->jumlah; ?></td>
                <td><?php echo $total_pembelian; ?></td>
            </tr>
    <?php
        }
    } else {
    ?>
        <tr>
            <td colspan="5">Tidak ada data order</td>
        </tr>
    <?php
    }
    ?>
    <tr>
        <td colspan="4"><strong>Total Penjualan:</strong></td>
        <td><strong><?php echo $total_penjualan; ?></strong></td>
    </tr>
</table>
<br>
<br>
<div style="margin-top: 20px;">
    <div style="float:right;">
        Lhokseumawe, <?php echo date('j F Y'); ?><br>
        <br>
        <br>
        <br>
        <br>
        (Olivia Galfi)
    </div>
</div>
