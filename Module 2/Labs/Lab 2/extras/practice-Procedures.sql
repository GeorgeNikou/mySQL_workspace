DELIMITER | 
	CREATE PROCEDURE display_names()
	BEGIN 
        SELECT name 
        FROM animal ORDER BY name;
	END | 
DELIMITER ;



-- when using the console, be sure to use the delimiter seperate from the actual stored procedure(Like example below).
DELIMITER | -- RUN first

BEGIN -- RUN second 
	SELECT * 
	FROM animal
	ORDER BY name
END |

DELIMITER ; -- RUN last (if you wish to reset the delimiter to its default semi-colon)

SHOW PROCEDURE STATUS;

use block3mod2;

-- lab2.2 question 3
CREATE PROCEDURE price_of_pets(IN p_id1 SMALLINT, IN p_id2 SMALLINT, IN p_id3 SMALLINT, OUT p_total_price_of_animals INT)
BEGIN 
	SELECT SUM(s.price) 
    FROM animal a 
    JOIN species s 
		ON a.species_id = s.id 
	WHERE a.id IN(p_id1, p_id2, p_id3) 
    GROUP BY name 
    WITH ROLLUP INTO p_total_price_of_animals; 
END|

block3/module2/LAB2(2)

1. STORE PROCEDURE: list_animals
	Display the list of all the animals with a name and a race
	
DELIMITER |
CREATE PROCEDURE list_animals()
BEGIN
	SELECT *
	FROM animal 
	WHERE name IS NOT NULL OR race_id IS NOT NULL
	ORDER BY name;
END 
DELIMITER ;


-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


2. STORE PROCEDURE: fetch_animal_age
	IN: Animal id
	OUT: Animal age in numbers
	
DELIMITER |
CREATE PROCEDURE fetch_animal_age(IN p_animal_id SMALLINT, OUT p_animal_age INT)
BEGIN 
	SELECT YEAR(NOW()) - YEAR(dob) INTO p_animal_age 
	FROM animal 
	WHERE id = p_animal_id; 
END |
DELIMITER ;


-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



3. STORE PROCEDURE: price_of_pets
	IN: 3 Animal ids
	OUT: Price of the 3 animals
	
DELIMITER |
CREATE PROCEDURE price_of_pets(IN p_id1 SMALLINT, IN p_id2 SMALLINT, IN p_id3 SMALLINT, OUT p_total_price_of_animals INT) 
BEGIN 
	SELECT SUM(s.price) INTO p_total_price_of_animals
	FROM animal a 
	JOIN species s
		ON a.species_id = s.id 
	WHERE a.id IN(p_id1, p_id2, p_id3) ; 
END|
DELIMITER ;










