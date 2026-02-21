---
name: bioconductor-geometadb
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GEOmetadb.html
---

# bioconductor-geometadb

name: bioconductor-geometadb
description: Querying and navigating NCBI Gene Expression Omnibus (GEO) metadata using a local SQLite database. Use this skill to find microarray experiments, platforms (GPL), samples (GSM), and series (GSE) using SQL queries or dplyr, and to convert between different GEO accession types.

# bioconductor-geometadb

## Overview

The `GEOmetadb` package provides a powerful alternative to NCBI Entrez for searching GEO metadata. It functions by downloading a frequently updated SQLite database containing nearly all metadata associated with GEO records. This allows for complex, programmatic, and high-performance SQL-based queries that are difficult or impossible via web interfaces. It is often used in conjunction with `GEOquery` to identify datasets of interest before downloading the actual expression data.

## Core Workflow

### 1. Database Setup
The package requires a local SQLite file. You must download this file before performing queries.

```r
library(GEOmetadb)
# Download the full database (large file)
# getSQLiteFile(destdir = getwd(), destfile = "GEOmetadb.sqlite.gz")

# For demonstration or testing, a smaller demo database is available
sqlfile <- getSQLiteFile(type = "demo")
con <- dbConnect(SQLite(), sqlfile)
```

### 2. Exploring the Schema
Use standard `DBI` functions to explore available metadata tables and fields.

```r
# List all tables (e.g., gse, gsm, gpl, gds)
dbListTables(con)

# List fields in the Sample (gsm) table
dbListFields(con, "gsm")

# Get column descriptions
dbGetQuery(con, "SELECT * FROM geodb_column_desc")
```

### 3. Executing SQL Queries
The primary way to use `GEOmetadb` is via `dbGetQuery`.

```r
# Find all human breast cancer series
sql <- "SELECT DISTINCT gse.title, gse.gse 
        FROM gse 
        JOIN gse_gpl ON gse.gse = gse_gpl.gse
        JOIN gpl ON gse_gpl.gpl = gpl.gpl
        WHERE gse.title LIKE '%breast cancer%' 
        AND gpl.organism LIKE '%Homo sapiens%'"
results <- dbGetQuery(con, sql)
```

### 4. Accession Conversion
The `geoConvert` function is a high-level utility for mapping between different GEO entity types (e.g., finding all samples associated with a specific platform).

```r
# Convert a Platform ID to Series and Samples
conversion <- geoConvert("GPL96", out_type = c("gse", "gsm"))
```

### 5. Integration with dplyr
You can use `dplyr` and `dbplyr` to query the database without writing raw SQL.

```r
library(dplyr)
db_src <- src_sqlite(sqlfile)
gse_tbl <- tbl(db_src, "gse")

# Filter for specific series
gse_tbl %>% 
  filter(gse == "GSE2553") %>% 
  select(title, submission_date) %>% 
  collect()
```

## Key Functions

- `getSQLiteFile()`: Downloads the GEOmetadb SQLite database from the server.
- `geoConvert()`: Efficiently maps between GEO accession types (GPL, GSE, GSM, GDS).
- `getBiocPlatformMap()`: Maps GEO Platforms (GPL) to Bioconductor annotation packages.
- `dbConnect(SQLite(), ...)`: Establishes the connection to the downloaded database.

## Tips for Success

- **Database Size**: The full SQLite database is very large (several gigabytes). Ensure you have adequate disk space and a stable connection when running `getSQLiteFile()`.
- **Wildcards**: Use the SQL `%` operator with `LIKE` for flexible text searching (e.g., `LIKE '%RNA-seq%'`).
- **Cleanup**: Always close the database connection using `dbDisconnect(con)` when your analysis is complete to prevent file locking.
- **Data vs. Metadata**: Remember that `GEOmetadb` contains **metadata only**. To download the actual expression matrices or processed data, use the `GEOquery` package with the IDs found via `GEOmetadb`.

## Reference documentation

- [Using the GEOmetadb Package](./references/GEOmetadb.md)