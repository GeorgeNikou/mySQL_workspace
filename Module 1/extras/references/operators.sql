USE block3m1;

SELECT species, sex, name FROM animal;

INSERT INTO animal VALUES (NULL,'cat','M','Biggles','evil cat','2005-04-07');

# selecting all cats from table
SELECT * FROM animal WHERE species='cat';

# selecting all before date listed
SELECT * FROM animal WHERE dob<'2008-01-01';

# selecting all that is different then cat
SELECT * FROM animal WHERE species<>'cat';

# selecting all female cats using AND operator
SELECT * FROM animal WHERE species='cat' AND sex='F';

# selecting all male cats using && operator
SELECT * FROM animal WHERE species='cat' && sex='M';

# selecting all except male turtles
SELECT * FROM animal WHERE species='turtle' XOR sex='M';

# selecting all cats or turtles using OR operator
SELECT * FROM animal WHERE species='cat' OR species='turtle';

# selecting all cats or turtles using || operator
SELECT * FROM animal WHERE species='cat' || species='turtle';

# selecting all BUT cats and dogs using AND NOT operator
SELECT * FROM animal WHERE species='cat' AND NOT species='dog';

# selecting all BUT cats or dogs using != operator
SELECT * FROM animal WHERE species='cat' != species='dog';

# select all cats born after 2009
SELECT * FROM animal WHERE species='cat' AND dob>'2009';

# select cats male and female born after 2009 AND male cats born 2 years older code 1
SELECT * FROM animal WHERE species='cat' AND  dob>'2009' AND  sex='F' OR sex='M' AND dob<'2007';

# teachers code for code 1
SELECT * FROM animal WHERE species='cat'AND ((sex = 'M' OR sex = 'F' AND dob > '2008-12-31') OR (sex = 'M' AND  dob < '2006-12-31'));

# select all animals before 2009 or male and female cats AND  female cats born before 2006 code 2
SELECT * FROM animal WHERE dob > '2009' OR (species = 'cat' AND  sex = 'M' OR sex = 'F');

# teachers code for code 2
SELECT * FROM animal WHERE (dob > '2008-12-31') OR (species = 'cat' AND (sex = 'M' OR sex = 'F')) OR (species = 'cat' AND sex = 'F' AND dob < '2006-05-30');

# selecting all animals with names that are NULL
SELECT * FROM animal WHERE name IS NULL;

# selecting all animals with comments that are NULL
SELECT * FROM animal WHERE comments <=> NULL;

# select all animals where name is not null and name is in descending order
SELECT * FROM animal WHERE name IS NOT NULL ORDER BY name DESC;

# select all animals ordered by species and date of birth
select * from animal ORDER BY species, dob;

# selects all animals including duplicates
SELECT species FROM animal;

# select all animals excluding duplicates
SELECT DISTINCT species FROM animal;

# select 6 animals starting from ID 0
SELECT * FROM animal ORDER BY id LIMIT 6 OFFSET 0;

# selecting animals with the letter 'a' in position
SELECT * FROM ANIMAL WHERE name LIKE '%a%';

# selecting animals from a specific date to the next specific date using  less than and greater than operators
SELECT * FROM animal WHERE dob <= '2009-03-23' AND dob >='2008-01-05'; 

# selecting animals from a specific date to the next specific date using the BETWEEN key word
SELECT * FROM animal WHERE dob BETWEEN '2008-01-05' AND '2009-03-23';

# select all specified names method #1
SELECT  * FROM
    animal
WHERE
    name = 'Moka' OR name = 'Bilba'
        OR name = 'Tortilla'
        OR name = 'Balou'
        OR name = 'Dana'
        OR name = 'Redbul'
        OR name = 'Gingko';

# select all specified names method #2
SELECT * FROM animal WHERE name IN('Bilba','Tortilla', 'Balou', 'Dana', 'Redbul', 'Gingko');

# delete row with the name Zoulou
DELETE FROM animal WHERE name = 'Zoulou';

# change the name and sex of specified animal (logical operators are used when specifying the data already inside the table)
UPDATE animal SET name='Zoro', sex='M' WHERE name='Zara' AND sex='F'; 

SELECT * FROM animal;









