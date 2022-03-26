-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.33 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table damar-futsal.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table damar-futsal.failed_jobs: ~0 rows (approximately)
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;

-- Dumping structure for table damar-futsal.inventory
CREATE TABLE IF NOT EXISTS `inventory` (
  `id_inventory` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT '1',
  `nama_barang` varchar(50) DEFAULT NULL,
  `jumlah` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id_inventory`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `FK_inventory_users` FOREIGN KEY (`role_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table damar-futsal.inventory: ~4 rows (approximately)
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` (`id_inventory`, `role_id`, `nama_barang`, `jumlah`, `created_at`, `updated_at`) VALUES
	(2, 1, 'SAPU', '2', NULL, '2022-02-18 19:24:48'),
	(12, 1, 'KURSI', '30', NULL, NULL),
	(19, 1, 'SEPATU', '2', NULL, NULL);
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;

-- Dumping structure for table damar-futsal.jadwal_pertandingan
CREATE TABLE IF NOT EXISTS `jadwal_pertandingan` (
  `id_pertandingan` int(11) NOT NULL AUTO_INCREMENT,
  `paket` int(11) DEFAULT NULL,
  `metode_pembayaran` int(11) DEFAULT '1',
  `flag_status` int(11) DEFAULT '1',
  `tanggal_pertandingan` date DEFAULT NULL,
  `jam_pertandingan` time DEFAULT NULL,
  `nama_tim` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_pertandingan`),
  KEY `paket` (`paket`),
  KEY `flag_status` (`flag_status`),
  KEY `metode_pembayaran` (`metode_pembayaran`),
  CONSTRAINT `FK_jadwal_pertandingan_jenis_pembayaran` FOREIGN KEY (`metode_pembayaran`) REFERENCES `jenis_pembayaran` (`id_pembayaran`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_jadwal_pertandingan_paket` FOREIGN KEY (`paket`) REFERENCES `paket` (`id_paket`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_jadwal_pertandingan_status_pesanan` FOREIGN KEY (`flag_status`) REFERENCES `status_pesanan` (`id_status_pesanan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table damar-futsal.jadwal_pertandingan: ~21 rows (approximately)
/*!40000 ALTER TABLE `jadwal_pertandingan` DISABLE KEYS */;
INSERT INTO `jadwal_pertandingan` (`id_pertandingan`, `paket`, `metode_pembayaran`, `flag_status`, `tanggal_pertandingan`, `jam_pertandingan`, `nama_tim`) VALUES
	(220, 0, 3, 4, '2021-09-03', '20:00:00', 'ROCK FC'),
	(221, 0, 3, 4, '2021-09-03', '21:00:00', 'ROCK FC'),
	(222, 0, 3, 4, '2021-09-10', '18:00:00', 'BRT'),
	(223, 0, 3, 4, '2021-09-03', '18:00:00', 'ROCK FC'),
	(224, 0, 3, 4, '2021-09-10', '20:00:00', 'ROCK FC'),
	(225, 0, 2, 4, '2021-09-04', '18:00:00', 'ROCK FC'),
	(226, 0, 2, 4, '2021-09-23', '21:00:00', 'ROCK FC'),
	(227, 0, 2, 4, '2021-09-04', '20:00:00', 'ROCK FC'),
	(228, 0, 2, 4, '2021-09-04', '17:00:00', 'ROCK FC'),
	(229, 0, 2, 4, '2021-09-11', '20:00:00', 'ROCK FC'),
	(230, 0, 2, 6, '2021-09-22', '17:00:00', 'ROCK FC'),
	(231, 0, 2, 6, '2021-09-20', '21:00:00', 'BRT'),
	(232, 0, 2, 6, '2021-09-24', '21:00:00', 'ROCK FC'),
	(233, 0, 2, 6, '2021-09-11', '18:00:00', 'ROCK FC'),
	(234, 0, 2, 6, '2021-09-22', '21:00:00', 'ROCK FC'),
	(235, 0, 2, 4, '2021-09-04', '21:00:00', 'ROCK FC'),
	(236, 0, 2, 4, '2021-09-17', '20:00:00', 'ROCK FC'),
	(237, 0, 2, 4, '2021-09-24', '16:00:00', 'ROCK FC'),
	(238, 0, 2, 4, '2021-09-10', '17:00:00', 'ROCK FC'),
	(239, 0, 2, 4, '2021-09-11', '17:00:00', 'ROCK FC'),
	(240, 3, 1, 4, '2021-09-07', '21:00:00', 'ROCK FC');
/*!40000 ALTER TABLE `jadwal_pertandingan` ENABLE KEYS */;

-- Dumping structure for table damar-futsal.jenis_pembayaran
CREATE TABLE IF NOT EXISTS `jenis_pembayaran` (
  `id_pembayaran` int(11) NOT NULL AUTO_INCREMENT,
  `diskripsi` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_pembayaran`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table damar-futsal.jenis_pembayaran: ~3 rows (approximately)
/*!40000 ALTER TABLE `jenis_pembayaran` DISABLE KEYS */;
INSERT INTO `jenis_pembayaran` (`id_pembayaran`, `diskripsi`) VALUES
	(1, 'DP'),
	(2, 'TRANSFER'),
	(3, 'BAYAR DI TEMPAT');
/*!40000 ALTER TABLE `jenis_pembayaran` ENABLE KEYS */;

-- Dumping structure for table damar-futsal.master_role
CREATE TABLE IF NOT EXISTS `master_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deskripsi` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table damar-futsal.master_role: ~4 rows (approximately)
/*!40000 ALTER TABLE `master_role` DISABLE KEYS */;
INSERT INTO `master_role` (`id`, `deskripsi`) VALUES
	(0, 'NON MEMBER'),
	(1, 'ADMIN'),
	(2, 'OWNER'),
	(3, 'MEMBER');
/*!40000 ALTER TABLE `master_role` ENABLE KEYS */;

-- Dumping structure for table damar-futsal.member
CREATE TABLE IF NOT EXISTS `member` (
  `id_member` int(11) NOT NULL AUTO_INCREMENT,
  `jadwal` int(11) NOT NULL DEFAULT '0',
  `id_user_member` int(11) NOT NULL DEFAULT '0',
  `bukti_tf` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id_member`),
  KEY `jadwal` (`jadwal`),
  KEY `id_user_member` (`id_user_member`),
  CONSTRAINT `FK_member_jadwal_pertandingan` FOREIGN KEY (`jadwal`) REFERENCES `jadwal_pertandingan` (`id_pertandingan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_member_users` FOREIGN KEY (`id_user_member`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table damar-futsal.member: ~20 rows (approximately)
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` (`id_member`, `jadwal`, `id_user_member`, `bukti_tf`, `created_at`, `updated_at`) VALUES
	(139, 220, 9, NULL, '2021-09-03 16:36:30', '2021-09-03 16:36:30'),
	(140, 221, 9, NULL, '2021-09-03 16:36:38', '2021-09-03 16:36:38'),
	(141, 222, 9, NULL, '2021-09-03 16:36:48', '2021-09-03 16:36:48'),
	(142, 223, 9, NULL, '2021-09-03 16:37:02', '2021-09-03 16:37:02'),
	(143, 224, 9, NULL, '2021-09-03 16:37:10', '2021-09-03 16:37:10'),
	(144, 225, 13, 'foto_resi_6132d820d4891.png', '2021-09-04 09:12:22', '2021-09-04 09:21:20'),
	(145, 226, 13, 'foto_resi_6132d820d4891.png', '2021-09-04 09:12:29', '2021-09-04 09:21:20'),
	(146, 227, 13, 'foto_resi_6132d820d4891.png', '2021-09-04 09:12:39', '2021-09-04 09:21:20'),
	(147, 228, 13, 'foto_resi_6132d820d4891.png', '2021-09-04 09:12:54', '2021-09-04 09:21:20'),
	(148, 229, 13, 'foto_resi_6132d820d4891.png', '2021-09-04 09:13:05', '2021-09-04 09:21:20'),
	(149, 230, 10, NULL, '2021-09-04 09:25:13', '2021-09-04 09:25:13'),
	(150, 231, 10, NULL, '2021-09-04 09:25:25', '2021-09-04 09:25:25'),
	(151, 232, 10, NULL, '2021-09-04 09:25:35', '2021-09-04 09:25:35'),
	(152, 233, 10, NULL, '2021-09-04 09:25:43', '2021-09-04 09:25:43'),
	(153, 234, 10, NULL, '2021-09-04 09:25:52', '2021-09-04 09:25:52'),
	(154, 235, 8, 'foto_resi_6132e055b8df0.png', '2021-09-04 09:52:46', '2021-09-04 09:56:21'),
	(155, 236, 8, 'foto_resi_6132e055b8df0.png', '2021-09-04 09:53:00', '2021-09-04 09:56:21'),
	(156, 237, 8, 'foto_resi_6132e055b8df0.png', '2021-09-04 09:53:13', '2021-09-04 09:56:21'),
	(157, 238, 8, 'foto_resi_6132e055b8df0.png', '2021-09-04 09:53:21', '2021-09-04 09:56:21'),
	(158, 239, 8, 'foto_resi_6132e055b8df0.png', '2021-09-04 09:56:05', '2021-09-04 09:56:21');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;

-- Dumping structure for table damar-futsal.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table damar-futsal.migrations: ~4 rows (approximately)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2019_08_19_000000_create_failed_jobs_table', 1),
	(4, '2021_07_04_143244_create_inventorys_table', 2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Dumping structure for table damar-futsal.non_member
CREATE TABLE IF NOT EXISTS `non_member` (
  `id_non_member` int(11) NOT NULL AUTO_INCREMENT,
  `jadwal` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT '0',
  `nama_pemesan` varchar(50) DEFAULT NULL,
  `bukti_tf` varchar(256) DEFAULT NULL,
  `tambahan_rompi` int(11) DEFAULT '0',
  `biaya_tambahan` int(11) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id_non_member`) USING BTREE,
  KEY `role_id` (`role_id`),
  KEY `jadwal` (`jadwal`),
  CONSTRAINT `FK_non_member_jadwal_pertandingan` FOREIGN KEY (`jadwal`) REFERENCES `jadwal_pertandingan` (`id_pertandingan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `non_member_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `master_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table damar-futsal.non_member: ~0 rows (approximately)
/*!40000 ALTER TABLE `non_member` DISABLE KEYS */;
INSERT INTO `non_member` (`id_non_member`, `jadwal`, `role_id`, `nama_pemesan`, `bukti_tf`, `tambahan_rompi`, `biaya_tambahan`, `created_at`, `updated_at`) VALUES
	(27, 240, 0, 'GALANG', 'foto_resi_61373cabd0d48.png', 4000, 10000, '2021-09-07 17:19:15', '2021-09-07 17:54:36');
/*!40000 ALTER TABLE `non_member` ENABLE KEYS */;

-- Dumping structure for table damar-futsal.paket
CREATE TABLE IF NOT EXISTS `paket` (
  `id_paket` int(11) NOT NULL AUTO_INCREMENT,
  `deskripsi` varchar(50) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL,
  `jenis_paket` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_paket`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table damar-futsal.paket: ~4 rows (approximately)
/*!40000 ALTER TABLE `paket` DISABLE KEYS */;
INSERT INTO `paket` (`id_paket`, `deskripsi`, `harga`, `jenis_paket`) VALUES
	(0, 'Member', 350000, 2),
	(1, 'Paket 1 (1 jam)', 50000, 1),
	(2, 'Paket 2 (1 jam + 2 Air Mineral 1,5L)', 60000, 1),
	(3, 'Paket 3 (1 jam + 2 Air Mineral 1,5L + 5  Rompi)', 70000, 1);
/*!40000 ALTER TABLE `paket` ENABLE KEYS */;

-- Dumping structure for table damar-futsal.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table damar-futsal.password_resets: ~0 rows (approximately)
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Dumping structure for table damar-futsal.snack
CREATE TABLE IF NOT EXISTS `snack` (
  `id_snack` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT '2',
  `nama_snack` varchar(50) DEFAULT NULL,
  `harga_jual` int(11) DEFAULT '0',
  `harga_beli` int(11) DEFAULT '0',
  `jumlah_masuk` int(11) DEFAULT '0',
  `tanggal_ditambahkan` datetime DEFAULT NULL,
  `tanggal_update` datetime DEFAULT NULL,
  `tanggal_keluar` datetime DEFAULT NULL,
  `jumlah_keluar` int(11) DEFAULT '0',
  `status_snack` int(11) DEFAULT '0',
  `tanggal_dihapus` date DEFAULT NULL,
  PRIMARY KEY (`id_snack`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `FK_snack_users` FOREIGN KEY (`role_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table damar-futsal.snack: ~5 rows (approximately)
/*!40000 ALTER TABLE `snack` DISABLE KEYS */;
INSERT INTO `snack` (`id_snack`, `role_id`, `nama_snack`, `harga_jual`, `harga_beli`, `jumlah_masuk`, `tanggal_ditambahkan`, `tanggal_update`, `tanggal_keluar`, `jumlah_keluar`, `status_snack`, `tanggal_dihapus`) VALUES
	(23, 2, 'TARO', 3000, 300000, 107, '2021-09-02 22:54:11', '2021-09-02 23:25:01', '2021-09-02 23:25:01', 108, 1, '2021-09-02'),
	(24, 2, 'TA', 2000, 300000, 312, '2021-09-02 23:33:25', NULL, NULL, 0, 1, '2021-09-02'),
	(25, 2, 'TEH GELAS', 3000, 40000, 120, '2021-09-02 23:34:46', NULL, NULL, 0, 1, '2021-09-03'),
	(26, 2, 'asdasd', 3000, 300000, 2, '2021-09-02 23:48:55', NULL, NULL, 0, 0, NULL),
	(27, 2, 'ASDASDAS', 3000, 300000, 312, '2021-09-02 23:57:30', '2021-09-02 23:57:30', NULL, 0, 0, NULL);
/*!40000 ALTER TABLE `snack` ENABLE KEYS */;

-- Dumping structure for table damar-futsal.status_pesanan
CREATE TABLE IF NOT EXISTS `status_pesanan` (
  `id_status_pesanan` int(11) NOT NULL AUTO_INCREMENT,
  `deskripsi` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_status_pesanan`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table damar-futsal.status_pesanan: ~7 rows (approximately)
/*!40000 ALTER TABLE `status_pesanan` DISABLE KEYS */;
INSERT INTO `status_pesanan` (`id_status_pesanan`, `deskripsi`) VALUES
	(1, 'PESANAN MASUK '),
	(2, 'PESANAN TELAH DI BAYAR DP'),
	(3, 'MENUNGGU PELUNASAN'),
	(4, 'PEMBAYARAN LUNAS'),
	(5, 'BATAL PESANAN'),
	(6, 'MENUNGGU PEMBAYARAN '),
	(7, 'MENUNGGU VALIDASI ADMIN');
/*!40000 ALTER TABLE `status_pesanan` ENABLE KEYS */;

-- Dumping structure for table damar-futsal.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT '3',
  `name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `FK_users_master_role` FOREIGN KEY (`role_id`) REFERENCES `master_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table damar-futsal.users: ~13 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `role_id`, `name`, `email`, `password`, `created_at`, `updated_at`) VALUES
	(1, 2, 'Owner Damar', 'ownerdamar@contoh.com', '$2y$10$em/yBRxE1bYnl0XwAgPJxOEj5qj8Dig1eyy/vcu2aoq', '2021-06-28 03:00:55', '2021-06-28 03:00:55'),
	(2, 1, 'Admin Damar', 'admindamar@contoh.com', '$2y$10$MhlJbacnt4ogqzS57hCbt.QpQ.pjL.2Rle50v36ud9Y', '2021-07-03 14:02:12', '2021-07-03 14:02:12'),
	(3, 3, 'Member Damar', 'memberdamar@contoh.com', '$2y$10$KNj5ehNhVdZGWcTzkiLAWeIvSk5nOs4s5ZncjBadDIL', '2021-07-03 15:44:23', '2021-07-03 15:44:23'),
	(4, 3, 'new', 'new@member.com', '$2y$10$wrjtvYe.u8M2r9x0UXvxjOd9fpkEgHX8qTq0D8D0EPt', '2021-08-02 01:45:25', '2021-08-02 01:45:25'),
	(5, 1, 'admin1', 'admin1@contoh.com', '$2y$10$q6V9lCGj1aBAsz.tttYvw.IIOHWVwPow3VprNytD6Y0kSvx7fqC7O', '2021-08-02 07:15:10', '2021-08-02 07:15:10'),
	(7, 2, 'owner', 'owner@damar.com', '$2y$10$UZf3/6yCKeq7Ko3iPLKAi.SnLx3IiDfU5X.gDEA.N2DaANKu3t7aa', '2021-08-03 10:44:54', '2021-08-03 10:44:54'),
	(8, 3, 'fauzan', 'fauzan@member.com', '$2y$10$WKXmrfQEbZIaAOvywEJqh.Zzn2COJ8nldmXxQbP9b5A0JMGJ7KJ1.', '2021-08-07 05:54:01', '2021-08-07 05:54:01'),
	(9, 3, 'rendi', 'rendi@damar.com', '$2y$10$NbUDFSB5VqLepg7zp0lho.dCkCOYVXTZh02koQAwVnvqMBo0GOy9C', '2021-08-07 11:54:40', '2021-08-07 11:54:40'),
	(10, 3, 'regar', 'regar@gmail.com', '$2y$10$VsIzfPhG105FFltzWEB3luj0QqDB9ysA27Txt9gdgh3fe5GmPD/zG', '2021-08-13 10:25:51', '2021-08-13 10:25:51'),
	(11, 3, 'gilang', 'gilang@gmail.com', '$2y$10$WLGvbHBSw8lB8Oo1FN8rueEQno4do3/p4AqpXpWbSCrL5ZVpX0EbG', '2021-08-19 04:44:56', '2021-08-19 04:44:56'),
	(12, 3, 'nazri', 'nazri@gmail.com', '$2y$10$V9GKSrQM51.k7umNYFin9O9hy.RP6PFBT0I/4aJSs4pdItuR8yu0G', '2021-08-19 04:47:28', '2021-08-19 04:47:28'),
	(13, 3, 'fani', 'fani@gmail.com', '$2y$10$k21mfOILdEdjuNnZroPPzuBo7TpAel0XwBd5uMeXdDKuR6NxHPXlO', '2021-09-02 15:20:35', '2021-09-02 15:20:35'),
	(14, 3, 'drupadi', 'drupadi@gmail.com', '$2y$10$qzrQ/6meNOktlG8n6tB3hONq9eFXJmxJr258VeEBiFCGxjkNecXji', '2021-09-03 03:04:48', '2021-09-03 03:04:48'),
	(15, 2, 'Admin Damar', 'owner_damar@gmail.com', '$2y$10$aoK10gfZrLrYi7tnRjmWj.wcbWobTPVAvasl4R8/oMu8eV9lr5W8a', '2022-02-18 12:24:00', '2022-02-18 12:24:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
