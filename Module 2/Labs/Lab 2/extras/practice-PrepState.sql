SET @price = 7;
SET @catDog = 'dog';
SELECT @catDog;

SELECT @test1 := 42;

SELECT @price;

SET @columns = 'name, dob, current_name';

SELECT @columns
FROM animal a
JOIN species s
	ON a.species_id = s.id
WHERE s.current_name = @catDog AND a.id = @price;


PREPARE quickName
FROM 'SELECT name, dob FROM animal';

EXECUTE quickName;

PREPARE young 
FROM 'SELECT id, name, dob 
	  FROM animal 
	  WHERE YEAR(dob) <= ? 
	  ORDER BY YEAR(dob)';

SET @year1 = 2007;
SET @year2 = 2009;
SET @year3 = 2006;

EXECUTE young USING @year1;
EXECUTE young USING @year2;
EXECUTE young USING @year3;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
										-- practice prepared statements
PREPARE findAnimal
FROM 'SELECT name, dob, sex, current_name, price
	  FROM animal 
      JOIN species
		ON animal.species_id = species.id
        WHERE name = ? AND current_name = ? AND price < ?
        ORDER BY price DESC';
        
        select * from animal
        join species
        on animal.species_id = species.id;
        
SET @name1 = 'rox';
SET @speciesName = 'dog';
SET @price = 500;

EXECUTE findAnimal USING @name1, @speciesName, @price;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @query = 'SELECT * FROM race'; -- setting race table into user created variable
PREPARE select_race
FROM @query; -- assigning prepared statement using user created variable

PREPARE select_species
FROM 'SELECT * FROM species'; -- this achieves the same thing as the statement above

EXECUTE select_race;
EXECUTE select_species;




SET @animal_dob = 'SELECT * FROM animal WHERE YEAR(dob) = 2009'; -- store statement in variable

PREPARE dob
FROM @animal_dob;

EXECUTE dob;



-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

												-- ADVANCED PREPARED STATEMENTS
				
PREPARE breeds -- get all the breeds in the race table
FROM 'SELECT name 
	  FROM race
      ORDER BY name';
      
EXECUTE breeds; -- execute the prepared statement




SET @maledogsFemalecats = "SELECT a.name, a.sex, a.dob, s.current_name, s.price 
						   FROM animal a 
                           JOIN species s 
                           ON a.species_id = s.id 
                           WHERE (s.current_name = ? AND a.sex = ?)
                           ORDER BY s.current_name";

PREPARE find_animal FROM @maledogsFemalecats;

SET @dog = 'dog';
SET @cat = 'cat';
SET @parrot = 'parrot';
SET @turtle = 'turtle';

SET @sex1 = 'M';
SET @sex2 = 'F';


EXECUTE find_animal USING @cat, @sex2; -- executes the prepared statement

DEALLOCATE PREPARE find_animal; -- removes created preapred statement

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     
     
     
     
     
     
     
