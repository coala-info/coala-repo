---
name: bioconductor-mesh.ath.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for Arabidopsis thaliana. Use when user asks to map Arabidopsis genes to MeSH terms, perform functional annotation, or conduct enrichment analysis using the MeSH.Ath.eg.db database.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Ath.eg.db.html
---

# bioconductor-mesh.ath.eg.db

name: bioconductor-mesh.ath.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Arabidopsis thaliana. Use this skill when performing functional annotation, enrichment analysis, or data integration involving Arabidopsis genes and MeSH terms using the MeSH.Ath.eg.db Bioconductor package.

# bioconductor-mesh.ath.eg.db

## Overview

The `MeSH.Ath.eg.db` package is an annotation database for *Arabidopsis thaliana*. It facilitates the correspondence between Entrez Gene IDs and MeSH IDs. This package is built upon the `MeSHDbi` infrastructure and follows the standard `AnnotationDbi` interface, allowing users to query biological metadata using a consistent set of methods.

## Installation and Loading

To use this package, it must be installed via `BiocManager`:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MeSH.Ath.eg.db")

library(MeSH.Ath.eg.db)
```

## Core Workflows

The package uses the standard four accessor methods: `columns`, `keytypes`, `keys`, and `select`.

### 1. Exploring the Database
Before querying, identify what data types are available:

```r
# List all available data columns
columns(MeSH.Ath.eg.db)

# List all available key types (searchable fields)
keytypes(MeSH.Ath.eg.db)
```

### 2. Retrieving Keys
To see the identifiers present in a specific keytype:

```r
# Get the first 6 Entrez Gene IDs
head(keys(MeSH.Ath.eg.db, keytype="GENEID"))

# Get the first 6 MeSH IDs
head(keys(MeSH.Ath.eg.db, keytype="MESHID"))
```

### 3. Mapping Identifiers (The `select` Method)
To map between Entrez Gene IDs and MeSH terms:

```r
# Example: Map specific Entrez IDs to MeSH IDs and Categories
my_genes <- c("814629", "814630")
res <- select(MeSH.Ath.eg.db, 
              keys = my_genes, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")
head(res)
```

## Database Metadata
You can inspect the underlying database connection and species information:

```r
species(MeSH.Ath.eg.db)
dbInfo(MeSH.Ath.eg.db)
dbfile(MeSH.Ath.eg.db)
```

## Usage Tips
- **MeSH Categories**: MeSH IDs are often categorized (e.g., Anatomy [A], Diseases [C]). Use the `MESHCATEGORY` column to filter results to specific areas of interest.
- **Integration**: This package is designed to work alongside `MeSHDbi`. For advanced enrichment analysis, consider using the `meshr` package.
- **Entrez IDs**: Ensure your input keys are character strings, as Entrez IDs in Bioconductor annotation packages are typically treated as characters.

## Reference documentation
- [MeSH.Ath.eg.db Reference Manual](./references/reference_manual.md)