-- Movie Rating Analysis
-- Hive database and table creation

CREATE DATABASE IF NOT EXISTS movie_db;

USE movie_db;

CREATE EXTERNAL TABLE IF NOT EXISTS ratings (
    userId INT,
    movieId INT,
    rating FLOAT,
    review_time BIGINT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/user/hadoop/movielens/ratings'
TBLPROPERTIES ("skip.header.line.count"="1");

CREATE EXTERNAL TABLE IF NOT EXISTS movies (
    movieId INT,
    title STRING,
    genres STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/user/hadoop/movielens/movies'
TBLPROPERTIES ("skip.header.line.count"="1");
