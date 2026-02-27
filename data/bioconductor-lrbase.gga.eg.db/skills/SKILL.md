---
name: bioconductor-lrbase.gga.eg.db
description: This package provides ligand-receptor interaction data for Gallus gallus and a framework for creating custom ligand-receptor annotation databases. Use when user asks to retrieve chicken ligand-receptor pairs, query interaction databases using NCBI Gene IDs, or build new LRBase annotation packages from custom data.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/LRBase.Gga.eg.db.html
---


# bioconductor-lrbase.gga.eg.db

name: bioconductor-lrbase.gga.eg.db
description: Use this skill when working with the Bioconductor package LRBase.Gga.eg.db in R. This package is used for managing ligand-receptor (LR) interaction data for Gallus gallus (chicken) and for creating custom LRBase.XXX.eg.db-type annotation packages. Use this skill to retrieve LR pairs, query interaction databases, or build new LR annotation packages from custom data.

# bioconductor-lrbase.gga.eg.db

## Overview

LRBase.Gga.eg.db is a specialized Bioconductor annotation package that serves two primary purposes:
1. **Data Source**: It provides a collection of ligand-receptor gene pairs for *Gallus gallus* (chicken).
2. **Framework**: It defines the `LRBaseDb` class and provides the `makeLRBasePackage` function, which allows users to construct their own ligand-receptor interaction databases for any species.

This package is a core component of the `scTensor` ecosystem for analyzing cell-cell interactions.

## Core Workflows

### Loading the Package
```r
library(LRBase.Gga.eg.db)
```

### Querying Ligand-Receptor Data
The package follows the standard Bioconductor `AnnotationDbi` interface (select, columns, keys, keytypes).

```r
# View available columns (e.g., GENEID_L, GENEID_R, SOURCE)
columns(LRBase.Gga.eg.db)

# View available keytypes
keytypes(LRBase.Gga.eg.db)

# Retrieve all ligand NCBI Gene IDs
l_keys <- keys(LRBase.Gga.eg.db, keytype="GENEID_L")

# Perform a join-style query
# Example: Find all receptors for specific ligand Gene IDs
select(LRBase.Gga.eg.db, 
       keys = l_keys[1:5], 
       columns = c("GENEID_L", "GENEID_R", "SOURCE"), 
       keytype = "GENEID_L")
```

### Creating a Custom LRBase Package
Use `makeLRBasePackage` to bundle custom LR interaction data into a reusable R package.

```r
# Required data: 
# 1. lr_list: Data frame with GENEID_L and GENEID_R columns
# 2. metadata: Data frame describing the source and species

makeLRBasePackage(lr_list, 
                  metadata, 
                  version = "0.99.0", 
                  maintainer = "Your Name <user@email.com>", 
                  author = "Your Name", 
                  destDir = ".", 
                  license = "Artistic-2.0")
```

### Database Metadata and Inspection
```r
# Get species information
species(LRBase.Gga.eg.db)
nomenclature(LRBase.Gga.eg.db)

# List the underlying data sources for the LR pairs
listDatabases(LRBase.Gga.eg.db)

# Connection and file info
dbconn(LRBase.Gga.eg.db)
dbfile(LRBase.Gga.eg.db)
```

## Tips and Best Practices
- **Gene IDs**: The package primarily uses NCBI Entrez Gene IDs. Ensure your input data is mapped to these IDs before querying or package creation.
- **scTensor Integration**: This package is designed to work seamlessly with `scTensor`. If you are performing cell-cell interaction analysis on single-cell RNA-seq data, use this package to provide the reference LR pairs.
- **Interactive Help**: Use `example('makeLRBasePackage')` to see a live demonstration of package construction using FANTOM5 demo data.

## Reference documentation
- [Introduction to LRBase.Gga.eg.db and LRBase.XXX.eg.db-type packages](./references/LRBase.Gga.eg.db.md)