---
name: bioconductor-mesh.sco.a32.eg.db
description: This package provides annotation mapping between MeSH identifiers and Entrez Gene IDs for Streptomyces coelicolor A3(2). Use when user asks to map MeSH terms to gene identifiers, perform functional annotation, or conduct gene set enrichment analysis for this organism.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Sco.A32.eg.db.html
---

# bioconductor-mesh.sco.a32.eg.db

name: bioconductor-mesh.sco.a32.eg.db
description: Provides annotation mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Streptomyces coelicolor A3(2). Use this skill when performing functional annotation, gene set enrichment analysis, or mapping biological concepts to gene identifiers for this specific organism using Bioconductor.

# bioconductor-mesh.sco.a32.eg.db

## Overview

The `MeSH.Sco.A32.eg.db` package is a specialized Bioconductor annotation database. It facilitates the mapping between MeSH terms (a hierarchically-organized medical and biological vocabulary) and Entrez Gene identifiers for *Streptomyces coelicolor A3(2)*. This package is built upon the `MeSHDbi` framework and follows the standard `AnnotationDbi` interface.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Sco.A32.eg.db")
library(MeSH.Sco.A32.eg.db)
```

## Core Workflows

The package uses four standard accessor methods: `columns`, `keytypes`, `keys`, and `select`.

### 1. Exploring the Database
Check what types of data and identifiers are available within the object.

```r
# View available columns (data types)
columns(MeSH.Sco.A32.eg.db)

# View available keytypes (searchable identifiers)
keytypes(MeSH.Sco.A32.eg.db)

# Check the species name
species(MeSH.Sco.A32.eg.db)
```

### 2. Retrieving Keys
Extract specific identifiers to use for mapping.

```r
# Get the first 6 Entrez Gene IDs
gene_keys <- head(keys(MeSH.Sco.A32.eg.db, keytype = "GENEID"))
```

### 3. Mapping Identifiers (select)
The `select` function is the primary tool for mapping between MeSH IDs and Gene IDs.

```r
# Map specific Gene IDs to MeSH IDs and Categories
res <- select(MeSH.Sco.A32.eg.db, 
              keys = gene_keys, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = "GENEID")
head(res)
```

## Database Metadata
For reproducibility and provenance, you can inspect the underlying database connection and schema:

```r
dbconn(MeSH.Sco.A32.eg.db)   # Database connection object
dbfile(MeSH.Sco.A32.eg.db)   # Path to the SQLite file
dbschema(MeSH.Sco.A32.eg.db) # Database schema
dbInfo(MeSH.Sco.A32.eg.db)   # Package metadata and versioning
```

## Usage Tips
- **MeSH Categories**: MeSH IDs are often grouped into categories (e.g., D for Drugs and Chemicals, G for Phenomena and Processes). Use the `MESHCATEGORY` column to filter results.
- **Integration**: This package is designed to work seamlessly with `MeSHDbi`. For advanced enrichment analysis, consider using this database in conjunction with the `meshr` package.
- **Key Selection**: Always verify your `keytype` matches the format of your input `keys` to avoid empty returns.

## Reference documentation

- [MeSH.Sco.A32.eg.db Reference Manual](./references/reference_manual.md)