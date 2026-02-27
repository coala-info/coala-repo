---
name: bioconductor-mesh.dre.eg.db
description: This package provides mappings between MeSH identifiers and Entrez Gene IDs for Danio rerio. Use when user asks to map zebrafish gene IDs to medical subject headings, perform MeSH-based functional annotation, or conduct gene set enrichment analysis for zebrafish.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Dre.eg.db.html
---


# bioconductor-mesh.dre.eg.db

name: bioconductor-mesh.dre.eg.db
description: Mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Danio rerio (Zebrafish). Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biomedical literature terms with zebrafish genetic data using the MeSH.Dre.eg.db Bioconductor package.

## Overview

The `MeSH.Dre.eg.db` package is an annotation database that provides the correspondence between MeSH IDs and Entrez Gene IDs specifically for *Danio rerio* (Zebrafish). It is built upon the `MeSHDbi` infrastructure, allowing users to query biological metadata using standard AnnotationDbi methods.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Dre.eg.db")
library(MeSH.Dre.eg.db)
```

## Core Workflows

The package follows the standard `AnnotationDbi` interface using four main methods: `columns()`, `keytypes()`, `keys()`, and `select()`.

### 1. Exploring the Database Structure
Before querying, identify what types of data (keytypes) are available and what information (columns) can be retrieved.

```r
# List available columns (data types to retrieve)
columns(MeSH.Dre.eg.db)

# List available keytypes (fields that can be used as input keys)
keytypes(MeSH.Dre.eg.db)
```

### 2. Retrieving Keys
To see the identifiers present in the database for a specific keytype:

```r
# Get the first 6 Entrez Gene IDs
head(keys(MeSH.Dre.eg.db, keytype = "GENEID"))

# Get the first 6 MeSH IDs
head(keys(MeSH.Dre.eg.db, keytype = "MESHID"))
```

### 3. Performing Queries
Use the `select()` function to map between identifiers.

```r
# Example: Map specific Entrez Gene IDs to MeSH IDs and Categories
my_genes <- c("30037", "30038", "30039")
res <- select(MeSH.Dre.eg.db, 
              keys = my_genes, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")
head(res)
```

## Database Metadata
To inspect the underlying database properties and species information:

```r
species(MeSH.Dre.eg.db)  # Confirm species is Danio rerio
dbInfo(MeSH.Dre.eg.db)   # Get database metadata
dbfile(MeSH.Dre.eg.db)   # Locate the SQLite database file
dbschema(MeSH.Dre.eg.db) # View the database schema
```

## Usage Tips
- **MeSH Categories**: MeSH IDs are often grouped into categories (e.g., D for Drugs and Chemicals, G for Biological Sciences). Use the `MESHCATEGORY` column to filter results by specific biological domains.
- **Integration**: This package is typically used in conjunction with `MeSHDbi` and enrichment analysis tools like `meshr` to perform MeSH-based hyper-geometric tests or GSEA.
- **Entrez IDs**: Ensure your input gene identifiers are Entrez IDs (numeric strings) rather than Gene Symbols or Ensembl IDs when using `keytype = "GENEID"`.

## Reference documentation
- [MeSH.Dre.eg.db Reference Manual](./references/reference_manual.md)