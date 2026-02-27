---
name: bioconductor-mesh.dya.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for the species Daphnia galeata. Use when user asks to perform functional annotation, conduct gene set enrichment analysis, or map genomic data to Medical Subject Headings for Daphnia galeata.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Dya.eg.db.html
---


# bioconductor-mesh.dya.eg.db

name: bioconductor-mesh.dya.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for the species Daphnia galeata (Dya). Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological literature with genomic data for Daphnia.

# bioconductor-mesh.dya.eg.db

## Overview

`MeSH.Dya.eg.db` is a Bioconductor annotation package that serves as a specialized interface for mapping between Medical Subject Headings (MeSH) and Entrez Gene identifiers for *Daphnia galeata*. It is built upon the `AnnotationDbi` framework, allowing users to query biological metadata using a standard set of accessor methods.

## Basic Usage

To use this package, you must first load the library. The main object is named the same as the package.

```r
library(MeSH.Dya.eg.db)

# Display object information
MeSH.Dya.eg.db
```

### Exploring the Database

Use the standard `AnnotationDbi` methods to discover what data is available:

```r
# List available column types (e.g., MESHID, GENEID)
cls <- columns(MeSH.Dya.eg.db)

# List available keytypes that can be used for querying
kts <- keytypes(MeSH.Dya.eg.db)

# Retrieve keys of a specific type (e.g., the first 6 Entrez IDs)
ks <- head(keys(MeSH.Dya.eg.db, keytype = "GENEID"))
```

### Querying Data

The `select` function is the primary way to retrieve mappings:

```r
# Map Entrez Gene IDs to MeSH IDs
res <- select(MeSH.Dya.eg.db, 
              keys = ks, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = "GENEID")

# View results
head(res)
```

## Database Metadata

You can extract administrative and species-specific information using the following utility functions:

- `species(MeSH.Dya.eg.db)`: Confirms the target organism (*Daphnia galeata*).
- `dbInfo(MeSH.Dya.eg.db)`: Provides metadata about the database source and build version.
- `dbfile(MeSH.Dya.eg.db)`: Returns the path to the underlying SQLite database file.
- `dbschema(MeSH.Dya.eg.db)`: Displays the database schema.

## Workflow Integration

1.  **Gene Set Enrichment**: Use the mappings to group *Daphnia* genes by MeSH terms for over-representation analysis.
2.  **Literature Linking**: Convert Entrez Gene IDs from experimental results into MeSH terms to facilitate searching PubMed for related biological concepts.
3.  **Cross-Species Comparison**: Use MeSH IDs as a universal vocabulary to compare functional annotations across different organisms supported by other `MeSH.XXX.eg.db` packages.

## Reference documentation

- [MeSH.Dya.eg.db Reference Manual](./references/reference_manual.md)