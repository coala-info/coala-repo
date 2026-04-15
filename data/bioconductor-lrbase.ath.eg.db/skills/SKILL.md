---
name: bioconductor-lrbase.ath.eg.db
description: This package provides a unified interface and tools for managing ligand-receptor interaction data and creating custom annotation packages for Arabidopsis thaliana and other species. Use when user asks to create custom LRBase annotation packages, query ligand-receptor pairs, or perform cell-cell interaction analysis with scTensor.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/LRBase.Ath.eg.db.html
---

# bioconductor-lrbase.ath.eg.db

name: bioconductor-lrbase.ath.eg.db
description: Specialized skill for using the Bioconductor package LRBase.Ath.eg.db to manage ligand-receptor (LR) interaction data. Use this skill when you need to create custom LRBase annotation packages (LRBase.XXX.eg.db-type), query ligand-receptor pairs for Arabidopsis thaliana or other species, or interface with the scTensor package for cell-cell interaction analysis.

# bioconductor-lrbase.ath.eg.db

## Overview

LRBase.Ath.eg.db is a Bioconductor annotation package that serves two primary purposes:
1. **Class Definition**: It defines the `LRBaseDb` class, which provides a unified interface for accessing ligand-receptor interaction data.
2. **Package Construction**: It provides tools (specifically `makeLRBasePackage`) to generate custom LRBase annotation packages from user-supplied ligand-receptor lists.

This package is a foundational component for the `scTensor` ecosystem, enabling systematic analysis of cell-cell communications.

## Core Workflows

### Creating a Custom LRBase Package

To build a new LRBase annotation package for a specific dataset or species, use the `makeLRBasePackage` function.

```r
library(LRBase.Ath.eg.db)

# Required data:
# 1. lrvalues: A data frame with columns 'GENEID_L' and 'GENEID_R' (NCBI Gene IDs)
# 2. metadata: A data frame describing the source and version of the LR list

# Example construction (conceptual)
makeLRBasePackage(
    lrvalues = my_lr_dataframe,
    metadata = my_metadata_dataframe,
    pkgname = "Custom.LR.db",
    destDir = ".",
    version = "0.99.0",
    maintainer = "User <user@example.com>",
    author = "User"
)

# After creation, install the resulting source package
install.packages("Custom.LR.db", repos=NULL, type="source")
library(Custom.LR.db)
```

### Querying LRBase Objects

All LRBase-type packages (including the generated ones) use a standard `AnnotationDbi`-like interface.

```r
# 1. Check available columns
columns(Custom.LR.db)

# 2. Check available keytypes (usually GENEID_L, GENEID_R, etc.)
keytypes(Custom.LR.db)

# 3. Retrieve specific keys
lr_keys <- keys(Custom.LR.db, keytype="GENEID_L")

# 4. Select data
# Returns a data frame of ligand-receptor pairings
results <- select(Custom.LR.db, 
                  keys = lr_keys[1:10], 
                  columns = c("GENEID_L", "GENEID_R"), 
                  keytype = "GENEID_L")
```

### Metadata and Database Inspection

Use these functions to inspect the provenance and technical details of the LR database:

*   `species(db)`: Returns the common name of the organism.
*   `nomenclature(db)`: Returns the scientific name.
*   `listDatabases(db)`: Lists the source databases used to compile the LR pairs.
*   `dbInfo(db)`: Displays general package information.
*   `dbconn(db)`: Returns the underlying SQLite connection.

## Integration with scTensor

LRBase packages are designed to be used as input for `scTensor`. If you are performing cell-cell interaction analysis, you will typically pass the LRBase object to the `cellCellDecomp` or similar functions within the `scTensor` package to map expression data to known interactions.

## Reference documentation

- [Introduction to LRBase.Ath.eg.db and LRBase.XXX.eg.db-type packages](./references/LRBase.Ath.eg.db.md)