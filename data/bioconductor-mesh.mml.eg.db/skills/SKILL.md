---
name: bioconductor-mesh.mml.eg.db
description: This package provides mappings between MeSH identifiers and Entrez Gene IDs for Macaca mulatta. Use when user asks to map MeSH terms to Rhesus monkey genes, perform gene set enrichment analysis using MeSH categories, or query biological metadata for Macaca mulatta.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Mml.eg.db.html
---


# bioconductor-mesh.mml.eg.db

name: bioconductor-mesh.mml.eg.db
description: Mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Macaca mulatta (Rhesus monkey). Use this skill when performing biomedical data annotation, gene set enrichment analysis, or cross-referencing biological literature with genomic data for Macaca mulatta.

## Overview

The `MeSH.Mml.eg.db` package is a Bioconductor annotation object that facilitates the conversion and mapping between MeSH terms and Entrez Gene identifiers specifically for *Macaca mulatta*. It is built upon the `MeSHDbi` framework, providing a standardized interface to query biological metadata.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Mml.eg.db")
library(MeSH.Mml.eg.db)
```

## Core Workflows

The package follows the standard `AnnotationDbi` interface using four main methods: `columns`, `keytypes`, `keys`, and `select`.

### 1. Exploring the Database Structure
Before querying, identify what types of data (keytypes) are available and what information (columns) can be retrieved.

```r
# List available columns to retrieve
columns(MeSH.Mml.eg.db)

# List available keytypes to search by
keytypes(MeSH.Mml.eg.db)
```

### 2. Retrieving Keys
To see the identifiers present in the database for a specific keytype:

```r
# Get the first 6 Entrez Gene IDs
head(keys(MeSH.Mml.eg.db, keytype="GENEID"))

# Get the first 6 MeSH IDs
head(keys(MeSH.Mml.eg.db, keytype="MESHID"))
```

### 3. Performing a Query
Use the `select` function to map between identifiers.

```r
# Example: Mapping specific Entrez Gene IDs to MeSH IDs and Categories
my_keys <- c("693384", "693387", "693391")
res <- select(MeSH.Mml.eg.db, 
              keys = my_keys, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")
head(res)
```

## Database Metadata
You can inspect the underlying database properties using these utility functions:

```r
species(MeSH.Mml.eg.db)  # Confirm species (Macaca mulatta)
dbInfo(MeSH.Mml.eg.db)   # Get package metadata and data sources
dbfile(MeSH.Mml.eg.db)   # Locate the SQLite database file
dbschema(MeSH.Mml.eg.db) # View the SQL schema
```

## Usage Tips
- **MeSH Categories**: When selecting `MESHCATEGORY`, the results often include codes (e.g., D, G, A) representing high-level MeSH hierarchies (Diseases, Phenomena and Processes, Anatomy).
- **Join Operations**: The `select` function may return a 1:many mapping if a gene is associated with multiple MeSH terms. Be prepared to handle duplicated input keys in the resulting data frame.
- **Integration**: This package is often used in conjunction with `meshr` for MeSH enrichment analysis.

## Reference documentation
- [MeSH.Mml.eg.db Reference Manual](./references/reference_manual.md)