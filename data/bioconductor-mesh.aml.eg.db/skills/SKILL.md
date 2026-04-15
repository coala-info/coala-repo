---
name: bioconductor-mesh.aml.eg.db
description: This package provides mappings between MeSH identifiers and Entrez Gene IDs specifically for Amiel Syndrome. Use when user asks to map MeSH terms to gene identifiers, perform functional annotation for Amiel Syndrome, or conduct gene set enrichment analysis using Bioconductor.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Aml.eg.db.html
---

# bioconductor-mesh.aml.eg.db

name: bioconductor-mesh.aml.eg.db
description: Mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Amiel Syndrome (Aml). Use this skill when performing functional annotation, gene set enrichment analysis, or looking up biological context for genes associated with Amiel Syndrome using Bioconductor.

## Overview

The `MeSH.Aml.eg.db` package is a specialized annotation database within the Bioconductor ecosystem. It provides the correspondence between MeSH terms and Entrez Gene IDs specifically curated for Amiel Syndrome. It follows the standard `AnnotationDbi` interface, allowing users to query the database using a consistent set of methods: `columns()`, `keytypes()`, `keys()`, and `select()`.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Aml.eg.db")
library(MeSH.Aml.eg.db)
```

## Core Workflows

### Exploring the Database Structure
Before querying, identify what types of data (keytypes) are available and what information (columns) can be retrieved.

```r
# List available columns (data types to retrieve)
columns(MeSH.Aml.eg.db)

# List available keytypes (fields that can be used as query inputs)
keytypes(MeSH.Aml.eg.db)
```

### Querying Data
Use the `select` function to map between identifiers.

```r
# 1. Get a sample of keys (e.g., Entrez Gene IDs)
kts <- keytypes(MeSH.Aml.eg.db)
kt <- "GENEID" # Example keytype
ks <- head(keys(MeSH.Aml.eg.db, keytype=kt))

# 2. Perform the mapping
# This retrieves MeSH IDs and other associated data for the given Gene IDs
res <- select(MeSH.Aml.eg.db, 
              keys = ks, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = kt)

# View results
head(res)
```

### Database Metadata
You can inspect the underlying database properties using these utility functions:

```r
species(MeSH.Aml.eg.db)   # Check the target species
dbInfo(MeSH.Aml.eg.db)    # Display database metadata
dbfile(MeSH.Aml.eg.db)    # Get the path to the SQLite file
dbschema(MeSH.Aml.eg.db)  # View the database schema
```

## Usage Tips
- **MeSH Categories**: When selecting columns, including `MESHCATEGORY` helps filter results by specific MeSH branches (e.g., Diseases, Chemicals and Drugs).
- **Integration**: This package is often used in conjunction with `MeSHDbi` for more complex MeSH-based enrichment analyses.
- **Standard Interface**: Because it implements the `AnnotationDbi` interface, it can be used in workflows that accept `OrgDb` or `ChipDb` objects, provided the keytypes match.

## Reference documentation

- [MeSH.Aml.eg.db Reference Manual](./references/reference_manual.md)