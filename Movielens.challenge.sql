use movielens;

-- Q1 List the titles and release dates of movies released between 1983-1993 in reverse chronological order
SELECT title, release_date
	FROM movies
	WHERE release_date BETWEEN '1983-01-01' AND '1993-12-31'
    ORDER BY release_date DESC;

-- Q2 Without using LIMIT, list the titles of the movies with the lowest average rating.

SELECT movies.title, AVG(ratings.rating)
FROM movies
JOIN raitings ON movies.id=raitings.movie_id
GROUP BY ratings.movie_id
ORDER BY AVG(ratings.rating) ASC ;

-- Q3 List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.
SELECT * FROM movies
JOIN genres_movies ON movies.id = genres_movies.movie_id
JOIN genres ON genres_movies.genre_id = genres.id
JOIN ratings ON movies.id = ratings.movie_id
JOIN users ON ratings.user_id = users.id
JOIN occupations ON users.occupation_id = occupations.id
WHERE occupations.`name` = "student" AND genres.`name` = 'Sci-Fi';

-- Q4 List the unique titles of each of the movies released on the most popular release day.

SELECT title 
FROM movies 
WHERE release_date - (
SELECT release_date
FROM movies
GROUP BY release_date
ORDER BY COUNT(release_date) DESC
LIMIT 1
);

-- Q5 Find the total number of movies in each genre; list the results in ascending numeric order.
SELECT genres.`name`, COUNT(movies.id)
FROM movies
JOIN genres_movies ON movies.id=genres_movies.movie_id
JOIN genres ON genres_movies.genre_id=genres.id
GROUP BY genres.`name`
ORDER BY COUNT(movies.title) ASC;
