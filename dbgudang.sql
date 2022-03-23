-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 23 Mar 2022 pada 10.58
-- Versi server: 10.4.22-MariaDB
-- Versi PHP: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbgudang`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE `barang` (
  `brgkode` char(10) NOT NULL,
  `brgnama` varchar(100) NOT NULL,
  `brgkatid` int(10) UNSIGNED NOT NULL,
  `brgsatid` int(10) UNSIGNED NOT NULL,
  `brgharga` double NOT NULL,
  `brggambar` varchar(200) NOT NULL,
  `brgstok` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`brgkode`, `brgnama`, `brgkatid`, `brgsatid`, `brgharga`, `brggambar`, `brgstok`) VALUES
('as', 'PB 9 mm 4 x 80', 1, 1, 200000, 'as.jpg', 0),
('pb001', 'PB 9 mm 4 x 8', 1, 1, 190000, 'pb001.jpg', 10);

-- --------------------------------------------------------

--
-- Struktur dari tabel `barangkeluar`
--

CREATE TABLE `barangkeluar` (
  `faktur` char(20) NOT NULL,
  `tglfaktur` date NOT NULL,
  `idpel` int(11) NOT NULL,
  `totalharga` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `barangmasuk`
--

CREATE TABLE `barangmasuk` (
  `faktur` char(20) CHARACTER SET utf8 NOT NULL,
  `tglfaktur` date NOT NULL,
  `totalharga` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `barangmasuk`
--

INSERT INTO `barangmasuk` (`faktur`, `tglfaktur`, `totalharga`) VALUES
('F-001', '2022-03-22', 1800000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_barangkeluar`
--

CREATE TABLE `detail_barangkeluar` (
  `id` bigint(20) NOT NULL,
  `detfaktur` char(20) NOT NULL,
  `detbrgkode` char(20) NOT NULL,
  `dethargajual` double NOT NULL,
  `detjml` int(11) NOT NULL,
  `detsubtotal` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_barangmasuk`
--

CREATE TABLE `detail_barangmasuk` (
  `iddetail` int(11) NOT NULL,
  `detfaktur` char(20) CHARACTER SET utf8 NOT NULL,
  `detbrgkode` char(20) CHARACTER SET utf8 NOT NULL,
  `dethargamasuk` double NOT NULL,
  `dethargajual` double NOT NULL,
  `detjml` int(11) NOT NULL,
  `detsubtotal` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `detail_barangmasuk`
--

INSERT INTO `detail_barangmasuk` (`iddetail`, `detfaktur`, `detbrgkode`, `dethargamasuk`, `dethargajual`, `detjml`, `detsubtotal`) VALUES
(25, 'F-001', 'pb001', 180000, 190000, 10, 1800000);

--
-- Trigger `detail_barangmasuk`
--
DELIMITER $$
CREATE TRIGGER `tri_kurangi_stok_barang` AFTER DELETE ON `detail_barangmasuk` FOR EACH ROW BEGIN
UPDATE barang SET brgstok = brgstok - old.detjml WHERE brgkode = old.detbrgkode;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tri_tambah_stok_barang` AFTER INSERT ON `detail_barangmasuk` FOR EACH ROW BEGIN
	UPDATE barang SET brgstok = brgstok+NEW.detjml WHERE brgkode = NEW.detbrgkode;
    END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tri_update_stok_barang` AFTER UPDATE ON `detail_barangmasuk` FOR EACH ROW BEGIN
UPDATE barang SET brgstok = (brgstok - old.detjml) + new.detjml WHERE brgkode = new.detbrgkode;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `katid` int(10) UNSIGNED NOT NULL,
  `katnama` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`katid`, `katnama`) VALUES
(1, 'Bahan Baku');

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `group` varchar(255) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `batch` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `version`, `class`, `group`, `namespace`, `time`, `batch`) VALUES
(1, '2022-03-14-114433', 'App\\Database\\Migrations\\Kategori', 'default', 'App', 1647498360, 1),
(2, '2022-03-14-114441', 'App\\Database\\Migrations\\Satuan', 'default', 'App', 1647498361, 1),
(3, '2022-03-14-114449', 'App\\Database\\Migrations\\Barang', 'default', 'App', 1647498362, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggan`
--

CREATE TABLE `pelanggan` (
  `pelid` int(11) NOT NULL,
  `pelnama` varchar(100) NOT NULL,
  `peltelp` char(20) NOT NULL,
  `pelalamat` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `satuan`
--

CREATE TABLE `satuan` (
  `satid` int(10) UNSIGNED NOT NULL,
  `satnama` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `satuan`
--

INSERT INTO `satuan` (`satid`, `satnama`) VALUES
(1, 'Lembar'),
(2, 'Piece');

-- --------------------------------------------------------

--
-- Struktur dari tabel `temp_barangkeluar`
--

CREATE TABLE `temp_barangkeluar` (
  `id` bigint(20) NOT NULL,
  `detfaktur` char(20) NOT NULL,
  `detbrgkode` char(20) NOT NULL,
  `dethargajual` double NOT NULL,
  `detjml` int(11) NOT NULL,
  `detsubtotal` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `temp_barangmasuk`
--

CREATE TABLE `temp_barangmasuk` (
  `iddetail` bigint(20) NOT NULL,
  `detfaktur` char(20) CHARACTER SET utf8 NOT NULL,
  `detbrgkode` char(20) CHARACTER SET utf8 NOT NULL,
  `dethargamasuk` double NOT NULL,
  `dethargajual` double NOT NULL,
  `detjml` int(11) NOT NULL,
  `detsubtotal` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`brgkode`),
  ADD KEY `barang_brgkatid_foreign` (`brgkatid`),
  ADD KEY `barang_brgsatid_foreign` (`brgsatid`);

--
-- Indeks untuk tabel `barangkeluar`
--
ALTER TABLE `barangkeluar`
  ADD PRIMARY KEY (`faktur`);

--
-- Indeks untuk tabel `barangmasuk`
--
ALTER TABLE `barangmasuk`
  ADD PRIMARY KEY (`faktur`);

--
-- Indeks untuk tabel `detail_barangkeluar`
--
ALTER TABLE `detail_barangkeluar`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `detail_barangmasuk`
--
ALTER TABLE `detail_barangmasuk`
  ADD PRIMARY KEY (`iddetail`) USING BTREE,
  ADD KEY `barang` (`detbrgkode`),
  ADD KEY `barangmasuk` (`detfaktur`);

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD KEY `katid` (`katid`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`pelid`);

--
-- Indeks untuk tabel `satuan`
--
ALTER TABLE `satuan`
  ADD KEY `satid` (`satid`);

--
-- Indeks untuk tabel `temp_barangkeluar`
--
ALTER TABLE `temp_barangkeluar`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `temp_barangmasuk`
--
ALTER TABLE `temp_barangmasuk`
  ADD PRIMARY KEY (`iddetail`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `detail_barangkeluar`
--
ALTER TABLE `detail_barangkeluar`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `detail_barangmasuk`
--
ALTER TABLE `detail_barangmasuk`
  MODIFY `iddetail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT untuk tabel `kategori`
--
ALTER TABLE `kategori`
  MODIFY `katid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `pelid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `satuan`
--
ALTER TABLE `satuan`
  MODIFY `satid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `temp_barangkeluar`
--
ALTER TABLE `temp_barangkeluar`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `temp_barangmasuk`
--
ALTER TABLE `temp_barangmasuk`
  MODIFY `iddetail` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_brgkatid_foreign` FOREIGN KEY (`brgkatid`) REFERENCES `kategori` (`katid`),
  ADD CONSTRAINT `barang_brgsatid_foreign` FOREIGN KEY (`brgsatid`) REFERENCES `satuan` (`satid`);

--
-- Ketidakleluasaan untuk tabel `detail_barangmasuk`
--
ALTER TABLE `detail_barangmasuk`
  ADD CONSTRAINT `barang` FOREIGN KEY (`detbrgkode`) REFERENCES `barang` (`brgkode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barangmasuk` FOREIGN KEY (`detfaktur`) REFERENCES `barangmasuk` (`faktur`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
