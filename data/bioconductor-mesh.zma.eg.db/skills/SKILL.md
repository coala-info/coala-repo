---
name: bioconductor-mesh.zma.eg.db
description: This package provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Zea mays. Use when user asks to map Maize gene identifiers to MeSH terms, perform functional annotation, or conduct gene set enrichment analysis within the Bioconductor environment.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Zma.eg.db.html
---


# bioconductor-mesh.zma.eg.db

name: bioconductor-mesh.zma.eg.db
description: Provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Zea mays (Maize). Use this skill when performing functional annotation, gene set enrichment analysis, or data retrieval involving Maize gene identifiers and MeSH terms within the Bioconductor R environment.

# bioconductor-mesh.zma.eg.db

## Overview

The `MeSH.Zma.eg.db` package is a specialized annotation database for *Zea mays* (Maize). It facilitates the translation between Entrez Gene IDs and MeSH IDs, allowing researchers to link genetic data with standardized medical and biological headings. It follows the standard `AnnotationDbi` interface, making it compatible with common Bioconductor workflows.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Zma.eg.db")
library(MeSH.Zma.eg.db)
```

## Core Workflows

The package uses the standard four accessor methods: `columns`, `keytypes`, `keys`, and `select`.

### 1. Exploring the Database
Check what types of data can be retrieved and what keys can be used as input.

```R
# View available columns (data types)
columns(MeSH.Zma.eg.db)

# View available keytypes (input types)
keytypes(MeSH.Zma.eg.db)
```

### 2. Retrieving Keys
Fetch specific identifiers (e.g., Entrez Gene IDs) present in the database.

```R
# Get the first 6 Entrez Gene IDs
ks <- head(keys(MeSH.Zma.eg.db, keytype="GENEID"))
```

### 3. Mapping Identifiers
Use the `select` function to map between MeSH IDs and Gene IDs.

```R
# Map specific Gene IDs to MeSH IDs and Categories
res <- select(MeSH.Zma.eg.db, 
              keys = ks, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = "GENEID")
head(res)
```

## Database Metadata
You can extract information about the database source and schema using these utility functions:

```R
species(MeSH.Zma.eg.db)  # Confirm species (Zea mays)
dbInfo(MeSH.Zma.eg.db)   # Database metadata
dbfile(MeSH.Zma.eg.db)   # Path to the SQLite file
dbschema(MeSH.Zma.eg.db) # Database schema structure
```

## Usage Tips
- **MeSH Categories**: MeSH terms are organized into categories (e.g., D for Drugs and Chemicals, G for Phenomena and Processes). Use the `MESHCATEGORY` column to filter results to specific biological domains.
- **Integration**: This package is often used in conjunction with `MeSHDbi` and enrichment analysis packages like `meshr` to perform MeSH-based hyper-geometric tests.

## Reference documentation
- [MeSH.Zma.eg.db Reference Manual](./references/reference_manual.md)