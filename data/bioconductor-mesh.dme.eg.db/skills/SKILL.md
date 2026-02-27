---
name: bioconductor-mesh.dme.eg.db
description: This package provides mappings between Entrez Gene IDs and Medical Subject Headings for Drosophila melanogaster. Use when user asks to map fruit fly genes to MeSH identifiers, perform functional annotation, or query biological context for Drosophila genes.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Dme.eg.db.html
---


# bioconductor-mesh.dme.eg.db

name: bioconductor-mesh.dme.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Drosophila melanogaster (fruit fly). Use this skill when performing functional annotation, gene set enrichment analysis, or retrieving MeSH terms associated with fruit fly genes using the MeSH.Dme.eg.db Bioconductor package.

# bioconductor-mesh.dme.eg.db

## Overview

`MeSH.Dme.eg.db` is a specialized annotation package for *Drosophila melanogaster*. It serves as a bridge between the Entrez Gene database and the Medical Subject Headings (MeSH) hierarchy. This package is built upon the `MeSHDbi` framework, allowing users to query biological context and disease/topic associations for fruit fly genes using standard AnnotationDbi methods.

## Installation

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Dme.eg.db")
```

## Basic Usage

The package uses the standard four accessor methods common to Bioconductor annotation objects: `columns()`, `keytypes()`, `keys()`, and `select()`.

### Exploring the Database

Before querying, identify what data types are available:

```r
library(MeSH.Dme.eg.db)

# List available columns (data types to retrieve)
columns(MeSH.Dme.eg.db)

# List available keytypes (types of IDs you can use as input)
keytypes(MeSH.Dme.eg.db)

# Get the species name
species(MeSH.Dme.eg.db)
```

### Querying Data

To map Entrez Gene IDs to MeSH IDs and categories:

```r
# 1. Define your keys (e.g., Entrez Gene IDs)
my_keys <- c("30970", "30971", "30972")

# 2. Perform the selection
# Common columns include MESHID, MESHCATEGORY, and GENEID
res <- select(MeSH.Dme.eg.db, 
              keys = my_keys, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = "GENEID")

# View results
head(res)
```

### Database Metadata

To inspect the underlying database structure and information:

```r
dbconn(MeSH.Dme.eg.db)   # Get the SQLite connection
dbfile(MeSH.Dme.eg.db)   # Get the database file path
dbschema(MeSH.Dme.eg.db) # View the database schema
dbInfo(MeSH.Dme.eg.db)   # View package metadata
```

## Workflow Tips

1.  **Integration with MeSHDbi**: This package is often used in conjunction with the `MeSHDbi` package for more complex enrichment analyses.
2.  **Key Selection**: Ensure your input keys match the `keytype` specified. For this package, `GENEID` typically refers to Entrez Gene IDs.
3.  **Many-to-Many Mappings**: One Gene ID may map to multiple MeSH IDs across different categories (e.g., Anatomy, Diseases, Chemicals and Drugs). Always check the `MESHCATEGORY` column to filter results to your specific area of interest.

## Reference documentation

- [MeSH.Dme.eg.db Reference Manual](./references/reference_manual.md)