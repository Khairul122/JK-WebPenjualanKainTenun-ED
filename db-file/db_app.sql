-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 28 Jun 2024 pada 06.02
-- Versi server: 10.3.16-MariaDB
-- Versi PHP: 7.1.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_app`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `id_user` varchar(25) NOT NULL,
  `id_invoice` varchar(30) NOT NULL,
  `id_brg` int(11) NOT NULL,
  `nama_brg` varchar(255) NOT NULL,
  `jumlah` int(3) NOT NULL,
  `harga` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `cart`
--

INSERT INTO `cart` (`id`, `id_user`, `id_invoice`, `id_brg`, `nama_brg`, `jumlah`, `harga`) VALUES
(37, '12', 'INV-52171021', 13, 'Tenun Ikat', 1, 100000);

--
-- Trigger `cart`
--
DELIMITER $$
CREATE TRIGGER `pesanan_penjualan` AFTER INSERT ON `cart` FOR EACH ROW BEGIN
	UPDATE product SET stok = stok-NEW.jumlah
    WHERE id_brg = NEW.id_brg;
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `id_kategori` int(11) NOT NULL,
  `nama_kategori` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `nama_kategori`) VALUES
(1, 'Tenun'),
(2, 'Songket'),
(3, 'Ulos\r\n');

-- --------------------------------------------------------

--
-- Struktur dari tabel `product`
--

CREATE TABLE `product` (
  `id_brg` int(11) NOT NULL,
  `nama_brg` varchar(255) NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `kategori` varchar(60) NOT NULL,
  `harga` int(11) NOT NULL,
  `stok` int(4) NOT NULL,
  `gambar` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `product`
--

INSERT INTO `product` (`id_brg`, `nama_brg`, `keterangan`, `kategori`, `harga`, `stok`, `gambar`) VALUES
(18, 'Kain Tenun Sarung Lombok', 'Dibuat dengan teknik tenun tangan, kain ini mencerminkan keindahan budaya dan kerajinan khas Lombok.', 'Tenun', 150000, 100, 'kain_lombok_new.png'),
(19, 'Kain Tenun Endek Bali', 'Kain Tenun Endek Bali adalah kain tradisional Bali yang dibuat dengan teknik ikat. Memiliki motif unik dan warna-warna cerah, kain ini sering digunakan dalam pakaian adat dan upacara keagamaan.', 'Tenun', 100000, 50, 'kain_bali_new.jpg'),
(20, 'Kain Tenun Lurik', 'Kain Tenun Lurik adalah kain tradisional Jawa dengan motif garis-garis sederhana namun elegan. Dibuat dengan teknik tenun tangan, kain ini sering digunakan dalam pakaian adat dan memiliki makna filosofis mendalam.', 'Tenun', 110000, 70, 'lurik_new.jpg'),
(21, 'Kain Ulos Batak Toba', 'Kain tenun ulos Batak Toba adalah salah satu warisan budaya dari suku Batak Toba di Sumatera Utara, Indonesia.', 'Ulos\r\n', 170000, 30, 'ulos_batak_toba.jpg'),
(22, 'Kain Ulos Bintang Maratur', 'Ulos ini dinamakan berdasarkan motif bintangnya yang teratur dan simetris, melambangkan ketertiban dan keharmonisan.', 'Ulos\r\n', 140000, 20, 'ulos_bintang_maratur.jpeg'),
(23, 'Kain Ulos Ragi Hotang', 'Ulos Ragi Hotang memiliki makna khusus yang terkait dengan kesetiaan dan kesucian. \"Ragi\" berarti dasar atau inti, dan \"Hotang\" adalah jenis rotan yang kuat.', 'Ulos\r\n', 160000, 60, 'ulos_ragi_hotang.JPG'),
(24, 'Kain Songket Palembang', 'Berasal dari Sumatera Selatan, terkenal dengan motif yang rumit dan penggunaan benang emas.', 'Songket', 200000, 150, 'songket_palembang.jpeg'),
(25, 'Kain Songket Minang Kabau', 'Dari Sumatera Barat, memiliki motif yang mencerminkan budaya Minangkabau, seperti motif pucuak rabuang (bambu muda).', 'Songket', 185000, 80, 'Songket_Minangkabau.jpg'),
(26, 'Kain Songket Bugis', 'Dari Sulawesi Selatan, biasanya menggunakan warna-warna cerah dan motif geometris.', 'Songket', 125000, 40, 'songket_bugis.jpeg'),
(27, 'Kain Tenun Sasirangan ', 'Kain tenun sasirangan adalah kain tradisional yang berasal dari Kalimantan Selatan, Indonesia. Kain ini terkenal dengan teknik pewarnaan ikat celup yang khas dan unik.', 'Tenun', 100000, 30, 'kain_sasirangan.jpg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaction`
--

CREATE TABLE `transaction` (
  `order_id` char(30) NOT NULL,
  `id_user` varchar(5) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(225) NOT NULL,
  `total` decimal(10,3) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `mobile_phone` varchar(15) NOT NULL,
  `city` varchar(255) NOT NULL,
  `kode_pos` varchar(100) NOT NULL,
  `payment_method` varchar(100) NOT NULL,
  `ekspedisi` varchar(100) NOT NULL,
  `tracking_id` varchar(30) NOT NULL,
  `transaction_time` datetime DEFAULT NULL,
  `payment_limit` datetime DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `gambar` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `transaction`
--

INSERT INTO `transaction` (`order_id`, `id_user`, `name`, `email`, `total`, `alamat`, `mobile_phone`, `city`, `kode_pos`, `payment_method`, `ekspedisi`, `tracking_id`, `transaction_time`, `payment_limit`, `status`, `gambar`) VALUES
('INV-52171021', '12', 'olivia', 'oliviagalfi@gmail.com', '100.000', 'blangpulo', '0897987867', 'Pandeglang', '76796', 'Transfer Bank Langsung', 'J&T Express', '869266596234', '2024-06-25 23:45:27', '2024-06-26 23:45:27', '1', 'kain_tenun2.jpeg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `nama_user` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `level` varchar(255) NOT NULL,
  `avatar` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `nama_user`, `email`, `password`, `level`, `avatar`) VALUES
(6, 'Admin', 'admin@gmail.com', '21232f297a57a5a743894a0e4a801fc3', '1', 'user.png'),
(12, 'olivia', 'oliviagalfi@gmail.com', 'b79c7a7852c3845303593f4a335cc8d0', '2', 'user.png');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indeks untuk tabel `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id_brg`);

--
-- Indeks untuk tabel `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`order_id`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT untuk tabel `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `product`
--
ALTER TABLE `product`
  MODIFY `id_brg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
