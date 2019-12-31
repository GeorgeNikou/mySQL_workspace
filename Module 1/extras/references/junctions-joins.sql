USE block3m1; 

# junction
SELECT species.description 
FROM species
INNER JOIN  animals
ON species.id = animals.species_id 
WHERE animals.name = 'Cartouche';


# aliases
SELECT s.description 
FROM species AS s
INNER JOIN  animals AS a
ON s.id = a.species_id 
WHERE a.name = 'Cartouche';

# test
SELECT 5 + 3 AS my_add;


# junctions - column name
SELECT species.id, species.description, animals.name 
FROM species 
INNER JOIN animals 
ON species.id = animals.species_id 
WHERE animals.name LIKE 'Ch%';


# junctions - column name (using aliases)
SELECT s.id AS 'SpecieID',
	s.description AS 'Specie Description',
	a.name AS 'Animal Name' 
FROM species AS s
INNER JOIN animals AS a
ON s.id = a.species_id 
WHERE a.name LIKE 'Ch%';


# junctions - about the word INNER JOIN
SELECT  a.name AS Name,
		r.name AS race
FROM animals AS a
INNER JOIN races AS r
ON a.race_id = r.id
WHERE a.species_id = 2
ORDER BY r.name, a.name;


# junctions - about the word LEFT JOIN
SELECT  a.name AS Name,
		r.name AS race
FROM animals AS a
LEFT JOIN races AS r
ON a.race_id = r.id
WHERE a.species_id = 2
ORDER BY r.name, a.name;


# junctions - about the word RIGHT JOIN
SELECT  a.name AS Name,
		r.name AS race
FROM animals AS a
RIGHT JOIN races AS r
ON a.race_id = r.id
WHERE a.species_id = 2
ORDER BY r.name, a.name;

SELECT * FROM races WHERE species_id = 2;

SELECT * FROM animals WHERE species_id = 2;



SELECT * FROM animals, species WHERE animals.id = species.id;
