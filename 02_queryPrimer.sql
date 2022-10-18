-- QUERY MECHANICS
-- 1. log into the MySQL server
-- 2. Server verifies your username and password
-- 3. If (2) is successful, server generates a database connection for you
-- 4. Connection is held until the application releases it (by typing quit()) or when server closes the connection (server shut down)
-- 5. Each connection into the server is assigned an identifier
-- 6. When query is sent to server, server checks if:

SELECT 
    language_id,
    'common' language_usage,
    language_id * 3.14 lang_pi_value,
    UPPER(name) language_name
FROM
    languagelling in-built functions alone doesn't require calling tables
SELECT VERSION(), USER(), DATABASE();
 
 -- REMOVING DUPLICATES
 SELECT 
    actor_id
FROM
    film_actor
ORDER BY actor_id;-- returns multiple instances of the same actor
 SELECT DISTINCT
    actor_id
FROM
    film_actor
ORDER BY actor_id;-- returns single instances of the actors
 
 -- FROM CLAUSE
 -- ROLE: defines the tables used in a query, along with the means of linking the tables together
 
 -- TABLES
 -- • Permanent tables (i.e., created using the create table statement)
-- • Derived tables (i.e., rows returned by a subquery and held in memory)
-- • Temporary tables (i.e., volatile data held in memory)
-- • Virtual tables (i.e., created using the create view statement

-- DERIVED TABLES
select concat(cust.last_name, ', ', cust.first_name) full_name
from (
(select first_name, last_name, email from customer where first_name = 'JESSIE')) cust;

-- In this example, a subquery against the customer table returns three columns, and
-- the containing query references two of the three available columns. The subquery is
-- referenced by the containing query via its alias, which, in this case, is cust. The data
-- in cust is held in memory for the duration of the query and is then discarded.

-- TEMPORARY TABLES (volatile; disappears after transaction or database session)
create temporary table actors_j (actor_id smallint(5), first_name varchar(45), last_name varchar(45) );
insert into actors_j select actor_id, first_name, last_name from actor where last_name like 'J%';
select * from actors_j;

-- These seven rows are held in memory temporarily and will disappear after your session is closed

-- VIEW
-- A view is a QUERY stored in a data dictionary. 
-- It looks and acts like a table, but there is no data associated with a view (this is why I call it a virtual table)

create view cust_vw as select customer_id, first_name, last_name, email, active
from customer;

-- When the view is created, no additional data is generated or stored: the server simply
-- tucks away the select statement for future use. Now that the view exists, you can
-- issue queries against it, as in:

select first_name, last_name from cust_vw where active=0;

-- Views are created for various reasons, including 
-- to hide columns from users and to
-- simplify complex database designs.

-- TABLE LINKS
-- RULE: if more than one tables are declared in the from clause, the conditions used to link the tables
-- must be included as well.
SELECT 
    *
FROM
    customer;
SELECT 
    *
FROM
    rental;

SELECT 
    customer.first_name,
    customer.last_name,
    TIME(rental.rental_date) rental_time
FROM
    customer
        INNER JOIN
    rental ON customer.customer_id = rental.customer_id
WHERE
    DATE(rental.rental_date) = '2005-06-14';
    
-- SAME QUERY BUT WITH ALIASES
select c.first_name, c.last_name, time(r.rental_date) as rental_time
from customer c inner join rental r on c.customer_id = r.customer_id
where date(r.rental_date) = '2005-06-14';

-- WHERE CLAUSE
-- ROLE: The where clause is the mechanism for filtering out unwanted rows from your result set
--  perhaps you are interested in renting a film but you are only interested
-- in movies rated G that can be kept for at least a week
select title from film where rating='G' and rental_duration >= 7;

-- Note that SELECT filters columns; WHERE filters rows based on their values

-- Multiple conditions 
 SELECT title, rating, rental_duration
 FROM film
 WHERE (rating = 'G' AND rental_duration >= 7)
 OR (rating = 'PG-13' AND rental_duration < 4);
 
 -- GROUPBY AND HAVING CLAUSE
 -- say I wanna get the count of rentals for each customer; AND THEN filter out customers whose rental count is at least 40
 -- This is the domain of the groupby and having clause. GROUPBY performs aggregation first (count of rentals for each customer), while HAVING serves to
 -- FILTER ON AGGREGATED DATA. Its similar to WHERE, but WHERE works for unaggregated data; HAVING works on 'cooked' data
 
 SELECT c.first_name, c.last_name, count(*) as total_rentals_39_above
 from customer c inner join rental r on c.customer_id = r.customer_id group by c.first_name, c.last_name
 having count(*) >= 40;
 
 -- ORDERBY CLAUSE
 -- ROLE: The order by clause is the mechanism for sorting your result set using either raw column data or expressions based on column data
 -- Default is asc sorting. 
 -- use limit to return top n rows
 -- use position  to reference columns when column names are expressions
 -- Reference columns positionally when writing ad hoc queries,
-- but always reference columns by name when writing code.
 SELECT c.first_name, c.last_name,
 time(r.rental_date) rental_time
 FROM customer c
 INNER JOIN rental r
 ON c.customer_id = r.customer_id
 WHERE date(r.rental_date) = '2005-06-14'
 ORDER BY 3 desc limit 10;
 
 -- EXERCISE 3-1
 -- Retrieve the actor ID, first name, and last name for all actors. Sort by last name and
-- then by first name.
select actor_id, first_name, last_name
from actor
order by last_name, first_name;

-- EXERCISE 3-2
-- Retrieve the actor ID, first name, and last name for all actors whose last name equals
-- 'WILLIAMS' or 'DAVIS'.
select actor_id, first_name, last_name
from actor
where (last_name = 'WILLIAMS') OR (last_name= 'DAVIES');

-- EXERCISE 3-3
-- Write a query against the rental table that returns the IDs of the customers who rented a film on July 5, 2005 (use the rental.rental_date column, and you can use the
-- date() function to ignore the time component). Include a single row for each distinct
-- customer ID.
SELECT distinct customer_id
from rental
where date(rental_date) = '2005-7-5';

-- EXERCISE 3-4
-- Fill in the blanks (denoted by <#>) for this multitable query to achieve the following
-- results:
 SELECT 
    c.email, r.return_date
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-06-14'
ORDER BY r.return_date DESC , c.email;


