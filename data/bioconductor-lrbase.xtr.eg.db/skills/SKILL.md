---
name: bioconductor-lrbase.xtr.eg.db
description: This package provides infrastructure for creating and querying ligand-receptor interaction database objects within the Bioconductor ecosystem. Use when user asks to create custom LRBase annotation packages, build ligand-receptor databases using makeLRBasePackage, or retrieve interaction data using select, keys, and columns methods.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/LRBase.Xtr.eg.db.html
---


# bioconductor-lrbase.xtr.eg.db

name: bioconductor-lrbase.xtr.eg.db
description: Specialized workflows for the Bioconductor package LRBase.Xtr.eg.db. Use this skill when creating custom Ligand-Receptor (LR) database packages or querying LRBase-type annotation objects. It provides instructions for the LRBaseDb class, package construction via makeLRBasePackage, and standard data retrieval methods (select, keys, columns) for ligand-receptor gene pairs.

## Overview
LRBase.Xtr.eg.db is a Bioconductor package designed for managing ligand-receptor (LR) interaction data. It serves two primary roles:
1. **Class Definition**: It defines the `LRBaseDb` class, which standardizes how LR data is accessed across different species and sources.
2. **Package Construction**: It provides the infrastructure to build custom LRBase-type annotation packages (e.g., `LRBase.XXX.eg.db`) from user-provided gene pair lists.

This skill helps users navigate the creation of these databases and the extraction of biological interaction data using standard R/Bioconductor patterns.

## Core Workflows

### Creating a Custom LRBase Package
To build a new LRBase annotation package, you need a data frame of ligand-receptor pairs and a metadata table.

1. **Prepare Data**: Create a data frame with at least two columns: `GENEID_L` (Ligand NCBI Gene ID) and `GENEID_R` (Receptor NCBI Gene ID).
2. **Prepare Metadata**: A data frame containing package information (e.g., Species, Source, Version).
3. **Execute Construction**:
```R
library(LRBase.Xtr.eg.db)
# Assuming lr_pair_data and meta_data are prepared
makeLRBasePackage(lr_pair_data, meta_data, ...)
```

### Querying LRBase Objects
Once an LRBase package (like `FANTOM5.Hsa.eg.db`) is loaded, it behaves similarly to other Bioconductor annotation objects.

*   **Check available fields**: `columns(db_object)`
*   **Check searchable keys**: `keytypes(db_object)`
*   **Retrieve keys**: `keys(db_object, keytype="GENEID_L")`
*   **Fetch data**:
```R
select(db_object, 
       keys = c("1", "2"), 
       columns = c("GENEID_L", "GENEID_R"), 
       keytype = "GENEID_L")
```

### Metadata and Database Utilities
Use these functions to inspect the contents and origin of the LR data:
*   `species(db)`: Returns the common name of the organism.
*   `nomenclature(db)`: Returns the scientific name.
*   `listDatabases(db)`: Shows the source databases for the LR pairs.
*   `dbInfo(db)`: Displays general package information.
*   `dbconn(db)`: Returns the underlying SQLite connection.

## Implementation Tips
*   **Gene IDs**: Ensure that input IDs are NCBI (Entrez) Gene IDs, as the `.eg` suffix in the package naming convention implies.
*   **Interactive Use**: When testing package creation, use `example('makeLRBasePackage')` to see a demonstration using FANTOM5 project data.
*   **Integration**: LRBase packages are often used in conjunction with `scTensor` for cell-cell interaction analysis.

## Reference documentation
- [Introduction to LRBase.Xtr.eg.db](./references/LRBase.Xtr.eg.db.md)