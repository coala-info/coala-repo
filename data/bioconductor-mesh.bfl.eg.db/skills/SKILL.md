---
name: bioconductor-mesh.bfl.eg.db
description: This package provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for the species Bos floridae. Use when user asks to map identifiers, perform functional annotation, or conduct gene set enrichment analysis for this specific organism.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Bfl.eg.db.html
---

# bioconductor-mesh.bfl.eg.db

name: bioconductor-mesh.bfl.eg.db
description: Provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for the species Bos floridae (Lancelet). Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological literature with genomic data for this specific organism using Bioconductor.

## Overview

The `MeSH.Bfl.eg.db` package is a specialized annotation database within the Bioconductor ecosystem. It facilitates the translation between MeSH terms (used for indexing biological literature) and Entrez Gene identifiers for *Bos floridae*. It follows the standard `AnnotationDbi` interface, allowing users to query the database using a consistent set of methods.

## Core Workflows

### Loading the Database
To begin using the annotation data, load the library:

```r
library(MeSH.Bfl.eg.db)
# View basic metadata and species information
MeSH.Bfl.eg.db
species(MeSH.Bfl.eg.db)
```

### Exploring the Database Structure
Before querying, identify what types of data (keys) are available and what information (columns) can be retrieved:

```r
# List available data types (e.g., MESHID, GENEID)
keytypes(MeSH.Bfl.eg.db)

# List columns that can be returned in a query
columns(MeSH.Bfl.eg.db)
```

### Querying Data
Use the `select` function to map identifiers. This is the primary method for retrieving annotations.

```r
# 1. Get a sample of keys to work with
pk <- head(keys(MeSH.Bfl.eg.db, keytype="GENEID"))

# 2. Map Entrez Gene IDs to MeSH IDs
res <- select(MeSH.Bfl.eg.db, 
              keys = pk, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = "GENEID")

# View results
head(res)
```

### Database Metadata and Inspection
For reproducibility and debugging, you can inspect the underlying database connection and schema:

```r
dbconn(MeSH.Bfl.eg.db)   # Get the DBI connection object
dbfile(MeSH.Bfl.eg.db)   # Get the path to the SQLite file
dbschema(MeSH.Bfl.eg.db) # View the database schema
dbInfo(MeSH.Bfl.eg.db)   # View package metadata
```

## Usage Tips
- **Key Selection**: Always verify the `keytype` matches the format of your input vector (e.g., use "MESHID" if you are starting with MeSH terms).
- **MeSH Categories**: MeSH terms are organized into categories (e.g., Anatomy, Diseases, Chemicals and Drugs). Use the `MESHCATEGORY` column to filter results to specific areas of interest.
- **Integration**: This package is often used in conjunction with `MeSHDbi` and enrichment analysis tools like `meshr`.

## Reference documentation
- [MeSH.Bfl.eg.db Reference Manual](./references/reference_manual.md)