---
name: bioconductor-mesh.pab.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for the organism Picea abietina. Use when user asks to map gene identifiers to medical subject headings, perform functional annotation, or conduct gene set enrichment analysis for this species.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Pab.eg.db.html
---

# bioconductor-mesh.pab.eg.db

name: bioconductor-mesh.pab.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for the organism P. abietina (Pab). Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological literature with genomic data for this specific species using Bioconductor.

# bioconductor-mesh.pab.eg.db

## Overview

The `MeSH.Pab.eg.db` package is a specialized Bioconductor annotation data package. It serves as a bridge between the Medical Subject Headings (MeSH) controlled vocabulary and Entrez Gene identifiers for *Picea abietina* (or related species identified by the 'Pab' prefix). It implements the standard `AnnotationDbi` interface, allowing users to query biological metadata using a consistent set of methods.

## Core Workflows

### Loading the Package
To begin using the annotation data, load the library in your R session:

```r
library(MeSH.Pab.eg.db)
# Display basic information about the database object
MeSH.Pab.eg.db
```

### Exploring the Database Structure
Before querying, identify what types of data (keys) are available and what information (columns) can be retrieved.

```r
# List available data types (e.g., MESHID, GENEID)
keytypes(MeSH.Pab.eg.db)

# List columns that can be returned in a query
columns(MeSH.Pab.eg.db)
```

### Querying Data
Use the `select` function to map between identifiers. This is the primary method for retrieving annotations.

```r
# 1. Define the keys you want to look up
my_keys <- head(keys(MeSH.Pab.eg.db, keytype="MESHID"))

# 2. Perform the mapping
results <- select(MeSH.Pab.eg.db, 
                  keys = my_keys, 
                  columns = c("MESHID", "GENEID"), 
                  keytype = "MESHID")

# View results
head(results)
```

### Database Metadata
You can extract specific metadata about the underlying SQLite database and the species:

```r
species(MeSH.Pab.eg.db)  # Confirm the target organism
dbInfo(MeSH.Pab.eg.db)   # Get database metadata
dbfile(MeSH.Pab.eg.db)   # Locate the SQLite file on disk
```

## Usage Tips
- **Keytype Consistency**: Ensure the `keytype` argument in `select()` matches the format of the `keys` provided.
- **MeSH Hierarchy**: This package provides the direct mapping; for hierarchical traversal of MeSH terms (e.g., finding parent/child terms), use the `MeSHDbi` or `MeSH.db` packages in conjunction with this one.
- **Vectorized Queries**: The `keys` argument accepts vectors, making it efficient to translate entire gene lists from differential expression experiments into MeSH categories.

## Reference documentation
- [MeSH.Pab.eg.db Reference Manual](./references/reference_manual.md)