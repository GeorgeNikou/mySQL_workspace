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
CALL list_animals();


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
CALL fetch_animal_age(19, @var_animal);
SELECT @var_animal;


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
CALL price_of_pets(1,4,19, @var_price_of_pets);
SELECT @var_price_of_pets;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- INCOMPLETE
4. STORE PROCEDURE: total_age_of_animal
	IN: 1 Animal id
	INOUT: Cummulative age of the animals
	Do it for 5 animals
    
SET @added_age = 0;   
    
DELIMITER | 
CREATE PROCEDURE total_age_of_animal(IN p_id INT, OUT p_result INT)

BEGIN 
	
    SELECT (YEAR(NOW()) - YEAR(dob)) INTO p_result 
    FROM animal
    WHERE animal.id = p_id;

END |
DELIMITER ;
DROP PROCEDURE total_age_of_animal;
CALL total_age_of_animal(1, @age_total);

SET @added_age = @added_age + @age_total;
SELECT @age_total;


use block3mod2;																			-- -- Question 4 FIXED (08/29/2019)
DELIMITER |
CREATE PROCEDURE calculate_price(IN p_animal_id INT, INOUT p_price DECIMAL(7,2))
BEGIN
    SELECT p_price + COALESCE(race.price, Species.price) INTO p_price
    FROM animal
    JOIN species 
		ON species.id = animal.species_id
    LEFT JOIN race 
		ON race.id = animal.race_id
    WHERE animal.id = p_animal_id;
END |
DELIMITER ;
DROP PROCEDURE calculate_price;
CALL calculate_price(5, @price);


SET @price = 0;
CALL calculate_price (13, @price);  
SELECT @price AS first_total;

CALL calculate_price (24, @price);  
SELECT @price AS second_total;

CALL calculate_price (42, @price);
SELECT @price AS third_total;

CALL calculate_price (25, @price);
SELECT @price AS fourth_total;

CALL calculate_price (1, @price);
SELECT @price AS fifth_total;


-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


5. STORE PROCEDURE: top_x_animals
	IN: How many animals to display
	Display a list of x number of animals for the following:
		-Youngest
		-Oldest
		-Cheapest
		-Most Expensive
		-Male
		-Female

# youngest
DELIMITER |
CREATE PROCEDURE top_x_animals_youngest(IN p_var SERIAL)
BEGIN
	SELECT * 
	FROM animal
	ORDER BY DATE(dob) DESC 
    LIMIT p_var;
END |
DELIMITER ;
DROP PROCEDURE top_x_animals_youngest;
CALL top_x_animals_youngest(3);

	
# oldest
DELIMITER |
CREATE PROCEDURE top_x_animals_oldest(IN p_var SERIAL)
BEGIN
	SELECT * 
	FROM animal
	ORDER BY DATE(dob) 
    LIMIT p_var;
END |
DELIMITER ;
DROP PROCEDURE top_x_animals_oldest;
CALL top_x_animals_oldest(6);

# cheapest animal
DELIMITER |
CREATE PROCEDURE top_x_animals_most_expensive(IN p_var SERIAL)
BEGIN

	SELECT a.id, a.name, DATE(a.dob) AS 'dob', r.price
    FROM animal a
    JOIN race r
		ON a.race_id = r.id
	WHERE r.price IS NOT NULL
	ORDER BY r.price DESC
    LIMIT p_var;
	
END | 
DELIMITER ;
DROP PROCEDURE top_x_animals_most_expensive;
CALL top_x_animals_most_expensive(15);


# most expensive animal
DELIMITER |
CREATE PROCEDURE top_x_animals_least_expensive(IN p_var SERIAL)
BEGIN

	SELECT a.id, a.name, DATE(a.dob) AS dob, r.price
    FROM animal a
    JOIN race r
		ON a.race_id = r.id
	WHERE r.price IS NOT NULL
	ORDER BY r.price
    LIMIT p_var;
	
END | 
DELIMITER ;
DROP PROCEDURE top_x_animals_least_expensive;
CALL top_x_animals_least_expensive(5);


# male animals
DELIMITER |
CREATE PROCEDURE top_male_animals(IN p_var INT)
BEGIN

	SELECT * 
	FROM animal
	WHERE sex = 'M' AND sex IS NOT NULL
	ORDER BY name
	LIMIT p_var;

END | 
DELIMITER ;
DROP PROCEDURE top_male_animals;
CALL top_male_animals(7);


# male animals
DELIMITER |
CREATE PROCEDURE top_female_animals(IN p_var INT)
BEGIN

	SELECT * 
	FROM animal
	WHERE sex = 'F' AND sex IS NOT NULL
	ORDER BY name
	LIMIT p_var;

END | 
DELIMITER ;
DROP PROCEDURE top_female_animals;
CALL top_female_animals(7);

	