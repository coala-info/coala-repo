---
name: bioconductor-mesh.cin.eg.db
description: This package provides mappings between MeSH identifiers and Entrez Gene IDs for Cinchona species. Use when user asks to map MeSH terms to gene IDs, perform functional annotation for Cinchona, or cross-reference biomedical literature with genetic data.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Cin.eg.db.html
---


# bioconductor-mesh.cin.eg.db

name: bioconductor-mesh.cin.eg.db
description: Mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Cinchona (Cin). Use this skill when performing functional annotation, gene enrichment analysis, or cross-referencing biomedical literature terms with genetic data for Cinchona species using Bioconductor.

## Overview

The `MeSH.Cin.eg.db` package is a specialized annotation database within the Bioconductor ecosystem. It provides the correspondence between MeSH unique identifiers (which categorize biomedical concepts and literature) and Entrez Gene IDs for the genus *Cinchona*. It is built upon the `AnnotationDbi` infrastructure, allowing for standardized data retrieval.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Cin.eg.db")
library(MeSH.Cin.eg.db)
```

## Core Workflows

The package follows the standard `AnnotationDbi` interface using four main methods: `columns`, `keytypes`, `keys`, and `select`.

### 1. Exploring the Database Structure
Before querying, identify what data types are available:

```r
# View available information types (e.g., MESHID, GENEID)
columns(MeSH.Cin.eg.db)

# View types of identifiers that can be used as query keys
keytypes(MeSH.Cin.eg.db)
```

### 2. Retrieving Identifiers
To see the specific IDs stored in the database:

```r
# Get the first 6 MeSH IDs
head(keys(MeSH.Cin.eg.db, keytype="MESHID"))

# Get the first 6 Entrez Gene IDs
head(keys(MeSH.Cin.eg.db, keytype="GENEID"))
```

### 3. Mapping Between MeSH and Gene IDs
Use the `select` function to perform the actual mapping:

```r
# Example: Mapping specific MeSH IDs to Gene IDs
my_keys <- c("D000123", "D000456") # Replace with actual MeSH IDs
res <- select(MeSH.Cin.eg.db, 
              keys = my_keys, 
              columns = c("MESHID", "GENEID"), 
              keytype = "MESHID")
head(res)
```

## Database Metadata
You can inspect the underlying database properties using these helper functions:

- `species(MeSH.Cin.eg.db)`: Confirms the target organism (Cinchona).
- `dbconn(MeSH.Cin.eg.db)`: Returns the connection object to the underlying SQLite database.
- `dbfile(MeSH.Cin.eg.db)`: Returns the path to the database file.
- `dbschema(MeSH.Cin.eg.db)`: Displays the database schema.

## Usage Tips
- **MeSH Hierarchy**: This package provides direct mappings. For hierarchical traversal (finding parent/child terms), use the `MeSHDbi` or `MeSH.db` packages in conjunction with this one.
- **Data Frames**: The output of `select()` is always a `data.frame`. If a key has multiple matches, the resulting data frame will contain one row for each match.

## Reference documentation
- [MeSH.Cin.eg.db Reference Manual](./references/reference_manual.md)