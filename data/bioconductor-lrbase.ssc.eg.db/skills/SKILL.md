---
name: bioconductor-lrbase.ssc.eg.db
description: This package provides ligand-receptor gene pair mappings for Sus scrofa and the infrastructure to create custom ligand-receptor annotation packages. Use when user asks to query pig ligand-receptor interactions, retrieve NCBI Gene IDs for interacting pairs, or build a custom LRBase annotation package.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/LRBase.Ssc.eg.db.html
---


# bioconductor-lrbase.ssc.eg.db

## Overview

LRBase.Ssc.eg.db is a Bioconductor annotation package that serves two primary purposes:
1. **Data Source**: It provides a mapping of ligand-receptor gene pairs for *Sus scrofa* (pig), using NCBI Gene IDs.
2. **Framework Provider**: It defines the `LRBaseDb` class and provides the infrastructure (`makeLRBasePackage`) to create custom ligand-receptor annotation packages (LRBase.XXX.eg.db-type) for other species or specific datasets like FANTOM5.

The package follows the standard Bioconductor `AnnotationDbi` interface, allowing users to query interaction data using familiar methods like `select`, `keys`, and `columns`.

## Core Workflows

### Loading the Package
```r
library(LRBase.Ssc.eg.db)
```

### Querying Ligand-Receptor Data
The package acts as a database object. You can explore and extract interaction pairs using the following standard methods:

*   **Check available fields**: `columns(LRBase.Ssc.eg.db)`
*   **Check searchable keys**: `keytypes(LRBase.Ssc.eg.db)`
*   **Retrieve all IDs**: `keys(LRBase.Ssc.eg.db, keytype='GENEID_L')`
*   **Fetch specific interactions**:
    ```r
    # Example: Get receptors for specific ligand Gene IDs
    res <- select(LRBase.Ssc.eg.db, 
                  keys = c("100127154", "100144471"), 
                  columns = c("GENEID_L", "GENEID_R"), 
                  keytype = "GENEID_L")
    ```

### Creating Custom LRBase Packages
If you have a custom list of ligand-receptor pairs and want to wrap them into a functional Bioconductor annotation package:

1.  **Prepare Data**: You need a data frame with `GENEID_L` and `GENEID_R` columns.
2.  **Prepare Metadata**: A data frame describing the source, species, and version.
3.  **Run Constructor**:
    ```r
    # Basic structure for package creation
    makeLRBasePackage(lrlist, metadata, outputDir, packageName)
    ```

### Database Metadata and Inspection
Use these functions to get information about the underlying data source:
*   `species(LRBase.Ssc.eg.db)`: Returns the common name (e.g., "Pig").
*   `nomenclature(LRBase.Ssc.eg.db)`: Returns the scientific name (*Sus scrofa*).
*   `listDatabases(LRBase.Ssc.eg.db)`: Shows the source databases for the LR pairs.
*   `dbInfo(LRBase.Ssc.eg.db)`: Provides package metadata and versioning.

## Usage Tips
*   **Gene IDs**: This package primarily uses NCBI (Entrez) Gene IDs. If you have Symbol or Ensembl IDs, use a species-specific OrgDb (like `org.Ss.eg.db`) to convert them to Entrez IDs before querying LRBase.
*   **Integration**: This package is a core component for the `scTensor` workflow, which performs cell-cell interaction analysis using tensor decomposition.
*   **Connection Access**: If you need to perform direct SQL queries, use `dbconn(LRBase.Ssc.eg.db)` to get the SQLite connection object.

## Reference documentation
- [Introduction to LRBase.Ssc.eg.db and LRBase.XXX.eg.db-type packages](./references/LRBase.Ssc.eg.db.md)