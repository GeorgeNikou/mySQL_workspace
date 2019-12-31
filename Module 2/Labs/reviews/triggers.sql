USE block3mod2; -- to delete a trigger use 'DROP TRIGGER'

DELIMITER |
CREATE TRIGGER test BEFORE UPDATE ON animal FOR EACH ROW
BEGIN
	UPDATE species SET current_name = 'Dogo' WHERE id = 1;
END |
DELIMITER ;

UPDATE animal SET name = 'ROXY' WHERE id = 1;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER |
CREATE TRIGGER set_mom AFTER UPDATE ON animal FOR EACH ROW
BEGIN
	UPDATE species SET current_name = 'Dogo' WHERE id = 1;
END |
DELIMITER ;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER |
CREATE TRIGGER verify_sex BEFORE UPDATE ON animal FOR EACH ROW
BEGIN
	IF NEW.sex IS NOT NULL AND NEW.sex != 'M' AND NEW.sex != 'F'  THEN
		SET NEW.sex = NULL;
	END IF;
END |
DELIMITER ;

UPDATE animal SET sex = 'R' WHERE id = 1;
SELECT * FROM animal WHERE id = 1;



# PRACTICE
DELIMITER |
CREATE TRIGGER update_count AFTER UPDATE ON animal FOR EACH ROW
BEGIN 
	DECLARE counting INT DEFAULT 0;

	SELECT COUNT(*) INTO counting
	FROM animal;

	SELECT counting;
END |
DELIMITER ;

UPDATE ANIMAL SET name = 'ROX' where id = 1;


DELIMITER |
CREATE TRIGGER update_species_count AFTER INSERT ON animal FOR EACH ROW
BEGIN
	UPDATE species SET `count` = countSpecies(id) WHERE id = NEW.species_id;
END |
DELIMITER ;


INSERT INTO animal (name, sex,dob, species_id) VALUES ('Ratzi', 'P', '2019-01-01', 5);



