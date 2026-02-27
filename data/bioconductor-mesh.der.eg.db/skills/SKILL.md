---
name: bioconductor-mesh.der.eg.db
description: This package provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Danio rerio. Use when user asks to perform functional annotation, conduct gene enrichment analysis, or map Zebrafish gene identifiers to MeSH terms.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Der.eg.db.html
---


# bioconductor-mesh.der.eg.db

name: bioconductor-mesh.der.eg.db
description: Provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Danio rerio (Zebrafish). Use this skill when performing functional annotation, gene enrichment analysis, or cross-referencing biological literature with genomic data for Zebrafish.

# bioconductor-mesh.der.eg.db

## Overview
The `MeSH.Der.eg.db` package is a Bioconductor annotation resource specifically designed for *Danio rerio* (Zebrafish). It facilitates the correspondence between MeSH terms—a hierarchical controlled vocabulary used for indexing biomedical information—and Entrez Gene identifiers. This package is built upon the `MeSHDbi` framework, allowing users to query biological relationships using standard AnnotationDbi methods.

## Core Workflows

### Loading the Package
To begin using the annotation data, load the library in your R session:

```r
library(MeSH.Der.eg.db)
# Display basic information about the database object
MeSH.Der.eg.db
```

### Exploring the Database Structure
Before querying, identify what types of data (keys) you have and what information (columns) you can retrieve.

```r
# List available data types (e.g., MESHID, GENEID)
keytypes(MeSH.Der.eg.db)

# List columns that can be returned in a query
columns(MeSH.Der.eg.db)
```

### Querying Annotations
Use the `select` function to map between identifiers. This is the primary method for retrieving data.

```r
# Define the keys you want to look up (e.g., specific Entrez IDs)
my_keys <- c("30037", "30038", "30039")

# Retrieve MeSH IDs associated with these Entrez Gene IDs
results <- select(MeSH.Der.eg.db, 
                  keys = my_keys, 
                  columns = c("MESHID", "MESHCATEGORY"), 
                  keytype = "GENEID")

# View the first few rows of the result
head(results)
```

### Database Metadata and Inspection
You can inspect the underlying database connection and species information using these utility functions:

```r
species(MeSH.Der.eg.db)    # Confirm species (Danio rerio)
dbconn(MeSH.Der.eg.db)     # Get the underlying SQLite connection
dbfile(MeSH.Der.eg.db)     # Get the path to the DB file
dbschema(MeSH.Der.eg.db)   # View the database schema
```

## Usage Tips
- **Key Selection**: If you are unsure of the available keys, use `head(keys(MeSH.Der.eg.db, keytype="GENEID"))` to see examples.
- **MeSHDbi Integration**: This package is a data-only package. For advanced MeSH-based enrichment analysis or functional analysis, use this package in conjunction with the `meshr` or `MeSHDbi` packages.
- **One-to-Many Mappings**: Note that one Gene ID may map to multiple MeSH IDs depending on the biological contexts and literature indexed.

## Reference documentation
- [MeSH.Der.eg.db Reference Manual](./references/reference_manual.md)