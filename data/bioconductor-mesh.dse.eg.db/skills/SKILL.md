---
name: bioconductor-mesh.dse.eg.db
description: This package provides mappings between MeSH disease identifiers and Entrez Gene IDs for Homo sapiens. Use when user asks to map MeSH IDs to gene identifiers, perform functional annotation of disease-related genes, or conduct gene set enrichment analysis using MeSH terms.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Dse.eg.db.html
---


# bioconductor-mesh.dse.eg.db

name: bioconductor-mesh.dse.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Homo sapiens. Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biomedical literature terms with genomic data in R.

## Overview

The `MeSH.Dse.eg.db` package is a Bioconductor annotation resource that facilitates the correspondence between MeSH IDs and Entrez Gene IDs. It is built upon the `MeSHDbi` framework, allowing users to query biological relationships using a standard interface. "Dse" in the name typically refers to "Diseases," indicating the specific category of MeSH terms contained within this mapping database.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Dse.eg.db")
library(MeSH.Dse.eg.db)
```

## Core Workflows

The package follows the standard `AnnotationDbi` interface. You can interact with the database using four main methods: `columns()`, `keytypes()`, `keys()`, and `select()`.

### 1. Exploring the Database Structure
Before querying, identify what types of data are available:

```r
# List all available data columns
columns(MeSH.Dse.eg.db)

# List all available key types (searchable fields)
keytypes(MeSH.Dse.eg.db)
```

### 2. Retrieving Keys
To see the identifiers present in the database:

```r
# Get the first 6 MeSH IDs
head(keys(MeSH.Dse.eg.db, keytype="MESHID"))

# Get the first 6 Entrez Gene IDs
head(keys(MeSH.Dse.eg.db, keytype="GENEID"))
```

### 3. Performing Queries
Use `select()` to map between identifiers:

```r
# Map specific MeSH IDs to Entrez Gene IDs
my_keys <- c("D001249", "D009369") # Example MeSH IDs for Asthma and Neoplasms
res <- select(MeSH.Dse.eg.db, 
              keys = my_keys, 
              columns = c("MESHID", "GENEID"), 
              keytype = "MESHID")
head(res)
```

## Database Metadata

You can retrieve information about the underlying SQLite database and the species covered:

```r
# Check the species
species(MeSH.Dse.eg.db)

# Get database metadata
dbInfo(MeSH.Dse.eg.db)

# Get the underlying SQLite file path
dbfile(MeSH.Dse.eg.db)
```

## Usage Tips
- **MeSH Categories**: This specific package focuses on the relationship between genes and disease-related MeSH terms.
- **Integration**: This package is often used in conjunction with `MeSH.db` (for term descriptions) and `meshr` (for enrichment analysis).
- **Large Queries**: When calling `keys()` without arguments, it defaults to the primary key. Always specify `keytype` if you are looking for a specific identifier format.

## Reference documentation
- [MeSH.Dse.eg.db Reference Manual](./references/reference_manual.md)