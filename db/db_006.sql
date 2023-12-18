-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 08, 2023 at 07:12 AM
-- Server version: 10.1.29-MariaDB
-- PHP Version: 7.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_006`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `nmr` ()  SET @num = (SELECT max(num)+1 FROM tb_num);$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tb_brg`
--

CREATE TABLE `tb_brg` (
  `rowid` int(11) NOT NULL,
  `kd_brg` varchar(50) DEFAULT NULL,
  `nama_brg` varchar(200) DEFAULT NULL,
  `uom` varchar(10) DEFAULT NULL,
  `harga_beli` float DEFAULT NULL,
  `harga_jual` float DEFAULT NULL,
  `sts` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_brg`
--

INSERT INTO `tb_brg` (`rowid`, `kd_brg`, `nama_brg`, `uom`, `harga_beli`, `harga_jual`, `sts`) VALUES
(1, 'Tes', 'Tes barang', 'PACK', 1500, 1700, NULL),
(4, 'kd brg 0001', 'kopi kapal api', 'PCS', 2200, 2500, NULL),
(6, 'kd 0003', 'kopi torabika', 'PCS', 2500, 3000, NULL),
(7, 'kd 0007', 'kopi luwak hitam', 'PCS', 2500, 2700, NULL),
(8, 'kd brg 009', 'kopi excelso', 'PCS', 3500, 3700, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tb_grup_brg`
--

CREATE TABLE `tb_grup_brg` (
  `id_grup` tinyint(4) NOT NULL,
  `grup` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tb_harga`
--

CREATE TABLE `tb_harga` (
  `id_harga` int(11) NOT NULL,
  `id_brg` int(11) DEFAULT NULL,
  `harga_beli` float DEFAULT NULL,
  `harga_jual` float DEFAULT NULL,
  `crid` tinyint(4) DEFAULT NULL,
  `crdt` date DEFAULT NULL,
  `sts` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tb_num`
--

CREATE TABLE `tb_num` (
  `num` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_num`
--

INSERT INTO `tb_num` (`num`) VALUES
(1),
(1);

-- --------------------------------------------------------

--
-- Table structure for table `tb_pay`
--

CREATE TABLE `tb_pay` (
  `rowid` int(11) NOT NULL,
  `trid` int(11) DEFAULT NULL,
  `total_price` float DEFAULT NULL,
  `pay` float DEFAULT NULL,
  `changes` float DEFAULT NULL,
  `crid` tinyint(4) DEFAULT NULL,
  `crdt` date DEFAULT NULL,
  `sts` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tb_stock`
--

CREATE TABLE `tb_stock` (
  `rowid` int(11) NOT NULL,
  `id_brg` int(11) DEFAULT NULL,
  `qty` float DEFAULT NULL,
  `uom` tinyint(4) DEFAULT NULL,
  `crid` tinyint(4) DEFAULT NULL,
  `crdt` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_stock`
--

INSERT INTO `tb_stock` (`rowid`, `id_brg`, `qty`, `uom`, `crid`, `crdt`) VALUES
(1, 8, 200, 0, NULL, NULL),
(2, 4, 150, 0, NULL, NULL),
(3, 8, 0, 0, NULL, NULL),
(4, 8, 0, 0, NULL, NULL),
(5, 4, 10, 0, NULL, NULL),
(6, 4, 5, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tb_tr`
--

CREATE TABLE `tb_tr` (
  `rowid` int(11) NOT NULL,
  `trid` int(11) DEFAULT NULL,
  `id_brg` int(11) DEFAULT NULL,
  `harga` float DEFAULT NULL,
  `qty` float DEFAULT NULL,
  `uom` tinyint(4) DEFAULT NULL,
  `crid` tinyint(4) DEFAULT NULL,
  `crdt` date DEFAULT NULL,
  `sts` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tb_uom`
--

CREATE TABLE `tb_uom` (
  `id_uom` tinyint(11) NOT NULL,
  `uom` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_uom`
--

INSERT INTO `tb_uom` (`id_uom`, `uom`) VALUES
(1, 'PCS'),
(2, 'SACHET'),
(3, 'RENTENG'),
(4, 'PACK'),
(5, 'BOTOL'),
(6, 'KARTON'),
(7, 'BOX'),
(8, 'KG'),
(9, 'LTR');

-- --------------------------------------------------------

--
-- Table structure for table `tb_uom2`
--

CREATE TABLE `tb_uom2` (
  `rowid` int(11) NOT NULL,
  `id_brg` int(11) DEFAULT NULL,
  `qty_uom` float DEFAULT NULL,
  `uom` tinyint(4) DEFAULT NULL,
  `qty_biguom` float DEFAULT NULL,
  `biguom` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tb_usr`
--

CREATE TABLE `tb_usr` (
  `id_usr` tinyint(4) NOT NULL,
  `nama` varchar(20) DEFAULT NULL,
  `sandi` varchar(200) DEFAULT NULL,
  `sts` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_usr`
--

INSERT INTO `tb_usr` (`id_usr`, `nama`, `sandi`, `sts`) VALUES
(1, 'pipi', 'admin7', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_brg`
--
ALTER TABLE `tb_brg`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `kd_brg` (`kd_brg`);

--
-- Indexes for table `tb_grup_brg`
--
ALTER TABLE `tb_grup_brg`
  ADD PRIMARY KEY (`id_grup`),
  ADD KEY `id_grup` (`id_grup`);

--
-- Indexes for table `tb_harga`
--
ALTER TABLE `tb_harga`
  ADD PRIMARY KEY (`id_harga`),
  ADD KEY `id_brg` (`id_brg`);

--
-- Indexes for table `tb_pay`
--
ALTER TABLE `tb_pay`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `trid` (`trid`);

--
-- Indexes for table `tb_stock`
--
ALTER TABLE `tb_stock`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `id_brg` (`id_brg`);

--
-- Indexes for table `tb_tr`
--
ALTER TABLE `tb_tr`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `trid` (`trid`);

--
-- Indexes for table `tb_uom`
--
ALTER TABLE `tb_uom`
  ADD PRIMARY KEY (`id_uom`),
  ADD KEY `id_uom` (`id_uom`);

--
-- Indexes for table `tb_uom2`
--
ALTER TABLE `tb_uom2`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `id_brg` (`id_brg`);

--
-- Indexes for table `tb_usr`
--
ALTER TABLE `tb_usr`
  ADD PRIMARY KEY (`id_usr`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_brg`
--
ALTER TABLE `tb_brg`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tb_grup_brg`
--
ALTER TABLE `tb_grup_brg`
  MODIFY `id_grup` tinyint(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_harga`
--
ALTER TABLE `tb_harga`
  MODIFY `id_harga` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_pay`
--
ALTER TABLE `tb_pay`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_stock`
--
ALTER TABLE `tb_stock`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tb_tr`
--
ALTER TABLE `tb_tr`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_uom`
--
ALTER TABLE `tb_uom`
  MODIFY `id_uom` tinyint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tb_uom2`
--
ALTER TABLE `tb_uom2`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_usr`
--
ALTER TABLE `tb_usr`
  MODIFY `id_usr` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
