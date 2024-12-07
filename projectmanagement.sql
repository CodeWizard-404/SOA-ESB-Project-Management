-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 07, 2024 at 12:18 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `projectmanagement`
--

-- --------------------------------------------------------

--
-- Table structure for table `calendar`
--

CREATE TABLE `calendar` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `project_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `calendar`
--

INSERT INTO `calendar` (`id`, `name`, `description`, `start_date`, `end_date`, `project_id`) VALUES
(1, 'Project Kickoff', 'Initial meeting to discuss project scope and timeline', '2024-12-01 10:00:00', '2024-12-01 12:00:00', 1),
(2, 'Sprint 1 Planning', 'Planning meeting for the first development sprint', '2024-12-05 09:00:00', '2024-12-05 11:00:00', 1),
(3, 'Design Review', 'Review of UI/UX design before development starts', '2024-12-10 14:00:00', '2024-12-10 16:00:00', 2),
(4, 'Project Deadline', 'Final submission of the project for approval', '2024-12-20 15:00:00', '2024-12-20 18:00:00', 3),
(5, 'Project Deadline', 'Final submission of the project for approval', '2024-12-20 15:00:00', '2024-12-20 18:00:00', 2),
(6, 'Project Deadline', 'Final submission of the project for approval', '2024-12-20 15:00:00', '2024-12-20 18:00:00', 2);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` bigint(20) NOT NULL,
  `description` text NOT NULL,
  `timestamp` datetime DEFAULT current_timestamp(),
  `member_id` int(11) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `description`, `timestamp`, `member_id`, `project_id`) VALUES
(1, 'Great progress on the project.', '2024-12-03 09:18:42', 1, 1),
(2, 'Great progress on the project.', '2024-12-03 09:19:00', 1, 1),
(3, 'Great progress on the project.', '2024-12-03 09:20:01', 3, 2),
(4, 'Great progress on the project.', '2024-12-03 09:33:27', 2, 1),
(5, 'Great progress on the project.', '2024-12-03 09:34:27', 2, 2),
(6, 'Greate Project test', '2024-12-03 10:33:51', 3, 1),
(7, 'Great Project test', '2024-12-03 10:36:02', 3, 1),
(8, 'Great Project test', '2024-12-03 10:36:06', 3, 1),
(9, 'Great Project test', '2024-12-03 10:44:45', 3, 1),
(10, 'Great Project test', '2024-12-03 10:45:07', 3, 1),
(11, 'Great Project test22', '2024-12-03 11:06:05', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `Id` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `TeamId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`Id`, `Name`, `TeamId`) VALUES
(1, 'Alice', 1),
(2, 'Bob', 3),
(3, 'Charlie', 3);

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `id` bigint(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`id`, `description`, `name`, `status`) VALUES
(1, 'A project to develop a new website', 'Website Development', 'Ongoing'),
(2, 'A marketing campaign for the new product', 'Marketing Campaign', 'Completed'),
(3, 'Designing the new logo and branding', 'Logo Design', 'Ongoing');

-- --------------------------------------------------------

--
-- Table structure for table `projectteam`
--

CREATE TABLE `projectteam` (
  `ProjectId` bigint(20) NOT NULL,
  `TeamId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `projectteam`
--

INSERT INTO `projectteam` (`ProjectId`, `TeamId`) VALUES
(1, 1),
(1, 2),
(1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `team`
--

CREATE TABLE `team` (
  `Id` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `team`
--

INSERT INTO `team` (`Id`, `Name`) VALUES
(1, 'Development Team'),
(2, 'Marketing Team'),
(3, 'Design Team');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `calendar`
--
ALTER TABLE `calendar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `TeamId` (`TeamId`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `projectteam`
--
ALTER TABLE `projectteam`
  ADD PRIMARY KEY (`ProjectId`,`TeamId`),
  ADD KEY `TeamId` (`TeamId`);

--
-- Indexes for table `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `calendar`
--
ALTER TABLE `calendar`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `team`
--
ALTER TABLE `team`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `calendar`
--
ALTER TABLE `calendar`
  ADD CONSTRAINT `calendar_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`);

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`Id`),
  ADD CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`);

--
-- Constraints for table `member`
--
ALTER TABLE `member`
  ADD CONSTRAINT `member_ibfk_1` FOREIGN KEY (`TeamId`) REFERENCES `team` (`Id`);

--
-- Constraints for table `projectteam`
--
ALTER TABLE `projectteam`
  ADD CONSTRAINT `projectteam_ibfk_1` FOREIGN KEY (`ProjectId`) REFERENCES `project` (`id`),
  ADD CONSTRAINT `projectteam_ibfk_2` FOREIGN KEY (`TeamId`) REFERENCES `team` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
