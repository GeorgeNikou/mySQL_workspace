-- M2 | Lab 1

--
-- EASY questions
use herzing;

-- 1. Select all the animals born in June (assuming you don't know the month number of June)
SELECT *
FROM animals 
WHERE MONTHNAME(dob) = 'June';

SELECT * FROM animals
ORDER BY MONTH(dob); -- shows all dates in order of month


-- 2. Select all the animals born in the first 8 weeks of the year
SELECT *
FROM animals
WHERE WEEKOFYEAR(dob) = 8;


-- 3. Display the day (in numbers) and month of birth (in words) of all the turtles and cats born before 2007 (two columns).
SELECT name, DAY(dob) AS days, MONTHNAME(dob)
FROM animals
WHERE (species_id = '3' AND YEAR(dob) < 2007) OR (species_id = 2 AND YEAR(dob) < 2007);


-- 4. Display the day (in numbers) and month of birth (in words) of all the turtles and cats born before 2007 (one column).
SELECT name, CONCAT(DAY(dob), '  ', MONTHNAME(dob)) AS 'Date'
FROM animals
WHERE (species_id = '3' AND YEAR(dob) < 2007) OR (species_id = 2 AND YEAR(dob) < 2007);


-- 5. Select all the animals born in April, but not April 24, sorted by decreasing birth time (hours, minutes, seconds) 
--    and display their date of birth as in the exemple below:
--    Format : January 8, at 6h30 PM, in 2010 after J.C.
SELECT name,  DATE_FORMAT(dob, '%M %D, at %Hh%i %p, in %Y after J.C') AS 'date format' 
FROM animals
WHERE MONTHNAME(dob) = 'April' AND DAY(dob) != 24
ORDER BY TIME(dob) DESC;



-- 6. Display all the animal ages in seconds, minutes, hours, days, months, years (I want a column for each)
SELECT name, SECOND(dob)  AS 'seconds', MINUTE(dob) AS 'minute', HOUR(dob) AS 'hour', DAY(dob) AS 'day', MONTH(dob) AS 'month', YEAR(dob) AS 'year', dob
FROM animals
ORDER BY name;

SELECT name, dob,  															-- Question 6 (easy) FIXED (08/29/2019)
	   TIMESTAMPDIFF(SECOND, DATE(dob), DATE(NOW())) AS 'seconds', 
	   TIMESTAMPDIFF(MINUTE, DATE(dob), DATE(NOW())) AS 'minute',
       TIMESTAMPDIFF(HOUR, DATE(dob), DATE(NOW())) AS 'hour',
       TIMESTAMPDIFF(DAY, DATE(dob), DATE(NOW())) AS 'day',
       TIMESTAMPDIFF(MONTH, DATE(dob), DATE(NOW())) AS 'month',
       TIMESTAMPDIFF(YEAR, DATE(dob), DATE(NOW())) AS 'year'
FROM animals;


-- 7. Which animals have their birthdays in the month with an even number of days.
SELECT * 
FROM animals
WHERE DAY(dob) %2 = 0;


-- 8. Assuming that cats and dogs should not live more than 4 years. . . which of them should be dead by now. (#sorryNoSoSorry)
SELECT CONCAT(name, ' / ' ,'DECEASED') AS name, current_name AS 'species', YEAR(dob), DATEDIFF(NOW(), dob)
FROM animals
JOIN species
	ON animals.species_id = species.id
WHERE (DATEDIFF(NOW(), dob) > 1461 AND current_name = 'cat') OR (DATEDIFF(NOW(), dob) > 1461 AND current_name = 'dog')
ORDER BY dob;-- (a)


SELECT CONCAT(name, ' / ' , 'DECEASED') AS name, YEAR(dob) AS 'Birth year', ADDDATE(dob, INTERVAL 4 YEAR) AS 'Interval 4 Year'
FROM animals
JOIN species
	ON animals.species_id = species.id
WHERE (YEAR(dob) < '2015' AND current_name = 'cat') OR (YEAR(dob) < '2015' AND current_name = 'dog')
ORDER BY dob;-- (b)

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--
-- MEDIUM questions
--

-- 1. Moka was supposed to be born on February 27, 2008. Calculate how many days late she was born.
SELECT name, DATE(dob) AS 'birth date','2008-02-27' AS 'ideal birth date' , DATEDIFF(dob, '2008-02-27') AS 'days born late' 
FROM animals 
WHERE name = 'Moka';


-- 2. Display the date each parrot will celebrate their 25th birthday.
SELECT name, dob, ADDDATE(dob, INTERVAL 25 YEAR) AS 'added years', current_name AS 'species'
FROM animals 
JOIN species
	ON animals.species_id = species.id
WHERE current_name = 'parrot'
ORDER BY dob;


-- 3. Select all the animals born within a month that has exactly 29 days.
SELECT name, dob
FROM animals
WHERE MONTH(dob) = 2
ORDER BY name; -- (a) using the known month of february

SELECT name, dob, LAST_DAY(dob) AS 'last day of the month'
FROM animals
WHERE LAST_DAY(dob) = DATE_FORMAT(dob,'%y-%m-29')
ORDER BY name; -- (b) using LAST_DAY and DATE_FORMAT function to find results

-- 4. After twelve weeks, a kitten is weaned (with some exceptions of course). 
--    Display the date from which a cat(s) may be adopted (passed or future date).
SELECT name, current_name, DATE(dob) AS 'born', DATE(ADDDATE(dob, INTERVAL 98 DAY)) AS 'cha-ching'
FROM animals
JOIN species
	ON animals.species_id = species.id
WHERE current_name = 'cat'
ORDER BY name;


-- 5. After Rouquine, Zira, Bouli and Balou are part of the same scope. 
--    Calculate how long, in minutes, Balou was born before Zira.
SELECT CONCAT(name, ' (',current_name, ')') AS 'name', dob, TIME(dob) AS 'time', CONCAT(SUBTIME( '12:59:00', '12:45:00'), '  minutes') AS 'time difference'
FROM animals
JOIN species
	ON animals.species_id = species.id
WHERE name = 'Balou' OR name = 'Zira';  


-- 6. Display the age of each animal in numbers																	-- Question 6 (medium) FIXED (08/29/2019)
SELECT name, DATE(dob) AS 'dob', DATE(NOW()) AS 'current', CONCAT(YEAR(NOW()) - YEAR(dob), ' years old') AS 'age' 
FROM animals
ORDER BY dob DESC;

SELECT name, dob, TIMESTAMPDIFF(YEAR, dob, NOW()) AS 'animal age'
FROM animals
ORDER BY name;


-- 7. Display the animals born in the same year, Display in this format: 
-- "... was born this YYYY, in MM, on DD (name of day), at HH:MM:SS" 
SELECT GROUP_CONCAT(name) AS 'names', COUNT(*) AS 'count', DATE_FORMAT(dob, 'Was born this year in %Y, in %M, on the %D at %H:%i:%S %p') AS 'date'
FROM animals
GROUP BY YEAR(dob);


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--
-- MEDIUM/HARD questions
--

-- 1. Rouquine, Zira, Bouli and Balou are part of the same scope. 
--    Calculate how long in minutes elapsed between the first born and last born.
SELECT CONCAT('N/A') AS name,
	   MIN(TIME(dob)) AS 'first born',
       MAX(TIME(dob)) AS 'last born',
	   MIN(MINUTE(dob)) AS 'earliest minutes',
       MAX(MINUTE(dob)) AS 'latest minutes', 
       CONCAT(MAX(MINUTE(dob)) - MIN(MINUTE(dob)), ' minutes') AS 'time difference' 
FROM animals
WHERE name IN('Zira','Bouli','Balou','Rouquine');



-- 2. Calculate how many animals are born during a month in which the molds are the most consumables
--    (that is to say the months ending in "ber" [September, October, November and December]).
SELECT GROUP_CONCAT(name) AS 'Names', DATE(dob) AS 'Date', MONTHNAME(dob) AS 'Month', COUNT(*) AS 'count'
FROM animals
WHERE MONTHNAME(dob) IN('September', 'October', 'November', 'December')
GROUP BY MONTHNAME(dob);



-- 3. For dogs and cats, display the date of birth of litters of at least two individuals (DD / MM / YYYY), 
--    and the number of individuals for each of these litters. By Litter I mean 'Animals Born on the same date'.
--    Attention, it is possible that a range of cats was born the same day a litter of dogs.
SELECT current_name AS 'species', DATE(dob) AS 'date', TIME(dob)  AS 'time', COUNT(*) AS litter
FROM animals
JOIN species
	ON animals.species_id = species.id
GROUP BY DATE(dob)
HAVING (current_name = 'dog' AND litter > 2) OR (current_name = 'cat' AND litter > 2)
ORDER BY current_name; 



-- 4. Calculate the average dogs that were born each year between 2006 and 2010 (knowing that we had at least one birth every year).
SELECT name, dob, current_name AS 'species', COUNT(YEAR(dob)) AS total_dogs
FROM animals 
JOIN species
	ON animals.species_id = species.id
WHERE (current_name = 'dog') AND (YEAR(dob) < 2010 AND YEAR(dob) > 2006)
GROUP BY YEAR(dob) 
WITH ROLLUP; -- (a) have trouble using the AVG() function with the COUNT() function...


SELECT name, dob, current_name AS 'species', ROUND(COUNT(YEAR(dob)) / 3, 0) AS average
FROM animals 
JOIN species
	ON animals.species_id = species.id
WHERE (current_name = 'dog') AND (YEAR(dob) < 2010 AND YEAR(dob) > 2006)
GROUP BY YEAR(dob) 
WITH ROLLUP; -- (b)

-- scrap test
SELECT AVG(r_count), r.current_name 
FROM (
	SELECT COUNT(current_name) AS r_count 
    FROM animals a
    JOIN species r
		ON a.species_id = r.id
        WHERE(r.current_name = 'dog') AND (YEAR(a.dob) < 2010 AND YEAR(a.dob) > 2006))
    r;

use herzing;
select * from animals;

-- 5. Display the date in ISO format of the fifth anniversary of an animal(s) having a father or a mother.
SELECT child.name AS 'child', mother.name AS 'mother', father.name AS 'father', DATE_FORMAT(child.dob, '%Y-%e-%dT%H:%i:%S-04:00') AS 'dob'
FROM animal child
JOIN animal mother
	ON child.mother_id = mother.id
JOIN animal father
	ON child.father_id = father.id;
use block3mod2;



