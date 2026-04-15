---
name: bioconductor-mesh.eco.55989.eg.db
description: This package maps MeSH terms to Entrez Gene identifiers for *Escherichia coli* strain 55989. Use when user asks to map gene IDs to MeSH categories, retrieve biological metadata for E. coli strain 55989, or query MeSH term associations.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Eco.55989.eg.db.html
---

# bioconductor-mesh.eco.55989.eg.db

## Overview

The `MeSH.Eco.55989.eg.db` package is a Bioconductor annotation data package that facilitates the mapping between MeSH (Medical Subject Headings) terms and Entrez Gene identifiers for *Escherichia coli* strain 55989. It is built upon the `MeSHDbi` framework, allowing users to query biological metadata using a standardized interface.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Eco.55989.eg.db")
library(MeSH.Eco.55989.eg.db)
```

## Core Workflows

The package follows the standard `AnnotationDbi` interface. Use the following four methods to explore and extract data.

### 1. Discovering Available Data
Check which types of identifiers (keys) and data categories (columns) are available within the database.

```r
# View available column types
columns(MeSH.Eco.55989.eg.db)

# View available keytypes (searchable fields)
keytypes(MeSH.Eco.55989.eg.db)
```

### 2. Retrieving Keys
Extract specific identifiers to use for filtering or lookups.

```r
# Get the first 6 Entrez Gene IDs
gene_keys <- head(keys(MeSH.Eco.55989.eg.db, keytype="GENEID"))

# Get all MeSH IDs
mesh_keys <- keys(MeSH.Eco.55989.eg.db, keytype="MESHID")
```

### 3. Mapping Identifiers (Select)
The `select` function is the primary tool for mapping between Entrez IDs and MeSH terms.

```r
# Map specific Gene IDs to their MeSH categories and IDs
res <- select(MeSH.Eco.55989.eg.db, 
              keys = gene_keys, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")

# View results
head(res)
```

## Database Metadata
To inspect the underlying database structure and versioning information:

```r
# Get species name
species(MeSH.Eco.55989.eg.db)

# Get database metadata (version, organism, etc.)
dbInfo(MeSH.Eco.55989.eg.db)

# Get the path to the underlying SQLite file
dbfile(MeSH.Eco.55989.eg.db)
```

## Usage Tips
- **Strain Specificity**: Ensure your data corresponds to *E. coli* strain 55989. Using this package for other strains (like K-12) may result in inaccurate mappings.
- **MeSH Categories**: MeSH terms are organized by categories (e.g., D for Drugs and Chemicals, G for Phenomena and Processes). Use the `MESHCATEGORY` column to filter results by broad biological contexts.
- **Integration**: This package is often used in conjunction with `MeSHDbi` and `meshr` for enrichment analysis.

## Reference documentation
- [MeSH.Eco.55989.eg.db Reference Manual](./references/reference_manual.md)