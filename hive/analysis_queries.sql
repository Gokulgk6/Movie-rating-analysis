-- Movie Rating Analysis
-- Analysis Queries

USE movie_db;

-- 1. Top 10 Most Popular Movies
-- Based on number of reviews

SELECT
    m.title,
    COUNT(r.rating) AS review_count
FROM ratings r
JOIN movies m
    ON r.movieId = m.movieId
GROUP BY m.title
ORDER BY review_count DESC
LIMIT 10;


-- 2. Top 10 Highest Rated Movies
-- Considering movies with at least 2,000 reviews

SELECT
    m.title,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    COUNT(r.rating) AS total_reviews
FROM ratings r
JOIN movies m
    ON r.movieId = m.movieId
GROUP BY m.title
HAVING total_reviews >= 2000
ORDER BY avg_rating DESC
LIMIT 10;


-- 3. Genre Analysis
-- Calculate rating count and average rating for each genre

SELECT
    genre,
    COUNT(r.rating) AS rating_count,
    ROUND(AVG(r.rating), 2) AS avg_genre_rating
FROM ratings r
JOIN (
    SELECT
        movieId,
        genre
    FROM movies
    LATERAL VIEW explode(split(genres, '\\|')) genre_table AS genre
) m
    ON r.movieId = m.movieId
GROUP BY genre
ORDER BY rating_count DESC;
