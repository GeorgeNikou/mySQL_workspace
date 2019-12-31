USE block3m1;

SELECT name, dob AS 'date of birth' 
FROM animals 
	WHERE comments = 'No shell' 
    OR comments =  'Bite hard';



SELECT name, dob AS 'date of birth' 
FROM animals 
	WHERE name IN('rox', 'bobo','cali')
    ORDER BY name ASC;
    
DESCRIBE animals;

--
-- JOINING TWO TABLES
--
SELECT animals.name, animals.comments, races.name, races.description  
FROM animals JOIN races 
	ON animals.race_id = races.id;
    
--
-- JOINING TWO TABLES USING ALIASES (inner join)
--
SELECT a.name, a.comments, r.name, r.description  
FROM animals AS a JOIN races AS r
	ON a.race_id = r.id;
    
--
-- JOINING TWO TABLES USING ALIASES (left join)
--
SELECT a.name, a.comments, r.name, r.description  
FROM animals AS a LEFT JOIN races AS r
	ON a.race_id = r.id;
    
--
-- JOINING TWO TABLES USING ALIASES (right join)
--
SELECT a.name, a.comments, r.name, r.description  
FROM animals AS a RIGHT JOIN races AS r
	ON a.race_id = r.id;