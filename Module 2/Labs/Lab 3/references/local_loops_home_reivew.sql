use block3mod2;

DELIMITER |
CREATE PROCEDURE search_name(IN p_name VARCHAR(30))
BEGIN
	SELECT id, name, sex, dob, IF(name LIKE 'T%', 'TRUE', 'FALSE') AS 'boolean'
	FROM animal;
END |
DELIMITER ;

DROP PROCEDURE search_name;
CALL search_name('rox');

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER |
CREATE PROCEDURE check_dog(IN p_name VARCHAR(30), OUT p_var1 VARCHAR(30))
BEGIN
	SELECT id, name, dob, IF(species_id = 1, 'true', 'false') AS 'is it a dog?'
    FROM animal
    WHERE name = p_name; -- narrowing search
    SET p_var1 = p_name; -- setting result to OUT variable
END | 
DELIMITER ;
DROP PROCEDURE check_dog;
CALL check_dog('bouli', @dog);

SELECT @dog; -- animal has been set

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER |
CREATE PROCEDURE check_alive()
BEGIN
	SELECT *, IF(YEAR(dob) > 2011, 'alive', 'r.i.p') AS alive 
	FROM animal; 
END |
DELIMITER ;
DROP PROCEDURE check_alive;
CALL check_alive;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER |
CREATE PROCEDURE search_price()
BEGIN

	SELECT a.name, s.current_name, s.price, IF(s.price > 400, 'expensive', 'cheap') AS 'too expensive?' 
	FROM animal a
	JOIN species s
		ON a.species_id = a.id
	ORDER BY a.id;

END |
DELIMITER ;
DROP PROCEDURE search_price;
CALL search_price();

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER |
CREATE PROCEDURE search_total(IN p_calculate FLOAT, OUT p_total INT)
BEGIN 
	DECLARE tax FLOAT DEFAULT .15; -- creates tax
	DECLARE total_tax FLOAT; -- stores the sub total from sum

	SELECT a.id, a.name, s.current_name, s.price, COUNT(s.price) AS total_count, SUM(s.price) AS total_price
	FROM animal a
	JOIN species s
		ON a.species_id = s.id
	GROUP BY s.current_name
	WITH ROLLUP;

	SET total_tax = p_calculate * tax;
	SET p_total = total_tax + p_calculate;

-- SET sub_total =  SUM(s.price); -- stores total
-- SET tax = sub_total * tax; -- multiplies sub total with tax
-- SET p_total = p_total + tax; -- final total with tax added

END |
DELIMITER ;
DROP PROCEDURE search_total;

SET @animal_total = 0;
CALL search_total(199.99,@animal_total);
SELECT @animal_total;


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------


SELECT id, name, sex, dob, 
CASE
	WHEN YEAR(dob) <= 2010 AND YEAR(dob) >= 2008 THEN 'old'
    WHEN YEAR(dob) < 2008 THEN 'very old'
    WHEN YEAR(dob) > 2010 THEN 'very young'
	ELSE 'n/a'
END AS 'age summary'
FROM animal;


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER |
CREATE PROCEDURE check_state(IN p_id SMALLINT(6), OUT p_var VARCHAR(30))
BEGIN

	DECLARE l_name VARCHAR(30);

	SELECT name INTO l_name
	FROM animal 
	WHERE animal.id = p_id;

	SET p_var = l_name;

	IF (p_var = 'Rox') THEN
		SELECT CONCAT_WS('    ', 'this is rox!', p_var) AS result;
	ELSE 
		SELECT CONCAT_WS(' - ','this is NOT rox', p_var) AS result;
	END IF;

END |
DELIMITER ;
DROP PROCEDURE check_state;

CALL check_state(1, @rare);
SELECT @rare;


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# using IF, IFELSE, ELSE
DELIMITER |
CREATE PROCEDURE born_after2008(IN p_id SMALLINT(6))
BEGIN

	DECLARE i_name VARCHAR(30);
	DECLARE i_year YEAR;

	SELECT name INTO i_name
	FROM animal
	WHERE id = p_id;

	SELECT YEAR(dob) INTO i_year
	FROM animal
	WHERE id = p_id;

	IF i_year > 2008 THEN
		SELECT CONCAT(UPPER(i_name), ' was born after 2008 in the year ', i_year, '.') as final_result; 
	ELSEIF(i_year <= 2008) THEN
		SELECT CONCAT(UPPER(i_name), ' was born before 2008 in the year ', i_year, '.') as final_result; 
	ELSE 
		SELECT CONCAT(UPPER(i_name),"'s ", ' year of birth is unknown to us.') as final_result;
	END IF;
 
END |
DELIMITER ;
DROP PROCEDURE born_after2008;
CALL born_after2008(50);


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------


# using CASE
DELIMITER |
CREATE PROCEDURE born_after2009(IN p_id SMALLINT(6))
BEGIN

	DECLARE i_name VARCHAR(30);
	DECLARE i_year YEAR;

	SELECT name INTO i_name
	FROM animal
	WHERE id = p_id;

	SELECT YEAR(dob) INTO i_year
	FROM animal
	WHERE id = p_id;

	CASE
	WHEN i_year > 2009 THEN
		SELECT CONCAT(UPPER(i_name), ' was born after 2008 in the year ', i_year, '.') as final_result; 
	WHEN (i_year <= 2009) THEN
		SELECT CONCAT(UPPER(i_name), ' was born before 2008 in the year ', i_year, '.') as final_result; 
	ELSE
		SELECT CONCAT(UPPER(i_name),"'s ", ' year of birth is unknown to us.') as final_result;
	END CASE;
 
END |
DELIMITER ;
DROP PROCEDURE born_after2009;
CALL born_after2009(50);


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------


DELIMITER |
CREATE PROCEDURE search_tables(IN p_table_name VARCHAR(20))
BEGIN

DECLARE i_null VARCHAR(10) DEFAULT NULL;

CASE 
	WHEN p_table_name = 'animal' THEN SELECT * FROM `animal`;
	WHEN p_table_name = 'adoption' THEN SELECT * FROM `adoption`;
    WHEN p_table_name = 'client' THEN SELECT * FROM `client`;
    WHEN p_table_name = 'race' THEN SELECT * FROM `race`;
    WHEN p_table_name = 'species' THEN SELECT * FROM `species`;
    ELSE SELECT 'no tables were found' as 'result';
END CASE;

END |
DELIMITER ;
DROP PROCEDURE search_tables;
CALL search_tables('animal');


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# repeat loop practice
DELIMITER |
CREATE PROCEDURE repeat_test1(IN p_num INT)
BEGIN
	
    DECLARE i_num INT DEFAULT 0; -- stopPing factor
	DECLARE i_user_num INT;
    DECLARE i_result TEXT DEFAULT 'result';
    
    SET i_user_num = p_num; -- stores user input into variable

	REPEAT
		SET i_result =  CONCAT_WS(',', i_result, i_user_num);
        SET i_user_num = i_user_num - 1;
		UNTIL i_user_num = i_num
    END REPEAT;

	SELECT I_result AS 'results';

END |
DELIMITER ;
DROP PROCEDURE repeat_test1;
CALL repeat_test1(10);


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------


DELIMITER |
CREATE PROCEDURE even_test(IN p_num1 FLOAT, OUT p_num2 INT)
BEGIN

	DECLARE multi_num FLOAT DEFAULT 5.0;
    
    IF(p_num1 MOD 2 = 0) THEN 
		SELECT 'this is an even number';
        SET p_num1 = p_num1 + 2;
	ELSE SELECT 'this is an odd number';
		SET p_num1 = p_num1 + 3;
	END IF;
    
    SET p_num2 = p_num1;
    SET p_num2 = p_num2 * multi_num;
    
    
END |
DELIMITER ;

DROP PROCEDURE even_test;
CALL even_test(2, @r);

SELECT @r;


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------


DELIMITER |
CREATE PROCEDURE repeat_test2()
BEGIN

	DECLARE num1 INT DEFAULT 0;
	DECLARE counter INT DEFAULT 10;
	DECLARE result TEXT;

	REPEAT
		SET result = CONCAT_WS(' | ', result, num1);
		SET num1 = num1 + 1;
		UNTIL num1 = counter 
	END REPEAT;

	SELECT result AS resultz; 

END |
DELIMITER ;

DROP PROCEDURE repeat_test2;
CALL repeat_test2();