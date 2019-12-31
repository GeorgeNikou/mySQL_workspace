CREATE DATABASE blockbuster;

USE blockbuster;

CREATE TABLE movies(
id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(100),
duration VARCHAR(100),
copies INT(50),
genre VARCHAR(50),
director VARCHAR(50),
actors VARCHAR(200),
released DATETIME
);

INSERT INTO movies VALUES
(NULL,'Scarface','3 hours', 12, 'drama,action,mafia', 'Al Paccinno', 'Robert Deniro, Joe Pecci', '2013-09-23' );

INSERT INTO movies VALUES
(NULL,'The Lion King','2 hours', 35, 'children,educational', 'Johnny Depp', 'Jordan Peel', '2013-09-23' );

INSERT INTO movies VALUES
(NULL,'V for Vendetta','2 and a half hours', 50, 'suspense', 'Natalie Portman', 'James Mcteigue', '2013-09-23 23:11' );

SELECT * FROM movies;
SELECT * FROM movies WHERE title='Scarface';

UPDATE movies SET actors ='Natalie Portman' WHERE id=3;
UPDATE movies SET director ='James Mcteigue' WHERE id=3;
SELECT * FROM movies WHERE duration=3;

ALTER TABLE movies CHANGE copies quantity VARCHAR(30);