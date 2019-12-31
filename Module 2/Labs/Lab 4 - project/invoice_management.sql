DROP DATABASE IF EXISTS invoice_management;
CREATE DATABASE invoice_management;

USE invoice_management; 
SET foreign_key_checks = 0; -- please run this line, I created my foreign keys during the creation of the tables


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------


														# DATABASE & TABLE CREATION
                                                        
                                                        

# Create the user table
DROP TABLE IF EXISTS users;
CREATE TABLE users(
id INT(11) UNSIGNED AUTO_INCREMENT NOT NULL,
username VARCHAR(50) NOT NULL,
password VARCHAR(50) NOT NULL,
date_created DATETIME NOT NULL,
status TINYINT(1) DEFAULT 0,
PRIMARY KEY(id)
) ENGINE = InnoDB;


#Create clients table 
DROP TABLE IF EXISTS clients;
CREATE TABLE clients(
id INT(11) UNSIGNED AUTO_INCREMENT NOT NULL,
name VARCHAR(50) NOT NULL,
address VARCHAR(150) NOT NULL,
phone VARCHAR(50),
email VARCHAR(150) NOT NULL UNIQUE,
status TINYINT(1) DEFAULT 0,
PRIMARY KEY (id)
) ENGINE = InnoDB;


# Create invoice table 
DROP TABLE IF EXISTS invoice;
CREATE TABLE invoice(
id INT(11) UNSIGNED AUTO_INCREMENT NOT NULL,
client_id INT UNSIGNED NOT NULL,
created_date DATETIME NOT NULL,
delivery_date DATETIME NOT NULL,
payment_method VARCHAR(50) NOT NULL,
status TINYINT(1) DEFAULT 0,
PRIMARY KEY(id),
FOREIGN KEY (client_id) REFERENCES clients(id)
) ENGINE = InnoDB;



# create invoice detail table
DROP TABLE IF EXISTS invoice_details;
CREATE TABLE invoice_details(
id INT(11) UNSIGNED AUTO_INCREMENT NOT NULL,
item_id INT UNSIGNED NOT NULL,
invoice_id INT UNSIGNED NOT NULL,
item_quantity INT DEFAULT 1,
PRIMARY KEY(id),
FOREIGN KEY (invoice_id) REFERENCES invoice (id),
FOREIGN KEY (item_id) REFERENCES items (id)
) ENGINE = InnoDB;


# create items table
DROP TABLE IF EXISTS items;
CREATE TABLE items(
id INT(11) UNSIGNED AUTO_INCREMENT NOT NULL,
name VARCHAR(150) NOT NULL,
price DOUBLE NOT NULL,
quantity INT DEFAULT 1,
comment TEXT,
status TINYINT(1) DEFAULT 0,
PRIMARY KEY (id)
);

-- DROP TABLE users;
-- DROP TABLE clients;
-- DROP TABLE invoice;
-- DROP TABLE invoice_details;
-- DROP TABLE items;


-- -------------------------------------------------------------------------------------------------------------------------


															# USERS
                                                            


# creates a user
DROP PROCEDURE IF EXISTS add_user;
DELIMITER |
CREATE PROCEDURE add_user(IN p_username VARCHAR(50), IN p_password VARCHAR(50))
BEGIN
	
    # declare instanced variables 
	DECLARE var_username VARCHAR(50);
	DECLARE var_password VARCHAR(50) DEFAULT 'admin';
	DECLARE var_date DATETIME;

	# set instanced variables to user input
	SET var_username = p_username;
	SET var_password = p_password;
	SET var_date = NOW();
    
    # inserting values and setting status to active
    INSERT INTO users (username, password, date_created, status) 
    VALUES (var_username, var_password, var_date, 1);

END |
DELIMITER ;
CALL add_user('Lucy Bernes', '1234');


# search for single user
DROP PROCEDURE IF EXISTS search_user;
DELIMITER |
CREATE PROCEDURE search_user(IN p_id INT(11))
BEGIN

	# checks if user exists and is active
	IF((SELECT status FROM users WHERE id = p_id) = 1) THEN
		SELECT *
		FROM users
		WHERE id = p_id;
	ELSE
		SELECT 'user does not exists or is inactive.';
	END IF;
END | 
DELIMITER ;
CALL search_user(2); 
CALL search_user(3); -- does not exist


# search for all users
DROP PROCEDURE IF EXISTS search_all_users;
DELIMITER |
CREATE PROCEDURE search_all_users()
BEGIN
	SELECT *
    FROM users
    ORDER BY username;
END | 
DELIMITER ;
CALL search_all_users();



# updates user from users table
DROP PROCEDURE IF EXISTS update_user;
DELIMITER |
CREATE PROCEDURE update_user(IN p_id INT, IN p_username VARCHAR(50), IN p_password VARCHAR(50), IN p_date DATETIME, IN p_status TINYINT(1))
BEGIN 
	
    # declares all instance variables
	DECLARE var_name VARCHAR(50);
    DECLARE var_password VARCHAR(50);
    DECLARE var_date DATETIME DEFAULT NOW();
    DECLARE var_status TINYINT(1);
    DECLARE result TEXT;
    DECLARE var_id INT DEFAULT 0;
    
    # set user input into instance variables
    SET var_name = p_username;
    SET var_password = p_password;
    SET var_date = p_date;
    SET var_status = p_status;
    SET var_id = p_id;
    
    # checks to see if user exists and enters correct information
	IF(var_id = (SELECT id FROM users WHERE id = var_id)) THEN
		IF(var_name NOT LIKE (SELECT users.username FROM users WHERE id = var_id)) THEN
			UPDATE users SET users.username = var_name WHERE id = var_id;
        END IF;
        IF(var_password NOT LIKE (SELECT password FROM users WHERE id = var_id)) THEN
			UPDATE users SET users.password = var_password WHERE id = var_id;
        END IF;
        IF(var_date NOT LIKE (SELECT date_created FROM users WHERE id = var_id)) THEN
			UPDATE users SET users.date_created = var_date WHERE id = var_id;
        END IF;
        IF(var_status NOT LIKE (SELECT users.status FROM users WHERE id = var_id)) THEN
			UPDATE users SET users.status = var_status WHERE id = var_id;
        END IF;
	END IF;
    
    # Displays the user update results
    SELECT result AS 'Update results';
    
END |
DELIMITER ;
CALL update_user(3, 'peter', 123, NOW(), 0);


# deletes a user permanently
DROP PROCEDURE IF EXISTS deallocate_user;
DELIMITER |
CREATE PROCEDURE deallocate_user(IN p_name VARCHAR(50), IN p_password VARCHAR(50))
BEGIN

	# declaring instance variable
	DECLARE var_name VARCHAR(50);
    DECLARE var_password VARCHAR(50);
    DECLARE var_id INT;
    DECLARE result TEXT;
   
    # setting instance variables
	SET var_name = p_name;
	SET var_password = p_password;
    
    # stores users id into instanced variable
    SELECT id INTO var_id
    FROM users
    WHERE users.username LIKE var_name AND users.password LIKE var_password;
	
    # permanently removing user from the users table
    IF (var_id = (SELECT id FROM users WHERE users.username LIKE var_name AND users.password LIKE var_password)) THEN
		DELETE FROM users WHERE username = var_name AND password = var_password;
        SET result  = CONCAT(var_name, ' has been successfully deleted!');
	ELSE
		SET result  = ' OOPS! Something went wrong, please try again.';
    END IF;
    
    # displays final result of delete procedure
    SELECT result AS 'Deallocation result';

END |
DELIMITER ;
CALL deallocate_user('lucy bernes', '1234');


# soft delete user
DROP PROCEDURE IF EXISTS soft_delete_user;
DELIMITER |
CREATE PROCEDURE soft_delete_user(IN p_id TINYINT(1))
BEGIN
	
    DECLARE result TEXT;
    
    IF (p_id = (SELECT id FROM users WHERE id = p_id)) THEN
		UPDATE users SET status = 0 WHERE id = p_id;
        SET result = CONCAT('user ID number ', p_id ,' has been set to 0. Account is now inactive.');
	ELSE 
		SET result = 'no user was found, please try again.';
	END IF;
    
    SELECT result AS 'user delete result';
    
END |
DELIMITER ;
CALL soft_delete_user(2);



# deactivate user
DROP PROCEDURE IF EXISTS deactivate_user;
DELIMITER |
CREATE PROCEDURE deactivate_user(IN p_username VARCHAR(50), IN p_password VARCHAR(50))
BEGIN
	
	# declare instanced variables 
	DECLARE var_username VARCHAR(50);
    DECLARE var_password VARCHAR(50);
    
    # set instanced variables to user input
    SET var_username = p_username;
	SET var_password = p_password;
    
    # setting selected user's status to zero
    UPDATE users SET status = 0 WHERE username = var_username AND password = var_password;
     
END |
DELIMITER ;
CALL deactivate_user('lucy bernes', '1234');



# activate user
DROP PROCEDURE IF EXISTS activate_user;
DELIMITER |
CREATE PROCEDURE activate_user(IN p_username VARCHAR(50), IN p_password VARCHAR(50))
BEGIN
	
	# declare instanced variables 
	DECLARE var_username VARCHAR(50);
    DECLARE var_password VARCHAR(50);
    
    # set instanced variables to user input
    SET var_username = p_username;
	SET var_password = p_password;
    
    # setting selected user's status to active
    UPDATE users SET status = 1 WHERE username = var_username AND password = var_password;
     
END |
DELIMITER ;
CALL activate_user('George nikou', '12345');

SELECT * FROM users;


# login user										-- STEP 1 (login and retrieve user)
DROP PROCEDURE IF EXISTS login_user;
DELIMITER | 
CREATE PROCEDURE login_user(IN p_username VARCHAR(50), IN p_password VARCHAR(50), OUT valid_name VARCHAR(50), OUT valid_password VARCHAR(50))
BEGIN 

	# declare instanced variables 
	DECLARE var_username VARCHAR(50) DEFAULT '';
    DECLARE var_password VARCHAR(50) DEFAULT '';
    DECLARE vu VARCHAR(50) DEFAULT '';
    DECLARE vp VARCHAR(50) DEFAULT '';
    
    
    # set instanced variables to user input
    SET var_username = p_username;
	SET var_password = p_password;
    
    
    # setting variables for login validation
    SELECT username, password INTO vu, vp
    FROM users
    WHERE username = var_username AND password = var_password;
    
    # setting OUT variables
    SET valid_name = vu;
    SET valid_password = vp;
    
END |
DELIMITER ;
CALL login_user('Lucy buttface','123454', @check_name, @check_password);

# values have been added to variables
SELECT @check_name, @check_password;

# validates user's user name and password	
DROP FUNCTION IF EXISTS validate_user;					-- STEP 2 (validate)
DELIMITER |
CREATE FUNCTION validate_user(f_name VARCHAR(50), f_password VARCHAR(50)) RETURNS VARCHAR(50) DETERMINISTIC
BEGIN 

	DECLARE result VARCHAR(50);

	IF(f_name = @check_name AND f_password = @check_password) THEN
		SET result = 'you have logged in successfully';
	ELSE 
		SET result = 'invalid username or password';
	END IF;

	RETURN result;
END |
DELIMITER ;
SELECT invoice_management.validate_user('lucy buttface','123454'); --  please run step 1 first (sorry I struggled on this point and needed two parts to complete validation. What can I say, Im a dumbass...)
SELECT invoice_management.validate_user('luy buttfac','123454'); -- checking validation
SELECT invoice_management.validate_user('lucy buttface','123'); -- ...

-- -------------------------------------------------------------------------------------------------------------------------


														# CLIENTS
                                                        
                                                        

# create procedure for ADDING new client
DROP PROCEDURE IF EXISTS add_client;
DELIMITER | 
CREATE PROCEDURE add_client(IN name VARCHAR(50), IN address VARCHAR(150), IN phone VARCHAR(50), IN email VARCHAR(150))
BEGIN
	# declaring local variables
	DECLARE var_name VARCHAR(50) DEFAULT 'N/A';
	DECLARE var_address VARCHAR(150) DEFAULT 'N/A';
	DECLARE var_phone VARCHAR(50);
	DECLARE var_email VARCHAR(150) DEFAULT 'N/A';
    

	# assigning local variables
	SET var_name = name;
    SET var_address = address;
    SET var_phone = phone;
    SET var_email = email;

	# conditional statements(validate user)
	IF(var_name IS NULL OR var_address IS NULL OR var_email IS NULL) THEN
		INSERT INTO clients (name, address, phone, email, status) VALUES('n/a', 'n/a', 'n/a', 1);
	ELSE
		INSERT INTO clients (name, address, phone, email, status) VALUES(var_name, var_address, var_phone, var_email, 1);
	END IF;
END |
DELIMITER ;
CALL add_client('Eric', '3 555 street', '565-5555', 'g66.@gmail.com');



# search single client
DROP PROCEDURE IF EXISTS search_client;
DELIMITER |
CREATE PROCEDURE search_client(IN p_id INT(11))
BEGIN
	
	# query to retrieve client based on id given
	IF( 1 = (SELECT clients.status FROM clients WHERE id = p_id)) THEN
		SELECT * 
		FROM clients
		WHERE id = p_id; 
	ELSE
		SELECT 'client unavailable or is inactive';
	END IF;
    
END |
DELIMITER ;
CALL search_client(4);


# search all clients
DROP PROCEDURE IF EXISTS search_all_clients;
DELIMITER |
CREATE PROCEDURE search_all_clients()
BEGIN

	# query to retrieve all clients
    SELECT * 
	FROM clients
	ORDER BY name;  
    
END |
DELIMITER ;
CALL search_all_clients();


# update a client
DROP PROCEDURE IF EXISTS update_client;
DELIMITER |
CREATE PROCEDURE update_client(IN p_id INT(11), IN name VARCHAR(50), IN address VARCHAR(150), IN phone VARCHAR(50), IN email VARCHAR(150), IN p_status TINYINT(1))
BEGIN
	
    # declaring local variables
    DECLARE var_id INT;
	DECLARE var_name VARCHAR(50) DEFAULT (SELECT name FROM clients WHERE id = p_id); -- my defaults are not working/getting overriden :'(
	DECLARE var_address VARCHAR(150) DEFAULT (SELECT address FROM clients WHERE id = p_id);
	DECLARE var_phone VARCHAR(50) DEFAULT (SELECT phone FROM clients WHERE id = p_id);
	DECLARE var_email VARCHAR(150) DEFAULT (SELECT email FROM clients WHERE id = p_id);
    DECLARE var_status TINYINT DEFAULT (SELECT status FROM clients WHERE id = p_id);
    DECLARE result TEXT;
    

	# assigning local variables
    SET var_id = p_id;
	SET var_name = name;
    SET var_address = address;
    SET var_phone = phone;
    SET var_email = email;
    SET var_status = p_status;
	
    # update chosen client
    IF(var_id = (SELECT id FROM clients WHERE id = var_id)) THEN
		IF(var_name NOT LIKE (SELECT name FROM clients WHERE id = var_id))THEN
			UPDATE clients SET name = var_name WHERE id = var_id;
        END IF;
        IF(var_address NOT LIKE (SELECT name FROM clients WHERE id = var_id))THEN
			UPDATE clients SET address = var_address WHERE id = var_id;
        END IF;
        IF(var_phone NOT LIKE (SELECT name FROM clients WHERE id = var_id))THEN
			UPDATE clients SET phone = var_phone WHERE id = var_id;
        END IF;
        IF(var_email NOT LIKE (SELECT name FROM clients WHERE id = var_id))THEN
			UPDATE clients SET email = var_email WHERE id = var_id;
        END IF;
        IF(var_status NOT LIKE (SELECT status FROM clients WHERE id = var_id))THEN
			UPDATE clients SET name = var_status WHERE id = var_id;
        END IF;
	END IF;
    
    -- SELECT result;
    
END |
DELIMITER ;
CALL update_client(2, 'Lucy Shulks', '123 care street', '575-9986', 'totalycool@gmail.com',1);


select * from clients;

# delete the chosen client
DROP PROCEDURE IF EXISTS deallocate_client;
DELIMITER |
CREATE PROCEDURE deallocate_client(IN p_name VARCHAR(50))
BEGIN

	# declaring local variable
	DECLARE var_name VARCHAR(50) DEFAULT NULL;
    
    # assigning local variable
    SET var_name = LOWER(p_name);
	
    # deleting user by given name
	DELETE FROM clients 
	WHERE name = var_name;

END |
DELIMITER ;
CALL deallocate_client('Eric');



# soft deletes client
DROP PROCEDURE IF EXISTS soft_delete_client;
DELIMITER |
CREATE PROCEDURE soft_delete_client(IN p_id TINYINT(1))
BEGIN

	DECLARE result TEXT;
	
    IF (p_id = (SELECT id FROM clients WHERE id = p_id)) THEN
		UPDATE clients SET status = 0 WHERE id = p_id;
        SET result = CONCAT('Client ID number ', p_id , ' has been set to inactive.');
	ELSE
		SET result = 'Client not found.';
    END IF;
    
    SELECT result AS 'client delete';

END |
DELIMITER ;
CALL soft_delete_client(4);



-- -------------------------------------------------------------------------------------------------------------------------------------------------------------


															-- INVOICE
                                                            
						
                        
# search for a single invoice by ID
DROP PROCEDURE IF EXISTS search_invoice;
DELIMITER |
 CREATE PROCEDURE search_invoice(IN p_id INT(11))
 BEGIN 
	
    # checks if status is is active 1
    IF(1 = (SELECT invoice.status FROM invoice WHERE id = p_id)) THEN
		SELECT *
		FROM invoice
		WHERE id = p_id;
	ELSE 
		SELECT 'invoice does not exist or is inactive.';
	END IF;
 
 END |
 DELIMITER ;
 CALL search_invoice(6);
 
 
 
 # search for all the invoice
 DROP PROCEDURE IF EXISTS search_all_invoice;
DELIMITER |
 CREATE PROCEDURE search_all_invoice()
 BEGIN 
 
	SELECT *
    FROM invoice
    ORDER BY client_id;

 END |
 DELIMITER ;
 CALL search_all_invoice();
 
 
 # function to check if client id exists
 DROP FUNCTION IF EXISTS validate_invoice_client_id;
 DELIMITER |
 CREATE FUNCTION validate_invoice_client_id(f_client_id INT(10)) RETURNS VARCHAR(50) DETERMINISTIC
 BEGIN
	# declarred variables
	DECLARE result VARCHAR(50);
    DECLARE max_count INT;
    
    # counts total number of clients and stores the result into a instance variable
    SELECT COUNT(*) INTO max_count
    FROM clients;
    
	# checks if client_id exists
	IF(f_client_id < 0) THEN
		SET result = CONCAT(f_client_id, ' is a negative number id and does NOT exist');
	ELSEIF(f_client_id > max_count OR f_client_id = 0) THEN
		SET result = CONCAT(f_client_id, ' does NOT exist');
	ELSE
		SET result = CONCAT(f_client_id, ' exists!');
	END IF;
    
    RETURN result;
 END |
 DELIMITER ;
 SELECT invoice_management.validate_invoice_client_id(1);


# adds a new invoice
DROP PROCEDURE IF EXISTS add_invoice;
DELIMITER |
CREATE PROCEDURE add_invoice(IN client_id INT(10), IN payment_method VARCHAR(50))
BEGIN
	
    # declared variables
	DECLARE var_client_id INT DEFAULT 0;
    DECLARE var_payment_method VARCHAR(50);
    DECLARE result TEXT;
    
    # set instanced variables to IN para
    SET var_client_id = client_id;
    SET var_payment_method = payment_method;
    
    # check if client id exists, if so adds a new invoice respectively
    IF(var_client_id = (SELECT clients.id FROM clients WHERE clients.id = var_client_id))THEN
		SET result =  CONCAT('invoice successfully added for client number ', var_client_id);
        INSERT INTO invoice (client_id, created_date, delivery_date, payment_method, status) VALUES (var_client_id, NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY), var_payment_method, 1);
	ELSE
		SET result = "The invoice you're trying to add cannot be added due to unknown client";
	END IF;
    
    SELECT result AS 'Invoice result';
    
END |
DELIMITER ;
CALL add_invoice(3, 'mastercard');


# Permanently deletes invoice
DROP PROCEDURE IF EXISTS deallocate_invoice;
DELIMITER |
CREATE PROCEDURE deallocate_invoice(IN p_id INT(11))
BEGIN
	
    # declare instance variables
    DECLARE var_id INT;
    DECLARE result TEXT;
    
    # set instanced variables
    SET var_id = p_id;
    
    # checks if id exists in the invoice table, if so deletes the chosen row
    IF(var_id = (SELECT invoice.id FROM invoice WHERE invoice.id = var_id))THEN
		DELETE FROM invoice WHERE invoice.id = var_id;
        SET result = CONCAT('Invoice number ', var_id ,' has been deleted successfully!');
	ELSE
        SET result = 'id does not exist and therefore cannot be deleted';
	END IF;
    
    # displays whether id was found or not
    SELECT result AS 'Deallocation result';

END |
DELIMITER ;
CALL deallocate_invoice(5);



# soft deletes invoice
DROP PROCEDURE IF EXISTS soft_delete_invoice;
DELIMITER |
CREATE PROCEDURE soft_delete_invoice(IN p_id TINYINT(1))
BEGIN

	DECLARE result TEXT;
    
    IF (p_id = (SELECT id FROM invoice WHERE id = p_id)) THEN
		UPDATE invoice SET status = 0 WHERE id = p_id;
		SET result  = CONCAT('Invoice ID number ', p_id, ' has been set to inactive.');
	ELSE
		SET result = 'no matching invoices found.';
	END IF;
    
    SELECT result AS 'Invoice result';

END |
DELIMITER ;
CALL soft_delete_invoice(3);


# updates invoice
DROP PROCEDURE IF EXISTS update_invoice;
DELIMITER |
CREATE PROCEDURE update_invoice(IN p_id INT(11),IN p_delivery_date DATETIME, IN payment_method varchar(50))
BEGIN

	# declare instance variables
	DECLARE var_id INT;
    DECLARE var_delivery_date DATETIME;
    DECLARE var_payment_method VARCHAR(50);
    DECLARE result TEXT;
    
    # sets instanced variables
    SET var_id = p_id;
    SET var_delivery_date = p_delivery_date;
    SET var_payment_method = UPPER(payment_method);
    
    # checks if card type is viable, if so updates information respectively
    IF (var_payment_method NOT LIKE 'VISA' AND var_payment_method NOT LIKE 'AMERICAN EXPRESS' AND var_payment_method NOT LIKE 'MASTERCARD') THEN
		SET result = 'Invalid card type';
	ELSE
		 UPDATE invoice SET delivery_date = var_delivery_date, payment_method = var_payment_method WHERE invoice.id = var_id;
         SET result = CONCAT('You have updated client id number ', var_id, ' successfully!', '  |  ', var_payment_method);
	END IF;
   
   # displays whether card type was viable and update was successful
   SELECT result AS 'Action result', var_payment_method;
   
END |
DELIMITER ;
CALL update_invoice(6, NOW(), 'VISA');



-- -------------------------------------------------------------------------------------------------------------------------------------------------------------



													# INVOICE DETAILS
                                                        

# add a new invoice detail
DROP PROCEDURE IF EXISTS add_invoice_details; 
DELIMITER |
CREATE PROCEDURE add_invoice_details(IN p_item_id INT(10), IN p_invoice_id INT(10), IN p_quantity INT)
BEGIN
	
    # Declare instanced variables
    DECLARE var_invoice_id INT;
    DECLARE var_item_id INT;
    DECLARE result TEXT;
    DECLARE var_quantity INT;
    
    # sets instanced variables
    SET var_invoice_id = p_invoice_id;
    SET var_item_id = p_item_id;
    SET var_quantity = p_quantity;
    
    # checks if item and client exists, if so adds a new invoice detail respectively
    IF (var_item_id = (SELECT items.id FROM items WHERE items.id = var_item_id) AND var_invoice_id = (SELECT invoice.id FROM invoice WHERE invoice.id = var_invoice_id)) THEN
		SET result = 'yes, this item is available for purchase';
         INSERT INTO invoice_details (item_id, invoice_id, invoice_details.item_quantity) VALUES(var_item_id, var_invoice_id, var_quantity);
	ELSE
		SET result = 'OOPS! something went wrong, please try again';
	END IF;
    
    # displays whether an invoice detail was added or error was encountered
    SELECT result AS 'Invoice detail result';

END |
DELIMITER ;
CALL add_invoice_details(1,6,10);



# search for a invoice detail
DROP PROCEDURE IF EXISTS search_invoice_detail;
DELIMITER |
CREATE PROCEDURE search_invoice_detail(IN p_id INT)
BEGIN 
	
    # declare instanced variables
	DECLARE var_id INT DEFAULT 0;
    
    # set instance variable to user input
    SET var_id = p_id;
    
    SELECT *
    FROM invoice_details
    WHERE invoice_details.id = var_id;
    
END |
DELIMITER ;
CALL search_invoice_detail(11);




# search all invoice details
DROP PROCEDURE IF EXISTS search_all_invoice_detail;
DELIMITER |
CREATE PROCEDURE search_all_invoice_detail()
BEGIN 
	    
    SELECT *
    FROM invoice_details;
    
END |
DELIMITER ;
CALL search_all_invoice_detail();



# Updates invoice detail row
DROP PROCEDURE IF EXISTS update_invoice_details;
DELIMITER |
CREATE PROCEDURE update_invoice_details(IN p_id INT, IN p_item_id INT, IN p_invoice_id INT, IN p_quantity INT, OUT sub_quantity INT)
BEGIN

	# Declare instanced variables
    DECLARE var_item_id INT;
    DECLARE var_invoice_id INT;
    DECLARE result TEXT;
    DECLARE var_quantity INT;
    DECLARE var_id INT;
    
    # sets instanced variables
    SET var_item_id = p_item_id;
    SET var_quantity = p_quantity;
    SET var_invoice_id = p_invoice_id;
    SET var_id = p_id;
    
    # checks if item and client exists, if so adds a new invoice detail respectively
    IF (var_item_id = (SELECT items.id FROM items WHERE items.id = var_item_id)  -- checks if item exists
	AND var_invoice_id = (SELECT invoice.id FROM invoice WHERE invoice.id = var_invoice_id)  -- checks if invoice  exists
    AND var_id = (SELECT invoice_details.id FROM invoice_details WHERE invoice_details.id = var_id) -- checks if invoice detail id exists
    AND var_quantity < (SELECT items.quantity FROM items WHERE items.id = var_item_id)) THEN -- checks if there are enough items(quantity) in stock
		SET result = CONCAT('invoice details id ', var_id, ' has been successfully updated!');
		UPDATE invoice_details SET item_id = var_item_id, item_quantity = var_quantity WHERE id = var_id;
	ELSE
		SET result = 'OOPS! something went wrong, please try again';
	END IF;
    
    # displays whether an invoice detail was added or error was encountered
    SELECT result AS 'Invoice detail result';
	
END |
DELIMITER ;
CALL update_invoice_details(1, 3, 2, 30,@tmp);



# deletes invoice details
DROP PROCEDURE IF EXISTS deallocate_invoice_details_id;
DELIMITER |
CREATE PROCEDURE deallocate_invoice_details_id(IN p_id INT)
BEGIN

	DECLARE var_id INT;
    DECLARE result TEXT;
    
    SET var_id = p_id;
    
    IF (var_id = (SELECT id FROM invoice_details WHERE id = var_id)) THEN
		DELETE FROM invoice_details WHERE id  = var_id;
        SET result  = CONCAT('id number ', var_id, ' has been sucessfully deleted!');
	ELSE
		SET result  = 'id number does not exists';
	END IF;
    
    SELECT result AS 'Deallocate results';
END |
DELIMITER ;
CALL deallocate_invoice_details_id(11);



-- -------------------------------------------------------------------------------------------------------------------------------------------------------------



																# ITEMS 
                                                                
                                                                
# creates a new item
DROP PROCEDURE IF EXISTS add_item;
DELIMITER |
CREATE PROCEDURE add_item(IN p_name VARCHAR(150), IN p_price DOUBLE, IN p_quantity INT, IN p_comment TEXT)
BEGIN

	# declaring instance variables
    DECLARE var_name VARCHAR(50);
	DECLARE var_price DOUBLE;
	DECLARE var_quantity INT;
	DECLARE var_comment TEXT;
    DECLARE result TEXT;
    
    SET var_name = p_name;
    SET var_price = p_price;
    SET var_quantity = p_quantity;
    SET var_comment = p_comment;
    
    
	INSERT INTO items (name, price, quantity, comment, status) VALUES (var_name, var_price, var_quantity, var_comment, 1);
	SET result = CONCAT(var_name,' was successfully added!');
    
	SELECT result AS 'Items result';

END |
DELIMITER ;
CALL add_item('Nike shoes', 89.99, 14, 'sports edition');



# updates an item
DROP PROCEDURE IF EXISTS update_item;
DELIMITER |
CREATE PROCEDURE update_item(IN p_id INT,IN p_name VARCHAR(150), IN p_price DOUBLE, IN p_quantity INT, IN p_comment TEXT, IN p_status TINYINT(1))
BEGIN
	
    # declaring instance variables
    DECLARE var_id INT;
    DECLARE var_name VARCHAR(50);
	DECLARE var_price DOUBLE;
	DECLARE var_quantity INT;
	DECLARE var_comment TEXT;
    DECLARE var_status TINYINT(1) DEFAULT 1;
    DECLARE result TEXT;
    
    # assign instanced variables 
    SET var_id = p_id;
    SET var_name = p_name;
    SET var_price = p_price;
    SET var_quantity = p_quantity;
    SET var_comment = p_comment;
    SET var_status = p_status;
    
    # checks if item exists in the items table
    IF (var_id = (SELECT id FROM items WHERE id = var_id)) THEN
		UPDATE items SET name = var_name, price = var_price, quantity = var_quantity, comment = var_comment, status = var_status WHERE id LIKE var_id;
		SET result = CONCAT('ID number ', var_id, ' has been successfully updated!');
    ELSE
		SET result = 'The id you provided does not exists.';
	END IF;
    
    # displays the results
    SELECT result AS 'Update item result';
    
END |
DELIMITER ;
CALL update_item(3 ,'tenis rackets', 58.99, 5, 'Durable/limited quantity', 1);



# searches an item
DROP PROCEDURE IF EXISTS search_item;
DELIMITER |
CREATE PROCEDURE search_item(IN p_id INT)
BEGIN
	# declare instanced variables
    DECLARE var_id INT;
    
    # assigning instance user input to variable
    SET var_id = p_id;
    
    # finds matching id
    IF ((SELECT status FROM items WHERE id = var_id)) THEN
		SELECT *
		FROM items 
		WHERE id = var_id;
	ELSE
		SELECT 'Items were not found or are not available';
	END IF;
    
END |
DELIMITER ;
CALL search_item(5); 
CALL search_item(2); -- else triggered



# searches for all the items
DROP PROCEDURE IF EXISTS search_all_items;
DELIMITER |
CREATE PROCEDURE search_all_items()
BEGIN
    
    # finds matching id
    SELECT *
    FROM items 
	ORDER BY items.name;
    
END |
DELIMITER ;
CALL search_all_items();



# deletes item from the items table
DROP PROCEDURE IF EXISTS deallocate_item;
DELIMITER |
CREATE PROCEDURE deallocate_item(IN p_id INT)
BEGIN

	DECLARE var_id INT;
    DECLARE result TEXT;
    DECLARE var_name TEXT;
    
    SET var_id = p_id;
    SET var_name = (SELECT name  FROM items WHERE id = var_id);
    
    IF (var_id = (SELECT id FROM items WHERE id = var_id)) THEN
		DELETE FROM items WHERE id = var_id;
        SET result = CONCAT('ID number ', var_id, ' named ', var_name , ' has been sucessfully deleted.');
	ELSE 
		SET result = 'no matches were found.';
	END IF;
    
    SELECT result AS 'Delete row results';

END |
DELIMITER ;
CALL deallocate_item(1);




# soft deletes item
DROP PROCEDURE IF EXISTS soft_delete_item;
DELIMITER |
CREATE PROCEDURE soft_delete_item(IN p_id INT)
BEGIN

	DECLARE result TEXT;
    
    IF (p_id = (SELECT id FROM items WHERE id = p_id)) THEN
		UPDATE items SET status = 0 WHERE id = p_id;
		SET result = CONCAT('Item ID number ', p_id, ' is no longer available for purchase.');
	ELSE
		SET result = 'No matches found.';
    END IF;
    
    SELECT result AS 'Item delete result';

END |
DELIMITER ;
CALL soft_delete_item(3);



-- -------------------------------------------------------------------------------------------------------------------------------------------------------------


                                        
														-- FIND INVOICES
                                                        

--  find invoice by id number
DROP PROCEDURE IF EXISTS find_invoice_by_number;
DELIMITER |
CREATE PROCEDURE find_invoice_by_number(p_id INT(11))
BEGIN

	# declare instance variables
	DECLARE var_id INT;
    DECLARE result TEXT;
    
    # store user id into variable
    SET var_id = p_id;
    
	# displays invoice and invoice details based on invoice ID
    IF(var_id = (SELECT id FROM invoice WHERE id = var_id)) THEN
		SELECT i.id, i.client_id, i.delivery_date, i.payment_method, i.status AS invoice_status, d.id AS details_id, d.item_id, d.invoice_id, d.item_quantity
		FROM invoice i
		JOIN invoice_details d
			ON i.id = d.invoice_id
		WHERE i.id = var_id;
	ELSE
		SET result = 'no matches found, please try again';
		SELECT result;
    END IF;
    
END |
DELIMITER ;
CALL find_invoice_by_number(6);



# find invoice by date
DROP PROCEDURE IF EXISTS find_invoice_by_date;
DELIMITER |
CREATE PROCEDURE find_invoice_by_date(IN p_date DATE)
BEGIN
	
    # declare date variable
	DECLARE var_date DATE;
    
    # store users date into variable
    SET var_date  = p_date;
    
    # searches information based on date given
    SELECT i.id, i.client_id, i.delivery_date, i.payment_method, i.status AS invoice_status, d.id AS details_id, d.item_id, d.invoice_id, d.item_quantity
		FROM invoice i
		JOIN invoice_details d
			ON i.id = d.invoice_id
		WHERE DATE(i.created_date) = var_date;
    
END |
DELIMITER ;
CALL find_invoice_by_date('2019-09-02');



# find invoice by client
DROP PROCEDURE IF EXISTS find_invoice_client;
DELIMITER |
CREATE PROCEDURE find_invoice_client(IN p_client INT)
BEGIN
	
    # declare variable
	DECLARE var_client_id INT;
    
    # store  client id into instanced variable
    SET var_client_id = p_client;
    
    # displays invoice and invoice detail information based on client id given
    SELECT i.id, i.client_id, i.delivery_date, i.payment_method, i.status AS invoice_status, d.id AS details_id, d.item_id, d.invoice_id, d.item_quantity
		FROM invoice i
		JOIN invoice_details d
			ON i.id = d.invoice_id
		WHERE var_client_id = i.client_id;
	
END |
DELIMITER ;
CALL find_invoice_client(2);


# show detailed invoice
DROP PROCEDURE IF EXISTS show_detailed_invoice;
DELIMITER |
CREATE PROCEDURE show_detailed_invoice()
BEGIN
		
		# displays invoice and invoice details
		SELECT i.id, i.client_id, i.delivery_date, i.payment_method, i.status AS invoice_status, d.id AS details_id, d.item_id, d.invoice_id, d.item_quantity
		FROM invoice i
		JOIN invoice_details d
			ON i.id = d.invoice_id;
	
END |
DELIMITER ;
CALL show_detailed_invoice();




-- -------------------------------------------------------------------------------------------------------------------------------------------------------------


																# HOME PAGE
                                                                
                                                                
                                                                
# gets total sales(sum of all the invoice totals)
DROP PROCEDURE IF EXISTS total_sales;
DELIMITER |
CREATE PROCEDURE total_sales()
BEGIN

	# displays the total sales
	SELECT invoice.id, invoice.item_id, invoice.invoice_id, invoice.item_quantity, item.name, item.price, SUM(item.price), ROUND(item.price * invoice.item_quantity, 2) AS 'total sales'
	FROM invoice_details invoice
    LEFT JOIN items item
		ON invoice.item_id = item.id
	GROUP BY item.id
    WITH ROLLUP;
	
END |
DELIMITER ;
CALL total_sales();



# show total items
DROP PROCEDURE IF EXISTS total_items;
DELIMITER |
CREATE PROCEDURE total_items()
BEGIN
	
	IF (1 IN (SELECT status FROM items)) THEN
		SELECT id, name, price, quantity, status
		FROM items
        WHERE status = 1
        ORDER BY id;
	ELSE
		SELECT id, name, price, quantity, status, 'No available items found.'
		FROM items
        WHERE status = 0
        ORDER BY id;
	END IF;

END|
DELIMITER ;
CALL total_items();



# displays total invoices
DROP PROCEDURE IF EXISTS total_invoice;
DELIMITER |
CREATE PROCEDURE total_invoice()
BEGIN

	IF(1 IN (SELECT status FROM invoice)) THEN
		SELECT *, COUNT(*) AS 'Total invoices'
		FROM invoice
		WHERE status = 1
        GROUP BY id
		ORDER BY id;
	ELSE
		SELECT 'No available matches found';
	END IF;
        
END |
DELIMITER ;
CALL total_invoice();



# display total clients
DROP PROCEDURE IF EXISTS total_clients;
DELIMITER |
CREATE PROCEDURE total_clients()
BEGIN

	IF (1 IN (SELECT status FROM clients)) THEN
		SELECT *, COUNT(*) AS 'Total clients'
		FROM clients
		WHERE status = 1
        GROUP BY id
        WITH ROLLUP;
	ELSE
		SELECT 'No active clients were found';
	END IF;
    
END |
DELIMITER ;
CALL total_clients();



# displays last 5 invoices
DROP PROCEDURE IF EXISTS total_5_invoices;
DELIMITER |
CREATE PROCEDURE total_5_invoices()
BEGIN
	
    SELECT * 
    FROM invoice
    ORDER BY created_date
    LIMIT 5;

END |
DELIMITER ;
CALL total_5_invoices();


												
# display total upcoming deliveries (by date delivered)
DROP PROCEDURE IF EXISTS total_upcoming_deliveries;
DELIMITER |
CREATE PROCEDURE total_upcoming_deliveries()
BEGIN

	SELECT * 
    FROM invoice
    ORDER BY delivery_date DESC;

END |
DELIMITER ;
CALL total_upcoming_deliveries();



-- --------------------------------------------------------------------------------------------------------------------------------------------------------------

															-- LAST MINUTE FIXES
                                                                
                                                                
# user login attemtp fixed
DROP PROCEDURE IF EXISTS login_user2;
DELIMITER |
CREATE PROCEDURE login_user2(IN p_username VARCHAR(50), IN p_password VARCHAR(50))
BEGIN

	DECLARE var_name VARCHAR(50);
    DECLARE var_password VARCHAR(50);
    DECLARE counter INT;
    DECLARE result TEXT;
    
    SET var_name = p_username;
    SET var_password = p_password;
    SET counter  = 0;
    
    IF(counter > 3) THEN -- this code never gets considered?
			SET result = 'You gave exceeded the amount of login attemtps and can no longer gain acess.'; 
	END IF;
    
    IF (counter < 3) THEN
		IF (var_name IN (SELECT username FROM users) AND var_password IN (SELECT password FROM users) AND (SELECT status FROM users WHERE username LIKE var_name) = 1) THEN
			SET result = CONCAT('Welcome ',var_name,'.');
            SET counter = 0;
		ELSE
			SET result = 'Invalid entry. Please try again.';
			SET counter = counter + 1;
		END IF;
	END IF;

    SELECT result;

END |
DELIMITER ;
CALL login_user2('George', 1234);


												