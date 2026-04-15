---
name: bioconductor-mesh.mmu.eg.db
description: This package maps Medical Subject Headings (MeSH) identifiers to Entrez Gene IDs for Mus musculus. Use when user asks to map mouse gene identifiers to MeSH terms, perform functional annotation, or conduct gene set enrichment analysis.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Mmu.eg.db.html
---

# bioconductor-mesh.mmu.eg.db

name: bioconductor-mesh.mmu.eg.db
description: Provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Mus musculus (mouse). Use this skill when performing functional annotation, gene set enrichment analysis, or data integration involving mouse genomic data and MeSH terms.

# bioconductor-mesh.mmu.eg.db

## Overview

The `MeSH.Mmu.eg.db` package is a Bioconductor annotation resource that facilitates the translation between MeSH IDs and Entrez Gene IDs for mouse (*Mus musculus*). It is built upon the `MeSHDbi` framework, allowing users to query biological metadata using a standardized interface. This is particularly useful for researchers looking to categorize gene lists into clinical or hierarchical medical categories defined by the National Library of Medicine (NLM).

## Installation and Loading

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Mmu.eg.db")
library(MeSH.Mmu.eg.db)
```

## Core Workflows

The package follows the standard `AnnotationDbi` interface. You can interact with the database object `MeSH.Mmu.eg.db` using four main methods: `columns`, `keytypes`, `keys`, and `select`.

### 1. Exploring the Database
Before querying, identify what types of data are available.

```r
# List all available data types (columns)
columns(MeSH.Mmu.eg.db)

# List all possible types of keys you can use for searching
keytypes(MeSH.Mmu.eg.db)
```

### 2. Retrieving Keys
To see the actual identifiers stored in the database:

```r
# Get the first 6 Entrez Gene IDs
head(keys(MeSH.Mmu.eg.db, keytype="GENEID"))

# Get the first 6 MeSH IDs
head(keys(MeSH.Mmu.eg.db, keytype="MESHID"))
```

### 3. Mapping Identifiers (The `select` method)
This is the primary way to map between Entrez IDs and MeSH terms.

```r
# Example: Map specific Entrez IDs to MeSH IDs and Categories
my_genes <- c("11477", "11478", "11479")
res <- select(MeSH.Mmu.eg.db, 
              keys = my_genes, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")
head(res)
```

### 4. Database Metadata
To inspect the underlying database connection and species information:

```r
species(MeSH.Mmu.eg.db)
dbInfo(MeSH.Mmu.eg.db)
```

## Usage Tips
- **MeSH Categories**: The `MESHCATEGORY` column helps filter results by broad headings (e.g., Diseases, Chemicals and Drugs, Phenomena and Processes).
- **Integration**: This package is often used in conjunction with `meshr` for MeSH enrichment analysis.
- **Entrez IDs**: Ensure your input keys are character vectors, as Entrez IDs are treated as strings in this database.

## Reference documentation
- [MeSH.Mmu.eg.db Reference Manual](./references/reference_manual.md)