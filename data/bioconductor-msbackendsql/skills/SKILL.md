---
name: bioconductor-msbackendsql
description: The MsBackendSql package provides a high-performance infrastructure for managing and analyzing massive mass spectrometry datasets by using SQL databases as on-the-fly storage backends for the Spectra framework. Use when user asks to create a SQL-based mass spectrometry database, import raw MS files into SQL storage, or analyze large-scale proteomics data without loading it entirely into memory.
homepage: https://bioconductor.org/packages/release/bioc/html/MsBackendSql.html
---


# bioconductor-msbackendsql

## Overview

The `MsBackendSql` package provides a high-performance infrastructure for Mass Spectrometry (MS) data by leveraging SQL databases as storage backends for the `Spectra` framework. Unlike in-memory backends, `MsBackendSql` retrieves data on-the-fly, allowing for the analysis of massive datasets on standard hardware. It supports two primary classes: `MsBackendSql` (active connection) and `MsBackendOfflineSql` (connection-less, supporting parallel processing and object serialization).

## Core Workflows

### 1. Creating a SQL MS Database
You can create a database by importing raw MS files (e.g., mzML) or by converting an existing `DataFrame`.

```r
library(RSQLite)
library(Spectra)
library(MsBackendSql)

# Setup SQLite connection
dbfile <- tempfile()
con <- dbConnect(SQLite(), dbfile)

# Import from files
fls <- c("file1.mzML", "file2.mzML")
createMsBackendSqlDatabase(con, fls, blob = TRUE, peaksStorageMode = "blob2")
dbDisconnect(con)
```

**Storage Modes:**
*   `blob2` (Default): Stores the entire peak matrix as a BLOB. Fastest for data extraction and smallest disk footprint.
*   `long`: Stores m/z and intensity values in individual rows. Allows SQL-level filtering but results in much larger databases. Recommended for use with `duckdb`.

### 2. Initializing Spectra with SQL Backends
Use `MsBackendOfflineSql` for most applications as it is compatible with `saveRDS()` and parallel processing.

```r
# Connect to existing database
sps <- Spectra(dbname = dbfile, source = MsBackendOfflineSql(), drv = SQLite())

# For MySQL/MariaDB
# sps <- Spectra(dbname = "ms_db", host = "localhost", user = "admin", 
#                source = MsBackendOfflineSql(), drv = RMariaDB::MariaDB())
```

### 3. Data Manipulation and Caching
Data in the SQL database is read-only. Modifications are cached in memory within the R object.

```r
# Access data (retrieved on-the-fly)
mz(sps)
intensity(sps)

# Modify variables (cached in memory, does not change DB)
sps$rtime <- sps$rtime + 10

# Explicitly cache a variable to improve performance
sps$msLevel <- msLevel(sps)

# Revert all local changes
sps <- reset(sps)
```

### 4. Changing Backends
Move data between memory and SQL storage seamlessly.

```r
# Move from SQL to Memory (Download data)
sps_mem <- setBackend(sps, MsBackendMemory())

# Move from Memory to SQL (Upload/Persist data)
sps_sql <- setBackend(sps_mem, MsBackendOfflineSql(), 
                      drv = SQLite(), dbname = "new_storage.db")
```

## Performance Tips

*   **Memory Management:** Use `peaksapply()` with `chunkSize` for operations that load peak data (like `lengths()`) to avoid out-of-memory errors on massive datasets.
*   **Parallel Processing:** `MsBackendSql` (active connection) does NOT support parallel processing. Use `MsBackendOfflineSql` if you need to use `BPPARAM`.
*   **Subsetting:** Subsetting `Spectra` objects with SQL backends is extremely fast because it only manipulates indices, not the underlying data.
*   **Database Choice:** SQLite is excellent for local, portable storage. MariaDB/MySQL is preferred for centralized, multi-user environments. DuckDB is recommended specifically for "long" format storage.

## Reference documentation

- [Storing Mass Spectrometry Data in SQL Databases](./references/MsBackendSql.Rmd)
- [Storing Mass Spectrometry Data in SQL Databases (Markdown)](./references/MsBackendSql.md)