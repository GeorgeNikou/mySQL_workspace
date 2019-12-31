use block3mod2;


-- local variables
DELIMITER |

CREATE PROCEDURE today_tomorrow()
BEGIN 
	DECLARE today DATE DEFAULT now();
    DECLARE tomorrow DATE DEFAULT today + INTERVAL 1 DAY;
	DECLARE day2 DATE DEFAULT today + INTERVAL 2 DAY;
	DECLARE day3 DATE DEFAULT today + INTERVAL 3 DAY;
    
    SELECT date_format(today, '%w, %m, %e, %y') AS today,
		   date_format(tomorrow, '%w, %M, %e, %y') AS tomorrow,
		   date_format(day2, '%w, %m, %e, %y') AS day2,
           date_format(day3, '%w, %m, %e, %y') AS day3;
    
END |

-- ----------------------------------------------------------------------------------------------------------------------------------------------

-- test1
DROP PROCEDURE IF EXISTS today_tomorrow|
CALL today_tomorrow();

CREATE PROCEDURE testRange1()
BEGIN 
	DECLARE var1 VARCHAR(10) DEFAULT 'Mr george';
    
    BEGIN
		DECLARE var2 VARCHAR(10) DEFAULT 'Mrs george';
        SELECT 'scope 2' AS scope, var1 AS V1,  var2 AS V2;
    END;
	SELECT 'scope 2' AS scope, var1 AS V1,  var2 AS V2; -- these variables are out of scope and cannot be called
END |

CALL testRange()|

-- test2
CREATE PROCEDURE testRange2()
BEGIN 
	DECLARE var1 VARCHAR(10) DEFAULT 'Mr george';
    
    BEGIN
		SET var2 = 'Mrs george'; -- this variable will override
        SELECT 'scope 2' AS scope, var1 AS V1,  var2 AS V2;
    END;
	SELECT 'scope 2' AS scope, var1 AS V1,  var2 AS V2; 
END |

DELIMITER ;

-- ----------------------------------------------------------------------------------------------------------------------------------------------

-- IF statements
SELECT name, dob, IF(YEAR(dob) = 2010, 'lucky!', 'that sucks.') AS luck
FROM animal
WHERE race_id IS NOT NULL;

-- ----------------------------------------------------------------------------------------------------------------------------------------------

-- switch cases
SELECT name, dob, sex,
	CASE sex
		WHEN 'F' THEN 'Female'
        WHEN 'M' THEN 'Male'
        ELSE 'No Gender'
	END AS Gender
FROM animal;

SELECT name, dob, sex,
	CASE YEAR(dob)
		WHEN '2009' THEN '2009 yo'
        WHEN '2010' THEN 'best year'
        ELSE 'Nope'
	END AS year
FROM animal;



# REAL world example
DELIMITER |

CREATE PROCEDURE is_adopted(IN a_id INT)
BEGIN
	DECLARE bool TINYINT DEFAULT 0;
    DECLARE animal_name VARCHAR(50);
    
    # select the name and save it into my variable
    SELECT name INTO animal_name
    FROM animal 
    WHERE id = a_id;
    
    # check to see if the animal is in the adoption table or not
	SELECT COUNT(*) INTO bool
    FROM adoption
    WHERE animal_id = a_id;
    
    IF bool > 0 THEN 
		SELECT concat_ws(" ", animal_name, 'is adopted');
	ELSE 
		SELECT concat_ws(" ", animal_name, 'is not adopted');
	END IF;
END |

DELIMITER ;

CALL is_adopted(39);


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------


describe animal;
-- CLASS practice

DELIMITER  |
CREATE PROCEDURE check_year(IN p_id INT)
BEGIN 
	DECLARE a_year YEAR DEFAULT 0;
    
	SELECT id, name, YEAR(dob) AS 'date of birth' INTO a_year
    FROM animal
    WHERE id = p_id;
	
    IF a_year < 2010 THEN
		SELECT 'its 2010' AS first_year;
	ELSEIF a_year > 2010 THEN
		SELECT 'born after 2010' AS second_year;
	ELSE 
		SELECT 'nethier' AS other;
	END IF;
 
END |
DELIMITER ;
DROP PROCEDURE check_year;
CALL check_year(63);


-- teacher note (done like above using switch case) top is my code, not the teachers
-- SET before_after = IF(a_year > 2010, 'after', 'before')
-- CASE a_year
	-- WHEN 0 THEN
		-- SELECT CONCAT_WS(" ", a_id, "is not valid") AS result;
	-- WHEN 2010 THEN
		-- SELECT CONCAT_WS(" ", a_id, "is valid") AS result;
	-- ELSE 
		-- SELECT CONCAT_WS(" ", a_id, "nethier") AS result;
-- END CASE;

-- ----------------------------------------------------------------------------------------------------------------------------------------------

# using while loops
DELIMITER |
CREATE PROCEDURE count_in_while()
BEGIN 
	DECLARE i INT DEFAULT 0;
    DECLARE output TEXT;
    
    WHILE i < 10 DO
		SET output = CONCAT_WS(",", output, i);
        SET i = i + 1;
	END WHILE;
    
    SELECT output Result;
END |
DELIMITER ;
CALL count_in_while();



# while loops with parameter
DELIMITER |
CREATE PROCEDURE count_in_while2(IN p_num INT)
BEGIN 
	DECLARE i INT DEFAULT 0;
    DECLARE output TEXT;
    DECLARE LINEbREAK VARCHAR(2) DEFAULT '';
    
    WHILE i < p_num DO
		SET output = CONCAT_WS(",", output, i);
        SET i = i + 1;
	END WHILE;
    
    SELECT output Result;
END |
DELIMITER ;
CALL count_in_while2(10);

-- ----------------------------------------------------------------------------------------------------------------------------------------------

# while loop with line breaks
DELIMITER |
CREATE PROCEDURE count_in_while2(IN p_num INT)
BEGIN 
	DECLARE i INT DEFAULT 0;
    DECLARE output TEXT;
    DECLARE lineBreak VARCHAR(2) DEFAULT '';
    
    WHILE i < p_num DO
		SET lineBreak = IF(i Mod 10 = 0, '\n', ''); -- ternary IF statement
		SET output = CONCAT_WS(",", CONCAT(output, lineBreak), i);
        SET i = i + 1;
	END WHILE;
    
    SELECT output Result;
END |
DELIMITER ;

-- ----------------------------------------------------------------------------------------------------------------------------------------------

# creating and using a temporary table
DELIMITER |
CREATE PROCEDURE count_in_while3(IN num INT)
BEGIN
DECLARE i INT DEFAULT 0;

# create a temporary table
CREATE TABLE IF NOT EXISTS whileloop(num INT);
TRUNCATE TABLE whileloop; -- empties the temporary table

WHILE i < num DO
	INSERT INTO whileloop VALUES(i);
    SET i = i + 1;
END WHILE;

SELECT * FROM whileloop;

END |
DELIMITER ;

CALL count_in_while3(100);




DELIMITER |
CREATE PROCEDURE display_even(IN p_even INT)
# create a temporary table
CREATE TABLE IF NOT EXISTS whileloop(num INT);
TRUNCATE TABLE whileloop; -- empties the temporary table

BEGIN
WHILE i < num DO
	IF i MOD 2 = 0 THEN
		INSERT INTO whileloop VALUES(i);
		SET i = i + 1;
	END WHILE;
END |
DELIMITER ;

-- ----------------------------------------------------------------------------------------------------------------------------------------------

#COUNT in REPEAT
DELIMITER |
CREATE PROCEDURE count_in_repeat(IN num INT)
BEGIN 
DECLARE i INT DEFAULT 0;
    DECLARE output TEXT;
    DECLARE lineBreak VARCHAR(2) DEFAULT '';
    
   REPEAT
		SET lineBreak = IF(i Mod 10 = 0, '\n', ''); -- ternary IF statement
		SET output = CONCAT_WS(",", CONCAT(output, lineBreak), i);
        SET i = i + 1;
	UNTIL i > num END REPEAT;  
    
    SELECT output Result;
END |
DELIMITER ;
 CALL count_in_repeat(100);

-- ----------------------------------------------------------------------------------------------------------------------------------------------

# LEAVE example 1
DELIMITER |
CREATE PROCEDURE leave1(IN num INT, IN stopTo INT)
BEGIN 
DECLARE i INT DEFAULT 0;
    DECLARE output TEXT;
    DECLARE lineBreak VARCHAR(2) DEFAULT '';
    
   r1:  REPEAT
		SET lineBreak = IF(i Mod 10 = 0, '\n', ''); -- ternary IF statement
		SET output = CONCAT_WS(",", CONCAT(output, lineBreak), i);
        SET i = i + 1;
        IF i = stopTo THEN 
			LEAVE r1;
		END IF;
	UNTIL i > num END REPEAT;  
    
    SELECT output Result;
END |
DELIMITER ;
CALL leave1(100, 50);

-- ----------------------------------------------------------------------------------------------------------------------------------------------

# using ITERATE (this is continue in java)
DELIMITER |
CREATE PROCEDURE iterateLoop(IN num INT)
BEGIN
	DECLARE i INT DEFAULT 0;
    
w1: WHILE i < num DO
		SELECT i 'Num';
		SET i = i + 1;
        
		SELECT 'Before IF';
        
		IF i MOD 2 = 0 THEN
			SELECT 'inside IF';
			ITERATE w1;
		END IF;
	END WHILE w1;
END |
DELIMITER ;
CALL iterateLoop(5);

-- ----------------------------------------------------------------------------------------------------------------------------------------------
# LOOP LOOP(better known as a infinite loop)

-- last lecture will be on TRIGGERS
