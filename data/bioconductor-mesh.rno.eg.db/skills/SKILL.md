---
name: bioconductor-mesh.rno.eg.db
description: This package provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Rattus norvegicus. Use when user asks to map MeSH terms to rat gene identifiers, perform functional annotation for rat genomic data, or query the MeSH.Rno.eg.db database.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Rno.eg.db.html
---

# bioconductor-mesh.rno.eg.db

name: bioconductor-mesh.rno.eg.db
description: Provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Rattus norvegicus (Rat). Use this skill when performing functional annotation, gene set enrichment analysis, or data retrieval involving Rat genomic data and MeSH terms using the Bioconductor MeSH.Rno.eg.db package.

## Overview

The `MeSH.Rno.eg.db` package is an annotation database for *Rattus norvegicus*. It serves as a bridge between MeSH (Medical Subject Headings) terms and Entrez Gene identifiers. It is built upon the `AnnotationDbi` and `MeSHDbi` frameworks, allowing users to query biological metadata using a standardized interface.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Rno.eg.db")
library(MeSH.Rno.eg.db)
```

## Core Workflows

The package follows the standard `AnnotationDbi` interface using four main methods: `columns`, `keytypes`, `keys`, and `select`.

### 1. Exploring the Database
Before querying, identify what types of data (keys) you have and what information (columns) you can retrieve.

```R
# View available columns to retrieve
columns(MeSH.Rno.eg.db)

# View available keytypes to search by (e.g., "MESHID", "GENEID")
keytypes(MeSH.Rno.eg.db)
```

### 2. Retrieving Keys
To see the identifiers present in the database for a specific keytype:

```R
# Get the first 6 Entrez Gene IDs
head(keys(MeSH.Rno.eg.db, keytype="GENEID"))

# Get the first 6 MeSH IDs
head(keys(MeSH.Rno.eg.db, keytype="MESHID"))
```

### 3. Mapping Identifiers (The `select` Method)
Use `select` to map between MeSH IDs and Gene IDs.

```R
# Example: Map specific MeSH IDs to Entrez Gene IDs
my_keys <- c("D000001", "D000002")
res <- select(MeSH.Rno.eg.db, 
              keys = my_keys, 
              columns = c("GENEID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "MESHID")
head(res)
```

## Database Metadata
To inspect the underlying database structure and metadata:

```R
species(MeSH.Rno.eg.db)  # Confirm species (Rattus norvegicus)
dbInfo(MeSH.Rno.eg.db)   # Database metadata and source information
dbfile(MeSH.Rno.eg.db)   # Path to the SQLite database file
dbschema(MeSH.Rno.eg.db) # Database schema structure
```

## Usage Tips
- **MeSHDbi Dependency**: This package relies on `MeSHDbi`. For advanced queries or understanding the MeSH hierarchy (Categories like 'A' for Anatomy, 'C' for Diseases), refer to `MeSHDbi` documentation.
- **Entrez IDs**: The `GENEID` column refers to NCBI Entrez Gene identifiers.
- **Data Sources**: The mappings are typically derived from sources like PubMed, GeneRIF, and GOSlim; use `dbInfo()` to check the specific versions used in your installed instance.

## Reference documentation
- [MeSH.Rno.eg.db Reference Manual](./references/reference_manual.md)