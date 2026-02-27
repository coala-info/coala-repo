---
name: bioconductor-lrbase.rno.eg.db
description: This package provides ligand-receptor interaction data for Rattus norvegicus and tools to create custom LRBase annotation packages. Use when user asks to retrieve rat ligand-receptor pairs, query gene interactions using NCBI Gene IDs, or build custom ligand-receptor databases.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/LRBase.Rno.eg.db.html
---


# bioconductor-lrbase.rno.eg.db

## Overview

LRBase.Rno.eg.db is a specialized Bioconductor annotation package that serves two primary purposes:
1. **Class Definition**: It defines the `LRBaseDb` class, which provides a unified interface for accessing ligand-receptor interaction data.
2. **Package Construction**: It provides tools to build custom LRBase annotation packages for specific species or datasets (e.g., FANTOM5) using NCBI Gene IDs.

This package is essential for researchers performing cell-cell communication analysis, particularly when using tools like `scTensor`.

## Core Workflows

### Loading the Package
```R
library(LRBase.Rno.eg.db)
```

### Querying LRBase Objects
All LRBase-type packages (like `FANTOM5.Hsa.eg.db` or the internal rat database) use standard data access methods:

*   **columns(db)**: Lists the types of data available (e.g., GENEID_L, GENEID_R).
*   **keytypes(db)**: Lists the types of keys that can be used for filtering.
*   **keys(db, keytype)**: Returns all available values for a specific keytype.
*   **select(db, keys, columns, keytype)**: Retrieves the mapping between ligands and receptors.

Example query:
```R
# Assuming an LRBase object is loaded
lr_keys <- keys(LRBase.Rno.eg.db, keytype='GENEID_R')
results <- select(LRBase.Rno.eg.db, 
                  keys=lr_keys[1:5], 
                  columns=c('GENEID_L', 'GENEID_R'), 
                  keytype='GENEID_R')
```

### Creating a Custom LRBase Package
You can generate a new R package containing specific Ligand-Receptor pairs using `makeLRBasePackage`.

**Requirements:**
1.  A data frame with `GENEID_L` and `GENEID_R` (NCBI Gene IDs).
2.  A meta information table.

```R
# Example structure for creation
makeLRBasePackage(lrdata, metadata, 
                  pkgname = "CustomLR.Org.eg.db", 
                  destDir = ".", 
                  version = "0.99.0")
```

### Metadata and Helper Functions
Use these functions to inspect the database properties:
*   `species(db)`: Common name of the species.
*   `nomenclature(db)`: Scientific name.
*   `listDatabases(db)`: Source of the LR data.
*   `dbInfo(db)`: General package information.
*   `dbconn(db)`: Returns the underlying SQLite connection.

## Usage Tips
*   **Gene IDs**: LRBase packages primarily use NCBI Gene IDs (Entrez IDs). If you have Gene Symbols or Ensembl IDs, convert them first using `org.Rn.eg.db`.
*   **Integration**: This package is a core dependency for `scTensor`. For advanced tensor decomposition of cell-cell interactions, refer to the `scTensor` workflow.
*   **Ligand-Receptor Directionality**: By convention, `GENEID_L` refers to the ligand and `GENEID_R` refers to the receptor.

## Reference documentation
- [Introduction to LRBase.Rno.eg.db and LRBase.XXX.eg.db-type packages](./references/LRBase.Rno.eg.db.md)