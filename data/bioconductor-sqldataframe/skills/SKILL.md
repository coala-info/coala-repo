---
name: bioconductor-sqldataframe
description: The SQLDataFrame package provides a lazy, memory-efficient interface to SQL database tables that mimics the behavior of a standard Bioconductor DataFrame. Use when user asks to interface with large SQL-backed datasets, perform lazy data manipulation using dplyr verbs on-disk, or integrate database tables into Bioconductor containers like SummarizedExperiment.
homepage: https://bioconductor.org/packages/release/bioc/html/SQLDataFrame.html
---


# bioconductor-sqldataframe

## Overview
The `SQLDataFrame` package provides a lazy, memory-efficient interface to SQL database tables that mimics the behavior of a standard Bioconductor `DataFrame`. It supports common R operations like square-bracket subsetting, `rbind`, and `dplyr` verbs (`filter`, `mutate`, `select`) while keeping the data on-disk. It is particularly useful for integrating large SQL-backed datasets into Bioconductor containers like `SummarizedExperiment` or `GenomicRanges`.

## Core Workflows

### 1. Construction and Connection
You can create a `SQLDataFrame` by providing a connection and a unique key column.

```r
library(SQLDataFrame)
library(DBI)

# Connect to a database (e.g., SQLite)
conn <- dbConnect(RSQLite::SQLite(), dbname = "path/to/db.sqlite")

# Construct SQLDataFrame
# dbkey is required to uniquely identify rows
sdf <- SQLDataFrame(conn = conn, dbtable = "my_table", dbkey = "id_column")

# Alternative: Construct directly from file (auto-imports to temp SQLite)
sdf_from_file <- makeSQLDataFrame("data.csv", dbkey = "id_column", sep = ",")
```

### 2. Data Manipulation
`SQLDataFrame` supports standard R subsetting and `dplyr` syntax.

*   **Subsetting**: `sdf[1:10, 1:5]` returns a lazy `SQLDataFrame`.
*   **Column Extraction**: `sdf[[1]]` or `sdf$column_name` returns the realized vector.
*   **Dplyr Verbs**:
    ```r
    library(dplyr)
    res <- sdf %>% 
      filter(gene_type == "protein_coding") %>% 
      select(gene_id, symbol) %>%
      mutate(new_col = old_col * 10)
    ```

### 3. Combining Data
The package handles joins and unions, even across different database connections.

*   **Joins**: `left_join(sdf1, sdf2)`, `inner_join()`, `semi_join()`, `anti_join()`.
*   **Binding**: `rbind(sdf1, sdf2)` (preserves order) or `union(sdf1, sdf2)` (sorted by key).

### 4. Realization (Saving)
Because operations are lazy, you must explicitly save to "realize" changes (like joins or mutations) into a new physical database table.

```r
# Highly recommended after complex joins or rbinding
sdf_new <- saveSQLDataFrame(res, dbname = "processed_data.db", dbtable = "results")
```

### 5. Integration with Bioconductor
`SQLDataFrame` inherits from `DataFrame`, making it compatible with `mcols` or `colData`.

```r
library(GenomicRanges)
gr <- GRanges("chr1", IRanges(1:10, width=100))
# Assign SQLDataFrame as metadata columns
mcols(gr) <- sdf[1:10, ] 
```

## Tips and Best Practices
*   **Key Columns**: The `dbkey` is essential. If a table has composite keys, provide a character vector: `dbkey = c("chrom", "pos")`.
*   **Lazy Layers**: Frequent use of `saveSQLDataFrame()` is recommended to prevent performance degradation from too many nested lazy operations.
*   **Column Selection**: `ncol()` and `colnames()` refer to the non-key columns. The key columns are treated as fixed identifiers.
*   **BigQuery Support**: When using Google BigQuery, the `dbkey` is automatically assigned as `SurrogateKey`.

## Reference documentation
- [SQLDataFrame: Internal Implementation](./references/SQLDataFrame-internal.Rmd)
- [SQLDataFrame: Lazy representation of SQL database in DataFrame metaphor](./references/SQLDataFrame.Rmd)