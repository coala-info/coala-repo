---
name: bioconductor-mesh.oan.eg.db
description: This package provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for the platypus. Use when user asks to map platypus genes to MeSH terms, perform functional annotation, or conduct gene set enrichment analysis for Ornithorhynchus anatinus.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Oan.eg.db.html
---


# bioconductor-mesh.oan.eg.db

name: bioconductor-mesh.oan.eg.db
description: Provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Ornithorhynchus anatinus (Platypus). Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological literature with genomic data for platypus.

# bioconductor-mesh.oan.eg.db

## Overview
The `MeSH.Oan.eg.db` package is a Bioconductor annotation database that facilitates the correspondence between MeSH terms and Entrez Gene IDs specifically for *Ornithorhynchus anatinus* (Platypus). It is built upon the `MeSHDbi` framework, allowing users to query biological concepts and their associated genes using standard AnnotationDbi methods.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Oan.eg.db")
library(MeSH.Oan.eg.db)
```

## Core Workflows

### Exploring the Database
Users can inspect the available data types and keys within the database using the standard four accessor methods:

```r
# List available columns (data types)
columns(MeSH.Oan.eg.db)

# List available keytypes (searchable fields)
keytypes(MeSH.Oan.eg.db)

# Retrieve a sample of keys for a specific keytype
head(keys(MeSH.Oan.eg.db, keytype = "MESHID"))
```

### Querying Data
The `select` function is used to retrieve specific mappings.

```r
# Example: Mapping Entrez Gene IDs to MeSH IDs
my_genes <- head(keys(MeSH.Oan.eg.db, keytype = "GENEID"))
res <- select(MeSH.Oan.eg.db, 
              keys = my_genes, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")
head(res)
```

### Database Metadata
To extract information about the database version, species, or underlying file structure:

```r
species(MeSH.Oan.eg.db)
dbInfo(MeSH.Oan.eg.db)
dbfile(MeSH.Oan.eg.db)
```

## Usage Tips
- **MeSH Categories**: MeSH IDs are often categorized (e.g., Anatomy, Diseases, Chemicals and Drugs). Use the `MESHCATEGORY` column to filter results to specific areas of interest.
- **Integration**: This package is most effective when used in conjunction with `MeSHDbi` for advanced MeSH-based enrichment analysis.
- **Key Selection**: Always verify the `keytype` matches the format of your input vector to avoid empty returns.

## Reference documentation
- [MeSH.Oan.eg.db Reference Manual](./references/reference_manual.md)