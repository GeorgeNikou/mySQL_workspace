-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 05, 2018 at 02:57 PM
-- Server version: 5.7.14
-- PHP Version: 7.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `herzing_zoo`
--

-- --------------------------------------------------------

--
-- Table structure for table `animals`
--

CREATE TABLE `animals` (
  `id` smallint(6) UNSIGNED NOT NULL,
  `sex` char(1) DEFAULT NULL,
  `dob` datetime NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `comments` text,
  `species_id` smallint(5) UNSIGNED NOT NULL,
  `race_id` smallint(5) UNSIGNED DEFAULT NULL,
  `mother_id` smallint(5) UNSIGNED DEFAULT NULL,
  `father_id` smallint(5) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `animals`
--

INSERT INTO `animals` (`id`, `sex`, `dob`, `name`, `comments`, `species_id`, `race_id`, `mother_id`, `father_id`) VALUES
(1, 'M', '2010-04-05 13:43:00', 'Rox', 'Bite hard', 1, 1, 18, 22),
(2, NULL, '2010-03-24 02:23:00', 'Roucky', NULL, 2, NULL, 40, 30),
(3, 'F', '2010-09-13 15:02:00', 'Snory', NULL, 2, 4, 41, 31),
(4, 'F', '2009-08-03 05:12:00', NULL, 'A slow-moving reptile, enclosed in a scaly or leathery domed shell into which it can retract its head and thick legs.', 3, NULL, NULL, NULL),
(5, NULL, '2010-10-03 16:44:00', 'Choupi', 'No left hear', 2, NULL, NULL, NULL),
(6, 'F', '2009-06-13 08:17:00', 'Bobosse', 'No Shell', 3, NULL, NULL, NULL),
(7, 'F', '2008-12-06 05:18:00', 'Caroline', NULL, 1, 2, NULL, NULL),
(8, 'M', '2008-09-11 15:38:00', 'Bagherra', NULL, 2, 5, NULL, NULL),
(9, NULL, '2010-08-23 05:18:00', NULL, 'A slow-moving reptile, enclosed in a scaly or leathery domed shell into which it can retract its head and thick legs.', 3, NULL, NULL, NULL),
(10, 'M', '2010-07-21 15:41:00', 'Bobo', NULL, 1, NULL, 7, 21),
(11, 'F', '2008-02-20 15:45:00', 'Canaille', NULL, 1, NULL, NULL, NULL),
(12, 'F', '2009-05-26 08:54:00', 'Cali', NULL, 1, 2, NULL, NULL),
(13, 'F', '2007-04-24 12:54:00', 'Rouquine', NULL, 1, 1, NULL, NULL),
(14, 'F', '2009-05-26 08:56:00', 'Fila', NULL, 1, 2, NULL, NULL),
(15, 'F', '2008-02-20 15:47:00', 'Anya', NULL, 1, NULL, NULL, NULL),
(16, 'F', '2009-05-26 08:50:00', 'Louya', NULL, 1, NULL, NULL, NULL),
(17, 'F', '2008-03-10 13:45:00', 'Welva', NULL, 1, 3, NULL, NULL),
(18, 'F', '2007-04-24 12:59:00', 'Zira', NULL, 1, 1, NULL, NULL),
(19, 'F', '2009-05-26 09:02:00', 'Java', NULL, 1, 2, NULL, NULL),
(20, 'M', '2007-04-24 12:45:00', 'Balou', NULL, 1, 1, NULL, NULL),
(21, 'F', '2008-03-10 13:43:00', 'Pataude', NULL, 1, 3, NULL, NULL),
(22, 'M', '2007-04-24 12:42:00', 'Bouli', NULL, 1, 1, NULL, NULL),
(24, 'M', '2007-04-12 05:23:00', 'Cartouche', NULL, 1, NULL, NULL, NULL),
(25, 'M', '2006-05-14 15:50:00', 'Zambo', NULL, 1, 1, NULL, NULL),
(26, 'M', '2006-05-14 15:48:00', 'Samba', NULL, 1, 1, NULL, NULL),
(27, 'M', '2008-03-10 13:40:00', 'Moka', NULL, 1, 3, NULL, NULL),
(28, 'M', '2006-05-14 15:40:00', 'Pilou', NULL, 1, 1, NULL, NULL),
(29, 'M', '2009-05-14 06:30:00', 'Fiero', NULL, 2, 6, NULL, NULL),
(30, 'M', '2007-03-12 12:05:00', 'Zonko', NULL, 2, 5, NULL, NULL),
(31, 'M', '2008-02-20 15:45:00', 'Filou', NULL, 2, 4, NULL, NULL),
(32, 'M', '2007-03-12 12:07:00', 'Farceur', NULL, 2, 5, NULL, NULL),
(33, 'M', '2006-05-19 16:17:00', 'Caribou', NULL, 2, 4, NULL, NULL),
(34, 'M', '2008-04-20 03:22:00', 'Capou', NULL, 2, 5, NULL, NULL),
(35, 'M', '2006-05-19 16:56:00', 'Raccou', 'no tail', 2, 4, NULL, NULL),
(36, 'M', '2009-05-14 06:42:00', 'Boucan', NULL, 2, 6, NULL, NULL),
(37, 'F', '2006-05-19 16:06:00', 'Callune', NULL, 2, 4, NULL, NULL),
(38, 'F', '2009-05-14 06:45:00', 'Boule', NULL, 2, 6, NULL, NULL),
(39, 'F', '2008-04-20 03:26:00', 'Zara', NULL, 2, 5, NULL, NULL),
(40, 'F', '2007-03-12 12:00:00', 'Milla', NULL, 2, 5, NULL, NULL),
(41, 'F', '2006-05-19 15:59:00', 'Feta', NULL, 2, 4, NULL, NULL),
(42, 'F', '2008-04-20 03:20:00', 'Bilba', 'mute', 2, 5, NULL, NULL),
(43, 'F', '2007-03-12 11:54:00', 'Cracotte', NULL, 2, 5, NULL, NULL),
(44, 'F', '2006-05-19 16:16:00', 'Cawette', NULL, 2, 8, NULL, NULL),
(45, 'F', '2007-04-01 18:17:00', 'Nikki', 'A slow-moving reptile, enclosed in a scaly or leathery domed shell into which it can retract its head and thick legs.', 3, NULL, NULL, NULL),
(46, 'F', '2009-03-24 08:23:00', 'Tortilla', 'A slow-moving reptile, enclosed in a scaly or leathery domed shell into which it can retract its head and thick legs.', 3, NULL, NULL, NULL),
(47, 'F', '2009-03-26 01:24:00', 'Scroupy', 'A slow-moving reptile, enclosed in a scaly or leathery domed shell into which it can retract its head and thick legs.', 3, NULL, NULL, NULL),
(48, 'F', '2006-03-15 14:56:00', 'Lulla', 'A slow-moving reptile, enclosed in a scaly or leathery domed shell into which it can retract its head and thick legs.', 3, NULL, NULL, NULL),
(49, 'F', '2008-03-15 12:02:00', 'Dana', 'A slow-moving reptile, enclosed in a scaly or leathery domed shell into which it can retract its head and thick legs.', 3, NULL, NULL, NULL),
(50, 'F', '2009-05-25 19:57:00', 'Cheli', 'A slow-moving reptile, enclosed in a scaly or leathery domed shell into which it can retract its head and thick legs.', 3, NULL, NULL, NULL),
(51, 'F', '2007-04-01 03:54:00', 'Chicaca', 'A slow-moving reptile, enclosed in a scaly or leathery domed shell into which it can retract its head and thick legs.', 3, NULL, NULL, NULL),
(52, 'F', '2006-03-15 14:26:00', 'Redbul', 'Dont sleep', 3, NULL, NULL, NULL),
(53, 'M', '2007-04-02 01:45:00', 'Spoutnik', 'A slow-moving reptile, enclosed in a scaly or leathery domed shell into which it can retract its head and thick legs.', 3, NULL, NULL, NULL),
(54, 'M', '2008-03-16 08:20:00', 'Bubulle', 'A slow-moving reptile, enclosed in a scaly or leathery domed shell into which it can retract its head and thick legs.', 3, NULL, NULL, NULL),
(55, 'M', '2008-03-15 18:45:00', 'Relou', 'fat', 3, NULL, NULL, NULL),
(56, 'M', '2009-05-25 18:54:00', 'Bulbizard', 'A slow-moving reptile, enclosed in a scaly or leathery domed shell into which it can retract its head and thick legs.', 3, NULL, NULL, NULL),
(57, 'M', '2007-03-04 19:36:00', 'Safran', 'A bird, often vividly colored, with a short down-curved hooked bill, grasping feet, and a raucous voice, found esp. in the tropics and feeding on fruits and seeds.', 4, NULL, NULL, NULL),
(58, 'M', '2008-02-20 02:50:00', 'Gingko', 'A bird, often vividly colored, with a short down-curved hooked bill, grasping feet, and a raucous voice, found esp. in the tropics and feeding on fruits and seeds.', 4, NULL, NULL, NULL),
(59, 'M', '2009-03-26 08:28:00', 'Bavard', 'A bird, often vividly colored, with a short down-curved hooked bill, grasping feet, and a raucous voice, found esp. in the tropics and feeding on fruits and seeds.', 4, NULL, NULL, NULL),
(60, 'F', '2009-03-26 07:55:00', 'Parlotte', 'A bird, often vividly colored, with a short down-curved hooked bill, grasping feet, and a raucous voice, found esp. in the tropics and feeding on fruits and seeds.', 4, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `races`
--

CREATE TABLE `races` (
  `id` smallint(6) UNSIGNED NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `species_id` smallint(5) UNSIGNED NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `races`
--

INSERT INTO `races` (`id`, `name`, `species_id`, `description`) VALUES
(1, 'Affenpinscher', 1, 'An Affenpinscher generally weighs 6.5 to 13.2 pounds (2.9 to 6.0 kg) and stands 9 to 12 inches (23 to 30 cm) tall at the withers.'),
(2, 'Boxer', 1, 'The breed standard dictates that it must be in perfect proportion to the body and above all it must never be too light.[3] The greatest value is to be placed on the muzzle being of correct form and in absolute proportion to the skull.'),
(3, 'American Bully', 1, 'According to the American Bully Kennel Club the American bully has a well-defined, powerful appearance with straight, muscular legs. The head is medium-length and broad with a well-defined stop and high-set ears, which may be natural or cropped.'),
(4, 'American Curl', 2, 'The American Curl is a breed of cat characterized by its unusual ears, which curl back from the face toward the center of the back of the skull.'),
(5, 'Abyssinian', 2, 'The Abyssinian has alert, relatively large pointed ears. The head is broad and moderately wedge shaped. Its eyes are almond shaped and colors include gold, green, hazel or copper. The paws are small and oval. The legs are slender in proportion to the body, with a fine bone structure. The Abyssinian has a fairly long tail, broad at the base and tapering to a point.'),
(6, 'Bengal', 2, 'Bengal cats have "wild-looking" markings, such as large spots, rosettes, and a light/white belly, and a body structure reminiscent of the leopard cat. A Bengals rosetted spots occur only on the back and sides, with stripes elsewhere. The breed typically also features mascara (horizontal striping alongside the eyes), and foreleg striping.'),
(7, 'Chausie', 2, 'Chausies are bred to be medium to large in size, as compared to traditional domestic breeds (Chausie breed standard). Most Chausies are a little smaller than a male Maine Coon, for example, but larger than a Siamese. Adult Chausie males typically weigh 9 to 15 pounds. Adult females are usually 7 to 10 pounds.'),
(8, 'Nebelung', 2, 'A cat species that look some what like Chausies who are bred to be medium to large in size, as compared to traditional domestic breeds (Chausie breed standard). Most Chausies are a little smaller than a male Maine Coon, for example, but larger than a Siamese. Adult Chausie males typically weigh 9 to 15 pounds. Adult females are usually 7 to 10 pounds.'),
(9, 'Rottweiller', 1, 'Dog looks solid, well muscled, in black dress with tan markings clearly defined.');

-- --------------------------------------------------------

--
-- Table structure for table `species`
--

CREATE TABLE `species` (
  `id` smallint(6) UNSIGNED NOT NULL,
  `current_name` varchar(50) NOT NULL,
  `latin_name` varchar(50) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `species`
--

INSERT INTO `species` (`id`, `current_name`, `latin_name`, `description`) VALUES
(1, 'Dog', 'Canis?familiaris', 'A domesticated carnivorous mammal that typically has a long snout, an acute sense of smell.'),
(2, 'Cat', 'Felis catus', 'A small domesticated carnivorous mammal with soft fur, a short snout, and retractile claws.'),
(3, 'Turtle', 'Testudo hermanni', 'A slow-moving reptile, enclosed in a scaly or leathery domed shell into which it can retract its head and thick legs.'),
(4, 'Parrot', 'Alipiopstitta xanthops', 'A bird, often vividly colored, with a short down-curved hooked bill, grasping feet, and a raucous voice, found esp. in the tropics and feeding on fruits and seeds.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `animals`
--
ALTER TABLE `animals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ind_uni_specie_id` (`name`,`species_id`),
  ADD KEY `fk_mother_id` (`mother_id`),
  ADD KEY `fk_father_id` (`father_id`),
  ADD KEY `fk_race_id` (`race_id`),
  ADD KEY `fk_species_id` (`species_id`);

--
-- Indexes for table `races`
--
ALTER TABLE `races`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_race_species` (`species_id`);

--
-- Indexes for table `species`
--
ALTER TABLE `species`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `latin_name` (`latin_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `animals`
--
ALTER TABLE `animals`
  MODIFY `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;
--
-- AUTO_INCREMENT for table `races`
--
ALTER TABLE `races`
  MODIFY `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `species`
--
ALTER TABLE `species`
  MODIFY `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `animals`
--
ALTER TABLE `animals`
  ADD CONSTRAINT `animal_ibfk_1` FOREIGN KEY (`race_id`) REFERENCES `races` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `animal_ibfk_2` FOREIGN KEY (`mother_id`) REFERENCES `animals` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `animal_ibfk_3` FOREIGN KEY (`father_id`) REFERENCES `animals` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `animal_ibfk_4` FOREIGN KEY (`species_id`) REFERENCES `species` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `races`
--
ALTER TABLE `races`
  ADD CONSTRAINT `fk_race_species` FOREIGN KEY (`species_id`) REFERENCES `species` (`id`);


