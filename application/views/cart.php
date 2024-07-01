<div class="content">
    <div class="intro-y flex flex-col sm:flex-row items-center mt-8">
        <h2 class="text-lg font-medium mr-auto">
            Detail Keranjang
        </h2>
        <div class="w-full sm:w-auto flex mt-4 sm:mt-0">
            <a href="<?= site_url('dashboard/clear') ?>" class="btn btn-primary shadow-md mr-2">Kosongkan Keranjang</a>
            <a href="<?= site_url('dashboard') ?>" class="btn btn-danger shadow-md mr-2">Lanjut Belanja</a>
        </div>
    </div>
    <!-- MULAI: Detail Transaksi -->
    <div class="intro-y grid grid-cols-11 gap-5 mt-5">
        <div class="col-span-12 lg:col-span-12 2xl:col-span-8">
            <div class="box p-5 rounded-md">
                <div class="flex items-center border-b border-slate-200/60 dark:border-darkmode-400 pb-5 mb-5">
                    <div class="font-medium text-base truncate">Detail Pesanan</div>
                    <a href="<?= site_url('dashboard/checkout') ?>" class="flex items-center ml-auto btn btn-primary shadow-md mr-2"><i data-lucide="activity" class="w-4 h-4 mr-2"></i>&nbsp;CHECKOUT </a>
                </div>
                <div class="overflow-auto lg:overflow-visible -mt-3">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th></th>
                                <th class="whitespace-nowrap !py-5">Produk</th>
                                <th class="whitespace-nowrap">Keterangan</th> <!-- Ganti kolom ke Keterangan -->
                                <th class="whitespace-nowrap text-right">Harga Satuan</th>
                                <th class="whitespace-nowrap text-right">Jumlah</th>
                                <th class="whitespace-nowrap text-right"style="width: 150px;">Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php $no = 1;
                            foreach ($this->cart->contents() as $items) : ?>
                                <tr>
                                    <td><i class="fa fa-trash" data-rowid="<?= $items['rowid']; ?>" onclick="removeFromCart('<?= $items['rowid']; ?>')"></i></td>
                                    <td class="!py-4">
                                        <div class="flex items-center">
                                            <div class="w-10 h-10 image-fit zoom-in">
                                                <img alt="Midone - HTML Admin Template" class="rounded-lg border-2 border-white shadow-md tooltip" src="<?= base_url() . '/uploads/' . $items['options']['gambar']; ?>" title="Diunggah pada 8 Desember 2021">
                                            </div>
                                            <a href="" class="font-medium whitespace-nowrap ml-4"><?= $items['name']; ?></a>
                                        </div>
                                    </td>
                                    <td><?= $items['options']['keterangan']; ?></td> <!-- Menampilkan keterangan -->
                                    <td class="text-right">Rp. <?= number_format($items['price'], 0, ',', '.') ?></td>
                                    <td class="text-right"><?= number_format($items['qty'], 0, ',', '.') ?></td>
                                    <td class="text-right">Rp. <?= number_format($items['subtotal'], 0, ',', '.') ?></td>
                                </tr>
                            <?php endforeach; ?>
                            <tr>
                                <td colspan="4"></td>
                                <td class="text-right"colspan="2"><strong>Total Harga : Rp. <?= number_format($this->cart->total(), 0, ',', '.') ?>,-</strong></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- SELESAI: Detail Transaksi -->
</div>

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

<script>
    function removeFromCart(rowid) {
        $.ajax({
            url: '<?= site_url('dashboard/remove_from_cart') ?>',
            method: 'POST',
            data: { rowid: rowid },
            success: function(response) {
                location.reload();
            }
        });
    }
</script>
