---
name: bioconductor-mesh.ssc.eg.db
description: This tool provides annotation mapping between MeSH identifiers and Entrez Gene IDs for Sus scrofa. Use when user asks to map pig gene IDs to medical subject headings, perform MeSH-based functional enrichment analysis, or cross-reference pig genomic data with biomedical literature.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Ssc.eg.db.html
---

# bioconductor-mesh.ssc.eg.db

name: bioconductor-mesh.ssc.eg.db
description: Provides annotation mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Sus scrofa (pig). Use this skill when performing functional enrichment analysis, gene set characterization, or cross-referencing biological literature with genomic data for pig models using Bioconductor.

## Overview

The `MeSH.Ssc.eg.db` package is a specialized AnnotationDbi-style data package for *Sus scrofa*. It facilitates the translation between Entrez Gene IDs and MeSH terms, which are used for indexing, cataloging, and searching of biomedical and health-related information. This package is essential for researchers working on pig genomics who wish to leverage the MeSH hierarchy for functional annotation.

## Basic Usage

The package follows the standard Bioconductor `AnnotationDbi` interface. You interact with the `MeSH.Ssc.eg.db` object using four main methods: `columns()`, `keytypes()`, `keys()`, and `select()`.

### Loading the Package
```r
library(MeSH.Ssc.eg.db)
# View object summary
MeSH.Ssc.eg.db
```

### Exploring the Database Structure
To understand what data can be retrieved and what identifiers can be used as inputs:

```r
# List available data types (columns)
columns(MeSH.Ssc.eg.db)

# List types of identifiers that can be used as keys
keytypes(MeSH.Ssc.eg.db)
```

### Retrieving Data
Use `select()` to map between identifiers.

```r
# Example: Get MeSH IDs for specific Entrez Gene IDs
# First, get some sample keys
pkgs_keys <- head(keys(MeSH.Ssc.eg.db, keytype="GENEID"))

# Perform the mapping
res <- select(MeSH.Ssc.eg.db, 
              keys = pkgs_keys, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")
head(res)
```

## Database Metadata
You can access underlying database information using these utility functions:

- `species(MeSH.Ssc.eg.db)`: Confirms the target organism (*Sus scrofa*).
- `dbInfo(MeSH.Ssc.eg.db)`: Displays metadata about the database version and source.
- `dbfile(MeSH.Ssc.eg.db)`: Shows the path to the SQLite database file.
- `dbschema(MeSH.Ssc.eg.db)`: Displays the database table schema.

## Workflow Integration
This package is typically used in conjunction with `MeSHDbi` and enrichment analysis tools (like `meshr`). A common workflow involves:
1. Identifying a list of differentially expressed genes (Entrez IDs).
2. Using `MeSH.Ssc.eg.db` to map these genes to MeSH terms.
3. Performing over-representation analysis to find enriched MeSH categories (e.g., Diseases, Chemicals and Drugs, Phenomena and Processes).

## Reference documentation
- [MeSH.Ssc.eg.db Reference Manual](./references/reference_manual.md)