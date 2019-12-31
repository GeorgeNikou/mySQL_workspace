
CREATE DATABASE exam1m1; -- creating database
USE exam1m1; -- using chosen database

-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 19, 2013 at 12:40 PM
-- Server version: 5.5.24-log
-- PHP Version: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `herzing`
--

-- --------------------------------------------------------

--
-- Table structure for table `animal`
--

CREATE TABLE IF NOT EXISTS `animal` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `sex` char(1) DEFAULT NULL,
  `dob` datetime NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `comments` text,
  `species_id` smallint(5) unsigned NOT NULL,
  `race_id` smallint(5) unsigned DEFAULT NULL,
  `mother_id` smallint(5) unsigned DEFAULT NULL,
  `father_id` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ind_uni_specie_id` (`name`,`species_id`),
  KEY `fk_mother_id` (`mother_id`),
  KEY `fk_father_id` (`father_id`),
  KEY `fk_race_id` (`race_id`),
  KEY `fk_species_id` (`species_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=63 ;

--
-- Dumping data for table `animal`
--

INSERT INTO `animal` (`id`, `sex`, `dob`, `name`, `comments`, `species_id`, `race_id`, `mother_id`, `father_id`) VALUES
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
(60, 'F', '2009-03-26 07:55:00', 'Parlotte', 'A bird, often vividly colored, with a short down-curved hooked bill, grasping feet, and a raucous voice, found esp. in the tropics and feeding on fruits and seeds.', 4, NULL, NULL, NULL),
(61, 'M', '2010-11-09 00:00:00', 'Yoda', NULL, 2, 5, NULL, NULL),
(62, 'M', '2010-11-05 00:00:00', 'Pipo', NULL, 1, 9, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `race`
--

CREATE TABLE IF NOT EXISTS `race` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `species_id` smallint(5) unsigned NOT NULL,
  `description` text,
  `price` decimal(7,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_race_species` (`species_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `race`
--

INSERT INTO `race` (`id`, `name`, `species_id`, `description`, `price`) VALUES
(1, 'Affenpinscher', 1, 'An Affenpinscher generally weighs 6.5 to 13.2 pounds (2.9 to 6.0 kg) and stands 9 to 12 inches (23 to 30 cm) tall at the withers.', '485.00'),
(2, 'Boxer', 1, 'The breed standard dictates that it must be in perfect proportion to the body and above all it must never be too light.[3] The greatest value is to be placed on the muzzle being of correct form and in absolute proportion to the skull.', '935.00'),
(3, 'American Bully', 1, 'According to the American Bully Kennel Club the American bully has a well-defined, powerful appearance with straight, muscular legs. The head is medium-length and broad with a well-defined stop and high-set ears, which may be natural or cropped.', '985.00'),
(4, 'American Curl', 2, 'The American Curl is a breed of cat characterized by its unusual ears, which curl back from the face toward the center of the back of the skull.', '835.00'),
(5, 'Abyssinian', 2, 'The Abyssinian has alert, relatively large pointed ears. The head is broad and moderately wedge shaped. Its eyes are almond shaped and colors include gold, green, hazel or copper. The paws are small and oval. The legs are slender in proportion to the body, with a fine bone structure. The Abyssinian has a fairly long tail, broad at the base and tapering to a point.', '735.00'),
(6, 'Bengal', 2, 'Bengal cats have "wild-looking" markings, such as large spots, rosettes, and a light/white belly, and a body structure reminiscent of the leopard cat. A Bengals rosetted spots occur only on the back and sides, with stripes elsewhere. The breed typically also features mascara (horizontal striping alongside the eyes), and foreleg striping.', NULL),
(7, 'Chausie', 2, 'Chausies are bred to be medium to large in size, as compared to traditional domestic breeds (Chausie breed standard). Most Chausies are a little smaller than a male Maine Coon, for example, but larger than a Siamese. Adult Chausie males typically weigh 9 to 15 pounds. Adult females are usually 7 to 10 pounds.', '1235.00'),
(8, 'Nebelung', 2, 'A cat species that look some what like Chausies who are bred to be medium to large in size, as compared to traditional domestic breeds (Chausie breed standard). Most Chausies are a little smaller than a male Maine Coon, for example, but larger than a Siamese. Adult Chausie males typically weigh 9 to 15 pounds. Adult females are usually 7 to 10 pounds.', '985.00'),
(9, 'Rottweiller', 1, 'Dog looks solid, well muscled, in black dress with tan markings clearly defined.', '635.00');

-- --------------------------------------------------------

--
-- Table structure for table `species`
--

CREATE TABLE IF NOT EXISTS `species` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `current_name` varchar(50) NOT NULL,
  `latin_name` varchar(50) NOT NULL,
  `description` text,
  `price` decimal(7,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `latin_name` (`latin_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `species`
--

INSERT INTO `species` (`id`, `current_name`, `latin_name`, `description`, `price`) VALUES
(1, 'Dog', 'Canis familiaris', 'A domesticated carnivorous mammal that typically has a long snout, an acute sense of smell.', '200.00'),
(2, 'Cat', 'Felis catus', 'A small domesticated carnivorous mammal with soft fur, a short snout, and retractile claws.', '150.00'),
(3, 'Turtle', 'Testudo hermanni', 'A slow-moving reptile, enclosed in a scaly or leathery domed shell into which it can retract its head and thick legs.', '140.00'),
(4, 'Parrot', 'Alipiopstitta xanthops', 'A bird, often vividly colored, with a short down-curved hooked bill, grasping feet, and a raucous voice, found esp. in the tropics and feeding on fruits and seeds.', '700.00'),
(5, 'Brown Rat', 'Rattus norvegicus', 'Little creature with long whiskers and a long hairless tail', '10.00');

-- --------------------------------------------------------

--
-- Constraints for dumped tables
--

--
-- Constraints for table `animal`
--
ALTER TABLE `animal`
  ADD CONSTRAINT `animal_ibfk_4` FOREIGN KEY (`species_id`) REFERENCES `species` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `animal_ibfk_1` FOREIGN KEY (`race_id`) REFERENCES `race` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `animal_ibfk_2` FOREIGN KEY (`mother_id`) REFERENCES `animal` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `animal_ibfk_3` FOREIGN KEY (`father_id`) REFERENCES `animal` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `race`
--
ALTER TABLE `race`
  ADD CONSTRAINT `fk_race_species` FOREIGN KEY (`species_id`) REFERENCES `species` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;






INSERT INTO animal(name, dob, sex, species_id, race_id) SELECT 'Buddy', '2005-01-09', 'M', species_id, id FROM race WHERE name = 'Rottweiller';


-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

																				-- PRACTICAL EXAM
                                                                                -- 8/15/2019
                                                                                
                                                                                
					
-- QUESTION 1 | Change the name column character limit to 50 from the animal table (5pts)
DESCRIBE animal; -- verifying table structure
ALTER TABLE animal MODIFY name CHAR(50); -- changing column type


-- QUESTION 2 | Provide the total of all the male dogs BORN BEFORE 2008 AND ALL THE FEMALE DOGS BORN BEFORE 2006. (20pts)
SELECT a.sex, a.name, a.dob, r.name AS race, s.current_name, COUNT(*) AS total
FROM animal a
JOIN race r
	ON a.race_id = r.id
JOIN species s
	ON a.species_id = s.id
WHERE (s.current_name = 'Dog' AND a.sex = 'M' AND a.dob < '2008')  OR (s.current_name = 'Cat' AND a.sex = 'F' AND a.dob < '2006')
GROUP BY a.sex 
WITH ROLLUP;


-- QUESTION 3 | List all the animals(name, dob. race_name) whose race description is shorter than 150. (20pts)
SELECT a.name, a.dob, r.name AS race, CHAR_LENGTH(r.description) AS description_count
FROM animal a
JOIN race r
	ON a.race_id = r.id
-- GROUP BY r.description
HAVING description_count < 150;


-- QUESTION 4 | List all the DOGS with a mother AND a father (15pts)
SELECT child.name AS child_name, r.name AS child_race, s.current_name AS child_species, 
	   mother.name AS mother, r.name AS mothers_race, s.current_name AS mothers_species, 
       father.name AS father, r.name fathers_race, s.current_name fathers_species
FROM animal child
LEFT JOIN race r
	ON child.race_id = r.id
LEFT JOIN species s
	ON child.species_id = s.id
LEFT JOIN animal mother
	ON child.id = mother.mother_id
LEFT JOIN animal father
	ON child.id = father.father_id
WHERE (child.mother_id IS NOT NULL AND child.father_id IS NOT NULL AND s.current_name = 'dog');


-- QUESTION 5 | add the following animal in the database using a single query (10pts)
INSERT INTO animal(name, dob, sex, species_id, race_id)
SELECT 'Buddy', '2005-01-09', 'M', 1, 9; 


INSERT INTO animal(name, dob, sex, species_id, race_id)
SELECT 'Buddy', '2005-01-09', 'M'
FROM animals
JOIN species
	ON animals.species_id = species.id
JOIN race
	ON animals.race_id = r.id
WHERE (species_id,race_id) IN(
SELECT species_id, race_id WHERE species.current_name = 'dog' AND race.name = 'Rottweiller'
); 



SELECT * FROM animal ORDER BY name;


-- QUESTION 6 | Show the male dogs with an "o" in their name and the female cats with an "a" at the end of their name. (5pts)
SELECT a.name, a.sex, s.current_name AS species
FROM animal a
JOIN  species s
	ON  a.species_id = s.id
WHERE (s.current_name = 'dog' AND a.sex = 'M' AND a.name LIKE '%o%') OR (s.current_name = 'cat' AND a.sex = 'F' AND a.name LIKE '%a')
ORDER BY s.current_name; 


-- QUESTION 7 | List all the male and female cats and their price. Display their name, sex, price and total price. Group by race. use the races price by default, 
-- 				if animals doesnt have a race then use the species price. (15pts)
SELECT r.name AS Race, GROUP_CONCAT(a.name) AS Names, a.sex, COALESCE(r.price, s.price) AS Price, SUM(s.price) AS 'Total'
FROM animal a
JOIN species s
	ON a.species_id = s.id
JOIN race r
	ON a.race_id = r.id
WHERE s.current_name = 'dog' OR s.current_name = 'cat'
GROUP BY r.name
WITH ROLLUP;


-- QUESTION 8 | How much would it cost me to adopt all the animals in my database? 
-- 				group by species. Display their name, price per animal, total price pf species and total of all the animals.
-- 				race price by default, then species price if race price is null or doesnt exists. (15pts)

SELECT s.current_name AS species, GROUP_CONCAT(a.name) AS 'Animal Names', COALESCE(ROUND(SUM(r.price)), s.price) AS 'Price', SUM(s.price) AS 'total' , COUNT(s.current_name)
FROM animal a
left JOIN species s
	ON a.species_id = s.id
left JOIN race r
	ON a.race_id = r.id
GROUP BY s.current_name, a.name
WITH ROLLUP;


-- QUESTION 9 | Which species have more than 15 animals?  ORDER BY latin_name reverse (5pts)
SELECT s.current_name AS species, s.latin_name  AS 'Latin name', COUNT(a.species_id) AS total
FROM animal a
JOIN  species s
	ON a.species_id = s.id 
GROUP BY s.id
HAVING total > 15
ORDER BY s.latin_name DESC;







