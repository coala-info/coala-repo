---
name: bioconductor-lrbase.bta.eg.db
description: This Bioconductor package manages ligand-receptor interaction data for Bos taurus and provides a framework for creating custom LRBase annotation databases. Use when user asks to query cow ligand-receptor gene pairs, create custom LR interaction packages, or retrieve metadata for ligand-receptor databases.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/LRBase.Bta.eg.db.html
---

# bioconductor-lrbase.bta.eg.db

name: bioconductor-lrbase.bta.eg.db
description: Use this skill when working with the Bioconductor package LRBase.Bta.eg.db in R. This package is used for managing Ligand-Receptor (LR) interaction databases, specifically for Bos taurus (cow), and provides the framework for creating and querying LRBase.XXX.eg.db-type annotation packages. Use this skill to create custom LR databases, query gene pairs, and integrate LR data into single-cell analysis workflows (like scTensor).

# bioconductor-lrbase.bta.eg.db

## Overview

LRBase.Bta.eg.db is a specialized annotation package within the Bioconductor ecosystem. It serves two primary purposes:
1. **Class Definition**: It defines the `LRBaseDb` class, which standardizes how ligand-receptor interaction data is stored and accessed across different species.
2. **Package Construction**: It provides tools to build custom LR interaction packages (LRBase.XXX.eg.db) from user-provided gene pair lists.

While this specific package contains data for *Bos taurus*, its functional API is the template for all LRBase-style objects used in cell-cell interaction analysis.

## Core Workflows

### Loading the Package
```R
library(LRBase.Bta.eg.db)
```

### Querying the Database
LRBase objects follow the standard Bioconductor `AnnotationDbi` interface (select, columns, keys, keytypes).

```R
# View available columns
columns(LRBase.Bta.eg.db)

# View available keytypes (e.g., GENEID_L, GENEID_R)
keytypes(LRBase.Bta.eg.db)

# Retrieve specific ligand-receptor pairs
# Example: Get ligands for specific receptor Entrez IDs
receptors <- c("12345", "67890")
select(LRBase.Bta.eg.db, 
       keys = receptors, 
       columns = c("GENEID_L", "GENEID_R"), 
       keytype = "GENEID_R")
```

### Creating a Custom LRBase Package
If you have a custom list of ligand-receptor interactions, you can generate a standalone R package for them.

```R
# Required: A data frame with GENEID_L and GENEID_R (NCBI Gene IDs)
lr_list <- data.frame(GENEID_L = c("..."), GENEID_R = c("..."))

# Required: Meta information
meta_info <- data.frame(Name = "METADATA_KEY", Value = "METADATA_VALUE")

# Generate the package
makeLRBasePackage(lr_list, 
                  meta_info, 
                  species = "Homo sapiens", 
                  pkgname = "CustomLR.Hsa.eg.db", 
                  version = "0.99.0", 
                  maintainer = "User <user@example.com>", 
                  author = "User", 
                  destDir = ".")
```

### Database Metadata and Inspection
Use these functions to inspect the source and properties of the LR data:
* `species(LRBase.Bta.eg.db)`: Common name of the species.
* `nomenclature(LRBase.Bta.eg.db)`: Scientific name.
* `listDatabases(LRBase.Bta.eg.db)`: Shows the source databases (e.g., FANTOM5, HPRD).
* `dbInfo(LRBase.Bta.eg.db)`: General package information.
* `dbconn(LRBase.Bta.eg.db)`: Returns the underlying SQLite connection.

## Tips for Success
* **ID Types**: LRBase packages primarily use NCBI Entrez Gene IDs. If your data uses Gene Symbols or Ensembl IDs, use `org.Bt.eg.db` to convert them before querying LRBase.
* **Integration**: This package is a foundational component for `scTensor`. If you are performing cell-cell communication analysis, the LRBase object is typically passed into scTensor functions to define the underlying biology.
* **Directionality**: Always distinguish between `GENEID_L` (Ligand) and `GENEID_R` (Receptor) when using `keytype` to ensure biological accuracy in your queries.

## Reference documentation
- [Introduction to LRBase.Bta.eg.db and LRBase.XXX.eg.db-type packages](./references/LRBase.Bta.eg.db.md)