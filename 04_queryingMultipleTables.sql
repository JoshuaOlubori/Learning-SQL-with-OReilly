-- CHAPTER 5: QUERING MULTIPLE TABLES
-- Joining Three or More Tables
-- Task: Retrieve customer's first name, last name and city
-- Logic: 
select * from customer; -- contains first name and last name but no city info. It has address id however
select * from address; --  contains city id
select * from city; -- has city id as the pk

-- so we join as follows:
SELECT 
    c.first_name, c.last_name, ct.city
FROM
    customer c
        INNER JOIN
    address a ON c.address_id = a.address_id
        INNER JOIN
    city ct ON a.city_id = ct.city_id;

-- Order in which tables are joined is not important

-- Using Subqueries as tables; same result as joing multiple tables but more readable and performant
-- Task: Get customers' names, address and city using a subquery
SELECT 
    c.first_name, c.last_name, addr.address, addr.city
FROM
    customer c
        INNER JOIN
    (SELECT 
        a.address_id, a.address, ct.city
    FROM
        address a
    INNER JOIN city ct ON a.city_id = ct.city_id) addr ON c.address_id = addr.address_id;

-- Using the same table twice
-- Task: Find all the films in which CATE MCQUEEN and CUBA BIRCH both appear simultaneously
select * from film;
select * from film_actor;
select * from actor;

SELECT 
    f.title
FROM
    film_actor fa
        INNER JOIN
    film f ON fa.film_id = f.film_id
        INNER JOIN
    actor a ON fa.actor_id = a.actor_id
WHERE
    (a.first_name = 'CATE'
        AND a.last_name = 'MCQUEEN')
        OR (a.first_name = 'CUBA'
        AND a.last_name = 'BIRCH');
        
-- Task: Retrieve only those films in which both of these
-- actors appeared.
SELECT 
    f.title -- get the film's title
FROM
    film f -- from the film table
        INNER JOIN
    film_actor fa1 ON f.film_id = fa1.film_id -- joined with the film actor table through film id
        INNER JOIN
    actor a1 ON fa1.actor_id = a1.actor_id -- joined with actor table on actor_id 
        INNER JOIN
    film_actor fa2 ON f.film_id = fa2.film_id 
        INNER JOIN
    actor a2 ON fa2.actor_id = a2.actor_id
WHERE
    (a1.first_name = 'CATE'
        AND a1.last_name = 'MCQUEEN')
        AND (a2.first_name = 'CUBA'
        AND a2.last_name = 'BIRCH');
        
-- EXERCISE 5-1
 SELECT c.first_name, c.last_name, a.address, ct.city
 FROM customer c
 INNER JOIN address a
ON c.address_id = a.address_id
  INNER JOIN city ct
  ON a.city_id = ct.city_id
WHERE a.district = 'California';

-- EXERCISE 5-2
-- Write a query that returns the title of every film in which an actor with the first name
-- JOHN appeared.
select f.title
from film f inner join film_actor fa
on f.film_id = fa.film_id
inner join actor a
on fa.actor_id = a.actor_id
where a.first_name = 'JOHN';

-- EXERCISE 5-3
-- Construct a query that returns all addresses that are in the same city. You will need to
-- join the address table to itself, and each row should include two different addresses.

SELECT a1.address addr1, a2.address addr2, a1.city_id
 FROM address a1
  INNER JOIN address a2
  WHERE a1.city_id = a2.city_id
  AND a1.address_id <> a2.address_id;




