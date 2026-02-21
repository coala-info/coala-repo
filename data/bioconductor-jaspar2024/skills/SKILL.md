---
name: bioconductor-jaspar2024
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/JASPAR2024.html
---

# bioconductor-jaspar2024

name: bioconductor-jaspar2024
description: Access and query the JASPAR 2024 database of transcription factor binding profiles. Use this skill when you need to retrieve curated DNA-binding motifs (PFMs), metadata, or structural classifications for transcription factors across various taxa (human, mouse, plants, etc.) using the Bioconductor JASPAR2024 data package.

# bioconductor-jaspar2024

## Overview

The `JASPAR2024` package provides a local SQLite-based interface to the 10th release of the JASPAR database. It contains a non-redundant collection of transcription factor (TF) binding profiles. This version includes a 20% increase in CORE profiles compared to previous versions, enhanced metadata for plant TFs, and trimmed position frequency matrices (PFMs) for improved accuracy.

## Basic Workflow

To use this package, you must initialize the database connection and use standard SQL queries via `RSQLite` or `DBI` to extract data.

### 1. Initialize the Database
The package uses `BiocFileCache` to manage the SQLite database file.

```r
library(JASPAR2024)
library(RSQLite)

# Initialize the JASPAR2024 object
jaspar_db_obj <- JASPAR2024()

# Connect to the SQLite database
# The db() function retrieves the path to the local SQLite file
conn <- dbConnect(SQLite(), db(jaspar_db_obj))
```

### 2. Querying Data
You can query various tables such as `MATRIX`, `TAX`, and `SPECIES`.

```r
# List the first few entries in the MATRIX table
res <- dbGetQuery(conn, 'SELECT * FROM MATRIX LIMIT 5')
print(res)

# Example: Get specific metadata for a TF
tf_info <- dbGetQuery(conn, "SELECT * FROM MATRIX WHERE NAME = 'RUNX1'")
```

### 3. Closing Connection
Always disconnect from the database when finished.

```r
dbDisconnect(conn)
```

## Database Schema Tips

The JASPAR database is relational. Common tables include:
- **MATRIX**: Contains the core profile information (ID, Collection, Base ID, Version, Name).
- **COLLECTION**: Information about the different JASPAR collections (CORE, UNVALIDATED, etc.).
- **SPECIES**: Taxonomic information linked to the profiles.

To see all available tables:
```r
dbListTables(conn)
```

## Integration with TFBSTools
While `JASPAR2024` provides the raw data, it is frequently used in conjunction with the `TFBSTools` package to convert database entries into `PFMatrix` objects for motif analysis.

## Reference documentation

- [JASPAR2024 Vignette](./references/JASPAR2024.md)
- [JASPAR2024 RMarkdown Source](./references/JASPAR2024.Rmd)