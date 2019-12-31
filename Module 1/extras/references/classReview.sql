--
-- GET THE YOUNGEST ANIMALS OF EVERY RACE (question)
--

SELECT a.name, a.dob, r.name
FROM animals a
JOIN races r
	ON a.race_id = r.id
WHERE a.id IN (
SELECT MIN(a.dob)
);

(SELECT animals.name FROM animals WHERE animals.dob = (SELECT MIN(animals.dob)) AND animals.species_id = 1 LIMIT 1) -- incorrect
UNION
(SELECT animals.name FROM animals WHERE animals.dob = (SELECT MIN(animals.dob)) AND animals.species_id = 3 LIMIT 1);



(SELECT * FROM animals WHERE race_id = 1 ORDER BY dob DESC LIMIT 1) -- correct but long way of doing it
UNION
(SELECT * FROM animals WHERE race_id = 2 ORDER BY dob DESC LIMIT 1)
UNION
(SELECT * FROM animals WHERE race_id = 3 ORDER BY dob DESC LIMIT 1)
UNION
(SELECT * FROM animals WHERE race_id = 4 ORDER BY dob DESC LIMIT 1)
UNION
(SELECT * FROM animals WHERE race_id = 5 ORDER BY dob DESC LIMIT 1)
UNION
(SELECT * FROM animals WHERE race_id = 6 ORDER BY dob DESC LIMIT 1)
UNION
(SELECT * FROM animals WHERE race_id = 7 ORDER BY dob DESC LIMIT 1)
UNION
(SELECT * FROM animals WHERE race_id = 8 ORDER BY dob DESC LIMIT 1)
UNION
(SELECT * FROM animals WHERE race_id = 9 ORDER BY dob DESC LIMIT 1);


-- THE RIGHT WAY OF DOIG THIS (first way)
SELECT r.name, a.name, GROUP_CONCAT(a.dob ORDER BY a.dob)
FROM animals a
JOIN races r ON r.id = a.race_id
GROUP BY r.id
ORDER BY a.dob DESC;


SELECT r.name AS race, a.name, MAX(a.dob) -- This is the fastest and cleanest way to fetch the youngest races 
FROM animals a 
JOIN races r 
	ON r.id = a.race_id
GROUP BY r.id;

-- Can you insert dat into a table from another table? the answer is yes, heres how...
INSERT INTO animals (name, dob, sex, race_id, species_id) 
SELECT ('John', '2009-07-09', 'F', 1, 3);

SELECT SUM(r.price) AS total_price, GROUP_CONCAT(a.name, ':  (', s.current_name, '  - ' , r.name, ' ') animals -- WHENEVER USING SUM, USE GROUP_CONCAT TO PROVIDE ADDITIONAL INFORMATION
FROM animals a
JOIN species s
ON a.species_id = s.id
JOIN races r
ON a.races_id = r.id
WHERE a.name IN ('Rox', 'Bouli');

SELECT s.current_name AS species, COUNT(a.id) AS total, GROUP_CONCAT(a.name) -- google GROUP BY AND GROUP_CONCAT fo further information
FROM animals a
JOIN species s
ON a.species_id = s.id;


SELECT species.id, current_name, latin_name, COUNT(*) AS num_animal -- ORDER BY has priority over GROUP BY
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY current_name, sex;-- up to 12 groups(3*4) -- google WITH ROLLUP
												  
                                                   
SELECT COALESCE(current_name, 'Total'), COUNT(*) AS num_animals  -- google coalesce
FROM animals 
INNER JOIN species ON species_id = animals.species_id
GROUP BY sex WITH ROLLUP;

SELECT current_name, COUNT(*) AS num -- you can use the alias in the HAVING clause(IMPORTANT! - HAVING is alway at the end)
FROM animals 
INNER JOIN species ON species.id = animals.species_id
GROUP BY current_name
HAVING num > 15;