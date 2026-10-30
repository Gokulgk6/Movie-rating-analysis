# Movie Rating Analysis using Hadoop and Hive

**Distributed analytics on the MovieLens dataset with HDFS, Apache Hive, and HiveQL.**

<p>
<img src="https://img.shields.io/badge/Hadoop-66CCFF?style=flat-square&logo=apachehadoop&logoColor=black" />
<img src="https://img.shields.io/badge/Apache%20Hive-FDEE21?style=flat-square&logo=apachehive&logoColor=black" />
<img src="https://img.shields.io/badge/HDFS-66CCFF?style=flat-square&logo=apachehadoop&logoColor=black" />
<img src="https://img.shields.io/badge/Java-ED8B00?style=flat-square&logo=openjdk&logoColor=white" />
<img src="https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black" />
</p>

---

## Overview

This project demonstrates a complete Big Data processing workflow: raw MovieLens CSV files are stored in **HDFS**, exposed through **Hive external tables**, and analyzed with **HiveQL** in a pseudo-distributed Hadoop environment.

The analysis answers practical questions such as:

- Which movies have received the most ratings?
- Which highly-rated movies have at least 2,000 reviews?
- Which genres are rated most often, and how do their averages compare?

## Tech Stack

| Component | Technology |
|---|---|
| Operating System | Arch Linux x86_64 |
| Java | OpenJDK 8 |
| Hadoop | Apache Hadoop 3.3.6 |
| Storage | HDFS |
| Resource Management | YARN |
| Processing | Hadoop MapReduce |
| Data Warehouse | Apache Hive 3.1.3 |
| Metastore | Apache Derby |
| Query Language | HiveQL |
| Dataset | MovieLens |

## Dataset

The project uses the MovieLens dataset stored in `data/`:

| File | Description |
|---|---|
| `ratings.csv` | `userId`, `movieId`, `rating`, `review_time` |
| `movies.csv` | `movieId`, `title`, `genres` |
| `links.csv` | Movie identifier mappings |
| `tags.csv` | User-applied tags |

The two primary tables are joined on `movieId` to combine rating behavior with movie metadata and genres.

## Architecture

```text
MovieLens CSV
      |
      v
    HDFS  (/user/hadoop/movielens/{ratings,movies})
      |
      v
Hive external tables  (movie_db.ratings, movie_db.movies)
      |
      v
   HiveQL analysis
      |
      v
Aggregated results / exports
```

## Project Structure

```text
Movie-rating-analysis/
├── data/                 # MovieLens dataset and documentation
├── hive/
│   ├── create_tables.sql # database and external table definitions
│   └── analysis_queries.sql
├── setup/
│   ├── 01-clean-install.md
│   ├── 02-hadoop-config.md
│   └── 03-hive-config.md
├── README.md
└── .gitignore
```

## Setup and Execution

Detailed environment setup is documented in `setup/`:

- [Clean installation](setup/01-clean-install.md)
- [Hadoop configuration](setup/02-hadoop-config.md)
- [Hive configuration](setup/03-hive-config.md)

### Run

```bash
# 1. Start Hadoop services
start-dfs.sh
start-yarn.sh

# 2. Create HDFS directories and upload data
hdfs dfs -mkdir -p /user/hadoop/movielens/ratings
hdfs dfs -mkdir -p /user/hadoop/movielens/movies
hdfs dfs -put data/ratings.csv /user/hadoop/movielens/ratings/
hdfs dfs -put data/movies.csv  /user/hadoop/movielens/movies/

# 3. Create Hive tables and run analysis
hive -f hive/create_tables.sql
hive -f hive/analysis_queries.sql
```

## Analysis

`hive/analysis_queries.sql` implements three analyses:

1. **Top 10 most popular movies** — ranked by number of ratings.
2. **Top 10 highest-rated movies** — `HAVING total_reviews >= 2000` to avoid low-sample bias.
3. **Genre-wise analysis** — uses `SPLIT`, `EXPLODE`, and `LATERAL VIEW` to analyze multi-valued genre fields.

Example (popularity):

```sql
SELECT m.title, COUNT(r.rating) AS review_count
FROM ratings r
JOIN movies m ON r.movieId = m.movieId
GROUP BY m.title
ORDER BY review_count DESC
LIMIT 10;
```

## Concepts Demonstrated

- Distributed storage with HDFS and resource management with YARN
- Hive external tables over HDFS data
- HiveQL joins, aggregation (`COUNT`, `AVG`, `ROUND`), and filtering (`HAVING`)
- Multi-valued field transformation with `SPLIT`, `EXPLODE`, and `LATERAL VIEW`
- Exporting analytical results for reporting

## Author

**Gokulakrishnan G** — Cybersecurity Analyst
[GitHub](https://github.com/Gokulgk6) · [LinkedIn](https://linkedin.com/in/gokulgk64)
