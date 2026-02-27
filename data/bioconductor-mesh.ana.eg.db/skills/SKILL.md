---
name: bioconductor-mesh.ana.eg.db
description: This package provides mappings between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for functional annotation and enrichment analysis. Use when user asks to map MeSH terms to gene identifiers, query biological relationships using the MeSH.Ana.eg.db database, or link clinical headings to genetic data.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Ana.eg.db.html
---


# bioconductor-mesh.ana.eg.db

name: bioconductor-mesh.ana.eg.db
description: Provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for functional annotation and enrichment analysis. Use this skill when performing bioinformatics workflows in R that require translating MeSH terms to gene identifiers or vice versa using the MeSH.Ana.eg.db annotation package.

# bioconductor-mesh.ana.eg.db

## Overview
The `MeSH.Ana.eg.db` package is a Bioconductor annotation resource that facilitates the correspondence between MeSH IDs and Entrez Gene IDs. It is built upon the `MeSHDbi` framework, allowing users to query biological relationships using standard AnnotationDbi methods. This is particularly useful for researchers looking to link clinical or thematic medical headings to specific genetic data.

## Installation and Loading
To use this package, ensure it is installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Ana.eg.db")
library(MeSH.Ana.eg.db)
```

## Core Workflows

### Exploring the Database
Use the standard AnnotationDbi interface to understand the available data types:

```r
# View available columns (data types you can retrieve)
columns(MeSH.Ana.eg.db)

# View available keytypes (data types you can search by)
keytypes(MeSH.Ana.eg.db)

# Get a sample of keys for a specific keytype
head(keys(MeSH.Ana.eg.db, keytype = "MESHID"))
```

### Mapping MeSH IDs to Entrez Gene IDs
The primary use case is retrieving mappings using the `select` function:

```r
# Define the keys you want to look up
my_keys <- c("D000001", "D000002") # Example MeSH IDs

# Perform the mapping
results <- select(MeSH.Ana.eg.db, 
                  keys = my_keys, 
                  columns = c("GENEID", "MESHID"), 
                  keytype = "MESHID")

# View results
head(results)
```

### Database Metadata
To inspect the underlying database structure or versioning information:

```r
# Get species information
species(MeSH.Ana.eg.db)

# Get database metadata
dbInfo(MeSH.Ana.eg.db)

# Get the underlying SQLite connection or file path
dbconn(MeSH.Ana.eg.db)
dbfile(MeSH.Ana.eg.db)
```

## Usage Tips
- **MeSHDbi Dependency**: This package relies on the `MeSHDbi` package for its functional methods. If you encounter issues with `select` or `columns`, ensure `MeSHDbi` is also loaded.
- **Entrez IDs**: Note that "GENEID" in this package refers specifically to Entrez Gene IDs.
- **Large Queries**: When querying a large number of keys, the `select` function is more efficient than looping through individual keys.

## Reference documentation
- [MeSH.Ana.eg.db Reference Manual](./references/reference_manual.md)