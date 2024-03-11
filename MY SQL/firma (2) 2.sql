-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 19, 2021 at 01:42 PM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `firma`
--
CREATE DATABASE IF NOT EXISTS `firma` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `firma`;

-- --------------------------------------------------------

--
-- Table structure for table `angajati`
--

DROP TABLE IF EXISTS `angajati`;
CREATE TABLE `angajati` (
  `id` int(11) NOT NULL,
  `nume` varchar(255) DEFAULT NULL,
  `prenume` varchar(255) DEFAULT NULL,
  `data_nasterii` date DEFAULT NULL,
  `pozitie` varchar(255) DEFAULT NULL,
  `departament` varchar(255) DEFAULT NULL,
  `salariu` int(11) DEFAULT 1000,
  `data_angajarii` date DEFAULT '2019-01-01'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `angajati`
--

INSERT INTO `angajati` (`id`, `nume`, `prenume`, `data_nasterii`, `pozitie`, `departament`, `salariu`, `data_angajarii`) VALUES
(1, 'Florea', 'Bogdan', '1983-03-27', 'Programator', 'Soft', 5500, '2016-09-28'),
(2, 'Patrascu', 'Ana', '1987-12-12', 'Secretara', 'Marketing', 3000, '2017-07-18'),
(3, 'Mihalache', 'George', '1977-09-14', 'Director', 'Management', 9000, '2016-06-29'),
(4, 'Stoian', 'Carmelita', '1983-06-06', 'Vanzator', 'Sales', 5500, '2019-10-14'),
(5, 'Ionescu', 'Andrei', '1982-08-15', NULL, NULL, 1500, '2017-06-25'),
(6, 'Harabor', 'Cristian', '2000-05-29', 'Inspector', 'Sales', 4500, '2018-01-03'),
(7, 'Harabor', 'Ion', '2000-12-19', 'Director', 'Sales', 9650, '2016-08-02'),
(8, 'Harabor', 'Maria', '2000-04-09', 'Manager', 'Sales', 7650, '2018-11-12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `angajati`
--
ALTER TABLE `angajati`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `angajati`
--
ALTER TABLE `angajati`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
