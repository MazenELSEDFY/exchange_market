-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 03, 2024 at 09:03 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `exchange_market`
--

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `passport` varchar(20) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `date` date NOT NULL,
  `amountBefore` decimal(10,2) NOT NULL,
  `fromCurrency` varchar(3) NOT NULL,
  `toCurrency` varchar(3) NOT NULL,
  `amountAfter` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `passport`, `password`, `date`, `amountBefore`, `fromCurrency`, `toCurrency`, `amountAfter`) VALUES
(9, 'Am290', '$2y$10$3ZuD50isk1llMVT/s.rYKuUPoO8Sg5.oSb09bDsgIDi70Ee1ikSte', '2024-01-02', 100.00, 'USD', 'EGP', 3075.88),
(10, 'Am291', '$2y$10$YqmazEq7tP.ZfqG5rbDmpOGMfYt4xk6COpx6YslsjOzvwQ6fr8g.K', '2024-01-02', 100.00, 'USD', 'EGP', 3076.91),
(11, 'Am293', '$2y$10$XZ516Nl6csDwz/cKTK5.8e3IyAm5accsxNvxtbRazPlPVSk5/PxIC', '2024-01-02', 110.00, 'GBP', 'USD', 140.04),
(12, 'AM294', '$2y$10$8CVtVQ.OryOYaO6W.j.oVurDknynMBzBh7wyeU/Z8fZDryiAsQsle', '2024-01-02', 150.00, 'GBP', 'EGP', 5875.63),
(13, 'AM296', '$2y$10$Zjf8vCRd/iYzR9UAVihFQeR.a/sj93lZoC.CfzfkFKRWgrpMUc4ve', '2024-01-02', 100.00, 'USD', 'EGP', 3076.91),
(14, 'AZ123', '$2y$10$BHI9YuVeHLX6VwWw4n.IP.VdxiTi84rfLLhc2aJpBtlWz5e0MUsjC', '2024-01-02', 200.00, 'USD', 'EGP', 6153.83);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `passport` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `passport`, `email`, `phone`, `password`) VALUES
(12, 'Mazen', 'Am290', 'mazenaboutreka22@gmail.com', '01223603255', '$2y$10$3ZuD50isk1llMVT/s.rYKuUPoO8Sg5.oSb09bDsgIDi70Ee1ikSte'),
(13, 'Mazen El Sedfy', 'Am291', 'mazen-elsedfy@outlook.com', '201223603255', '$2y$10$YqmazEq7tP.ZfqG5rbDmpOGMfYt4xk6COpx6YslsjOzvwQ6fr8g.K'),
(14, 'Mazen El Sedfy', 'Am293', 'mazen-elsedfy@outlook.com', '201223603255', '$2y$10$XZ516Nl6csDwz/cKTK5.8e3IyAm5accsxNvxtbRazPlPVSk5/PxIC'),
(15, 'Mazen El Sedfy', 'AM294', 'mazen-elsedfy@outlook.com', '201223603255', '$2y$10$8CVtVQ.OryOYaO6W.j.oVurDknynMBzBh7wyeU/Z8fZDryiAsQsle'),
(16, 'Omar', 'AM296', 'omar@gmail.com', '193180180011', '$2y$10$Zjf8vCRd/iYzR9UAVihFQeR.a/sj93lZoC.CfzfkFKRWgrpMUc4ve'),
(17, 'SAMEH EL SEDFY', 'AZ123', 'sameh@gmail.com', '01006084159', '$2y$10$BHI9YuVeHLX6VwWw4n.IP.VdxiTi84rfLLhc2aJpBtlWz5e0MUsjC');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `passport` (`passport`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `passport` (`passport`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`passport`) REFERENCES `users` (`passport`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
