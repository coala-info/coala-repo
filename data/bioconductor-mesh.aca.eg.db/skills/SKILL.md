---
name: bioconductor-mesh.aca.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for the species Acacia. Use when user asks to map Acacia gene IDs to MeSH terms, perform functional annotation, or conduct gene set enrichment analysis using MeSH categories.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Aca.eg.db.html
---

# bioconductor-mesh.aca.eg.db

name: bioconductor-mesh.aca.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for the species Acacia (Aca). Use this skill when performing functional annotation, gene set enrichment analysis, or biological data mining involving Acacia genomic data and MeSH terms.

## Overview

The `MeSH.Aca.eg.db` package is a Bioconductor annotation database that facilitates the correspondence between MeSH IDs and Entrez Gene IDs for *Acacia*. It is built upon the `MeSHDbi` framework, allowing users to query biological metadata using standard AnnotationDbi methods. This package is essential for researchers looking to link specific genes in Acacia to standardized medical and biological concepts defined by the MeSH hierarchy.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Aca.eg.db")
library(MeSH.Aca.eg.db)
```

## Core Workflows

The package follows the standard `AnnotationDbi` interface using four main methods: `columns`, `keytypes`, `keys`, and `select`.

### 1. Exploring the Database Structure
Before querying, identify what data types are available:

```R
# View available columns to retrieve
columns(MeSH.Aca.eg.db)

# View available keytypes that can be used as query inputs
keytypes(MeSH.Aca.eg.db)
```

### 2. Retrieving Keys
To see the identifiers present in the database for a specific keytype:

```R
# Get the first 6 Entrez Gene IDs
gene_keys <- head(keys(MeSH.Aca.eg.db, keytype = "GENEID"))

# Get the first 6 MeSH IDs
mesh_keys <- head(keys(MeSH.Aca.eg.db, keytype = "MESHID"))
```

### 3. Mapping Identifiers
Use the `select` function to map between Entrez Gene IDs and MeSH terms:

```R
# Map specific Gene IDs to their corresponding MeSH IDs and Categories
target_genes <- c("12345", "67890") # Replace with actual Acacia Entrez IDs
results <- select(MeSH.Aca.eg.db, 
                  keys = target_genes, 
                  columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
                  keytype = "GENEID")

head(results)
```

## Database Metadata
You can extract administrative and versioning information about the underlying SQLite database:

```R
species(MeSH.Aca.eg.db)   # Confirm species (Acacia)
dbInfo(MeSH.Aca.eg.db)    # Database metadata
dbfile(MeSH.Aca.eg.db)    # Path to the database file
dbschema(MeSH.Aca.eg.db)  # Database schema structure
```

## Usage Tips
- **MeSH Categories**: MeSH IDs are often organized by categories (e.g., D for Drugs and Chemicals, G for Phenomena and Processes). Use the `MESHCATEGORY` column to filter results to specific biological domains.
- **MeSHDbi Dependency**: This package is a data-only package. For advanced analysis or to create custom MeSH databases, refer to the `MeSHDbi` package documentation.
- **Entrez IDs**: Ensure your input keys are character vectors, as Entrez IDs are treated as strings in this interface.

## Reference documentation
- [MeSH.Aca.eg.db Reference Manual](./references/reference_manual.md)