USE block3m1;

-- 
-- SUB - QUERIES
-- 
SELECT a.id, a.sex, a.dob, a.name, a.species_id
FROM animals a
INNER JOIN species s
	ON s.id = a.species_id
WHERE a.sex = 'F'
	AND s.current_name IN ('Turtle', 'Parrot');



SELECT MIN(dob)
FROM(
SELECT a.id, a.sex, a.dob, a.name, a.species_id
FROM animals a
INNER JOIN species s
	ON s.id = a.species_id
WHERE a.sex = 'F'
	AND s.current_name IN ('Turtle', 'Parrot')
) AS turtle_parrot_F;


SELECT id, sex, name, comments, species_id, race_id FROM animals
WHERE race_id = (SELECT id FROM races WHERE name = 'Affenpinscher');

--
-- SUB QUERIES - IN condtitions - compararisons
--


-- --------------------------------------------------------------------------------------------------------------------------------
-- (example 1)
-- --------------------------------------------------------------------------------------------------------------------------------
SELECT 
    id, name, species_id
FROM
    races
WHERE
    species_id = (SELECT 
            MIN(id)
        FROM
            species);


-- --------------------------------------------------------------------------------------------------------------------------------
-- (example 2)
-- --------------------------------------------------------------------------------------------------------------------------------
SELECT 
    id, name, species_id
FROM
    races
WHERE
    species_id < (SELECT 
            id
        FROM
            species
        WHERE
            current_name = 'turtle');


-- --------------------------------------------------------------------------------------------------------------------------------
-- (example 3)
-- --------------------------------------------------------------------------------------------------------------------------------
SELECT 
    id, sex, name, species_id, race_id
FROM
    animals
WHERE
    (id , race_id) = (SELECT 
            id, species_id
        FROM
            races
        WHERE
            id = 7);


-- --------------------------------------------------------------------------------------------------------------------------------
-- (example 4) IN
-- --------------------------------------------------------------------------------------------------------------------------------
SELECT 
    id, name, species_id
FROM
    animals
WHERE
    species_id IN (SELECT 
            id
        FROM
            species
        WHERE
            current_name IN ('turtle' , 'parrot'));
        
        
-- --------------------------------------------------------------------------------------------------------------------------------
-- (example 5) NOT IN
-- --------------------------------------------------------------------------------------------------------------------------------
SELECT 
    id, name, species_id
FROM
    animals
WHERE
    species_id NOT IN (SELECT 
            id
        FROM
            species
        WHERE
            current_name IN ('turtle' , 'parrot'));
            
            
            
-- --------------------------------------------------------------------------------------------------------------------------------
-- (example 6) ANY
-- --------------------------------------------------------------------------------------------------------------------------------
SELECT 
    *
FROM
    animals
WHERE
    species_id < ANY (SELECT 
            id
        FROM
            species
        WHERE
            current_name IN ('turtle' , 'parrot'));



-- --------------------------------------------------------------------------------------------------------------------------------
-- (example 7) ALL
-- --------------------------------------------------------------------------------------------------------------------------------
SELECT 
    *
FROM
    animals
WHERE
    species_id < ALL (SELECT 
            id
        FROM
            species
        WHERE
            current_name IN ('turtle' , 'parrot'));



-- --------------------------------------------------------------------------------------------------------------------------------
-- (example 7) correlation tree
-- --------------------------------------------------------------------------------------------------------------------------------
SELECT 
    current_name
FROM
    species s
WHERE
    s.id IN (SELECT 
            a.id
        FROM
            animals a
        WHERE
            a.species_id = s.id
                AND a.race_id IS NOT NULL);
       
      
      
-- --------------------------------------------------------------------------------------------------------------------------------
-- (example 8) correlated - EXISTS
-- --------------------------------------------------------------------------------------------------------------------------------
SELECT 
    id, name, species_id
FROM
    races
WHERE
    EXISTS(SELECT 
            *
        FROM
            animals
        WHERE
            name = 'Balou');
  
  
  
-- --------------------------------------------------------------------------------------------------------------------------------
-- (example 8) correlated - EXISTS
-- --------------------------------------------------------------------------------------------------------------------------------
SELECT 
    *
FROM
    races
WHERE
    NOT EXISTS(SELECT 
            *
        FROM
            animals
        WHERE
            animals.race_id = races.id);



-- --------------------------------------------------------------------------------------------------------------------------------
-- EXO Question - 1 (use sub queries to shorten the querie below)
-- --------------------------------------------------------------------------------------------------------------------------------
SELECT 
    races.name AS Race,
    animals.name AS Name,
    animals.dob,
    animals.id
FROM
    animals
        INNER JOIN
    races ON animals.race_id = races.id
WHERE
    animals.species_id = 1
        AND ((animals.dob BETWEEN '2008-01-01' AND '2011-01-01')
        OR animals.name LIKE 'C%');
        
        
        
-- --------------------------------------------------------------------------------------------------------------------------------
-- ANSWER
-- --------------------------------------------------------------------------------------------------------------------------------
SELECT 
    a.name AS Race, a.name AS Name, a.dob, a.id
FROM
    animals a
WHERE
    a.race_id IN (SELECT 
            id
        FROM
            races)
        AND a.species_id = 1
        AND ((a.dob BETWEEN '2008-01-01' AND '2011-01-01')
        OR a.name LIKE 'C%');
        


-- --------------------------------------------------------------------------------------------------------------------------------
-- EXO Question - 2 (Species for which at least one race is defined)
-- --------------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM species s
WHERE EXISTS (SELECT species_id FROM races r WHERE  r.species_id = s.id);

--
--
SELECT 'Yoda' AS name;

--
--
SELECT id AS race_id, species_id
FROM races 
WHERE name = 'Abyssinian';

--
--
SELECT 'Yoda', 'M','2010-11-09', id AS race_id, species_id
FROM races
WHERE name = 'Abyssinian';



-- --------------------------------------------------------------------------------------------------------------------------------
-- Junctions - to insert
-- --------------------------------------------------------------------------------------------------------------------------------
INSERT INTO animals(name, sex, dob, race_id, species_id)
SELECT 'Yoda', 'M', '2010-11-09', id AS race_id, species_id
FROM races
WHERE name = 'Abyssinian';



-- --------------------------------------------------------------------------------------------------------------------------------
-- Junctions - to modify
-- --------------------------------------------------------------------------------------------------------------------------------
UPDATE animals 
SET 
    comments = 'Sally wants a cracker'
WHERE
    species_id = (SELECT 
            id
        FROM
            species
        WHERE
            current_name LIKE 'parrot%');

-- ADDED EXTRA
INSERT INTO races (name, species_id, description) VALUES ('Nebelung', 2, 'A cat species that look some what like Chausies who are bred to be medium to large in size, as compared to traditional domestic breeds (Chausie breed standard). Most Chausies are a little smaller than a male Maine Coon, for example, but larger than a Siamese. Adult Chausie males typically weigh 9 to 15 pounds. Adult females are usually 7 to 10 pounds.');



UPDATE animals 
SET race_id = (
SELECT id 
FROM races
WHERE name = 'Nebelung'
AND species_id = 2
)
WHERE name = 'Cawette';

-- --------------------------------------------------------------------------------------------------------------------------------
-- WARNING! THIS WILL PRODUCE AN ERROR (You can't specify target table 'animals' for update in FROM clause)
-- --------------------------------------------------------------------------------------------------------------------------------
UPDATE animals SET race_id = (
SELECT race_id
FROM animals 
WHERE name = 'Cawette'
AND species_id = 2
)
WHERE name = 'Callune';


-- simple way
DELETE
FROM animals
WHERE name = 'Carabistouille';

-- --------------------------------------------------------------------------------------------------------------------------------
-- subquery way - SUBQUERY DELETE
-- --------------------------------------------------------------------------------------------------------------------------------
DELETE 
FROM animals
WHERE name = 'Carabistouille'
AND species_id = (
	SELECT id
    FROM species
	WHERE current_name = 'cat'
);
                


