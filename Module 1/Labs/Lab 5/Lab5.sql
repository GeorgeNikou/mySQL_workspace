USE herzing;
-- LAB #5
UPDATE animals SET mother_id = 13, father_id = 20 WHERE id = 18;
UPDATE animals SET mother_id = 13, father_id = 25 WHERE id = 22;
--
-- EASY questions
--
-- 1. List all the American Curl (Race Name, Animal Name)
SELECT r.name AS 'Race name', a.name AS 'Animal name' 
FROM animals a 
JOIN races r ON r.id = a.race_id 
WHERE r.name = 'American curl'; -- Q1

-- 2. List of animals (Name, DOB, Race Name, Race Description) who does not have the word color in their race description.
SELECT CONCAT(a.name,' / ', a.dob) AS 'Animal name', CONCAT(r.name, ' - ' ,r.description) AS 'Race name' 
FROM animals a 
INNER JOIN races r ON r.id = a.id 
WHERE r.description NOT LIKE '%color%'; -- Q2

-- 3. List of animals (Name, DOB, Race Name, Race Description) who does have a race description.
SELECT CONCAT(a.name,' / ', a.dob) AS 'Animal name', CONCAT(r.name, ' - ' ,r.description) AS 'Race name' 
FROM animals a 
LEFT JOIN races r ON r.id = a.id 
WHERE r.description IS NULL; -- Q3


--
-- MEDIUM questions
--
-- 1. List all the Cats and Dogs with their sex, species, latin name and race if exist. Order by animal type and by race.
SELECT a.sex, a.name, r.name AS Race, s.current_name AS Species, s.latin_name 
FROM animals a
INNER JOIN species s ON a.species_id = s.id
RIGHT JOIN races r ON a.race_id = r.id WHERE a.name IS NOT NULL AND r.name IS NOT NULL OR s.current_name IS NOT NULL
ORDER BY s.current_name, r.name;-- Q1


-- 2. List of the female Cats without a race and was born before july 2010. (Name, DOB and Race Name) 
SELECT a.name, a.dob, r.name AS 'race' 
FROM animals a 
JOIN races r ON a.race_id = r.id 
WHERE (a.sex = 'F' AND r.name IS NULL) AND (dob < '2010-07-29')
ORDER BY dob DESC; -- Q2


-- 3. List all the female Chausie Cats . Order by age. (Race Name, Species Current name, DOB, Sex)
SELECT r.name, s.current_name, a.sex, a.dob
FROM races r
INNER JOIN animals a 
	ON r.id = a.race_id
INNER JOIN species s 
	ON r.species_id = s.id
WHERE s.current_name = 'Cat' AND r.name = 'Chausie'
ORDER BY dob ASC; -- Q3 				-- FIXED



--
-- HARD questions
--

-- 1. List all the Cats who has any parents. (Species Current name, Name)
SELECT s.current_name, child.name
FROM animals child
JOIN animals mother
ON child.mother_id = mother.id
JOIN animals father
ON child.father_id = father.id
JOIN species AS s
WHERE s.current_name = 'cat'; -- Q1 (a) 

SELECT a.name, s.current_name
FROM animals a
LEFT JOIN species s ON a.species_id = s.id
WHERE (s.current_name = 'Cat') 
	AND a.mother_id IS NOT NULL 
	AND a.father_id IS NOT NULL
ORDER BY a.name ASC; -- Q1 (b)

-- -----------------------------------------------------------------------------------------------------------------
-- 2. List of Bouli’s kid(s) (Name, Sex and DOB)
SELECT *,child.name AS 'Child', father.name AS 'father', child.sex, child.dob
FROM animals child
JOIN animals father
	ON  child.father_id = father.id;
    

    
SELECT *
FROM animals child
JOIN animals father
	ON child.father_id = father.id
WHERE father.name = 'bouli';




SELECT child.name, father.name father, mother.name mother
FROM animals child
left JOIN animals father
	ON child.id = father.father_id
left JOIN animals mother
	ON child.id = mother.mother_id
WHERE child.id = mother.mother_id;




SELECT a.name, a.sex, a.dob,father.name
FROM animals father
JOIN animals child
ON father.id = child.father_id
JOIN animals AS a
WHERE father.name = 'Bouli';

 -- -----------------------------------------------------------------------------------
-- 3. List of animals who has a father, a mother and a race. We must know the parent’s race if exist
SELECT a.name, a.race_id, mother.mother_id,mother.race_id, father.father_id
FROM animals a
LEFT JOIN animals mother
	ON a.id = mother.mother_id
LEFT JOIN animals father
	ON a.id = father.father_id
WHERE (a.id = mother.mother_id AND mother.race_id IS NOT NULL) OR (a.id = father.father_id AND father.race_id IS NOT NULL);-- race of everyone


-- Are there any Grand-Parents in our BD? 
-- (Species Current Name, Child ID, Child Name, Father ID, Father Name, Mother ID Mather Name, Grandma Name From Mom, Grandma ID From Mom, Grandpa Name From Mom, Grandpa ID From Mom, Grandma Name From Dad, Grandma ID From Dad, Grandpa Name From Dad, Grandpa ID From Dad)
UPDATE animals SET mother_id = 13, father_id = 20 WHERE id = 18;
UPDATE animals SET mother_id = 13, father_id = 25 WHERE id = 22;

SELECT
	s.current_name, child.id, child.name, father.id, father.name, mother.id, mother.name, 
	grandmother_mother.name, grandmother_mother.id, grandfather_mother.name, grandfather_mother.id, 
	grandmother_father.name, grandmother_father.id, grandfather_father.name, grandfather_father.id
FROM animals child
JOIN races AS r 
	ON child.race_id = r.id
JOIN species AS s
	ON child.species_id = s.id
JOIN animals mother
	ON child.mother_id = mother.id
JOIN animals father
	ON child.father_id = father.id
JOIN animals grandmother_mother
	ON grandmother_mother.id = mother.id
JOIN animals grandfather_mother
	ON grandfather_mother.id = mother.id
JOIN animals grandmother_father
	ON grandmother_father.id = father.id
JOIN animals grandfather_father
	ON grandfather_father.id = father.id;






