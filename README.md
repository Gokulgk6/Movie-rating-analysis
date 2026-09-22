# 🎬 Movie Rating Analysis using Hadoop and Hive

## 📌 Project Overview

**Movie Rating Analysis using Hadoop and Hive** is a Big Data Processing and Distributed Analytics project based on the **MovieLens dataset**.

The project demonstrates how movie rating data can be stored in **Hadoop HDFS**, managed using **Apache Hive**, and analyzed using **HiveQL**.

The main objective of this project is to perform distributed data processing and extract useful information from movie ratings and movie metadata.

The project performs analysis such as:

- Identifying the most popular movies based on review count
- Identifying highly-rated movies with a minimum number of reviews
- Performing genre-wise rating analysis
- Calculating average ratings
- Counting movie reviews
- Exporting analytical results

The project was implemented using a **pseudo-distributed Hadoop environment** on Linux.

---

# 🎯 Project Objectives

The main objectives of this project are:

1. To understand the Hadoop ecosystem.
2. To configure a pseudo-distributed Hadoop environment.
3. To configure HDFS for distributed data storage.
4. To configure YARN for resource management and processing.
5. To install and configure Apache Hive.
6. To initialize and use the Hive Metastore.
7. To upload the MovieLens dataset into HDFS.
8. To create Hive external tables for the dataset.
9. To perform data analysis using HiveQL.
10. To identify popular movies based on review count.
11. To identify highly-rated movies with a minimum number of reviews.
12. To perform genre-wise analysis.
13. To export analytical results for further use.

---

# 🧠 Problem Statement

Movie-rating datasets can contain a large number of records.

Traditional data processing approaches can become difficult when the dataset grows in size.

This project uses the Hadoop ecosystem to provide distributed storage and processing capabilities.

The project uses the MovieLens dataset to answer questions such as:

- Which movies have received the highest number of ratings?
- Which movies have the highest average ratings?
- Which highly-rated movies have at least 2,000 reviews?
- Which genres have the highest number of ratings?
- What is the average rating for each genre?

---

# 📊 Dataset

The project uses the **MovieLens dataset**.

The main data files used in the project are:

```text
ratings.csv
movies.csv
```

The dataset contains information about movie ratings and movie metadata.

---

# 📁 Dataset Files

## 1. ratings.csv

The `ratings.csv` file contains user rating information.

| Column | Data Type | Description |
|---|---|---|
| `userId` | INT | Unique identifier of the user |
| `movieId` | INT | Unique identifier of the movie |
| `rating` | FLOAT | Rating given by the user |
| `review_time` | BIGINT | Timestamp associated with the rating |

Example:

```text
userId,movieId,rating,review_time
1,1,4.0,964982703
1,3,4.0,964981247
1,6,4.0,964982224
```

---

## 2. movies.csv

The `movies.csv` file contains movie information.

| Column | Data Type | Description |
|---|---|---|
| `movieId` | INT | Unique identifier of the movie |
| `title` | STRING | Movie title |
| `genres` | STRING | Movie genre information |

Example:

```text
movieId,title,genres
1,Toy Story (1995),Adventure|Animation|Children|Comedy|Fantasy
2,Jumanji (1995),Adventure|Children|Fantasy
3,Grumpier Old Men (1995),Comedy|Romance
```

---

# 🔗 Relationship Between Dataset Files

The `ratings` and `movies` datasets are connected using the `movieId` column.

```text
ratings.movieId
       │
       │ JOIN
       ▼
movies.movieId
```

This allows the project to combine user ratings with movie titles and genres.

---

# 🛠️ Technology Stack

| Component | Technology |
|---|---|
| Operating System | Arch Linux x86_64 |
| Java | OpenJDK 8 |
| Hadoop | 3.3.6 |
| Storage | HDFS |
| Resource Management | YARN |
| Processing | Hadoop MapReduce |
| Data Warehouse | Apache Hive 3.1.3 |
| Metastore | Apache Derby |
| Query Language | HiveQL |
| Dataset | MovieLens |

---

# 🏗️ System Architecture

The overall project architecture is:

```text
                    MovieLens Dataset
                           │
                           ▼
                  ┌─────────────────┐
                  │    CSV Files    │
                  │                 │
                  │ ratings.csv     │
                  │ movies.csv      │
                  └────────┬────────┘
                           │
                           ▼
                  ┌─────────────────┐
                  │      HDFS       │
                  │ Hadoop Storage  │
                  └────────┬────────┘
                           │
                           ▼
                  ┌─────────────────┐
                  │      Hive       │
                  │ External Tables │
                  └────────┬────────┘
                           │
                           ▼
                  ┌─────────────────┐
                  │     HiveQL      │
                  │    Analysis     │
                  └────────┬────────┘
                           │
                           ▼
                  ┌─────────────────┐
                  │ Analytical      │
                  │ Results         │
                  └─────────────────┘
```

---

# 🔄 Project Workflow

The complete project workflow is:

```text
Install Java 8
      ↓
Install Hadoop 3.3.6
      ↓
Configure Hadoop
      ↓
Configure HDFS
      ↓
Configure YARN
      ↓
Format NameNode
      ↓
Start Hadoop Services
      ↓
Create HDFS Directories
      ↓
Upload MovieLens Dataset
      ↓
Install Hive 3.1.3
      ↓
Configure Hive
      ↓
Initialize Derby Metastore
      ↓
Start Hive
      ↓
Create Hive Database
      ↓
Create External Tables
      ↓
Run HiveQL Queries
      ↓
Analyze Results
      ↓
Export Results
```

---

# 🐘 Hadoop Configuration

The project uses **Apache Hadoop 3.3.6**.

Hadoop provides the distributed storage and processing infrastructure required for the project.

The Hadoop environment includes:

- HDFS
- YARN
- MapReduce

The project uses a pseudo-distributed Hadoop configuration on a Linux machine.

Detailed setup instructions are available in:

- [Clean Installation Guide](setup/01-clean-install.md)
- [Hadoop Configuration](setup/02-hadoop-config.md)

---

# 💾 HDFS

HDFS is used to store the MovieLens dataset.

The project uses the following HDFS locations:

```text
/user/hadoop/movielens/ratings
/user/hadoop/movielens/movies
```

The ratings data and movie metadata are stored separately.

---

# 📂 HDFS Data Organization

```text
/user/hadoop/
        │
        └── movielens/
                │
                ├── ratings/
                │     └── ratings.csv
                │
                └── movies/
                      └── movies.csv
```

---

# 🔍 Verify HDFS Data

To check the ratings directory:

```bash
hdfs dfs -ls /user/hadoop/movielens/ratings
```

To check the movies directory:

```bash
hdfs dfs -ls /user/hadoop/movielens/movies
```

To view sample movie records:

```bash
hdfs dfs -cat /user/hadoop/movielens/movies/movies.csv | head
```

To view sample rating records:

```bash
hdfs dfs -cat /user/hadoop/movielens/ratings/ratings.csv | head
```

---

# 🐝 Apache Hive

Apache Hive is used as the data warehouse and analytical layer of the project.

Hive provides a SQL-like interface called **HiveQL**, which allows the MovieLens data stored in HDFS to be queried.

The project uses:

```text
Hive 3.1.3
```

The Hive database used in the project is:

```text
movie_db
```

---

# 🗄️ Hive Database

The database is created using:

```sql
CREATE DATABASE IF NOT EXISTS movie_db;
```

The database is selected using:

```sql
USE movie_db;
```

The database contains two main external tables:

```text
ratings
movies
```

---

# 📋 Ratings External Table

The `ratings` table is created using:

```sql
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
```

### Columns

```text
userId
movieId
rating
review_time
```

The table reads data from:

```text
/user/hadoop/movielens/ratings
```

---

# 🎬 Movies External Table

The `movies` table is created using:

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS movies (
    movieId INT,
    title STRING,
    genres STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/user/hadoop/movielens/movies'
TBLPROPERTIES ("skip.header.line.count"="1");
```

### Columns

```text
movieId
title
genres
```

The table reads data from:

```text
/user/hadoop/movielens/movies
```

---

# 📌 Why External Tables?

The project uses Hive **external tables** because the actual dataset is stored in HDFS.

External tables allow Hive to reference data stored in HDFS while keeping the underlying data separate from the Hive table definition.

This provides flexibility when managing the dataset.

---

# 📊 Data Analysis

The project performs three major analytical operations.

---

# 1️⃣ Top 10 Most Popular Movies

The first analysis identifies movies based on the number of ratings they have received.

### Query

```sql
SELECT m.title, COUNT(r.rating) AS review_count
FROM ratings r
JOIN movies m ON r.movieId = m.movieId
GROUP BY m.title
ORDER BY review_count DESC
LIMIT 10;
```

### Explanation

The query:

1. Reads data from the `ratings` table.
2. Joins the ratings table with the movies table.
3. Matches records using `movieId`.
4. Groups the records by movie title.
5. Counts the ratings for each movie.
6. Sorts the results by review count.
7. Returns the top 10 movies.

### Output

The output contains:

```text
Movie Title
Review Count
```

This analysis identifies movies with the highest number of ratings.

---

# 2️⃣ Top 10 Highest-Rated Movies

The second analysis identifies highly-rated movies while requiring at least **2,000 reviews**.

### Query

```sql
SELECT m.title,
       ROUND(AVG(r.rating), 2) AS avg_rating,
       COUNT(r.rating) AS total_reviews
FROM ratings r
JOIN movies m ON r.movieId = m.movieId
GROUP BY m.title
HAVING total_reviews >= 2000
ORDER BY avg_rating DESC
LIMIT 10;
```

### Explanation

The query:

1. Joins the ratings and movies tables.
2. Groups ratings by movie title.
3. Calculates the average rating.
4. Counts the total reviews.
5. Filters movies with at least 2,000 reviews.
6. Orders the results by average rating.
7. Returns the top 10 results.

### Minimum Review Requirement

The project uses:

```text
Minimum reviews = 2000
```

This prevents movies with very few ratings from being included in the high-rating analysis.

### Output

The output contains:

```text
Movie Title
Average Rating
Total Reviews
```

---

# 3️⃣ Genre-wise Analysis

The third analysis performs rating analysis based on movie genres.

A movie can belong to multiple genres.

For example:

```text
Action|Adventure|Sci-Fi
```

The project uses Hive's `SPLIT`, `EXPLODE`, and `LATERAL VIEW` functionality to process these values.

### Query

```sql
SELECT
    genre,
    COUNT(r.rating) AS rating_count,
    ROUND(AVG(r.rating), 2) AS avg_genre_rating
FROM ratings r
JOIN (
    SELECT movieId, genre
    FROM movies
    LATERAL VIEW explode(split(genres, '\\|')) genre_table AS genre
) m
    ON r.movieId = m.movieId
GROUP BY genre
ORDER BY rating_count DESC;
```

---

# 🔬 Genre Query Explanation

The following function splits the genre values:

```sql
split(genres, '\\|')
```

For example:

```text
Action|Adventure|Sci-Fi
```

is separated into individual genre values.

The `explode()` function converts the values into separate rows.

Conceptually:

```text
movieId | genre
--------|----------
1       | Adventure
1       | Animation
1       | Children
1       | Comedy
1       | Fantasy
```

`LATERAL VIEW` is used together with `explode()` so that the generated genre rows can be used for further analysis.

---

# 📈 Genre Analysis Output

The genre analysis produces:

```text
Genre
Rating Count
Average Genre Rating
```

The results are ordered by:

```text
rating_count DESC
```

This allows the project to identify genres with the highest number of ratings.

---

# 📤 Exporting Results

The project also supports exporting analytical results.

The top-rated movie output can be stored in:

```text
/tmp/movielens_top_rated
```

The exported results can be used for:

- Further analysis
- Verification
- Project reports
- Presentations
- Data visualization

---

# 🧪 HiveQL Concepts Demonstrated

The project demonstrates several important HiveQL concepts.

### SELECT

Used to retrieve required fields.

```sql
SELECT ...
```

### JOIN

Used to combine ratings with movie information.

```sql
JOIN movies m
ON r.movieId = m.movieId
```

### GROUP BY

Used to group records for aggregation.

```sql
GROUP BY m.title
```

### COUNT

Used to count ratings.

```sql
COUNT(r.rating)
```

### AVG

Used to calculate average ratings.

```sql
AVG(r.rating)
```

### ROUND

Used to round average rating values.

```sql
ROUND(AVG(r.rating), 2)
```

### HAVING

Used to filter aggregated results.

```sql
HAVING total_reviews >= 2000
```

### ORDER BY

Used to sort the results.

```sql
ORDER BY avg_rating DESC
```

### LIMIT

Used to restrict the number of results.

```sql
LIMIT 10
```

### SPLIT

Used to split multiple genres.

```sql
split(genres, '\\|')
```

### EXPLODE

Used to convert multiple genre values into individual rows.

```sql
explode(...)
```

### LATERAL VIEW

Used with `explode()` to process generated rows.

---

# ⚙️ Installation and Setup

Detailed setup instructions are provided in the `setup` directory.

## Step 1 — Clean Installation

See:

[Clean Installation Guide](setup/01-clean-install.md)

This document covers:

- Removing old Hadoop/Hive installations
- Installing Java 8
- Installing Hadoop 3.3.6
- Creating required directories
- Setting ownership and permissions
- Preparing the Hadoop environment

---

## Step 2 — Hadoop Configuration

See:

[Hadoop Configuration](setup/02-hadoop-config.md)

This covers:

```text
core-site.xml
hdfs-site.xml
mapred-site.xml
yarn-site.xml
```

It also covers:

- NameNode formatting
- Starting HDFS
- Starting YARN
- Checking Hadoop services
- Creating HDFS directories
- Uploading the MovieLens dataset

---

## Step 3 — Hive Configuration

See:

[Hive Configuration](setup/03-hive-config.md)

This covers:

- Installing Hive 3.1.3
- Configuring Hive
- Configuring environment variables
- Synchronizing required Guava dependencies
- Connecting Hadoop configuration files
- Initializing the Derby Metastore
- Starting Hive

---

# ▶️ Running the Project

After completing the Hadoop and Hive configuration, the project can be executed using the following steps.

## 1. Start HDFS

```bash
start-dfs.sh
```

Check the services:

```bash
jps
```

---

## 2. Start YARN

```bash
start-yarn.sh
```

Check the services:

```bash
jps
```

---

## 3. Create HDFS Directories

```bash
hdfs dfs -mkdir -p /user/hadoop/movielens/ratings
```

```bash
hdfs dfs -mkdir -p /user/hadoop/movielens/movies
```

---

## 4. Upload Dataset

Upload the ratings file:

```bash
hdfs dfs -put ratings.csv /user/hadoop/movielens/ratings/
```

Upload the movies file:

```bash
hdfs dfs -put movies.csv /user/hadoop/movielens/movies/
```

---

## 5. Start Hive

```bash
hive
```

---

## 6. Create Hive Tables

Use the SQL script:

[Create Tables](hive/create_tables.sql)

The script creates:

```text
movie_db
ratings
movies
```

---

## 7. Run Analysis

Use:

[Analysis Queries](hive/analysis_queries.sql)

The script performs:

```text
Top 10 Popular Movies
        ↓
Top 10 Highest-Rated Movies
        ↓
Genre-wise Analysis
```

---

# 🔎 Useful Verification Queries

## Show Databases

```sql
SHOW DATABASES;
```

---

## Select Database

```sql
USE movie_db;
```

---

## Show Tables

```sql
SHOW TABLES;
```

Expected tables:

```text
movies
ratings
```

---

## Describe Ratings Table

```sql
DESCRIBE ratings;
```

---

## Describe Movies Table

```sql
DESCRIBE movies;
```

---

## Check Ratings Data

```sql
SELECT * FROM ratings LIMIT 10;
```

---

## Check Movies Data

```sql
SELECT * FROM movies LIMIT 10;
```

---

# 🖥️ Hadoop Service Verification

Hadoop services can be checked using:

```bash
jps
```

The command is useful for verifying that the required Hadoop and YARN services are running.

---

# ⚙️ Important Configuration Notes

## Java 8 Compatibility

The project uses **Java 8** for compatibility with the selected Hadoop and Hive versions.

---

## YARN ShuffleHandler

The YARN ShuffleHandler is configured for MapReduce execution.

It is required during the shuffle phase of MapReduce processing.

---

## Hive Automatic Map Join

The project configuration uses:

```text
hive.auto.convert.join=false
```

This is part of the project configuration for predictable execution of the analytical joins.

---

## External Tables

External Hive tables are used because the physical dataset is stored in HDFS.

The Hive table definitions provide the schema and allow HiveQL queries to access the HDFS data.

---

# 🗂️ Repository Structure

```text
movie-rating-analysis/
│
├── README.md
├── .gitignore
│
├── data/
│   ├── README.md
│   └── dataset files
│
├── hive/
│   ├── create_tables.sql
│   └── analysis_queries.sql
│
├── setup/
│   ├── 01-clean-install.md
│   ├── 02-hadoop-config.md
│   └── 03-hive-config.md
│
├── screenshots/
│   └── project screenshots
│
└── docs/
    └── project report
```

---

# 📂 Repository File Description

| File / Directory | Description |
|---|---|
| `README.md` | Complete project documentation |
| `.gitignore` | Prevents unnecessary files from being committed |
| `data/` | Dataset and dataset documentation |
| `hive/` | HiveQL scripts |
| `setup/` | Hadoop and Hive installation/configuration |
| `screenshots/` | Project execution screenshots |
| `docs/` | Project report and documentation |

---

# 📝 Hive Scripts

## `hive/create_tables.sql`

This script:

1. Creates the `movie_db` database.
2. Selects the database.
3. Creates the `ratings` external table.
4. Creates the `movies` external table.

---

## `hive/analysis_queries.sql`

This script contains:

1. Top 10 popular movies
2. Top 10 highest-rated movies with at least 2,000 reviews
3. Genre-wise rating analysis

---

# 📸 Project Screenshots

Screenshots of the actual project execution can be stored inside:

```text
screenshots/
```

Recommended screenshots include:

### Hadoop

- Hadoop installation
- `jps` output
- HDFS services
- YARN services

### HDFS

- HDFS directories
- Ratings dataset uploaded to HDFS
- Movies dataset uploaded to HDFS

### Hive

- Hive startup
- Database creation
- Table creation
- `SHOW TABLES`
- `DESCRIBE ratings`
- `DESCRIBE movies`

### Analysis

- Top 10 popular movies
- Top 10 highest-rated movies
- Genre analysis
- Exported results

Suggested structure:

```text
screenshots/
├── 01-hadoop-jps.png
├── 02-hdfs-directories.png
├── 03-hive-database.png
├── 04-hive-tables.png
├── 05-popular-movies.png
├── 06-top-rated-movies.png
├── 07-genre-analysis.png
└── 08-exported-results.png
```

---

# 📄 Project Report

The final project report can be stored inside:

```text
docs/
```

Example:

```text
docs/
└── Movie_Rating_Analysis_Project_Report.pdf
```

The report can contain:

- Abstract
- Introduction
- Problem Statement
- Objectives
- Existing System
- Proposed System
- Technologies Used
- System Architecture
- Dataset Description
- Hadoop Configuration
- Hive Configuration
- Database Design
- Query Implementation
- Results
- Screenshots
- Conclusion
- Future Scope
- References

---

# 🎓 Learning Outcomes

This project provides practical experience with:

### Big Data

Understanding the need for distributed storage and processing.

### Hadoop

Understanding the Hadoop ecosystem and its components.

### HDFS

Learning how large datasets can be stored using a distributed file system.

### YARN

Understanding resource management and job execution.

### Hive

Using a SQL-like interface for Big Data analysis.

### HiveQL

Writing analytical queries over data stored in HDFS.

### Data Aggregation

Using:

```text
COUNT
AVG
GROUP BY
ORDER BY
```

for analytical processing.

### Data Transformation

Using:

```text
SPLIT
EXPLODE
LATERAL VIEW
```

to process multi-valued genre fields.

---

# 🧑‍🏫 Viva / Defense Points

## Why Hadoop?

Hadoop provides a framework for distributed storage and processing of large datasets.

---

## Why HDFS?

HDFS provides distributed storage for large datasets.

In this project, the MovieLens data is stored in HDFS before being queried through Hive.

---

## Why Hive?

Hive provides a SQL-like interface that makes it easier to perform analytical queries on data stored in Hadoop.

---

## Why Hive instead of a traditional SQL database?

Hive is designed for large-scale data processing in Hadoop environments and integrates directly with HDFS.

---

## Why use External Tables?

External tables allow Hive to reference data stored in HDFS while keeping the underlying data separate from the Hive table definition.

---

## Why use JOIN?

The ratings dataset contains `movieId`, while the movie dataset contains movie titles and genres.

A JOIN allows the rating information to be combined with movie information.

---

## Why use GROUP BY?

`GROUP BY` is used to calculate aggregate statistics for each movie or genre.

---

## Why use HAVING?

`HAVING` is used to filter aggregated results.

In this project:

```sql
HAVING total_reviews >= 2000
```

ensures that only movies with at least 2,000 reviews are considered for the high-rating analysis.

---

## Why use LATERAL VIEW?

`LATERAL VIEW` is used with `explode()` to transform multiple values stored in a single field into separate rows for analysis.

---

## Why use EXPLODE?

Movie genres can contain multiple values in a single field.

For example:

```text
Action|Adventure|Sci-Fi
```

`explode()` converts these values into individual rows.

---

# ⚠️ Dataset and GitHub Considerations

Large MovieLens datasets can be very large.

Therefore:

- Large raw datasets should generally not be committed to GitHub.
- The complete dataset can be downloaded separately and uploaded to HDFS.
- The repository contains dataset documentation and the project data currently used.
- The `.gitignore` file can be used to prevent accidentally committing unwanted large files.

---

# 🔐 Files to Avoid Committing

The repository should avoid unnecessary temporary or generated files such as:

```text
*.log
*.class
*.zip
*.tar
*.gz
tmp/
temp/
```

These files are handled by the `.gitignore` configuration.

---

# 📈 Expected Analytical Output

The project produces three major categories of results.

## Popularity Analysis

```text
Movie Title
Review Count
```

## Rating Analysis

```text
Movie Title
Average Rating
Total Reviews
```

## Genre Analysis

```text
Genre
Rating Count
Average Genre Rating
```

These results can be used in the project report and presentation.

---

# 🚀 Future Scope

Possible future improvements include:

- Adding larger MovieLens datasets.
- Performing time-based rating analysis.
- Analyzing rating trends over time.
- Creating visual dashboards from Hive output.
- Integrating Python for visualization.
- Comparing Hive with Apache Spark.
- Performing recommendation-system analysis.
- Adding advanced genre-based statistics.
- Automating the complete data-loading and query process.

---

# 🏁 Conclusion

This project demonstrates a complete Big Data processing workflow using Hadoop and Hive.

The MovieLens dataset is stored in HDFS and accessed through Hive external tables.

HiveQL is used to perform analytical operations including:

- Movie popularity analysis
- Average rating analysis
- Minimum review filtering
- Genre-wise analysis
- Data aggregation
- Result ordering
- Result exporting

The project demonstrates the practical application of Hadoop, HDFS, YARN, Hive, and HiveQL for distributed data processing and analytics.

---

# 📚 Project Documentation

The repository contains separate documentation for different parts of the project.

### Installation

[Clean Installation Guide](setup/01-clean-install.md)

### Hadoop Configuration

[Hadoop Configuration](setup/02-hadoop-config.md)

### Hive Configuration

[Hive Configuration](setup/03-hive-config.md)

### Hive Table Creation

[Create Hive Tables](hive/create_tables.sql)

### Analysis Queries

[Run Analysis Queries](hive/analysis_queries.sql)

### Dataset Documentation

[Dataset Information](data/README.md)

---

# 👥 Team Members

| Name | Roll Number | Role |
|---|---|---|
| Your Name | XXXXX | Project Member |
| Team Member 2 | XXXXX | Project Member |
| Team Member 3 | XXXXX | Project Member |
| Team Member 4 | XXXXX | Project Member |

> Replace the placeholder values with the actual team member details.

---

# 📌 Project Information

| Field | Details |
|---|---|
| Project Title | Movie Rating Analysis using Hadoop and Hive |
| Domain | Big Data Processing & Distributed Analytics |
| Dataset | MovieLens |
| Storage | HDFS |
| Processing | Hadoop / YARN |
| Query Engine | Apache Hive |
| Query Language | HiveQL |
| Hive Database | `movie_db` |
| Main Tables | `ratings`, `movies` |
| Hadoop Version | 3.3.6 |
| Hive Version | 3.1.3 |
| Java Version | OpenJDK 8 |

---

# ⭐ Key Technologies

```text
Apache Hadoop
HDFS
YARN
MapReduce
Apache Hive
HiveQL
Java
Apache Derby
MovieLens
Big Data Analytics
Distributed Data Processing
```

---

## 👨‍💻 Project

**Movie Rating Analysis using Hadoop and Hive**

**Domain:** Big Data Processing & Distributed Analytics

**Dataset:** MovieLens
