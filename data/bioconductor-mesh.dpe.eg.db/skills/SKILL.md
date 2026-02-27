---
name: bioconductor-mesh.dpe.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for the species Dipetalonema pecaudi. Use when user asks to map identifiers, perform functional annotation, or conduct gene set enrichment analysis for Dipetalonema pecaudi using MeSH terms.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Dpe.eg.db.html
---


# bioconductor-mesh.dpe.eg.db

name: bioconductor-mesh.dpe.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for the species Dipetalonema pecaudi (Dpe). Use this skill when performing functional annotation, gene set enrichment analysis, or biological data integration involving Dipetalonema pecaudi genomic data and MeSH terms.

## Overview

The `MeSH.Dpe.eg.db` package is a Bioconductor annotation database that facilitates the correspondence between MeSH IDs and Entrez Gene IDs for *Dipetalonema pecaudi*. It is built upon the `AnnotationDbi` infrastructure, allowing users to query biological metadata using a standardized set of accessor methods.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Dpe.eg.db")
library(MeSH.Dpe.eg.db)
```

## Core Workflows

The package follows the standard `AnnotationDbi` interface. The primary object is `MeSH.Dpe.eg.db`.

### 1. Exploring the Database Structure
Before querying, identify what types of data (keytypes) are available and what information (columns) can be retrieved.

```r
# List available columns to retrieve
columns(MeSH.Dpe.eg.db)

# List available keytypes to use as filters
keytypes(MeSH.Dpe.eg.db)
```

### 2. Retrieving Keys
To see the identifiers present in the database for a specific keytype:

```r
# Get the first 6 Entrez Gene IDs
head(keys(MeSH.Dpe.eg.db, keytype = "GENEID"))

# Get the first 6 MeSH IDs
head(keys(MeSH.Dpe.eg.db, keytype = "MESHID"))
```

### 3. Mapping Identifiers (The `select` Method)
The `select` function is the primary way to map between Entrez Gene IDs and MeSH terms.

```r
# Example: Map specific Entrez Gene IDs to MeSH IDs and Categories
my_genes <- head(keys(MeSH.Dpe.eg.db, keytype = "GENEID"))
res <- select(MeSH.Dpe.eg.db, 
              keys = my_genes, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = "GENEID")
head(res)
```

### 4. Database Metadata
You can retrieve specific information about the database instance:

```r
species(MeSH.Dpe.eg.db)  # Confirm species (Dipetalonema pecaudi)
dbInfo(MeSH.Dpe.eg.db)   # Database metadata and source information
dbfile(MeSH.Dpe.eg.db)   # Path to the SQLite database file
```

## Usage Tips
- **MeSH Categories**: When querying, the `MESHCATEGORY` column helps distinguish between different branches of the MeSH hierarchy (e.g., Diseases, Chemicals and Drugs).
- **Integration**: This package is often used in conjunction with `MeSHDbi` for more complex MeSH-based enrichment analyses.
- **Standard Accessors**: If you are familiar with `org.Hs.eg.db` or other Bioconductor annotation packages, the workflow for `MeSH.Dpe.eg.db` is identical.

## Reference documentation
- [MeSH.Dpe.eg.db Reference Manual](./references/reference_manual.md)