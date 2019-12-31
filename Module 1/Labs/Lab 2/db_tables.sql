# creates a database 
CREATE database lab2c;

# Selecting database to use
USE lab2c;

#creates a the first table
CREATE TABLE school
(
id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
name VARCHAR(50),
location VARCHAR(100) NOT NULL,
office_number VARCHAR(50),
other_number VARCHAR(50),
janitors INT(100),
tables INT(100),
chairs INT(100),
teachers INT(100),
comments text,
PRIMARY KEY (id)
)

ENGINE=INNODB;


#creates a the second table
CREATE TABLE dental_clinic
(
id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
name VARCHAR(50),
location VARCHAR(100) NOT NULL,
office_number VARCHAR(50),
other_number VARCHAR(50),
staff INT(100),
dentists INT(100),
rooms INT(100),
scalers INT(100),
crown_pullers INT(100),
forceps INT(100),
comments text,
PRIMARY KEY (id)
)


