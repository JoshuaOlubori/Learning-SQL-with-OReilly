-- CHAPTER 4: FILTERING
-- CONDITION TYPES
-- 1. EQUALITY CONDITIONS
SELECT 
    c.email
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-06-14';

SELECT 
    c.email
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) <> '2005-06-14';-- inequality!

SELECT 
    customer_id, rental_date
FROM
    rental
WHERE
    rental_date < '2005-05-25';
 
SELECT 
    customer_id, rental_date
FROM
    rental
WHERE
    rental_date BETWEEN '2005-06-14' AND '2005-06-16';
 
 -- NB! Using 'BEWTEEN', always specify the lower boundary first 
-- Also, the upper and lower boundaries are INCLUSIVE!
 
SELECT 
    customer_id, payment_date, amount
FROM
    payment
WHERE
    amount BETWEEN 10.0 AND 11.99;
 
 -- String ranges
SELECT 
    last_name, first_name
FROM
    customer
WHERE
    last_name BETWEEN 'FA' AND 'FR';
 
 -- Note that 'FRANKLIN' is not inncluded since 'fr' in franklin is out of range. Make the upper
SELECT 
    title, rating
FROM
    film
WHERE
    rating = 'G' OR rating = 'PG';
 
 -- it works but can become tedious when membership conditions increases
SELECT 
    title, rating
FROM
    film
WHERE
    rating IN ('G' , 'PG');
 
 -- using subqueries
SELECT 
    title, rating
FROM
    film
WHERE
    rating IN (SELECT 
            rating
        FROM
            film
        WHERE
            title LIKE '%PET%');

-- not in
SELECT 
    title, rating
FROM
    film
WHERE
    rating NOT IN ('PG-13' , 'R', 'NC-17');

-- 4. MATCHING CONDITIONS
-- example: I want to find all customers whose last name begins with Q
-- Naive query:
SELECT 
    last_name, first_name
FROM
    customer
WHERE
    LEFT(last_name, 1) = 'Q';-- i.e return character in the first position starting from the left

SELECT 
    last_name, first_name
FROM
    customer
WHERE
    last_name LIKE '_A_T%S';

-- This query specifies strings containing an A in
-- the second position and a T in the fourth position, followed by any number of characters and ending in S. 
SELECT 
    last_name, first_name
FROM
    customer
WHERE
    last_name LIKE 'Q%'
        OR last_name LIKE 'Y%';
 
 -- Regular expressions: search expressions on steroids
SELECT 
    last_name, first_name
FROM
    customer
WHERE
    last_name REGEXP '^[QY]';
    
-- NULL
-- Rule: An expression can be null, but it can never equal null.
-- Two nulls are never equal to each other
    
SELECT 
    rental_id, customer_id, return_date
FROM
    rental
WHERE
    return_date IS NULL;
    
    -- Don't use "= NULL"
SELECT 
    rental_id, customer_id, return_date
FROM
    rental
WHERE
    return_date = NULL;
    
    -- IS NOT NULL
SELECT 
    rental_id, customer_id, return_date
FROM
    rental
WHERE
    return_date IS NOT NULL;

-- Task: Return all rentals that were not returned during May through August of 2005

SELECT 
    rental_id, customer_id, return_date
FROM
    rental
WHERE
    return_date NOT BETWEEN '2005-05-01' AND '2005-09-01';

-- Account for the possibility that some customers' return date is null (haven't returned)
SELECT 
    rental_id, customer_id, return_date
FROM
    rental
WHERE
    return_date IS NULL
        OR return_date NOT BETWEEN '2005-05-01' AND '2005-09-01';

-- EXERCISE 4-3
-- Construct a query that retrieves all rows from the payments table where the amount
-- is either 1.98, 7.98, or 9.98.
SELECT 
    payment_id, amount
FROM
    payment
WHERE
    amount IN (1.98 , 7.98, 9.98);

-- EXERCISE 4-4
-- Construct a query that finds all customers whose last name contains an A in the sec‐
-- ond position and a W anywhere after the A
SELECT 
    last_name
FROM
    customer
WHERE
    last_name LIKE '_A%W%'