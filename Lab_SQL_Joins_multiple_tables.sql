-- Lab | SQL Joins on multiple tables

USE sakila;

-- 1. Write a query to display for each store its store ID, city, and country.
SELECT st.store_id, ci.city, co.country
FROM store st 
JOIN address ad
ON st.address_id = ad.address_id
JOIN city ci 
ON ci.city_id = ad.city_id
JOIN country co
ON ci.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT * FROM payment;
SELECT * FROM rental;
SELECT * FROM inventory; 
SELECT * FROM store; -- retrieve the shortest pathway btw the two tables by using the EER diagram

SELECT st.store_id, sum(p.amount)
FROM payment p
JOIN rental r
ON p.rental_id = r.rental_id
JOIN inventory i 
ON r.inventory_id = i.inventory_id
JOIN store st 
ON i.store_id = st.store_id
GROUP BY st.store_id;

-- 3. What is the average running time of films by category?
SELECT avg(f.length) as average_length, cat.name
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category cat
ON fc.category_id = cat.category_id
GROUP BY cat.name;

-- 4. Which film categories are longest?
SELECT avg(f.length) as average_length, cat.name
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category cat
ON fc.category_id = cat.category_id
GROUP BY cat.name
ORDER BY average_length DESC;

-- 5. Display the most frequently rented movies in descending order.
SELECT * FROM rental;
SELECT f.title, count(r.rental_id) as rental_count
FROM rental r
JOIN inventory i
ON r.rental_id = i.inventory_id
JOIN film f
ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY count(rental_id) DESC;

-- 6. List the top five genres in gross revenue in descending order.
SELECT * FROM payment;
SELECT * FROM rental;
SELECT * FROM inventory;
SELECT * FROM film;
SELECT * FROM film_category;
SELECT * FROM category;

SELECT sum(pay.amount), cat.name
FROM payment pay
JOIN rental r ON pay.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
GROUP BY cat.name
ORDER BY sum(pay.amount) DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title, sto.store_id FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store sto ON i.store_id = sto.store_id
WHERE f.title like 'ACADEMY%'
GROUP BY sto.store_id;