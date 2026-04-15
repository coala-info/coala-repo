---
name: bioconductor-mesh.eqc.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for Equus caballus. Use when user asks to map horse gene identifiers to medical subject headings, perform functional annotation for horse genomic data, or query biological metadata for Equus caballus.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Eqc.eg.db.html
---

# bioconductor-mesh.eqc.eg.db

name: bioconductor-mesh.eqc.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Equus caballus (horse). Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological literature with genomic data for horse samples using Bioconductor.

# bioconductor-mesh.eqc.eg.db

## Overview

The `MeSH.Eqc.eg.db` package is a specialized annotation database for *Equus caballus* (horse). It facilitates the translation between Medical Subject Headings (MeSH) and Entrez Gene identifiers. This package is built upon the `AnnotationDbi` infrastructure, allowing users to query biological metadata using a standardized interface.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Eqc.eg.db")
library(MeSH.Eqc.eg.db)
```

## Core Workflows

The package follows the standard `AnnotationDbi` interface using four main methods: `columns()`, `keytypes()`, `keys()`, and `select()`.

### 1. Exploring the Database
Before querying, identify what types of data are available:

```r
# View available column types (data you can retrieve)
columns(MeSH.Eqc.eg.db)

# View available key types (data you can use as input for searching)
keytypes(MeSH.Eqc.eg.db)
```

### 2. Retrieving Identifiers
To see the specific IDs (keys) stored in the database:

```r
# Get the first 6 Entrez Gene IDs
head(keys(MeSH.Eqc.eg.db, keytype = "GENEID"))

# Get the first 6 MeSH IDs
head(keys(MeSH.Eqc.eg.db, keytype = "MESHID"))
```

### 3. Mapping Between MeSH and Entrez
The `select()` function is used to perform the actual mapping:

```r
# Example: Map specific Entrez Gene IDs to MeSH terms
my_genes <- c("100033834", "100033835") # Example Horse Entrez IDs
res <- select(MeSH.Eqc.eg.db, 
              keys = my_genes, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = "GENEID")
head(res)
```

## Database Metadata
You can retrieve information about the database source and species:

```r
species(MeSH.Eqc.eg.db)  # Should return "Equus caballus"
dbInfo(MeSH.Eqc.eg.db)   # Display metadata about the database
dbfile(MeSH.Eqc.eg.db)   # Path to the SQLite file
```

## Usage Tips
- **MeSH Categories**: MeSH IDs are often categorized (e.g., Diseases, Chemicals and Drugs). Use the `MESHCATEGORY` column to filter results to specific areas of interest.
- **Integration**: This package is designed to work seamlessly with `MeSHDbi`. For advanced analysis or enrichment, refer to the `MeSHDbi` vignette.
- **Entrez IDs**: Ensure that your input gene IDs are character strings, as Entrez IDs are treated as keys in this database.

## Reference documentation
- [MeSH.Eqc.eg.db Reference Manual](./references/reference_manual.md)