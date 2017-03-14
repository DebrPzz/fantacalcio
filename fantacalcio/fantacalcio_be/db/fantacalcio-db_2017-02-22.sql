-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 22, 2017 at 11:33 AM
-- Server version: 5.6.34
-- PHP Version: 7.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fantacalcio`
--

-- --------------------------------------------------------

--
-- Table structure for table `calciatore`
--

CREATE TABLE `calciatore` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `ruolo` varchar(50) NOT NULL,
  `squadra_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `calciatore`
--

INSERT INTO `calciatore` (`id`, `nome`, `ruolo`, `squadra_id`) VALUES
(1, 'Brontolo', 'portiere', 1),
(2, 'Eolo', 'portiere', 2),
(3, 'Gongolo', 'portiere', 3),
(5, 'Nemo', 'difensore', 1),
(6, 'Dory', 'difensore', 2),
(7, 'Squalo', 'difensore', 3),
(9, 'Simba', 'difensore', 1),
(10, 'Scar', 'difensore', 2),
(11, 'Zazu', 'difensore', 3),
(13, 'Lilo', 'centrocampista', 1),
(14, 'Scattecat', 'attaccante', 2),
(15, 'Romeo', 'attaccante', 3),
(17, 'Mulan', 'attaccante', 1),
(18, 'Leia', 'attaccante', 2),
(19, 'Yoda', 'attaccante', 3);

-- --------------------------------------------------------

--
-- Table structure for table `calendario`
--

CREATE TABLE `calendario` (
  `id` int(11) NOT NULL,
  `goalcasa` int(11) NOT NULL,
  `goalospite` int(11) NOT NULL,
  `squadra_id` int(11) NOT NULL,
  `ospite_id` int(11) NOT NULL,
  `data` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `calendario`
--

INSERT INTO `calendario` (`id`, `goalcasa`, `goalospite`, `squadra_id`, `ospite_id`, `data`) VALUES
(2, 3, 4, 2, 3, '2017-02-02 00:00:00'),
(4, 2, 2, 3, 1, '2017-01-10 00:00:00');

-- --------------------------------------------------------

--
-- Stand-in structure for view `giocatore`
-- (See below for the actual view)
--
CREATE TABLE `giocatore` (
`id` int(11)
,`nome` varchar(50)
,`ruolo` varchar(50)
,`denominazione` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `partite`
-- (See below for the actual view)
--
CREATE TABLE `partite` (
`id` int(11)
,`squadracasa` varchar(50)
,`squadraospite` varchar(50)
,`goalcasa` int(11)
,`goalospite` int(11)
,`data` datetime
);

-- --------------------------------------------------------

--
-- Table structure for table `squadra`
--

CREATE TABLE `squadra` (
  `id` int(11) NOT NULL,
  `allenatore` varchar(50) NOT NULL,
  `denominazione` varchar(50) NOT NULL,
  `datafondazione` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `squadra`
--

INSERT INTO `squadra` (`id`, `allenatore`, `denominazione`, `datafondazione`) VALUES
(1, 'Petro Barbetti', 'Albinoleffe', '1961-02-04 00:00:00'),
(2, 'Marco Rossi', 'Torino', '1973-03-11 00:00:00'),
(3, 'Giuliano Pesce', 'Cagliari', '1982-05-24 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `votazione`
--

CREATE TABLE `votazione` (
  `id` int(11) NOT NULL,
  `calciatore_id` int(11) NOT NULL,
  `calendario_id` int(11) NOT NULL,
  `voto` decimal(3,1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `votazione`
--

INSERT INTO `votazione` (`id`, `calciatore_id`, `calendario_id`, `voto`) VALUES
(5, 15, 2, '7.0'),
(6, 19, 2, '8.0'),
(7, 10, 2, '6.5'),
(8, 2, 2, '5.5');

-- --------------------------------------------------------

--
-- Structure for view `giocatore`
--
DROP TABLE IF EXISTS `giocatore`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `giocatore`  AS  select `calciatore`.`id` AS `id`,`calciatore`.`nome` AS `nome`,`calciatore`.`ruolo` AS `ruolo`,`squadra`.`denominazione` AS `denominazione` from (`calciatore` left join `squadra` on((`calciatore`.`squadra_id` = `squadra`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `partite`
--
DROP TABLE IF EXISTS `partite`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `partite`  AS  select `calendario`.`id` AS `id`,`casa`.`denominazione` AS `squadracasa`,`ospite`.`denominazione` AS `squadraospite`,`calendario`.`goalcasa` AS `goalcasa`,`calendario`.`goalospite` AS `goalospite`,`calendario`.`data` AS `data` from ((`calendario` left join `squadra` `casa` on((`calendario`.`squadra_id` = `casa`.`id`))) left join `squadra` `ospite` on((`calendario`.`ospite_id` = `ospite`.`id`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `calciatore`
--
ALTER TABLE `calciatore`
  ADD PRIMARY KEY (`id`),
  ADD KEY `squadra_id` (`squadra_id`);

--
-- Indexes for table `calendario`
--
ALTER TABLE `calendario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ospite_id` (`ospite_id`,`data`) USING BTREE,
  ADD KEY `squadra_id` (`squadra_id`);

--
-- Indexes for table `squadra`
--
ALTER TABLE `squadra`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `votazione`
--
ALTER TABLE `votazione`
  ADD PRIMARY KEY (`id`),
  ADD KEY `calciatore_id` (`calciatore_id`),
  ADD KEY `calendario_id` (`calendario_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `calciatore`
--
ALTER TABLE `calciatore`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `calendario`
--
ALTER TABLE `calendario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `squadra`
--
ALTER TABLE `squadra`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `votazione`
--
ALTER TABLE `votazione`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `calciatore`
--
ALTER TABLE `calciatore`
  ADD CONSTRAINT `calciatore_ibfk_1` FOREIGN KEY (`squadra_id`) REFERENCES `squadra` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `calendario`
--
ALTER TABLE `calendario`
  ADD CONSTRAINT `calendario_ibfk_1` FOREIGN KEY (`squadra_id`) REFERENCES `squadra` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `calendario_ibfk_2` FOREIGN KEY (`ospite_id`) REFERENCES `squadra` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `votazione`
--
ALTER TABLE `votazione`
  ADD CONSTRAINT `votazione_ibfk_1` FOREIGN KEY (`calciatore_id`) REFERENCES `calciatore` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `votazione_ibfk_2` FOREIGN KEY (`calendario_id`) REFERENCES `calendario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
