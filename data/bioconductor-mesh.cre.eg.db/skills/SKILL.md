---
name: bioconductor-mesh.cre.eg.db
description: This package provides mappings between MeSH identifiers and Entrez Gene IDs for Chlamydomonas reinhardtii. Use when user asks to map gene identifiers to medical subject headings, perform functional annotation, or conduct gene set enrichment analysis for this species.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Cre.eg.db.html
---


# bioconductor-mesh.cre.eg.db

name: bioconductor-mesh.cre.eg.db
description: Mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Chlamydomonas reinhardtii. Use this skill when performing functional annotation, gene set enrichment analysis, or biological data integration involving MeSH terms and Entrez Gene IDs for this specific species.

# bioconductor-mesh.cre.eg.db

## Overview

The `MeSH.Cre.eg.db` package is a Bioconductor annotation db-style package providing mappings between Medical Subject Headings (MeSH) and Entrez Gene identifiers for *Chlamydomonas reinhardtii*. It utilizes the standard `AnnotationDbi` interface, allowing users to query biological metadata using a consistent set of methods (`columns`, `keytypes`, `keys`, and `select`).

## Installation and Loading

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Cre.eg.db")
library(MeSH.Cre.eg.db)
```

## Core Workflows

### Exploring the Database Structure
Before querying, identify what data types are available:

```r
# View available column types (data to retrieve)
columns(MeSH.Cre.eg.db)

# View available key types (data to search by)
keytypes(MeSH.Cre.eg.db)
```

### Querying Data
Use the `select` function to map between identifiers.

```r
# Example: Map Entrez Gene IDs to MeSH IDs
# 1. Get some sample keys
pk_keys <- head(keys(MeSH.Cre.eg.db, keytype="GENEID"))

# 2. Perform the mapping
mapping <- select(MeSH.Cre.eg.db, 
                  keys = pk_keys, 
                  columns = c("MESHID", "MESHCATEGORY"), 
                  keytype = "GENEID")
head(mapping)
```

### Database Metadata
Access administrative and versioning information about the underlying SQLite database:

```r
# Get species name
species(MeSH.Cre.eg.db)

# Get database metadata/info
dbInfo(MeSH.Cre.eg.db)

# Get the underlying SQLite connection or file path
dbconn(MeSH.Cre.eg.db)
dbfile(MeSH.Cre.eg.db)
```

## Usage Tips
- **Key Selection**: Always verify the `keytype` matches the format of your input vector. Common keytypes include `GENEID` (Entrez) and `MESHID`.
- **MeSH Categories**: MeSH terms are organized into categories (e.g., Anatomy, Diseases, Chemicals and Drugs). Use the `MESHCATEGORY` column to filter results if the mapping returns too many broad terms.
- **Integration**: This package is often used in conjunction with `MeSHDbi` and enrichment analysis packages like `meshr`.

## Reference documentation
- [MeSH.Cre.eg.db Reference Manual](./references/reference_manual.md)