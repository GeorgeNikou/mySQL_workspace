-- LAB 7


--
-- EASY
--


-- 1. How many races exist in the animals table? (Display all of their name)
SELECT r.name AS Race, count(*) AS Total 
FROM animals a
JOIN races r 
	ON a.race_id = r.id
GROUP BY race_id;


-- 2. How many species exist in the races table? (Display all of their name)
SELECT s.current_name AS species, r.species_id AS id, COUNT(*) AS Total
FROM species s
JOIN races r
	ON s.id = r.species_id
GROUP BY r.species_id;


-- 3. How many Dogs have a father? (Display the children's name and the father's name)
SELECT child.name, COUNT(*), father.name, COUNT(*) 
FROM animals child
JOIN animals father
	ON father.id = child.father_id
JOIN species s
WHERE father.id IS NOT NULL AND s.current_name = 'dog'
GROUP BY child.name;


-- 4. What is the average race price of each specie?
SELECT AVG(price), s.current_name
FROM species s
JOIN animals a 
ON a.species_id = s.id
GROUP BY s.current_name;


-- 5. How many males and females exist in the animals table?
SELECT sex, COUNT(*) 
FROM animals
WHERE sex IS NOT NULL
GROUP BY sex;

-- 6. Give the name of 6 random males and 4 random females.
(SELECT name, sex
FROM animals
WHERE sex = 'M' AND name IS NOT NULL
ORDER BY RAND()
LIMIT 6)
UNION
(SELECT name, sex
FROM animals
WHERE sex = 'F' AND name IS NOT NULL
ORDER BY RAND()
LIMIT 4);


-- 7. How many animals have the same name length?
SELECT id, GROUP_CONCAT(name), CHAR_LENGTH(name), COUNT(*) AS total-- , CHAR_LENGTH(name) AS s, SUM(s) -- need help getting the total sum of name length
FROM animals
WHERE CHAR_LENGTH(name) = CHAR_LENGTH(name)
GROUP BY CHAR_LENGTH(name)
ORDER BY CHAR_LENGTH(name);

--
-- EASIER
--

-- 1. Whice race doesn’t have any animal attached to it?
SELECT r.name AS Race
FROM animals a
RIGHT JOIN races r
	ON a.race_id = r.id
WHERE r.id NOT IN(
	SELECT r.id 
	WHERE a.race_id IN (r.id)
);


-- 2. Which specie has less than 5 males (order by latin_name alphabetically)
SELECT a.species_id, s.latin_name, COUNT(*) AS total_animals
FROM animals a
JOIN species s
	ON a.species_id = s.id
GROUP BY species_id
HAVING total_animals < 5
ORDER BY latin_name; -- incomplete (stuck at narrowing down the gender M) 


-- 3. What is the average animal age per species?
SELECT species_id, FLOOR(AVG(YEAR(dob))) AS average_age
FROM animals
GROUP BY species_id; -- deduct from todays date need to fix


-- 4. How many males and females of each race do we have? Do a total count for the race (male and female) and for the species. 
--    Display the race name and the current species name.
SELECT r.name, s.current_name, coalesce(a.sex,'total'), COUNT(sex) AS total
FROM animals a
JOIN races r
	ON a.race_id = r.id
JOIN species s
	ON a.species_id = s.id
GROUP BY r.name,a.sex with rollup;




-- 5. What would be the cost per species and the total cost to adopt:
--    Parlotte, Spoutnik, Caribou, Cartouche, Cali, Canaille, Yoda, Zambo and Lulla?
SELECT group_concat(concat(a.name, ' ', s.current_name, ' ', r.name)),sum(coalesce(r.price, s.price))
FROM animals a
LEFT join  races r
	ON a.race_id = r.id
JOIN species s
	ON a.species_id = s.id
WHERE a.name 
		IN ('Parlotte', 'Spoutnik', 'Caribou', 'Cartouche', 'Cali', 'Canaille', 'Yoda', 'Zambo', 'Lulla');

use herzing;


SELECT a.name, s.current_name, 
-- a.race_id, 
-- r.price AS race_price,
 s.price AS species_price
FROM animals a
LEFT join  races r
	ON a.race_id = r.id
JOIN species s
	ON a.species_id = s.id
WHERE a.id IN(
	SELECT animals.id 
    FROM animals 
	WHERE name 
		IN ('Parlotte', 'Spoutnik', 'Caribou', 'Cartouche', 'Cali', 'Canaille', 'Yoda', 'Zambo', 'Lulla') AND name IS NOT NULL
)
UNION

(SELECT 'grand', 'total',
		sum(species_price)
FROM
(SELECT a.name, s.current_name, 
-- a.race_id, 
-- r.price AS race_price,
 s.price AS species_price
FROM animals a
LEFT join  races r
	ON a.race_id = r.id
JOIN species s
	ON a.species_id = s.id
WHERE a.id IN(
	SELECT animals.id 
    FROM animals 
	WHERE name 
		IN ('Parlotte', 'Spoutnik', 'Caribou', 'Cartouche', 'Cali', 'Canaille', 'Yoda', 'Zambo', 'Lulla') AND name IS NOT NULL
)) ahri);



-- 6. What's the median price of the species?
--    (median = (max + min)/2)
SELECT species.current_name, MIN(price) AS lowest, MAX(price) AS highest, MAX(price) + MIN(price) / 2 AS median_price
FROM species;

-- 7. Assuming the inflation rises 20% more every year, show the prices of each animal for the next 5 years. (based on specie's race)
(SELECT current_name, price, price * .20 AS inflation
FROM species);



-- 
-- EASIER Questions
-- 

-- 1. How much would it cost me to buy all the Dogs and all the Cats. Show the total per species and the overall total.
SELECT s.current_name, SUM(s.price) AS Total_price
FROM species s
JOIN animals a
	ON a.species_id = s.id
WHERE s.current_name = 'Dog' OR s.current_name = 'cat'
GROUP BY s.current_name with rollup;




-- 2. What is the average price of all the Dogs and the average price of all the Cats.
SELECT a.species_id, s.current_name, s.price, COUNT(s.price) AS 'Count', COUNT(s.price) * s.price AS grand_total
FROM animals a
JOIN species s
	ON a.species_id = S.id
WHERE s.current_name = 'dog' OR s.current_name = 'cat'
GROUP BY s.id;




-- 3. Would it cost more to buy all the males or all the females animals based on their race price?
-- 	  (if the race price is null, or the animal doesn't have a race attached to it, use their specie's price)





-- 4. Show a sentence giving the price of the species, for each species ex: The Dogs cost: 200$...





-- 5. Show the cats with the letter "a" as the second letter in their name.
SELECT *, species.current_name
FROM animals 
JOIN species 
	ON animals.species_id = species.id
WHERE name LIKE '_a%' AND species.current_name = 'Cat'; -- also with substring


-- 6. Show the names of parrots by replacing "a" with "@" and "e" with "3".





-- 7. Show the dogs with an even number of letters in their names.






-- 8. Show the taxes you would pay on each animals and the total price. Assuming GST = 5% and HST = 9.9975% (Round to the tens)
--    ex: Price: 10$ GST: 0.5$ HST: 0.99975$ Total:  11.5$






--  9. Give a nickname to all the animals with the following criteria:
--     max 10 characters
--     all lower cases

