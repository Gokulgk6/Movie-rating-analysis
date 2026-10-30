# Dataset

This project uses the **MovieLens** dataset from [GroupLens](https://grouplens.org/datasets/movielens/). Both the "latest small" and "100k" variants work with the queries in this repository.

## Files

| File | Description |
|---|---|
| `ratings.csv` | User ratings |
| `movies.csv` | Movie titles and genres |
| `links.csv` | Movie ID mappings (IMDb, TMDb) |
| `tags.csv` | User-applied free-text tags |

### ratings.csv

```text
userId,movieId,rating,review_time
1,1,4.0,964982703
1,3,4.0,964981247
1,6,4.0,964982224
```

| Column | Type | Description |
|---|---|---|
| `userId` | INT | User identifier |
| `movieId` | INT | Movie identifier |
| `rating` | FLOAT | Rating from 0.5 to 5.0 |
| `review_time` | BIGINT | Unix timestamp of the rating |

### movies.csv

```text
movieId,title,genres
1,Toy Story (1995),Adventure|Animation|Children|Comedy|Fantasy
2,Jumanji (1995),Adventure|Children|Fantasy
3,Grumpier Old Men (1995),Comedy|Romance
```

| Column | Type | Description |
|---|---|---|
| `movieId` | INT | Movie identifier |
| `title` | STRING | Movie title (with year) |
| `genres` | STRING | Pipe-separated genre list |

### links.csv

| Column | Type | Description |
|---|---|---|
| `movieId` | INT | MovieLens identifier |
| `imdbId` | INT | IMDb identifier |
| `tmdbId` | INT | TMDb identifier |

### tags.csv

| Column | Type | Description |
|---|---|---|
| `userId` | INT | User identifier |
| `movieId` | INT | Movie identifier |
| `tag` | STRING | Free-text tag |
| `timestamp` | BIGINT | Unix timestamp |

## Relationships

`ratings` and `movies` are joined on `movieId`. `tags` also references `movieId`, and `links` maps MovieLens IDs to external databases.

```text
ratings.movieId ──┐
                  ├── movies.movieId
tags.movieId ─────┘

movies.movieId ──── links.movieId
```

## Storage in HDFS

The two files used by the analysis are uploaded to HDFS:

```bash
hdfs dfs -mkdir -p /user/hadoop/movielens/ratings
hdfs dfs -mkdir -p /user/hadoop/movielens/movies

hdfs dfs -put -f ratings.csv /user/hadoop/movielens/ratings/
hdfs dfs -put -f movies.csv  /user/hadoop/movielens/movies/
```

```text
/user/hadoop/movielens/
├── ratings/ratings.csv
└── movies/movies.csv
```

These paths match the `LOCATION` clauses in [`hive/create_tables.sql`](../hive/create_tables.sql).

## Notes

- CSV files are excluded from version control by [`.gitignore`](../.gitignore); download the dataset separately if the files are absent.
- The header row is skipped in Hive using `TBLPROPERTIES ("skip.header.line.count"="1")`.
