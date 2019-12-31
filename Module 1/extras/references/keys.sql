# creating the parent table with primary key
CREATE TABLE client (
client_number INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
client_name VARCHAR(50),
client_email VARCHAR(50)
)
ENGINE=InnoDB;

# inserting random information into client table
INSERT INTO client VALUES
(NULL, 'George Nikou' , 'george.nikou@gmail.com'),
(NULL, 'George Bourisquot' , 'george.bourisquot@gmail.com'),
(NULL, 'George Clooney' , 'george.clooney@gmail.com'),
(NULL, 'George Jungle' , 'george.jungle@gmail.com'),
(NULL, 'George Foreman' , 'george.foreman@gmail.com'),
(NULL, 'George Washington' , 'george.washington@gmail.com');

# creating the child table with foreign key
CREATE TABLE orders(
order_number INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
client_number INT UNSIGNED NOT NULL,
product VARCHAR(50),
quantity SMALLINT DEFAULT 1,
# the first client number references this child table while the second client number references the parent table
CONSTRAINT fk_client_num FOREIGN KEY (client_number) REFERENCES client (client_number)
)
ENGINE=InnoDB;

# inserting random information into orders table
INSERT INTO orders (client_number, product) VALUE(1, 'Oreo Cheese Cake');
INSERT INTO orders (client_number, product) VALUE(2, 'Vanilla Cake');
INSERT INTO orders (client_number, product) VALUE(3, 'Chocolate Cake');
INSERT INTO orders (client_number, product) VALUES(4 ,'Carrot Cake');
INSERT INTO orders (quantity, client_number, product) VALUES(8, 5 ,'red velvet Cake');

SELECT * FROM `client`;
SELECT * FROM orders;
