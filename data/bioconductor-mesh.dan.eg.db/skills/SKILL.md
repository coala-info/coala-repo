---
name: bioconductor-mesh.dan.eg.db
description: This tool provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Danio rerio (Zebrafish). Use when user asks to map zebrafish Entrez IDs to MeSH terms, perform functional annotation, or conduct gene enrichment analysis using MeSH categories.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Dan.eg.db.html
---


# bioconductor-mesh.dan.eg.db

name: bioconductor-mesh.dan.eg.db
description: Provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Danio rerio (Zebrafish). Use this skill when performing functional annotation, gene enrichment analysis, or cross-referencing biological concepts with zebrafish genomic data using the MeSH.Dan.eg.db Bioconductor package.

## Overview

The `MeSH.Dan.eg.db` package is an annotation database that facilitates the translation between MeSH terms and Entrez Gene identifiers specifically for *Danio rerio*. It is built upon the `AnnotationDbi` infrastructure, allowing users to query biological metadata using a standard set of accessor methods.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Dan.eg.db")
library(MeSH.Dan.eg.db)
```

## Core Workflows

The package follows the standard `AnnotationDbi` interface. The primary object is `MeSH.Dan.eg.db`.

### 1. Exploring the Database Structure
Before querying, identify what types of data (keys) and categories (columns) are available.

```r
# List available columns (data types to retrieve)
columns(MeSH.Dan.eg.db)

# List available keytypes (fields that can be used as query inputs)
keytypes(MeSH.Dan.eg.db)
```

### 2. Retrieving Keys
To see the identifiers present in the database for a specific keytype:

```r
# Get the first 6 Entrez Gene IDs
head(keys(MeSH.Dan.eg.db, keytype="GENEID"))

# Get the first 6 MeSH IDs
head(keys(MeSH.Dan.eg.db, keytype="MESHID"))
```

### 3. Mapping Identifiers (The `select` Method)
The `select` function is the primary tool for mapping between Entrez IDs and MeSH terms.

```r
# Example: Map specific Entrez Gene IDs to MeSH IDs and Categories
my_genes <- c("30037", "30038") # Example Zebrafish Entrez IDs
res <- select(MeSH.Dan.eg.db, 
              keys = my_genes, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")
head(res)
```

### 4. Database Metadata
Access administrative information about the underlying SQLite database:

```r
species(MeSH.Dan.eg.db)   # Confirm species (Danio rerio)
dbInfo(MeSH.Dan.eg.db)    # Database metadata and source versions
dbconn(MeSH.Dan.eg.db)    # Connection object
dbfile(MeSH.Dan.eg.db)    # Path to the SQLite file
```

## Usage Tips
- **MeSH Categories**: MeSH terms are organized into categories (e.g., Anatomy [A], Diseases [C]). Use the `MESHCATEGORY` column to filter results if you are only interested in specific biological domains.
- **Integration**: This package is often used in conjunction with `MeSHDbi` and `meshr` for performing MeSH enrichment analysis.
- **Standardization**: Ensure your input keys match the `keytype` exactly (e.g., character strings for IDs).

## Reference documentation
- [MeSH.Dan.eg.db Reference Manual](./references/reference_manual.md)