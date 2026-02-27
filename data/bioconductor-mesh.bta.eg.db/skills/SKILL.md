---
name: bioconductor-mesh.bta.eg.db
description: This package provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Bos taurus. Use when user asks to map bovine Entrez Gene IDs to MeSH terms, perform functional annotation for cow genomic data, or query bovine gene-MeSH relationships within Bioconductor.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Bta.eg.db.html
---


# bioconductor-mesh.bta.eg.db

name: bioconductor-mesh.bta.eg.db
description: Provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Bos taurus (cow). Use this skill when performing functional annotation, gene enrichment analysis, or data retrieval involving bovine genomic data and MeSH terms within the Bioconductor ecosystem.

# bioconductor-mesh.bta.eg.db

## Overview
The `MeSH.Bta.eg.db` package is a specialized annotation database for *Bos taurus*. It facilitates the translation between Entrez Gene identifiers and MeSH IDs, allowing researchers to link bovine genes to standardized medical and biological concepts. It is built upon the `AnnotationDbi` and `MeSHDbi` frameworks, providing a consistent interface for genomic data querying.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Bta.eg.db")
library(MeSH.Bta.eg.db)
```

## Core Workflows

### Exploring the Database
Use the standard AnnotationDbi methods to understand the structure of the database:

```r
# View available columns (data types) to retrieve
columns(MeSH.Bta.eg.db)

# View available keytypes (fields that can be used as input)
keytypes(MeSH.Bta.eg.db)

# Inspect the first few keys of a specific type (e.g., MESHID)
head(keys(MeSH.Bta.eg.db, keytype="MESHID"))
```

### Data Retrieval
The `select` function is the primary tool for mapping identifiers.

```r
# Example: Mapping specific Entrez Gene IDs to MeSH IDs and Categories
gene_ids <- c("280717", "280718") # Example Bos taurus Entrez IDs
res <- select(MeSH.Bta.eg.db, 
              keys = gene_ids, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")
head(res)
```

### Database Metadata
To retrieve information about the database source and species:

```r
species(MeSH.Bta.eg.db)
dbInfo(MeSH.Bta.eg.db)
dbfile(MeSH.Bta.eg.db)
```

## Usage Tips
- **MeSH Categories**: MeSH IDs are often organized by categories (e.g., Anatomy [A], Diseases [C]). Use the `MESHCATEGORY` column to filter results to specific areas of biological interest.
- **Integration**: This package is typically used in conjunction with `MeSHDbi` for advanced MeSH-based enrichment analysis.
- **Key Matching**: Ensure that the `keytype` argument matches the format of your input `keys` (e.g., use "GENEID" for Entrez IDs).

## Reference documentation
- [MeSH.Bta.eg.db Reference Manual](./references/reference_manual.md)