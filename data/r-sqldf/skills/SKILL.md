---
name: r-sqldf
description: This tool allows users to manipulate R data frames using SQL syntax. Use when user asks to perform complex data manipulation, join or aggregate data frames using SQL, or read and filter large CSV files that exceed available memory.
homepage: https://cloud.r-project.org/web/packages/sqldf/index.html
---


# r-sqldf

name: r-sqldf
description: Manipulate R data frames using SQL syntax. Use this skill when you need to perform complex data manipulation, joins, or aggregations on R data frames using SQL (SQLite, PostgreSQL, MySQL, or H2 syntax), or when you need to read and filter large CSV files that exceed available memory.

## Overview

The `sqldf` package allows users to run SQL queries on R data frames as if they were database tables. It transparently handles the creation of a temporary database, imports the data frames, executes the SQL statement, and returns the result as a new data frame. It is particularly useful for users more comfortable with SQL than R's `base` or `dplyr` syntax, and for processing large out-of-memory files.

## Installation

```R
install.packages("sqldf")
library(sqldf)
```

## Core Functions

### sqldf()
The primary function for executing SQL on data frames.

```R
# Basic selection
result <- sqldf("SELECT * FROM iris WHERE [Sepal.Width] > 3.5")

# Joins
df1 <- data.frame(id = 1:3, val = c("A", "B", "C"))
df2 <- data.frame(id = 2:4, score = c(10, 20, 30))
joined <- sqldf("SELECT a.*, b.score FROM df1 a LEFT JOIN df2 b ON a.id = b.id")

# Aggregation
agg <- sqldf("SELECT Species, AVG([Sepal.Length]) as MeanLength FROM iris GROUP BY Species")
```

### read.csv.sql()
Reads a CSV file into R while filtering it with an SQL statement. Only the filtered rows are loaded into R memory.

```R
# Filter a large file before loading
iris_setosa <- read.csv.sql("iris.csv", 
                            sql = "SELECT * FROM file WHERE Species = 'setosa'")
```

## Key Workflows and Tips

### Handling Column Names with Dots
R data frames often use dots in column names (e.g., `Sepal.Length`). In SQL, these must be escaped using backticks or square brackets:
- `SELECT `Sepal.Length` FROM iris`
- `SELECT [Sepal.Length] FROM iris`

### Persistent Connections
By default, `sqldf` opens and closes a connection for every call. For multiple queries on the same temporary database:
```R
sqldf() # Open connection
sqldf("SELECT * FROM iris LIMIT 5")
sqldf("SELECT * FROM main.iris WHERE [Sepal.Width] > 3") # Use 'main.' prefix
sqldf() # Close connection
```

### Data Type Heuristics
`sqldf` uses a heuristic to assign classes to returned columns. If the output column name matches a column name in the input data frames, it adopts that class (e.g., Date, Factor).
- Use `method = "raw"` to disable this and get raw database types.
- Use `method = "name__class"` to force types via aliases (e.g., `SELECT col AS [newcol__Date]`).

### Database Backends
While SQLite is the default, `sqldf` supports others if the drivers are loaded:
- `RSQLite` (Default)
- `RH2`
- `RMySQL`
- `RPostgreSQL`

### Arithmetic Differences
Note that SQLite performs integer division for integers. 
- `3/2` in SQLite results in `1`.
- `3.0/2.0` results in `1.5`.

## Reference documentation

- [sqldf: Manipulate R Data Frames Using SQL](./references/reference_manual.md)