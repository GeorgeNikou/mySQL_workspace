# creates a table
CREATE TABLE test_table (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL
);

# adding an index to an existing table
ALTER TABLE test_table ADD INDEX ind_name(name);

# drops indexes
ALTER TABLE test_table DROP INDEX ind_name;

# second way of creating an index
CREATE INDEX ind_name ON test_table(name);

# creating an index without giving it a name
ALTER TABLE test_table ADD INDEX(name);

# show index within a table
SHOW INDEX FROM test_table;
SHOW INDEX FROM school;
SHOW INDEX FROM dental_clinic;


# add indexes for the school table
ALTER TABLE school ADD INDEX ind_name(name);
ALTER TABLE school ADD INDEX ind_location(location);
ALTER TABLE school ADD INDEX ind_office_number(office_number);
ALTER TABLE school ADD INDEX ind_teachers(teachers);


# add indexes for the dental clinic table
ALTER TABLE dental_clinic ADD INDEX ind_name(name);
ALTER TABLE dental_clinic ADD INDEX ind_location(location);
ALTER TABLE dental_clinic ADD INDEX ind_office_number(office_number);
ALTER TABLE dental_clinic ADD INDEX ind_staff(staff);
ALTER TABLE dental_clinic ADD INDEX ind_dentists(dentists);

# shows all current indexes within a table
SHOW INDEX FROM books;

# search for author named 'Brown'
SELECT * FROM books WHERE MATCH author AGAINST ('Brown');

# search for a title with the name 'Harry'
SELECT * FROM books WHERE MATCH title AGAINST ('Harry');

# search for titles and authors with the name 'Jules Verne'
SELECT * FROM books WHERE MATCH  author,title AGAINST ('Jules');

# search for titles and authors with the name 'Jules Verne'
SELECT * FROM books WHERE MATCH title, author AGAINST ('Jules Verne');

# checking the weight of relevance one way
SELECT *, MATCH title, author AGAINST ('Brown') FROM books;

# checking the weight of relevance second way
SELECT *, MATCH (author,title) AGAINST ('Brown') AS WEIGHT FROM books;

# search all titles with the name 'potter' and subtract all titles with the name 'prince'
SELECT * FROM books WHERE MATCH title AGAINST ('+potter -prince' IN BOOLEAN MODE);

SELECT * FROM books WHERE MATCH title AGAINST ('potter and the code' IN BOOLEAN MODE);

# using a wildcard to find a match
SELECT * FROM books WHERE MATCH title AGAINST ('harr*' IN BOOLEAN MODE);
SELECT * FROM books WHERE MATCH title AGAINST ('jul*' IN BOOLEAN MODE);
SELECT * FROM books WHERE MATCH title AGAINST ('d*' IN BOOLEAN MODE);

# a sophisticated search that searches for the criteria including similar results
SELECT * FROM books WHERE MATCH (title, author) AGAINST ('demons' WITH QUERY EXPANSION);

CREATE FULLTEXT INDEX ind_full_title
ON books (title);

CREATE FULLTEXT INDEX ind_full_aut
ON books (author);

CREATE FULLTEXT INDEX ind_full_title_author
ON books (title, author);

SELECT * FROM books;

SELECT * FROM books;
USE block3m1;
SHOW INDEX FROM books;