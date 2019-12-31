

															-- LAB 2(1)
                                                                
USE block3mod2;



-- 1. Show all the animals (id, name, sex)
SET @animals = 'SELECT id, name, sex FROM animal ORDER BY id'; -- setting animal table to user created variable

PREPARE call_animals
FROM @animals; -- create prepared statement

EXECUTE call_animals; -- calling PS with zero parameters


-- 2. Show all the animals by ? race_id (id, name, sex, dob, race_name)
SET @select_id = 'SELECT a.id, a.name, a.sex, r.name 
				  FROM animal a
                  JOIN race r
					ON a.race_id = r.id
				  WHERE r.id = ?';
PREPARE ps_animal
FROM @select_id;

SET @id = 3; -- assigning variable

EXECUTE ps_animal USING @id; -- executing prepared statement using a parameter


-- 3. Show all the animals by ? race_id and ? species_id (id, name, sex, race_name, species_name)
SET @select_race_species = 'SELECT a.id, a.name, a.sex, r.name, s.current_name
							FROM animal a
                            JOIN race r
								ON a.race_id  = r.id
							JOIN species s
								ON a.species_id = s.id
							WHERE r.id = ? AND s.id = ?';
                            
PREPARE ps_race_species 
FROM @select_race_species;

SET @race_id = 2;
SET @species_id = 1;

EXECUTE ps_race_species USING @race_id, @species_id;




-- 4. Which specie has less than ? males and ? females (id, name, sex, race_name, species_name)
--    where ? is a number of animals
SET @select_species = "SELECT a.id, a.name, a.sex, r.name AS 'race', s.current_name AS 'species'
							FROM animal a
							JOIN race r
								ON a.race_id  = r.id
							JOIN species s
								ON a.species_id = s.id
							GROUP BY s.current_name
							HAVING COUNT(a.sex = ? AND a.sex = ? AND a.sex IS NOT NULL) < ?";
                            

PREPARE ps_species
FROM@select_species;

SET @sex1 = 'M';
SET @sex2 = 'F';
SET @species = 100;

EXECUTE ps_species USING @sex1, @sex2, @species;
-- trying to understand the question
SELECT a.id, a.name, a.sex, r.name, s.current_name, COUNT(*) AS 'total'
FROM animal a
LEFT JOIN race r
	ON a.race_id  = r.id
LEFT JOIN species s
	ON a.species_id = s.id
GROUP BY s.current_name
with rollup
HAVING COUNT(a.sex = 'M' AND a.sex = 'F' AND a.sex IS NOT NULL) < 100;


-- 5. Assuming the inflation rises 20% more every year, show the prices of ? animals for the ? year based on specie's race (id, name, sex, race_name, species_name)
--    where first argument is the number of animals to show and the second argument is the year number
SET @inflation = "SELECT a.id, a.name, a.sex, r.name, s.current_name, r.price AS 'base price', r.price * ROUND(POWER(1.2, ? - YEAR(a.dob)),2) AS 'Inflation'
					 FROM animal a
                     JOIN race r
						ON a.race_id = r.id
					 JOIN species s
						ON a.species_id = s.id
					 ORDER BY a.id
                     LIMIT ?";
                     
PREPARE ps_inflation
FROM @inflation;

DEALLOCATE PREPARE ps_inflation;

SET @select_num_animals = 5;
SET @select_year = 2013;

EXECUTE ps_inflation USING @select_year, @select_num_animals;




SELECT a.id, a.dob,  a.name, a.sex, r.name, s.current_name, r.price AS 'base price', r.price * ROUND(POWER(1.2, 2015 - YEAR(a.dob)),2) AS 'Inflation'
	FROM animal a
JOIN race r 
	ON a.race_id = r.id
JOIN species s
	ON a.species_id = s.id
ORDER BY A.ID
LIMIT 10;


                            