USE block3mod2; -- to drop a function use 'DROP FUNCTION'

# example 1
DELIMITER |
CREATE FUNCTION test_function() RETURNS VARCHAR(50)
BEGIN
	RETURN 'Herzing College Montreal';
END |
DELIMITER ;

SELECT test_function() AS school;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# example 2
DELIMITER |
CREATE FUNCTION get_species_name(s_id INT) RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
	DECLARE s_name VARCHAR(50);
    
	SELECT current_name INTO s_name 
	FROM species 
    WHERE id = s_id;
    
	RETURN s_name;
END |
DELIMITER ;

SELECT name, dob, sex, get_species_name(species_id) AS 'species'
FROM animal
WHERE id = 5;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER |
CREATE FUNCTION get_mother_name(a_id INT) RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
	DECLARE m_name VARCHAR(50);
    
    SELECT COALESCE(mother.name, 'No mom') INTO m_name
    FROM animal child
    LEFT JOIN animal mother
		ON child.mother_id = mother.id
	WHERE child.id = a_id;
    
    RETURN m_name;
END |
DELIMITER ;

SELECT name, sex, dob, get_mother_name(id) AS mom
FROM animal
WHERE id = 1;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER |
CREATE FUNCTION get_price(a_id INT) RETURNS DECIMAL(7,2) NOT DETERMINISTIC
BEGIN
	DECLARE price DECIMAL(7,2) DEFAULT 0.0;
    
    SELECT COALESCE(r.price, s.price) INTO price
    FROM animal a
    JOIN species s
		ON a.species_id = s.id
    LEFT JOIN race r
		ON a.race_id = r.id
	WHERE a.id = a_id;
    
    RETURN price;
END |
DELIMITER ;

set@price = get_price(1);
SELECT @price;

-- or use in a query

SELECT name, dob, sex, get_price(id) AS 'price', get_mother_name(id) AS 'mom', get_species_name(id) AS 'species'
FROM animal
 WHERE id = 1; 

