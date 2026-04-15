---
name: bioconductor-lrbase.dme.eg.db
description: This package provides the infrastructure for managing ligand-receptor interaction databases and defining LRBaseDb classes within the Bioconductor ecosystem. Use when user asks to create custom ligand-receptor annotation packages, query ligand-receptor pairs using select interfaces, or manage data for cell-cell interaction analysis.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/LRBase.Dme.eg.db.html
---

# bioconductor-lrbase.dme.eg.db

name: bioconductor-lrbase.dme.eg.db
description: Use this skill when working with the Bioconductor package LRBase.Dme.eg.db to manage ligand-receptor (LR) interaction databases. This includes defining LRBaseDb classes, creating custom LRBase.XXX.eg.db-type annotation packages for specific species or datasets, and querying ligand-receptor pairs using standard Bioconductor-style select interfaces.

# bioconductor-lrbase.dme.eg.db

## Overview

LRBase.Dme.eg.db is a core Bioconductor annotation package that serves two primary roles:
1. **Class Definition**: It defines the `LRBaseDb` class, which provides a unified interface for accessing ligand-receptor interaction data.
2. **Package Construction**: It provides the infrastructure (`makeLRBasePackage`) to build custom ligand-receptor annotation packages (e.g., `LRBase.Hsa.eg.db`) from user-provided gene pair lists.

This package is essential for researchers performing cell-cell interaction analysis, particularly those using the `scTensor` workflow.

## Core Workflows

### Creating a Custom LRBase Package
To build a new LRBase annotation package, you need a data frame of ligand-receptor pairs and a metadata table.

```r
library(LRBase.Dme.eg.db)

# 1. Prepare LR-list (must contain GENEID_L and GENEID_R)
# GENEID columns should typically be NCBI Entrez Gene IDs
lr_data <- data.frame(
  GENEID_L = c("1", "2"), 
  GENEID_R = c("3", "4")
)

# 2. Prepare Metadata
meta_data <- data.frame(
  name = c("SOURCE", "SPECIES", "DBVERSION"),
  value = c("FANTOM5", "Drosophila melanogaster", "2023")
)

# 3. Generate the package
makeLRBasePackage(
  lr_data, 
  meta_data, 
  destDir = ".", 
  version = "0.99.0", 
  maintainer = "Your Name <user@example.com>", 
  author = "Your Name"
)
```

### Querying LRBase Objects
Once an LRBase package (like `FANTOM5.Hsa.eg.db`) is loaded, use the standard `AnnotationDbi`-style interface:

```r
# Load the generated or existing package
library(FANTOM5.Hsa.eg.db)

# Check available columns and keytypes
columns(FANTOM5.Hsa.eg.db)
keytypes(FANTOM5.Hsa.eg.db)

# Retrieve keys
rk <- keys(FANTOM5.Hsa.eg.db, keytype="GENEID_R")

# Select specific interactions
select(FANTOM5.Hsa.eg.db, 
       keys = rk[1:5], 
       columns = c("GENEID_L", "GENEID_R"), 
       keytype = "GENEID_R")
```

### Database Metadata and Inspection
Use these functions to inspect the underlying database:

* `species()`: Returns the common name of the species.
* `nomenclature()`: Returns the scientific name.
* `listDatabases()`: Shows the source of the LR data.
* `dbInfo()`: Displays package metadata.
* `dbconn()`: Returns the underlying SQLite connection for advanced SQL queries.

## Tips and Best Practices
* **ID Consistency**: Ensure that `GENEID_L` and `GENEID_R` use NCBI Entrez Gene IDs to maintain compatibility with other Bioconductor annotation resources.
* **scTensor Integration**: This package is a prerequisite for `scTensor`. If you are performing tensor decomposition on single-cell RNA-seq data, ensure your LRBase object is correctly formatted using this package's constructor.
* **Interactive Help**: Use `example('makeLRBasePackage')` to see a live demonstration of package construction using internal demo data.

## Reference documentation
- [Introduction to LRBase.Dme.eg.db and LRBase.XXX.eg.db-type packages](./references/LRBase.Dme.eg.db.md)