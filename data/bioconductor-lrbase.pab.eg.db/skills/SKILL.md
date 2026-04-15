---
name: bioconductor-lrbase.pab.eg.db
description: This package provides the infrastructure for managing Ligand-Receptor interaction databases and defining the LRBaseDb class within the Bioconductor ecosystem. Use when user asks to create custom LRBase annotation packages, query ligand-receptor pair data using select methods, or define classes for cell-cell communication analysis.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/LRBase.Pab.eg.db.html
---

# bioconductor-lrbase.pab.eg.db

name: bioconductor-lrbase.pab.eg.db
description: Specialized knowledge for using the LRBase.Pab.eg.db R package to manage Ligand-Receptor (LR) interaction databases. Use this skill when you need to create custom LRBase annotation packages, define LRBaseDb classes, or query ligand-receptor pair data using standard Bioconductor-style select methods.

# bioconductor-lrbase.pab.eg.db

## Overview

LRBase.Pab.eg.db is a core Bioconductor package designed for handling Ligand-Receptor (LR) interaction data. It serves two primary purposes:
1. **Class Definition**: It defines the `LRBaseDb` class, providing a unified interface for all `LRBase.XXX.eg.db`-type annotation packages.
2. **Package Construction**: It provides the `makeLRBasePackage` function, allowing users to compile their own LR interaction data into a distributable R package format.

This package is essential for researchers performing cell-cell communication analysis, particularly those using the `scTensor` framework.

## Core Workflows

### Creating a Custom LRBase Package

To build a new LRBase annotation package from your own data, you need a data frame of interactions and a metadata table.

```r
library(LRBase.Pab.eg.db)

# 1. Prepare LR-list (must contain GENEID_L and GENEID_R as NCBI Gene IDs)
# lr_data <- data.frame(GENEID_L = ..., GENEID_R = ...)

# 2. Prepare Meta information
# meta_data <- data.frame(name = ..., value = ...)

# 3. Generate the package
# makeLRBasePackage(lr_data, meta_data, ...)
```

### Querying LRBase Objects

Once an LRBase package (like `FANTOM5.Hsa.eg.db`) is loaded, it behaves similarly to `AnnotationDbi` objects using four standard methods: `columns`, `keytypes`, `keys`, and `select`.

```r
library(FANTOM5.Hsa.eg.db)

# List available data columns
columns(FANTOM5.Hsa.eg.db)

# List available key types for filtering
keytypes(FANTOM5.Hsa.eg.db)

# Retrieve specific keys
key_r <- keys(FANTOM5.Hsa.eg.db, keytype='GENEID_R')

# Perform a join/lookup
res <- select(FANTOM5.Hsa.eg.db, 
              keys = key_r[1:5], 
              columns = c('GENEID_L', 'GENEID_R'), 
              keytype = 'GENEID_R')
```

### Database Metadata and Inspection

Use these functions to inspect the source and properties of the LR data:

*   `species()`: Returns the common name of the organism.
*   `nomenclature()`: Returns the scientific name.
*   `listDatabases()`: Shows the source databases for the LR pairs.
*   `dbInfo()`: Displays package metadata.
*   `dbconn()`: Returns the underlying SQLite connection.

## Tips and Best Practices

*   **Gene ID Format**: LRBase packages primarily use NCBI Entrez Gene IDs. Ensure your input data for `makeLRBasePackage` follows this convention to maintain compatibility.
*   **Integration**: This package is a prerequisite for `scTensor`. If you are performing tensor decomposition on single-cell RNA-seq data for cell-cell interaction, you will likely interact with LRBase objects.
*   **Interactive Help**: Use `example('makeLRBasePackage')` to see a live demonstration of package construction using FANTOM5 demo data.

## Reference documentation

- [Introduction to LRBase.Pab.eg.db and LRBase.XXX.eg.db-type packages](./references/LRBase.Pab.eg.db.md)