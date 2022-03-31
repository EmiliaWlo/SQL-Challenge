use sakila;

-- Q1 List all actors
SELECT first_name, last_name FROM actor;

-- Q2 Find the surname of the actor with the forename 'John'.
SELECT last_name FROM actor WHERE last_name="John";

-- Q3 Find all actors with surname 'Neeson'.
SELECT first_name, last_name FROM actor WHERE last_name="Neeson";

-- Q4 Find all actors with ID numbers divisible by 10.
SELECT first_name, last_name FROM actor WHERE actor_id % 10 = 0;

-- Q5 What is the description of the movie with an ID of 100?
SELECT description FROM film WHERE film_id=100;

-- Q6 Find every R-rated movie.
SELECT title, rating FROM film WHERE rating = "R";

-- Q7 Find every non-R-rated movie.
SELECT title, rating FROM film WHERE rating != "R";

-- Q8 Find the ten shortest movies.
SELECT title, length FROM film ORDER BY length LIMIT 10;

-- Q9 Find the movies with the longest runtime, without using LIMIT
SELECT title, length FROM film WHERE length = (SELECT MAX(length) from film);

-- Q10 Find all movies that have deleted scenes.
SELECT title, special_features FROM film WHERE special_features LIKE "%Deleted Scenes%";

-- Q11 Using HAVING, reverse-alphabetically list the last names that are not repeated.
SELECT last_name, count(last_name) c FROM actor GROUP BY last_name HAVING c = 1 ORDER BY last_name DESC ;

-- Q12 Using HAVING, list the last names that appear more than once, from highest to lowest frequency.
SELECT last_name, count(last_name) AS c 
FROM actor 
GROUP BY last_name HAVING c > 1 
ORDER BY c DESC;

-- Q13 Which actor has appeared in the most films?
SELECT a.first_name, a.last_name, count(f.actor_id) AS number_of_films 
FROM actor a
JOIN film_actor f ON a.actor_id=f.actor_id
GROUP BY a.actor_id
ORDER BY number_of_films DESC;

-- Q14 When is 'Academy Dinosaur' due?
SELECT f.title, r.return_date 
FROM rental r 
JOIN inventory i ON r.inventory_id=i.inventory_id
JOIN film f ON i.film_id=f.film_id
WHERE i.inventory_id=(
	SELECT film_id FROM film WHERE title="Academy Dinosaur"
);

-- Q15 What is the average runtime of all films?
SELECT AVG(length) AS avg_length FROM film;

-- Q16 List the average runtime for every film category.
SELECT c.name, AVG(f.length) AS avg_length
FROM film_category fc
JOIN film f ON fc.film_id=f.film_id
JOIN category c on fc.category_id=c.category_id
GROUP BY c.name;

-- Q17 List all movies featuring a robot.
SELECT title, description FROM film WHERE description LIKE "%robot%";

-- Q18 How many movies were released in 2010?
SELECT release_year, COUNT(release_year) AS number_of_films FROM film WHERE release_year=2010 GROUP BY release_year;

-- Q19 Find the titles of all the horror movies
SELECT f.title, c.name
FROM film_category fc
JOIN film f ON fc.film_id=f.film_id
JOIN category c on fc.category_id=c.category_id
WHERE c.name = "Horror";

-- Q20 List the full name of the staff member with the ID of 2
SELECT first_name, last_name FROM staff WHERE staff_id=2;

-- Q21 List all the movies that Fred Costner has appeared in
SELECT f.title, a.first_name, a.last_name
FROM film f
JOIN film_actor fa ON f.film_id=fa.film_id
JOIN actor a ON a.actor_id=fa.actor_id
WHERE fa.actor_id = (
	SELECT actor_id FROM actor WHERE first_name = "Fred" AND last_name = "Costner"
);

-- Q22 How many distinct countries are there?
SELECT DISTINCT count(country) AS number_of_countries FROM country;

-- Q23 List the name of every language in reverse-alphabetical order.
SELECT name FROM language ORDER BY name DESC;

-- Q24 List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.
SELECT first_name, last_name FROM actor WHERE last_name LIKE "%son";

-- Q25 Which category contains the most films?
SELECT c.name, COUNT(f.film_id) AS film_count
FROM film_category fc
JOIN film f ON fc.film_id=f.film_id
JOIN category c on fc.category_id=c.category_id
GROUP BY c.name
ORDER BY film_count DESC LIMIT 1;