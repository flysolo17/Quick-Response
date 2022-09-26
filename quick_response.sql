-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 26, 2022 at 04:13 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.0.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quick_response`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int(10) NOT NULL,
  `title` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `subjectId` int(11) NOT NULL,
  `code` varchar(100) NOT NULL,
  `isOpen` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`id`, `title`, `date`, `subjectId`, `code`, `isOpen`) VALUES
(48, '1', '2022-09-16', 77, '41e6420e-08cd-4a53-ac5f-7e415369efb877', 1),
(49, '2 ', '2022-09-16', 77, '60807c89-372a-4ae2-b901-f6412880594577', 1),
(50, '3', '2022-09-16', 77, '1e91d37a-c45e-4fa9-a506-dc5ea06c67ed77', 1),
(63, 'hey', '2022-09-18', 119, '36874192-27c8-445b-aa90-3d8590a465df119', 1),
(64, 'dasdas', '2022-09-18', 119, 'a9af71fe-082a-4cac-af32-2daeddf5e68c119', 1),
(65, 'nice', '2022-09-18', 119, '0a9e1efc-1503-43b1-af55-46d0efc7e811119', 1),
(66, 'nicefdfd', '2022-09-18', 119, 'b263bad8-638b-400c-8ae5-cb5152d376dc119', 1),
(67, 'nicefdfd', '2022-09-18', 119, 'be4bedfc-f686-4aad-a5e0-ccdb62dca850119', 1),
(68, 'Mag attendance na kayo', '2022-09-18', 115, '9ae04e46-6309-4953-8f0d-0a0157ca49a4115', 1),
(69, 'No Class today mag attendance lang kayo', '2022-09-18', 115, 'e2c8ce7d-6e34-4a2d-984a-24aca73c3ec6115', 1),
(70, 'Nice one!', '2022-09-18', 120, '23efedee-adf0-430a-b8b4-e1a2405829d5120', 1),
(73, 'fggf', '2022-09-22', 121, '64eab067-b04e-44ed-8426-8b3e9be73610121', 1),
(75, 'Walang pasok ngayun mag attendance lang kayo', '2022-09-26', 127, '6cec6505-76e9-4127-b18c-d9be54d39530127', 1),
(76, 'dasdas', '2022-09-26', 128, 'edfad289-c5b3-49c9-a1fa-ab766c353ae3128', 1),
(77, 'dasdasdasd', '2022-09-26', 128, 'de495aeb-302b-4d5a-b54a-a2955346f1cb128', 1),
(78, 'dasdasdasd', '2022-09-26', 128, 'b73fadf5-ece2-4e56-acb5-566dd2615b2c128', 1),
(79, 'dasdasdasd', '2022-09-26', 128, '38b67676-503c-4dca-8246-c524de530be1128', 1),
(80, 'dasdasdasd', '2022-09-26', 128, 'ce46df2c-5193-4468-819e-b2793dce972d128', 1);

-- --------------------------------------------------------

--
-- Table structure for table `attendees`
--

CREATE TABLE `attendees` (
  `id` int(50) NOT NULL,
  `idNumber` varchar(50) NOT NULL,
  `attendanceId` int(50) NOT NULL,
  `timestamp` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `attendees`
--

INSERT INTO `attendees` (`id`, `idNumber`, `attendanceId`, `timestamp`) VALUES
(1, '03161704870', 1, 1663955847343);

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `desc` varchar(300) DEFAULT NULL,
  `createdAt` date DEFAULT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `name`, `desc`, `createdAt`, `userId`) VALUES
(115, 'Science', 'hi', '2022-09-17', 1),
(117, 'Math lang malakas', '', '2022-09-18', 1),
(118, 'Math lang malakas', 'dsds', '2022-09-18', 1),
(119, 'hey thre baby', 'haynako', '2022-09-18', 1),
(120, 'mjmjmj', 'mjmjmjmj', '2022-09-18', 1),
(121, 'Maths', 'Science', '2022-09-19', 11),
(125, 'Science', 'hahahahahaha', '2022-09-25', 11),
(126, 'Math', 'bahala kayo jan', '2022-09-26', 14),
(127, 'Science', 'haynako', '2022-09-26', 14),
(128, 'asdasd', 'dasdas', '2022-09-26', 14),
(129, 'fsdfsdf', 'dasdas', '2022-09-26', 14);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) NOT NULL,
  `firstName` varchar(30) NOT NULL,
  `middleName` varchar(30) NOT NULL,
  `lastName` varchar(30) NOT NULL,
  `idNumber` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  `salt` varchar(100) NOT NULL,
  `type` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstName`, `middleName`, `lastName`, `idNumber`, `password`, `salt`, `type`) VALUES
(5, 'John Mark', 'D.', 'ballangca', '03161704874', 'a6842dedf65124e64e9bdc5da843798136fe5eaa4a1d14d9bdc337ec8766110a', '24d7bb2248808afc63c568d6adc47aba3f8c468ccf478b2127fa403df6c98cf5', 'Student'),
(8, 'hgfhfghfg', 'hfghfgh', 'hfghfgh', '03161704879', 'bc201c648dcdfdb374f79ce274fb533f7a58a3d38ac6e01645acb4d73fe6b827', 'afc56f2d042b4d776e35dc43909e5ccab4fd0c18412817e2e0d986f145b9a2bf', 'Teacher'),
(9, ' g gh ', 'hfghfgh', 'hfghfg', '4664564', 'd75554e5c3fd91f3f5ab518c0d6f5f3ffbe5d8c000cbe3305df9b5177bcdb05a', '4a8f3a2df533c9ca8020f0383d76acadab23b3e7ecd6a6224ab7cf210443daa2', 'Teacher'),
(10, 'John Mark', 'D.', 'Ballangca', '123456789', '8ad2fbccd875597af20c66e36d9e18d223f2220eadf88646bc3f52d163aa60ee', 'b64c59978eb61961149e1d4b4761922390f11018a1e7152c79820eaedc99de64', 'Student'),
(11, 'JM', '@', 'gwapo', '03161704870', '272be99ddd0b694de7cf1d4efd396981b706b6d845e6db907bf056634eefafca', '33c581fbec42f8f5094c75763fa5a2ecae65f151d2cad3200a4cd12fc264566b', 'Teacher'),
(12, 'Juan', 'Dela ', 'Cruz', '123456', '2e10b8876660c46b3e34c2f5300c7c926f4b8cb36b50a1621ee6d29f36c63644', 'ff4945b2d395db3c8fc55e535fe6f92bf4e9239ffaacd65a535c8d1efa88a231', 'Student'),
(13, 'hi', 'po', 'haha', '12345685', '1bf511d3179bd4242c0d9a4b6df14658d52924ca9c92db173cbbeb576ed7b1ed', 'aa3e0fc65c91adf87975fd26ea5b046f0b40d750db72cc43919ca3324497f9bf', 'Student'),
(14, 'Sample', 'Lang ', 'Po', '12345678', '830250e256155fd38dacc4c14e151f87a404c36f77b9ee1e8abcdb2236503abe', 'bde6fd7203189d23bc764c757cf51bad736c870499bca5428847018f7e55b2bc', 'Teacher');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendees`
--
ALTER TABLE `attendees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idNumber` (`idNumber`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `attendees`
--
ALTER TABLE `attendees`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
