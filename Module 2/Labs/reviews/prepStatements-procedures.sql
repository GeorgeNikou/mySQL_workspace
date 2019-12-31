CREATE DATABASE block3mod2; -- new Database
use block3mod2;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SET @age = 24;
SET @hello = 'Hello world', @weight = 7.8; --  assign variables
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT @age, @hello, @weight; -- declare variables
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT @age:=32, @weight:=48.15, @parrot:=4; -- assign and declare at the same time
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT id, sex, name, comments, species_id
FROM animals
WHERE species_id = @parrot; -- use variable to search
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------


SET@convertToEuro = 1.31564;
SELECT price AS current_dollar_price, ROUND(price * @convertToEuro, 2) AS euro_price, name -- using variable within a function
FROM race; 

SET @columns = 'id, name, description';
SELECT @columns
FROM races
WHERE species_id = 1;



-- prepared statements
PREPARE select_race 
FROM 'SELECT * FROM race';

PREPARE select_client
FROM 'SELECT * FROM client WHERE email = ?';

PREPARE select_adoption
FROM 'SELECT * FROM adoption WHERE client_id = ? AND animal_id = ?';

EXECUTE select_race;

SET @email = 'jean.dupont@email.com';
EXECUTE select_client USING @email;

SET @c_id = 1, @a_id = 39;
EXECUTE select_adoption USING @c_id,  @a_id; -- using two

PREPARE dogs
FROM 'SELECT id,name FROM animal WHERE species_id = 1 AND YEAR(dob) < 2008';-- random made prepared statement
EXECUTE dogs;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE show_race_query()
BEGIN
SELECT id, name, species_id, price
FROM race;
END; -- WON'T WORK, NEED TO CHANGE THE DELIMITER!




DELIMITER |
CREATE PROCEDURE show_race()
BEGIN
	SELECT id, name, species_id, price
    FROM race;
END |
DELIMITER ;

CALL show_race; -- calling stored procedure

USE block3mod2;
DELIMITER |
CREATE PROCEDURE
	show_race_by_species(IN p_species_id INT)
BEGIN
	SELECT id, name, species_id, price
    FROM race
    WHERE species_id = p_species_id;
END |
DELIMITER ;
describe animal;
CALL show_race_by_species(1);

DROP PROCEDURE show_race_by_species; -- drops the procedure


DELIMITER | 
CREATE PROCEDURE count_race_by_species(IN p_species_id INT, OUT p_num_races INT)
BEGIN
	SELECT COUNT(*) INTO p_num_races
	FROM race
	WHERE species_id = p_species_id;
END |
DELIMITER ;

CALL count_race_by_species(@num_cat_race);
SELECT @num_cat_race;
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT id, name INTO @var1, @var2
FROM animal
WHERE id = 7;

SELECT @var1, @var2;
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER | 
CREATE PROCEDURE calculate_price(IN p_animal_id INT, INOUT p_price DECIMAL(7,2))
BEGIN
	SELECT p_price + COALESCE(race.price, Species.price) INTO p_price
    FROM animal
    INNER JOIN species ON species.id = animal.species_id
    LEFT JOIN race ON race.id = animal.race_id
    WHERE animal.id = p_animal_id;
END |
DELIMITER ;

DROP PROCEDURE calculate_price;

SET @price = 0;
CALL calculate_price(13, @price);
SELECT @price;

SHOW PROCEDURE STATUS; -- shows all databases
SHOW CREATE PROCEDURE show_race; -- shows specific procedures
DROP PROCEDURE show_race; -- drops procedures






