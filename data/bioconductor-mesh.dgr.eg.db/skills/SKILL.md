---
name: bioconductor-mesh.dgr.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for Drosophila melanogaster. Use when user asks to map MeSH terms to fruit fly gene identifiers, perform gene set enrichment analysis using MeSH categories, or query biological metadata for Drosophila genes.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Dgr.eg.db.html
---

# bioconductor-mesh.dgr.eg.db

name: bioconductor-mesh.dgr.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Drosophila melanogaster (Fruit fly). Use this skill when performing functional annotation, gene set enrichment analysis, or data retrieval involving MeSH terms and Drosophila gene identifiers within the Bioconductor ecosystem.

# bioconductor-mesh.dgr.eg.db

## Overview
The `MeSH.Dgr.eg.db` package is a specialized Bioconductor annotation object (MeSHDb) that facilitates the correspondence between MeSH identifiers and Entrez Gene IDs for *Drosophila melanogaster*. It follows the standard `AnnotationDbi` interface, allowing users to query biological metadata using a consistent set of accessor methods.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Dgr.eg.db")
library(MeSH.Dgr.eg.db)
```

## Core Workflows

### Exploring the Database Structure
Before querying, identify what types of data (keytypes) are available and what information (columns) can be retrieved.

```r
# View available columns (data types to retrieve)
columns(MeSH.Dgr.eg.db)

# View available keytypes (types of IDs you can use as input)
keytypes(MeSH.Dgr.eg.db)
```

### Querying Data
Use the `select` function to map between identifiers. Common keytypes include `MESHID` and `GENEID`.

```r
# 1. Get the first few keys for a specific keytype
ks <- head(keys(MeSH.Dgr.eg.db, keytype="MESHID"))

# 2. Map MeSH IDs to Entrez Gene IDs
res <- select(MeSH.Dgr.eg.db, 
              keys = ks, 
              columns = c("GENEID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "MESHID")

# View results
head(res)
```

### Database Metadata
To inspect the underlying database properties or species information:

```r
# Check the target species
species(MeSH.Dgr.eg.db)

# Database connection details
dbconn(MeSH.Dgr.eg.db)
dbfile(MeSH.Dgr.eg.db)

# Metadata information
dbInfo(MeSH.Dgr.eg.db)
```

## Usage Tips
- **MeSHDbi Integration**: This package is designed to work seamlessly with the `MeSHDbi` framework. For advanced enrichment analysis, consider using this package in conjunction with `meshr`.
- **Key Selection**: Always verify the `keytype` argument in `keys()` and `select()` to ensure it matches the format of your input vector.
- **Data Sources**: The mappings typically include sources like PubMed, GeneRIF, and GAD; use the `SOURCEID` column to distinguish between them.

## Reference documentation
- [MeSH.Dgr.eg.db Reference Manual](./references/reference_manual.md)