---
name: bioconductor-mesh.ddi.ax4.eg.db
description: This package provides mappings between MeSH identifiers and Entrez Gene IDs for the organism Dictyostelium discoideum AX4. Use when user asks to map MeSH terms to Entrez IDs, perform functional annotation, or conduct gene enrichment analysis for Dictyostelium discoideum.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Ddi.AX4.eg.db.html
---

# bioconductor-mesh.ddi.ax4.eg.db

name: bioconductor-mesh.ddi.ax4.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Dictyostelium discoideum AX4. Use this skill when performing functional annotation, gene enrichment analysis, or cross-referencing biological literature with genomic data for this specific organism.

# bioconductor-mesh.ddi.ax4.eg.db

## Overview

The `MeSH.Ddi.AX4.eg.db` package is a specialized Bioconductor annotation object. It serves as a bridge between the Medical Subject Headings (MeSH) controlled vocabulary and Entrez Gene identifiers for the model organism *Dictyostelium discoideum* (strain AX4). This package is built upon the `AnnotationDbi` and `MeSHDbi` frameworks, allowing for standardized querying of biological metadata.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Ddi.AX4.eg.db")
library(MeSH.Ddi.AX4.eg.db)
```

## Core Workflows

The package follows the standard `AnnotationDbi` interface using four main methods: `columns()`, `keytypes()`, `keys()`, and `select()`.

### 1. Exploring the Database Structure
Before querying, identify what types of data are available:

```r
# View available column types (data you can retrieve)
columns(MeSH.Ddi.AX4.eg.db)

# View available keytypes (data you can use as input for searching)
keytypes(MeSH.Ddi.AX4.eg.db)
```

### 2. Retrieving Identifiers
To see the specific keys (IDs) present in the database:

```r
# Get the first 6 Entrez Gene IDs
head(keys(MeSH.Ddi.AX4.eg.db, keytype="GENEID"))

# Get the first 6 MeSH IDs
head(keys(MeSH.Ddi.AX4.eg.db, keytype="MESHID"))
```

### 3. Mapping Between MeSH and Entrez IDs
Use `select()` to perform the actual mapping. This is the primary use case for the package.

```r
# Example: Mapping specific Entrez Gene IDs to MeSH terms
my_genes <- head(keys(MeSH.Ddi.AX4.eg.db, keytype="GENEID"))
res <- select(MeSH.Ddi.AX4.eg.db, 
              keys = my_genes, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = "GENEID")
head(res)
```

## Database Metadata
You can inspect the underlying database properties using these utility functions:

- `species(MeSH.Ddi.AX4.eg.db)`: Confirm the target organism (*Dictyostelium discoideum*).
- `dbInfo(MeSH.Ddi.AX4.eg.db)`: View metadata about the data sources and versions.
- `dbfile(MeSH.Ddi.AX4.eg.db)`: Get the file path to the SQLite database.
- `dbschema(MeSH.Ddi.AX4.eg.db)`: View the internal SQL table structure.

## Usage Tips
- **MeSH Categories**: MeSH IDs are often categorized (e.g., Anatomy [A], Diseases [C]). Use the `MESHCATEGORY` column to filter results if you are only interested in specific types of biological associations.
- **Integration**: This package is designed to work seamlessly with `MeSHDbi`. For advanced enrichment analysis, consider using this package in conjunction with the `meshr` Bioconductor package.

## Reference documentation
- [MeSH.Ddi.AX4.eg.db Reference Manual](./references/reference_manual.md)