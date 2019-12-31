# creates a database 
CREATE database lab2c;

# Selecting database to use
USE lab2c;

#creates a the first table
CREATE TABLE school
(
id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT, # assigned a primary key in order to keep ids unique and not repeatable
name VARCHAR(50), # varchar was chosen for name because I specifically required text
location VARCHAR(100) NOT NULL, # varchar was chosen for name because I specifically required text
office_number VARCHAR(50), # varchar was chosen for name because I specifically required text
other_number VARCHAR(50), # varchar was chosen for name because I specifically required text
janitors INT(100), # int was used in order to obtain a whole number
tables INT(100), # int was used in order to obtain a whole number
chairs INT(100), # int was used in order to obtain a whole number
teachers INT(100), # int was used in order to obtain a whole number
comments text, # I used text in order to obtain more text than varchar
PRIMARY KEY (id)  # assigned a primary key in order to keep ids unique and not repeatable
)

ENGINE=INNODB; # used to switch structure to a primary/foreign key relationship


#creates a the second table
CREATE TABLE dental_clinic
(
id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT, # assigned a primary key in order to keep ids unique and not repeatable
name VARCHAR(50),  # varchar was chosen for name because I specifically required text 
location VARCHAR(100) NOT NULL, # varchar was chosen for name because I specifically required text
office_number VARCHAR(50), # varchar was chosen for name because I specifically required text
other_number VARCHAR(50), # varchar was chosen for name because I specifically required text
staff INT(100), # int was used in order to obtain a whole number
dentists INT(100), # int was used in order to obtain a whole number
rooms INT(100), # int was used in order to obtain a whole number
scalers INT(100), # int was used in order to obtain a whole number
crown_pullers INT(100), # int was used in order to obtain a whole number
forceps INT(100), # int was used in order to obtain a whole number
comments text, # I used text in order to obtain a more text than varchar
PRIMARY KEY (id)  # assigned a primary key in order to keep ids unique and not repeatable
);


#inserting data in table 1 (school)
INSERT INTO school VALUES 
(NULL,'MTL high school1', 'Montreal 233 fake street', '514-666-6666', '450-555-5555', '3','250','350','28','schools closed this upcoming week'),
(NULL,'MTL high school2', 'Vimont 999 db street', '514-666-6666', '450-555-5555', '100','500','1000','45','need more janitors'),
(NULL,'MTL high school3', 'Ile-Perot', '514-666-6666', '450-555-5555', '0','50','110','2','close this shit down'),
(NULL,'MTL high school4', 'laval 5550 boulevard', '514-666-6666', '450-555-5555', '8','250','150','15','need more chairs'),
(NULL,'MTL high school5', 'Montreal', '514-666-6666', '450-555-5555', '2','250','350','28', NULL),
(NULL,'MTL high school6', 'St-Leonard 222 dk street', '514-666-6666', '450-555-5555', '1','250','350','11','school closed'),
(NULL,'MTL high school7', 'St-Leonard 333 dk street', '514-666-6666', '450-555-5555', '3','250','350','28', NULL),
(NULL,'MTL high school8', 'St-Leonard 444 dk street', '514-666-6666', '450-555-5555', '3','250','350','28', NULL),
(NULL,'MTL high school9', 'St-Leonard 555 dk street', '514-666-6666', '450-555-5555', '3','250','350','28', NULL),
(NULL,'MTL high school10', 'St-Leonard 666 dk street', '514-666-6666', '450-555-5555', '2','250','350','22','teacher parent night June 03, 2019'),
(NULL,'MTL high school11', 'St-Leonard 777 dk street', '514-666-6666', '450-555-5555', '3','250','350','28', NULL),
(NULL,'MTL high school10', 'St-Leonard 888 dk street', '514-666-6666', '450-555-5555', '0','250','350','28', NULL),
(NULL,'MTL high school13', 'St-Leonard 999 dk street', '514-666-6666', '450-555-5555', '3','200','350','28', NULL),
(NULL,'MTL high school14', 'St-Leonard 1000 dk street', '514-666-6666', '450-555-5555', '2','20','50','28','who ate my lunch?'),
(NULL,'MTL high school15', 'St-Leonard 1100 dk street', '514-666-6666', '450-555-5555', '0','0','0','100','going out of buisness');


#inserting data in table 2 (dental_clinic)
INSERT INTO dental_clinic VALUES 
(NULL,'dental clinic 1', 'Montreal 111 fake street', '514-666-6666', '450-555-5555', '13','2','5','100','150', '40', 'need more scalpers'),
(NULL,'dental clinic 2', 'Montreal 222 fake street', '514-666-6666', '450-555-5555', '13','2','5','100','150', '0', 'empty on forceps'),
(NULL,'dental clinic 3', 'Montreal 333 fake street', '514-666-6666', '450-555-5555', '15','0','5','100','150', '40', 'dentist required'),
(NULL,'dental clinic 4', 'Montreal 444 fake street', '514-666-6666', '450-555-5555', '15','2','5','100','150', '100', NULL),
(NULL,'dental clinic 5', 'Montreal 555 fake street', '514-666-6666', '450-555-5555', '16','2','5','100','150', '45', NULL),
(NULL,'dental clinic 6', 'Montreal 666 fake street', '514-666-6666', '450-555-5555', '13','2','5','10','150', '400', 'not enough scalers'),
(NULL,'dental clinic 7', 'Montreal 777 fake street', '514-666-6666', '450-555-5555', '18','2','5','100','150', '40', NULL),
(NULL,'dental clinic 8', 'Montreal 888 fake street', '514-666-6666', '450-555-5555', '13','2','5','3','150', '40','not enough scalers'),
(NULL,'dental clinic 9', 'Montreal 999 fake street', '514-666-6666', '450-555-5555', '16','2','5','100','150', '40', NULL),
(NULL,'dental clinic 10', 'Montreal 1000 fake street', '514-666-6666', '450-555-5555', '13','2','5','100','150', '40', NULL),
(NULL,'dental clinic 11', 'Montreal 1100 fake street', '514-666-6666', '450-555-5555', '5','2','5','100','7', '40', 'low on staff and crown pullers'),
(NULL,'dental clinic 12', 'Montreal 1200 fake street', '514-666-6666', '450-555-5555', '13','2','5','100','150', '40', NULL),
(NULL,'dental clinic 13', 'Montreal 1300 fake street', '514-666-6666', '450-555-5555', '13','2','5','100','150', '40', NULL),
(NULL,'dental clinic 14', 'Montreal 1400 fake street', '514-666-6666', '450-555-5555', '18','2','5','100','150', '40', NULL),
(NULL,'dental clinic 15', 'Montreal 1500 fake street', '514-666-6666', '450-555-5555', '0','2','0','1','15', '0', 'going out of buisness because we torment souls');

# selects all data from selected tables
SELECT * FROM school;
SELECT * FROM dental_clinic;




