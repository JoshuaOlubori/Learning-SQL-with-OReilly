-- Table creation 
-- Lets imagine how we might store information about a person

CREATE TABLE person (
    person_id SMALLINT UNSIGNED,
    fname VARCHAR(20),
    lname VARCHAR(20),
    eye_color ENUM('BR', 'BL', 'GR'),
    birth_date DATE,
    street VARCHAR(30),
    city VARCHAR(20),
    state VARCHAR(20),
    country VARCHAR(20),
    postal_code VARCHAR(20),
    CONSTRAINT pk_person PRIMARY KEY (person_id)
);

CREATE TABLE favorite_food (
    person_id SMALLINT UNSIGNED,
    food VARCHAR(20),
    CONSTRAINT pk_favourite_food PRIMARY KEY (person_id , food),
    CONSTRAINT fk_fav_food_person FOREIGN KEY (person_id)
        REFERENCES person (person_id)
);

-- Since a person can have more than one favorite food (which is the reason this
-- table was created in the first place), it takes more than just the person_id column
-- to guarantee uniqueness in the table. This table, therefore, has a two-column pri‐
-- mary key: person_id and food

-- The favorite_food table contains another type of constraint which is called a
-- foreign key constraint. This constrains the values of the person_id column in the
-- favorite_food table to include only values found in the person table. With this
-- constraint in place, I will not be able to add a row to the favorite_food table
-- indicating that person_id 27 likes pizza if there isn’t already a row in the person
-- table having a person_id of 27


-- STEP 4: INSERTING DATA
-- INSERT table takes 3 parameters: name of table, name of columns, and values to be inserted.
-- It's not compulsory to provide a data for every column in an INSERT statement unless you have explicitly
-- put a NOT NULL constraint on that column. You can later update such empty columsn with an UPDATE statement

-- STEP 4: ALTER STATEMENT
-- We can change properties of the tables with an ALTER statement
-- For example, I should have set AUTO_INCREMENT on person_id during table creation, but I can 
-- still do that with:

set foreign_key_checks = 0;
ALTER TABLE person
MODIFY person_id SMALLINT UNSIGNED AUTO_INCREMENT;
set foreign_key_checks = 1;

INSERT INTO person
(person_id, fname, lname, eye_color, birth_date)
VALUES (null, 'Edun', 'Joshua', 'BL', '2000-1-15');

-- Lets check this data
SELECT * FROM person;

-- Choose specific columns
SELECT 
    person_id, fname, lname, eye_color, birth_date
FROM
    person;

-- Use a WHERE clause to narrow down searches
SELECT person_id, fname, lname, eye_color, birth_date 
FROM  person WHERE person_id = 1;

-- inserting values for Edun Joshua
insert into favorite_food
(person_id, food)
values(1, 'potatoes');

-- updating values
UPDATE person 
SET 
    street = 'Olorunda CDA',
    city = 'Abeokuta',
    country = 'USA',
    postal_code = '02138'
WHERE
    person_id = 1;
DELETE FROM person 
WHERE
    person_id = 1;

-- MYSQL accepts date in the format YYYY-MM-DD by default
-- You can specify you own format
UPDATE person 
SET 
    birth_date = STR_TO_DATE('DEC-21-1980', '%b-%d-%Y')
WHERE
    person_id = 1;

-- where %b = short month name; %d = numeric day; %Y = four numeric year; 

drop table favorite_food;
drop table person;