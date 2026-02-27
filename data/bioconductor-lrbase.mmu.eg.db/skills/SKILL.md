---
name: bioconductor-lrbase.mmu.eg.db
description: This package provides a mapping of ligand-receptor gene pairs for Mus musculus and defines the LRBaseDb class for standardized database access. Use when user asks to retrieve mouse ligand-receptor interactions, query NCBI Gene ID mappings for cell-cell communication, or create custom LRBase annotation packages.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/LRBase.Mmu.eg.db.html
---


# bioconductor-lrbase.mmu.eg.db

## Overview

LRBase.Mmu.eg.db is a functional annotation package that serves two primary purposes:
1. **Data Source**: It provides a comprehensive mapping of Ligand-Receptor (LR) gene pairs for *Mus musculus*, using NCBI Gene IDs.
2. **Framework**: It defines the `LRBaseDb` class, which standardizes how LR interaction databases are accessed and constructed across the Bioconductor ecosystem (e.g., for use with `scTensor`).

## Core Workflows

### Data Exploration and Retrieval

LRBase packages follow the standard AnnotationDbi interface. You can query the mouse LR interactions using the following functions:

```R
library(LRBase.Mmu.eg.db)

# Check available metadata and data columns
columns(LRBase.Mmu.eg.db)

# Check which columns can be used as keys for filtering
keytypes(LRBase.Mmu.eg.db)

# Retrieve all receptor Gene IDs
receptors <- keys(LRBase.Mmu.eg.db, keytype="GENEID_R")

# Perform a join-like query to find ligands for specific receptors
# Returns a data.frame of interactions
lr_pairs <- select(LRBase.Mmu.eg.db, 
                   keys = receptors[1:10], 
                   columns = c("GENEID_L", "GENEID_R"), 
                   keytype = "GENEID_R")
```

### Database Metadata

To understand the provenance and scope of the LR data:

```R
# Get the species name
species(LRBase.Mmu.eg.db)

# List the source databases (e.g., FANTOM5, HPRD, etc.)
listDatabases(LRBase.Mmu.eg.db)

# Get package version and build information
dbInfo(LRBase.Mmu.eg.db)
```

### Creating Custom LRBase Packages

If you have a custom list of ligand-receptor pairs (e.g., for a different species or a specific project), use `makeLRBasePackage`.

1. **Prepare Data**: You need a data frame with `GENEID_L` and `GENEID_R` columns.
2. **Prepare Metadata**: A data frame describing the source, species, and version.

```R
# Example structure for custom package creation
# lr_df: data.frame with GENEID_L and GENEID_R
# meta_df: data.frame with metadata fields

makeLRBasePackage(lr_df, 
                  meta_df, 
                  version = "1.0.0", 
                  maintainer = "Name <email@example.com>", 
                  author = "Name", 
                  destDir = ".", 
                  license = "Artistic-2.0")

# The resulting folder can be installed via:
# install.packages("PackageName", repos = NULL, type = "source")
```

## Integration with scTensor

LRBase packages are designed to work seamlessly with the `scTensor` package for cell-cell interaction analysis. If performing multi-cellular communication analysis, ensure the Gene IDs in your SingleCellExperiment object match the NCBI Gene IDs used in this package.

## Reference documentation

- [Introduction to LRBase.Mmu.eg.db and LRBase.XXX.eg.db-type packages](./references/LRBase.Mmu.eg.db.md)