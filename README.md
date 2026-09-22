# Movie Rating Analysis using Hadoop and Hive

## 📌 Project Overview

Movie Rating Analysis is a Big Data Analytics project based on the MovieLens dataset.

The project demonstrates how Big Data technologies can be used to store, process, and analyze a large collection of movie-rating records.

The project uses:

- Apache Hadoop
- HDFS
- YARN
- Apache Hive
- MapReduce
- MovieLens Dataset

The main objective is to analyze movie ratings and identify popular movies, highly rated movies, and rating statistics based on movie genres.

---

## 🎯 Objectives

The main objectives of this project are:

1. Store a large movie-rating dataset in HDFS.
2. Create Hive tables for movie and rating data.
3. Process the data using Hadoop and YARN.
4. Analyze movie popularity based on review count.
5. Identify highly rated movies.
6. Analyze movie ratings by genre.
7. Demonstrate distributed Big Data processing using Hive.

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Apache Hadoop 3.3.6 | Big Data processing framework |
| HDFS | Distributed storage of the dataset |
| YARN | Resource and job management |
| Apache Hive 3.1.3 | SQL-like querying and analysis |
| MapReduce | Distributed processing |
| Java 8 | Runtime environment |
| MovieLens | Movie rating dataset |
| Apache Derby | Hive Metastore |

---

## 📊 Dataset

The project uses the MovieLens dataset containing movie information and a large number of user-rating interactions.

### Ratings Dataset

The ratings data contains:

- `userId`
- `movieId`
- `rating`
- `review_time`

### Movies Dataset

The movie data contains:

- `movieId`
- `title`
- `genres`

The `movieId` field is used to connect the ratings data with the movie information.

> The complete MovieLens dataset is not included in this repository because the ratings dataset is very large.

---

## 🏗️ Project Architecture

```text
              MovieLens Dataset
                     |
             +-------+-------+
             |               |
         ratings.csv      movies.csv
             |               |
             +-------+-------+
                     |
                    HDFS
                     |
              Apache Hive
                     |
              Hive Tables
             /           \
        ratings          movies
             \           /
              JOIN using
               movieId
                     |
                   YARN
                     |
              MapReduce Jobs
                     |
              Analysis Results
