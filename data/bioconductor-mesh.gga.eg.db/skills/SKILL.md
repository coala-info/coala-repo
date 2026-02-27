---
name: bioconductor-mesh.gga.eg.db
description: This package provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Gallus gallus. Use when user asks to map chicken gene IDs to MeSH terms, perform functional annotation for chicken genomic data, or query the MeSH.Gga.eg.db database.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Gga.eg.db.html
---


# bioconductor-mesh.gga.eg.db

name: bioconductor-mesh.gga.eg.db
description: Provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Gallus gallus (chicken). Use this skill when performing functional annotation, gene set enrichment analysis, or data retrieval involving chicken genomic data and MeSH terms using the MeSH.Gga.eg.db Bioconductor package.

# bioconductor-mesh.gga.eg.db

## Overview

The `MeSH.Gga.eg.db` package is a specialized annotation database for *Gallus gallus* (chicken). It facilitates the correspondence between Entrez Gene IDs and MeSH (Medical Subject Headings) IDs. This package is built upon the `MeSHDbi` framework, allowing users to query biological context and functional classifications for chicken genes using standard Bioconductor AnnotationDbi methods.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Gga.eg.db")
library(MeSH.Gga.eg.db)
```

## Core Workflows

The package follows the standard `AnnotationDbi` interface. Users interact with the `MeSH.Gga.eg.db` object using four main methods: `columns()`, `keytypes()`, `keys()`, and `select()`.

### 1. Exploring the Database Structure
Before querying, identify what data types are available:

```r
# View available columns (data types to retrieve)
columns(MeSH.Gga.eg.db)

# View available keytypes (fields you can search by)
keytypes(MeSH.Gga.eg.db)
```

### 2. Retrieving Keys
To see the identifiers present in a specific field:

```r
# Get the first 6 Entrez Gene IDs
head(keys(MeSH.Gga.eg.db, keytype="GENEID"))

# Get the first 6 MeSH IDs
head(keys(MeSH.Gga.eg.db, keytype="MESHID"))
```

### 3. Mapping Identifiers (The `select` Method)
To map between Entrez IDs and MeSH terms:

```r
# Example: Map specific Entrez Gene IDs to MeSH IDs and Categories
my_genes <- head(keys(MeSH.Gga.eg.db, keytype="GENEID"))
res <- select(MeSH.Gga.eg.db, 
              keys = my_genes, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")
head(res)
```

## Database Metadata
You can extract metadata and connection details using the following utility functions:

- `species(MeSH.Gga.eg.db)`: Confirms the target organism (Gallus gallus).
- `dbInfo(MeSH.Gga.eg.db)`: Displays database metadata (version, creation date, etc.).
- `dbfile(MeSH.Gga.eg.db)`: Shows the path to the SQLite database file.
- `dbschema(MeSH.Gga.eg.db)`: Displays the database schema.

## Usage Tips
- **MeSH Categories**: MeSH terms are organized into categories (e.g., A for Anatomy, G for Phenomena and Processes). Use the `MESHCATEGORY` column to filter results by broad biological domains.
- **Integration**: This package is often used in conjunction with `MeSHDbi` and `meshr` for enrichment analysis.
- **Entrez IDs**: Ensure your input keys are character vectors of Entrez Gene IDs when using `keytype="GENEID"`.

## Reference documentation
- [MeSH.Gga.eg.db Reference Manual](./references/reference_manual.md)