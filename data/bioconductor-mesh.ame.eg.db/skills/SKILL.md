---
name: bioconductor-mesh.ame.eg.db
description: This Bioconductor package provides mappings between MeSH identifiers and Entrez Gene IDs for the honey bee species *Apis mellifera*. Use when user asks to map honey bee genes to medical subject headings, perform gene set enrichment analysis using MeSH terms, or cross-reference genomic data with biological literature.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Ame.eg.db.html
---


# bioconductor-mesh.ame.eg.db

name: bioconductor-mesh.ame.eg.db
description: Mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Apis mellifera (Honey bee). Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological literature with genomic data for honey bees in R.

## Overview

The `MeSH.Ame.eg.db` package is a Bioconductor annotation database that provides a direct correspondence between MeSH terms and Entrez Gene IDs for *Apis mellifera*. It is built upon the `MeSHDbi` framework, allowing users to query biological metadata using standard AnnotationDbi methods. This is particularly useful for researchers looking to link honey bee genes to specific medical or biological concepts defined in the MeSH hierarchy.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Ame.eg.db")
library(MeSH.Ame.eg.db)
```

## Core Workflows

The package follows the standard `AnnotationDbi` interface. You can explore and extract data using four main functions: `columns()`, `keytypes()`, `keys()`, and `select()`.

### 1. Discovering Available Data
Before querying, identify what types of identifiers (keys) and data types (columns) are available.

```R
# View available column types (data you can retrieve)
columns(MeSH.Ame.eg.db)

# View available key types (identifiers you can search by)
keytypes(MeSH.Ame.eg.db)
```

### 2. Retrieving Keys
To see the specific identifiers present in the database:

```R
# Get the first 6 Entrez Gene IDs
head(keys(MeSH.Ame.eg.db, keytype="GENEID"))

# Get the first 6 MeSH IDs
head(keys(MeSH.Ame.eg.db, keytype="MESHID"))
```

### 3. Mapping Identifiers (The `select` Method)
To map between Entrez Gene IDs and MeSH terms, use the `select` function.

```R
# Example: Map specific Entrez Gene IDs to MeSH IDs and Categories
my_genes <- c("406122", "406125")
res <- select(MeSH.Ame.eg.db, 
              keys = my_genes, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")
head(res)
```

## Database Metadata
You can retrieve information about the database version, species, and underlying file structure using these utility functions:

```R
species(MeSH.Ame.eg.db)   # Confirm species (Apis mellifera)
dbInfo(MeSH.Ame.eg.db)    # Database metadata and source information
dbfile(MeSH.Ame.eg.db)    # Path to the SQLite database file
dbschema(MeSH.Ame.eg.db)  # Database schema structure
```

## Usage Tips
- **MeSH Categories**: MeSH IDs are often grouped into categories (e.g., A for Anatomy, D for Drugs). Use the `MESHCATEGORY` column to filter results by broad biological domains.
- **Integration**: This package is designed to work seamlessly with other Bioconductor tools like `MeSHDbi` and `meshr` for enrichment analysis.
- **Entrez IDs**: Ensure your input keys are character strings, as Entrez Gene IDs are treated as characters in this database.

## Reference documentation
- [MeSH.Ame.eg.db Reference Manual](./references/reference_manual.md)