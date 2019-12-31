USE herzing;

--
-- EASY questions
--

-- 1. List all the Affenpinscher and all the Bengal (Race Name, Animal Name)
SELECT a.name, r.name 
FROM animals a 
JOIN races r
	ON a.race_id = r.id
WHERE a.id = (
SELECT a.id WHERE r.name = 'Affenpinscher ' OR r.name = 'Bengal'
);


-- 2. List of animals (Name, Sex, DOB, Race_Id, Species_ID) with a race .
SELECT a.name, a.sex, a.dob, a.race_id, a.species_id
FROM animals a
WHERE a.race_id = (
	SELECT a.race_id
    WHERE a.race_id IS NOT NULL
);


-- 3. List of animals (Name, Sex, DOB, Race_Id) whose race has the word weigh* in it.
SELECT a.name, a.sex, a.dob, a.race_id
FROM animals a
JOIN races r 
	ON a.race_id = r.id
WHERE r.id = (
	SELECT r.id 
	WHERE r.description LIKE '%wei%'
);


-- 4. List all the dog and cats and turtle whose name ends with the letter 'a' in it.
SELECT a.id, a.name, a.species_id
FROM animals a
JOIN species s 
	ON a.species_id = s.id
WHERE a.id = (
	SELECT a.id
	WHERE a.species_id IN (1,2,3) AND a.name LIKE '%a'
);


-- 5. List all the male dogs, the female cats and the youngest turtle(name, sex, specie, dob), order by species_name
SELECT a.name, a.sex, a.species_id, a.dob
FROM animals a
JOIN species s
	ON a.species_id = s.id
WHERE a.id = (
	SELECT a.id
    WHERE (a.species_id = 1 AND a.sex = 'M') OR (a.species_id = 2 AND a.sex = 'F') OR (a.species_id = 3 AND a.dob = (SELECT MIN(a.dob) FROM animals)) 
    ORDER BY s.current_name
); -- (a) using subquery

SELECT a.name, a.sex, s.current_name, a.dob 
FROM animals a
JOIN species s
	ON a.species_id = s.id
WHERE (a.species_id = 1 AND a.sex = 'M') OR (a.species_id = 2 AND a.sex = 'F')
UNION
SELECT a.name, a.sex, s.current_name, a.dob 
FROM animals a
INNER JOIN species s
	ON a.species_id = s.id
WHERE a.species_id = 3 AND a.dob = (SELECT MIN(a.dob) FROM animals  ); -- (b) using union  -- date desc limit 1

    

--
-- MEDIUM questions
-- 

-- 1. Display the (1) oldest Cat and the (1) oldest Turtle.
SELECT a.name, a.dob 
FROM animals a
WHERE a.name IN(
SELECT a.name WHERE a.species_id = 1 AND a.dob = (SELECT MIN(a.dob) FROM animals GROUP BY a.dob) -- min function returning multiple sets
);

(SELECT a.name, a.dob, s.current_name
FROM animals a 
JOIN species s
	ON a.species_id = s.id
WHERE a.dob = (SELECT MAX(a.dob)) AND a.species_id = 3  ORDER BY a.dob ASC LIMIT 1)   							-- FIXED
UNION
(SELECT a.name, a.dob, s.current_name
FROM animals a 
JOIN species s
	ON a.species_id = s.id
WHERE a.dob = (SELECT MIN(a.dob)) AND a.species_id = 2  ORDER BY a.dob ASC LIMIT 1);

-- 2. Display the cats whose id is smaller than it's race's id.
SELECT a.name, a.id AS 'animal ID', r.id AS 'race ID'
FROM animals a
JOIN races r
	ON a.race_id = r.id
WHERE a.id = (
SELECT a.id WHERE a.id < r.id AND r.species_id = 2
); -- Q2

-- 3. List all the female Chausie cats and parrots. (Name, DOB, Sex, Species)
SELECT a.name, a.dob, a.sex, r.species_id, s.id
FROM animals a
JOIN races r
	ON a.race_id = r.id
JOIN species s
	ON a.species_id = s.id
WHERE a.id = (
SELECT a.id WHERE (r.name = 'chausie' AND a.sex = 'F') OR (a.species_id = 4)
); -- (a) not working as intended, parrot set not listed


SELECT a.name, a.dob, a.sex, s.current_name 'Species'
FROM animals a
JOIN species s
	ON a.species_id = s.id
JOIN races r
	ON r.id = a.race_id
WHERE r.name = 'Chausie' AND a.sex = 'F'
UNION 
SELECT a.name, a.dob, a.sex, s.current_name 'Species'
FROM animals a
JOIN species s
	ON a.species_id = s.id
WHERE s.current_name = 'Parrot' AND a.sex = 'F'; -- (b)


-- 4. Update all the cat's nulled comments to "meow, meow, meow"
UPDATE animals
SET comments = 'meow, meow, meow'
WHERE id = (
	SELECT id
	WHERE comments IS NULL
); --  had to remove from clause, got an error


-- 5. Display the top 5 oldest animals of each race
(SELECT a.name, a.dob, r.name
FROM animals a
JOIN races r	
	ON a.race_id = r.id
WHERE r.id = 1 ORDER BY a.dob limit 5)
UNION
(SELECT a.name, a.dob, r.name
FROM animals a
JOIN races r
	ON a.race_id = r.id
WHERE r.id = 2 ORDER BY a.dob limit 5)
UNION
(SELECT a.name, a.dob, r.name
FROM animals a
JOIN races r
	ON a.race_id = r.id
WHERE r.id = 3 ORDER BY a.dob limit 5)
UNION
(SELECT a.name, a.dob, r.name
FROM animals a
JOIN races r
	ON a.race_id = r.id
WHERE r.id = 4 ORDER BY a.dob limit 5) 
UNION
(SELECT a.name, a.dob, r.name
FROM animals a
JOIN races r
	ON a.race_id = r.id
WHERE r.id = 5 ORDER BY a.dob limit 5); 

--
-- HARD questions
--

-- 1. List all the Cats who has any parents.
SELECT * 
FROM animals 
JOIN species
	ON animals.species_id = species.id
WHERE (mother_id, father_id) in(
	SELECT mother_id, father_id 
    FROM animals 
    WHERE species.current_name = 'Cat'  						-- FIXED
);


-- 2. List of Feta’s kid(s) (Name, Sex and DOB)
SELECT a.name, a.sex, a.dob
FROM animals a
WHERE a.mother_id IN(
	SELECT animals.id 
    from animals
    WHERE animals.name = 'feta'  				-- FIXED
);



-- 3. List of all the animals whose id matches their race id
SELECT *
FROM animals
WHERE EXISTS (
	SELECT id 
    WHERE id = race_id
); -- this query only finds the first id that matches the race id , then fucks off

SELECT id 
FROM animals
WHERE id = race_id;

SELECT *
FROM animals
WHERE id = (
	SELECT id 
    from races
    WHERE id = race_id
);



-- 4. Insert the following animal in the table:
-- Name	: Criky
-- DoB	: 2015-05-11
-- Sex	: M
-- Species	: Dog
-- Race	: American Bully
INSERT INTO animals(name, dob, sex, race_id, species_id)
SELECT 'Cricky', '2015-05-11', 'M', 3, 1 ;


-- 5. Insert the following animal in the table, on duplicate change the name to 'Mushi' and the sex to 'F'
-- Name	: Criky
-- DoB	: 2015-05-11
-- Sex	: M
-- Species	: Dog
-- Race	: American Bully
UPDATE animals
SET name = 'Mushi', sex = 'F'
WHERE name = (
	SELECT name
	WHERE name = 'Cricky'
);




