SELECT * FROM actor;

SELECT CONCAT(first_name, ' ', last_name) AS 'Actor Name' FROM actor;

SELECT actor_id, first_name, last_name
	FROM actor
    WHERE first_name = 'JOE';
    
SELECT actor_id, first_name, last_name
	FROM actor
    WHERE last_name LIKE '%GEN%';
    
SELECT last_name, first_name
	FROM actor
    WHERE last_name LIKE '%LI%';
    
SELECT country_id, country
	FROM country
    WHERE country_id IN (1,12,23);

ALTER TABLE actor
ADD COLUMN middle_name VARCHAR(50) NOT NULL AFTER first_name;


ALTER TABLE actor change middle_name middle_name blob;

ALTER TABLE actor
DROP COLUMN middle_name;

SELECT last_name, COUNT(*)
	FROM actor
    GROUP BY last_name;

SELECT first_name
	FROM actor
    WHERE first_name = 'HARPO';
    
CREATE DATABASE HW;

USE HW;

CREATE TABLE address(
	address_id int(100) auto_increment,
    address varchar(225),
    address2 varchar(225) default null,
    district varchar(225),
    city_id int(100),
    postal_code int(100),
    phone int(100),
    location BLOB,
    PRIMARY KEY(address_id)
);


SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address
ON (staff.address_id = address.address_id);

SELECT staff.staff_id, staff.first_name, staff.last_name, SUM(amount) AS Total_rung_up
FROM staff
JOIN payment
ON (staff.staff_id = payment.staff_id)
WHERE payment_date >= '2005-08-01 00:00:00' AND payment_date < '2005-09-01 00:00:00'
GROUP BY staff.staff_id;

SELECT film_actor.film_id, film.title, COUNT(actor_id) AS Number_of_Actors
FROM film_actor
INNER JOIN film
ON (film_actor.film_id = film.film_id)
GROUP BY film_actor.film_id;


SELECT title,(
	SELECT COUNT(*) FROM inventory WHERE film.film_id = inventory.film_id
    ) AS 'Number of Copies'
FROM film
WHERE title = 'HUNCHBACK IMPOSSIBLE';

SELECT payment.customer_id, customer.first_name, customer.last_name, SUM(amount) AS 'Total Paid'
FROM payment
JOIN customer
ON (payment.customer_id = customer.customer_id)
GROUP BY payment.customer_id
ORDER BY customer.last_name;

SELECT title
FROM film
WHERE title LIKE 'K%' OR title LIKE 'Q%';

SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
  SELECT actor_id
  FROM film_actor
  WHERE film_id IN
  (
   SELECT film_id
   FROM film
   WHERE title = 'Alone Trip'
  )
);

SELECT customer.customer_id, customer.first_name, customer.last_name, customer.email, customer.address_id
FROM customer
JOIN address
ON (customer.address_id = address.address_id)
JOIN city
ON (city.city_id = address.city_id)
WHERE country_id = '20';

SELECT film_id, title
FROM film
WHERE film_id IN
(
	SELECT film_id
    FROM film_category
    WHERE category_id IN
    (
		SELECT category_id
        FROM category
        WHERE category_id = '8'
	)
);

SELECT inventory.inventory_id, inventory.film_id, film.title, COUNT(inventory_id) AS Rental_Frequency
FROM inventory
JOIN film
ON (inventory.film_id = film.film_id)
GROUP BY inventory.film_id
ORDER BY Rental_Frequency DESC;

SELECT payment.staff_id, staff.store_id, SUM(amount) AS TOTAL_$
FROM payment
JOIN staff
ON (payment.staff_id = staff.staff_id)
GROUP BY staff_id;


SELECT store.store_id, store.address_id, address.city_id, city.country_id, city.city, country.country
FROM store
JOIN address
ON (store.address_id = address.address_id)
JOIN city
ON (address.city_id = city.city_id)
JOIN country
ON (country.country_id = city.country_id)
GROUP BY store_id;

SELECT payment.rental_id, category.name AS GENRE, SUM(amount) AS GROSS_REV_$
FROM payment
JOIN rental
ON (payment.rental_id = rental.rental_id)
JOIN inventory
ON (rental.inventory_id = inventory.inventory_id)
JOIN film_category 
ON (inventory.film_id = film_category.film_id)
JOIN category
ON (film_category.category_id = category.category_id)
GROUP BY name
ORDER BY GROSS_REV_$ DESC LIMIT 5;

CREATE VIEW GROSS_REVENUE AS
SELECT payment.rental_id, category.name AS GENRE, SUM(amount) AS GROSS_REV_$
FROM payment
JOIN rental
ON (payment.rental_id = rental.rental_id)
JOIN inventory
ON (rental.inventory_id = inventory.inventory_id)
JOIN film_category 
ON (inventory.film_id = film_category.film_id)
JOIN category
ON (film_category.category_id = category.category_id)
GROUP BY name
ORDER BY GROSS_REV_$ DESC LIMIT 5;

SELECT * FROM GROSS_REVENUE;

DROP VIEW GROSS_REVENUE;


