# Dataset

This project uses the MovieLens dataset.

The dataset contains two main files:

## ratings.csv

Contains movie-rating interactions with the following fields:

- userId
- movieId
- rating
- review_time

## movies.csv

Contains movie information with the following fields:

- movieId
- title
- genres

The `movieId` field is used to join the ratings data with the movie information.

## Dataset Storage

The dataset is uploaded to Hadoop HDFS using:

```text
/user/hadoop/movielens/ratings
/user/hadoop/movielens/movies
