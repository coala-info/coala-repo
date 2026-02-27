---
name: bioconductor-mesh.cbr.eg.db
description: This tool provides mapping between MeSH identifiers and Entrez Gene IDs for the organism Caenorhabditis briggsae. Use when user asks to map MeSH terms to gene identifiers, perform functional annotation, or conduct gene set enrichment analysis for C. briggsae.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Cbr.eg.db.html
---


# bioconductor-mesh.cbr.eg.db

name: bioconductor-mesh.cbr.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Caenorhabditis briggsae. Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological literature with genomic data for C. briggsae.

# bioconductor-mesh.cbr.eg.db

## Overview

The `MeSH.Cbr.eg.db` package is a Bioconductor annotation resource that facilitates the correspondence between MeSH terms and Entrez Gene identifiers specifically for the organism *Caenorhabditis briggsae*. It is built upon the `AnnotationDbi` and `MeSHDbi` frameworks, allowing users to query biological metadata using a standard set of accessor methods.

## Usage and Workflow

### Loading the Package
To begin using the annotation data, load the library in your R session:

```r
library(MeSH.Cbr.eg.db)
# Display object information
MeSH.Cbr.eg.db
```

### Exploring the Database Structure
Before querying, identify what types of data (keys) you have and what information (columns) you can retrieve.

```r
# List available column types (e.g., MESHID, GENEID)
cls <- columns(MeSH.Cbr.eg.db)

# List available key types
kts <- keytypes(MeSH.Cbr.eg.db)

# Retrieve a sample of keys for a specific keytype
ks <- head(keys(MeSH.Cbr.eg.db, keytype = "MESHID"))
```

### Querying Data
Use the `select` function to map identifiers. This is the primary method for converting between MeSH IDs and Entrez Gene IDs.

```r
# Map specific MeSH IDs to all available columns
res <- select(MeSH.Cbr.eg.db, 
              keys = ks, 
              columns = cls, 
              keytype = "MESHID")

# View results
head(res)
```

### Database Metadata
You can extract administrative and structural information about the underlying SQLite database:

```r
species(MeSH.Cbr.eg.db)  # Confirm organism (Caenorhabditis briggsae)
dbInfo(MeSH.Cbr.eg.db)   # Metadata about the database version and source
dbfile(MeSH.Cbr.eg.db)   # Path to the local SQLite file
dbschema(MeSH.Cbr.eg.db) # Internal table schema
```

## Tips for Success
- **Standard Accessors**: Since this package follows `AnnotationDbi` standards, it integrates seamlessly with other Bioconductor tools like `clusterProfiler` or `meshr` for enrichment analysis.
- **Keytype Consistency**: Always ensure the `keytype` argument in `select()` matches the format of the `keys` vector provided.
- **MeSH Hierarchy**: This package provides the mapping; for navigating the MeSH tree structure itself, consider using the `MeSH.db` general purpose package.

## Reference documentation
- [MeSH.Cbr.eg.db Reference Manual](./references/reference_manual.md)