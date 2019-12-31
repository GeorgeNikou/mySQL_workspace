CREATE TABLE photos (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(50),
photo_location VARCHAR(100),
user SMALLINT UNSIGNED NOT NULL,
CONSTRAINT fk_user FOREIGN KEY (user) REFERENCES school (id)
)
ENGINE=InnoDB;

SELECT * FROM photos;