-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 11, 2026 at 06:54 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `agriflow_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity`
--

CREATE TABLE `activity` (
  `activity_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `stage_id` int(11) NOT NULL,
  `operator_id` int(11) NOT NULL,
  `worker_id` int(11) DEFAULT NULL,
  `activity_title` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `start_date` date DEFAULT curdate(),
  `due_date` date DEFAULT NULL,
  `status` enum('Created','Verified','Assigned','Submitted','Completed') DEFAULT 'Created',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `activity_update`
--

CREATE TABLE `activity_update` (
  `update_id` int(11) NOT NULL,
  `activity_id` int(11) NOT NULL,
  `worker_id` int(11) NOT NULL,
  `proof_description` text DEFAULT NULL,
  `photo_path` varchar(255) DEFAULT NULL,
  `submitted` tinyint(1) DEFAULT 0,
  `submitted_at` timestamp NULL DEFAULT NULL,
  `verified_by` int(11) DEFAULT NULL,
  `verified_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `operator`
--

CREATE TABLE `operator` (
  `operator_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `operator_name` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `unit_category` enum('Plant','Aquatic','Animal') NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `operator`
--

INSERT INTO `operator` (`operator_id`, `user_id`, `unit_id`, `operator_name`, `phone`, `unit_category`, `status`, `created_at`) VALUES
(6, 19, 4, 'gkul', '5678990000', 'Plant', 'Active', '2026-02-04 19:13:46'),
(7, 20, 5, 'deepak', '7887663789', 'Plant', 'Active', '2026-02-05 07:19:14');

-- --------------------------------------------------------

--
-- Table structure for table `production_unit`
--

CREATE TABLE `production_unit` (
  `unit_id` int(11) NOT NULL,
  `unit_name` varchar(100) NOT NULL,
  `unit_category` enum('Plant','Aquatic','Animal') NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `owner_id` int(11) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `start_date` date DEFAULT curdate(),
  `end_date` date DEFAULT NULL,
  `status` enum('Pending','Active','Inactive') DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `operator_id` int(11) DEFAULT NULL,
  `operator_request` enum('No','Yes') NOT NULL DEFAULT 'No',
  `requested_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `production_unit`
--

INSERT INTO `production_unit` (`unit_id`, `unit_name`, `unit_category`, `location`, `owner_id`, `admin_id`, `start_date`, `end_date`, `status`, `created_at`, `operator_id`, `operator_request`, `requested_at`) VALUES
(4, 'Tea', 'Plant', 'marayoor', 13, 1, '2026-01-27', '2026-02-28', 'Active', '2026-02-04 19:12:10', 6, 'No', NULL),
(5, 'tea', 'Plant', 'muvattupuzha', 13, 1, '2026-02-06', '2026-02-26', 'Active', '2026-02-05 07:17:42', 7, 'No', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `stage_master`
--

CREATE TABLE `stage_master` (
  `stage_id` int(11) NOT NULL,
  `stage_name` varchar(100) NOT NULL,
  `unit_category` enum('Plant','Aquatic','Animal') NOT NULL,
  `stage_weight` int(11) NOT NULL,
  `stage_order` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_alert`
--

CREATE TABLE `stock_alert` (
  `alert_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `worker_id` int(11) NOT NULL,
  `alert_type` enum('Irrigation','Fertilizer','Inventory','Buy') NOT NULL,
  `quantity` varchar(50) NOT NULL,
  `alert_reason` varchar(255) NOT NULL,
  `alert_status` enum('Pending','Cleared') DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `cleared_by` int(11) DEFAULT NULL,
  `admin_cleared_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `unit_stage_progress`
--

CREATE TABLE `unit_stage_progress` (
  `progress_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `stage_id` int(11) NOT NULL,
  `completed_percentage` int(11) DEFAULT 0,
  `verified_by` int(11) NOT NULL,
  `verified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('Not Started','In Progress','Completed') DEFAULT 'Not Started'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Admin','Owner','Operator','Worker') NOT NULL,
  `status` enum('Pending','Active','Rejected') DEFAULT 'Pending',
  `full_name` varchar(100) NOT NULL,
  `age` int(11) NOT NULL,
  `address` varchar(50) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `photo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `role`, `status`, `full_name`, `age`, `address`, `phone`, `created_at`, `photo`) VALUES
(1, 'admin', 'admin123', 'Admin', 'Active', 'System Admin', 35, 'Head Office', NULL, '2026-01-04 07:40:49', NULL),
(2, 'akshay@gmail.com', 'akshay12', 'Owner', 'Active', 'aksahy', 21, 'ajahh', '83762', '2026-01-10 19:23:16', NULL),
(4, 'akshay@gma', 'akshay12z', 'Owner', 'Active', 'zxxz', 27, 'xxxsfrd', '8376298', '2026-01-10 19:31:03', NULL),
(5, 'aksay@gma', 'akshzzy12z', 'Owner', 'Rejected', 'mdc', 3, 'es', '2232', '2026-01-10 19:33:49', NULL),
(6, 'rahul@123', '123456', 'Owner', 'Active', 'rahul', 21, 'fshsh', '8714583190', '2026-01-12 08:56:16', NULL),
(7, 'ajay@gmail.com', '123', 'Owner', 'Rejected', 'ajay', 23, 'hssojs', '56277388292', '2026-01-12 10:07:19', '1768212438327_Screenshot 2025-04-21 223708.png'),
(8, 'gopi@gmail.com', 'gopi12', 'Owner', 'Rejected', 'gopinath', 22, 'gopimura', '567322211', '2026-01-12 10:14:34', '1768212874605_Screenshot 2025-07-04 113603.png'),
(11, 'aks@gmail.com', 'akshay12', 'Owner', 'Rejected', 're', 17, ' hdj', '08714', '2026-01-14 18:16:56', '1768414616103_Screenshot 2025-04-21 224007.png'),
(12, 'rameshan34', '4573627', 'Owner', 'Rejected', 'rameshan', 32, 'fdvjn', '7790735424', '2026-01-14 18:30:17', '1768415417660_Screenshot 2025-04-21 225330.png'),
(13, 'harilal2003', 'harilal123', 'Owner', 'Active', 'harilal k', 23, 'apchelil', '8606042886', '2026-01-16 06:28:15', '1768544895545_cat.jpeg'),
(14, 'kesh1234', '1234456', 'Owner', 'Pending', 'keshu', 23, 'nareeckal', '8714583190', '2026-01-26 15:02:51', '1769439771078_cat.jpeg'),
(15, 'harilal34', 'ak23456', 'Owner', 'Pending', 'harilal', 34, 'harikol', '4578965432', '2026-01-26 15:49:22', '1769442561684_safety2.png'),
(16, 'op1', 'op123', 'Operator', 'Active', 'Ramesh', 0, '', '9876543210', '2026-02-01 15:40:32', NULL),
(18, 'mohasn123', 'akshay12z', 'Operator', 'Active', 'mohan', 34, 'Durbar Hall ', '08714583190', '2026-02-01 17:52:13', NULL),
(19, 'gokul23', 'akshay12z', 'Operator', 'Active', 'gkul', 34, 'ghkhjk', '5678990000', '2026-02-04 19:13:46', NULL),
(20, 'deepak', 'deepak12', 'Operator', 'Active', 'deepak', 24, 'gdjkdd', '7887663789', '2026-02-05 07:19:14', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker`
--

CREATE TABLE `worker` (
  `worker_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `unit_id` int(11) NOT NULL,
  `worker_name` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `skill` varchar(100) DEFAULT NULL,
  `request_status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `status` enum('Active','Inactive') DEFAULT 'Inactive',
  `requested_by` int(11) NOT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `worker`
--

INSERT INTO `worker` (`worker_id`, `user_id`, `unit_id`, `worker_name`, `phone`, `skill`, `request_status`, `status`, `requested_by`, `approved_by`, `created_at`) VALUES
(1, NULL, 5, 'joy', '7678569843', 'planting', 'Approved', 'Active', 7, 7, '2026-02-09 10:33:55');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity`
--
ALTER TABLE `activity`
  ADD PRIMARY KEY (`activity_id`),
  ADD KEY `unit_id` (`unit_id`),
  ADD KEY `stage_id` (`stage_id`),
  ADD KEY `operator_id` (`operator_id`),
  ADD KEY `worker_id` (`worker_id`);

--
-- Indexes for table `activity_update`
--
ALTER TABLE `activity_update`
  ADD PRIMARY KEY (`update_id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `worker_id` (`worker_id`),
  ADD KEY `verified_by` (`verified_by`);

--
-- Indexes for table `operator`
--
ALTER TABLE `operator`
  ADD PRIMARY KEY (`operator_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `unit_id` (`unit_id`);

--
-- Indexes for table `production_unit`
--
ALTER TABLE `production_unit`
  ADD PRIMARY KEY (`unit_id`),
  ADD KEY `admin_id` (`owner_id`),
  ADD KEY `fk_production_unit_admin` (`admin_id`),
  ADD KEY `operator_id` (`operator_id`);

--
-- Indexes for table `stage_master`
--
ALTER TABLE `stage_master`
  ADD PRIMARY KEY (`stage_id`);

--
-- Indexes for table `stock_alert`
--
ALTER TABLE `stock_alert`
  ADD PRIMARY KEY (`alert_id`),
  ADD KEY `unit_id` (`unit_id`),
  ADD KEY `worker_id` (`worker_id`),
  ADD KEY `cleared_by` (`cleared_by`);

--
-- Indexes for table `unit_stage_progress`
--
ALTER TABLE `unit_stage_progress`
  ADD PRIMARY KEY (`progress_id`),
  ADD UNIQUE KEY `unit_id` (`unit_id`,`stage_id`),
  ADD KEY `stage_id` (`stage_id`),
  ADD KEY `verified_by` (`verified_by`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `worker`
--
ALTER TABLE `worker`
  ADD PRIMARY KEY (`worker_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `unit_id` (`unit_id`),
  ADD KEY `requested_by` (`requested_by`),
  ADD KEY `approved_by` (`approved_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity`
--
ALTER TABLE `activity`
  MODIFY `activity_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `activity_update`
--
ALTER TABLE `activity_update`
  MODIFY `update_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `operator`
--
ALTER TABLE `operator`
  MODIFY `operator_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `production_unit`
--
ALTER TABLE `production_unit`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `stage_master`
--
ALTER TABLE `stage_master`
  MODIFY `stage_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_alert`
--
ALTER TABLE `stock_alert`
  MODIFY `alert_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `unit_stage_progress`
--
ALTER TABLE `unit_stage_progress`
  MODIFY `progress_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `worker`
--
ALTER TABLE `worker`
  MODIFY `worker_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity`
--
ALTER TABLE `activity`
  ADD CONSTRAINT `activity_ibfk_1` FOREIGN KEY (`unit_id`) REFERENCES `production_unit` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `activity_ibfk_2` FOREIGN KEY (`stage_id`) REFERENCES `stage_master` (`stage_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `activity_ibfk_3` FOREIGN KEY (`operator_id`) REFERENCES `operator` (`operator_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `activity_ibfk_4` FOREIGN KEY (`worker_id`) REFERENCES `worker` (`worker_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `activity_update`
--
ALTER TABLE `activity_update`
  ADD CONSTRAINT `activity_update_ibfk_1` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`activity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `activity_update_ibfk_2` FOREIGN KEY (`worker_id`) REFERENCES `worker` (`worker_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `activity_update_ibfk_3` FOREIGN KEY (`verified_by`) REFERENCES `operator` (`operator_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `operator`
--
ALTER TABLE `operator`
  ADD CONSTRAINT `operator_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `operator_ibfk_2` FOREIGN KEY (`unit_id`) REFERENCES `production_unit` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `production_unit`
--
ALTER TABLE `production_unit`
  ADD CONSTRAINT `fk_production_unit_admin` FOREIGN KEY (`admin_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_production_unit_operator` FOREIGN KEY (`operator_id`) REFERENCES `operator` (`operator_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `production_unit_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `stock_alert`
--
ALTER TABLE `stock_alert`
  ADD CONSTRAINT `stock_alert_ibfk_1` FOREIGN KEY (`unit_id`) REFERENCES `production_unit` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `stock_alert_ibfk_2` FOREIGN KEY (`worker_id`) REFERENCES `worker` (`worker_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `stock_alert_ibfk_3` FOREIGN KEY (`cleared_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `unit_stage_progress`
--
ALTER TABLE `unit_stage_progress`
  ADD CONSTRAINT `unit_stage_progress_ibfk_1` FOREIGN KEY (`unit_id`) REFERENCES `production_unit` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `unit_stage_progress_ibfk_2` FOREIGN KEY (`stage_id`) REFERENCES `stage_master` (`stage_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `unit_stage_progress_ibfk_3` FOREIGN KEY (`verified_by`) REFERENCES `operator` (`operator_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `worker`
--
ALTER TABLE `worker`
  ADD CONSTRAINT `worker_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `worker_ibfk_2` FOREIGN KEY (`unit_id`) REFERENCES `production_unit` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `worker_ibfk_3` FOREIGN KEY (`requested_by`) REFERENCES `operator` (`operator_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `worker_ibfk_4` FOREIGN KEY (`approved_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
