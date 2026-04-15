---
name: bioconductor-mesh.xtr.eg.db
description: This package provides mappings between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for *Xenopus tropicalis*. Use when user asks to map gene identifiers to MeSH terms, perform functional annotation, or conduct gene set enrichment analysis for the Western clawed frog.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Xtr.eg.db.html
---

# bioconductor-mesh.xtr.eg.db

name: bioconductor-mesh.xtr.eg.db
description: Provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Xenopus tropicalis (Western clawed frog). Use this skill when performing functional annotation, gene set enrichment analysis, or translating between MeSH terms and NCBI gene identifiers in R.

# bioconductor-mesh.xtr.eg.db

## Overview
The `MeSH.Xtr.eg.db` package is a Bioconductor annotation data package for *Xenopus tropicalis*. It serves as a bridge between the MeSH (Medical Subject Headings) classification system and Entrez Gene identifiers. It is built upon the `MeSHDbi` framework, allowing users to query biological context and functional classifications associated with specific genes.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Xtr.eg.db")
```

## Core Workflow
The package follows the standard `AnnotationDbi` interface. You can interact with the database object `MeSH.Xtr.eg.db` using four main methods: `columns()`, `keytypes()`, `keys()`, and `select()`.

### 1. Exploring the Database
Check what types of data and identifiers are available:

```r
library(MeSH.Xtr.eg.db)

# View available column types (data you can retrieve)
columns(MeSH.Xtr.eg.db)

# View available keytypes (identifiers you can search by)
keytypes(MeSH.Xtr.eg.db)

# Get the species name
species(MeSH.Xtr.eg.db)
```

### 2. Retrieving Keys
To see the identifiers present in the database:

```r
# Get the first 6 Entrez Gene IDs
gene_keys <- head(keys(MeSH.Xtr.eg.db, keytype="GENEID"))

# Get the first 6 MeSH IDs
mesh_keys <- head(keys(MeSH.Xtr.eg.db, keytype="MESHID"))
```

### 3. Mapping Identifiers (select)
Use `select` to perform the actual mapping between MeSH terms and Gene IDs:

```r
# Map specific Entrez Gene IDs to MeSH terms and categories
res <- select(MeSH.Xtr.eg.db, 
              keys = c("100485824", "100491195"), 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")

# View results
head(res)
```

## Database Metadata
You can inspect the underlying database structure and metadata using these utility functions:

- `dbconn(MeSH.Xtr.eg.db)`: Returns the SQLite connection object.
- `dbfile(MeSH.Xtr.eg.db)`: Returns the path to the SQLite database file.
- `dbschema(MeSH.Xtr.eg.db)`: Displays the database schema.
- `dbInfo(MeSH.Xtr.eg.db)`: Provides general information about the database version and creation.

## Usage Tips
- **MeSH Categories**: MeSH IDs are often grouped into categories (e.g., D for Drugs and Chemicals, C for Diseases). Use the `MESHCATEGORY` column to filter results for specific biological contexts.
- **Integration**: This package is most effective when used in conjunction with `MeSHDbi` for advanced querying or `meshr` for enrichment analysis.
- **Entrez IDs**: Ensure your input gene list consists of Entrez Gene IDs (integers/character strings of numbers) when using `keytype="GENEID"`.

## Reference documentation
- [MeSH.Xtr.eg.db Reference Manual](./references/reference_manual.md)