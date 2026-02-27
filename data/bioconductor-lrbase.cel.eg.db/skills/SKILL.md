---
name: bioconductor-lrbase.cel.eg.db
description: This package provides the class definition and construction tools for managing ligand-receptor interaction databases for Caenorhabditis elegans. Use when user asks to create a custom ligand-receptor annotation package, define the LRBaseDb class, or query structured cell-cell interaction data.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/LRBase.Cel.eg.db.html
---


# bioconductor-lrbase.cel.eg.db

## Overview

`LRBase.Cel.eg.db` serves two primary roles:
1. **Class Definition**: It defines the `LRBaseDb` class, which standardizes how ligand-receptor interaction data is stored and accessed across various species-specific packages.
2. **Package Construction**: It provides the `makeLRBasePackage` function, allowing users to compile their own ligand-receptor interaction data into a structured R package.

This package is essential for researchers performing cell-cell interaction analysis, particularly those using the `scTensor` workflow.

## Core Workflows

### 1. Creating a Custom LRBase Package
If you have a list of ligand-receptor pairs and want to build a formal Bioconductor-style annotation package:

```R
library(LRBase.Cel.eg.db)

# Required: A data frame with GENEID_L (Ligand NCBI ID) and GENEID_R (Receptor NCBI ID)
lr_pair_data <- data.frame(
  GENEID_L = c("171591", "178715"), 
  GENEID_R = c("173459", "175957")
)

# Required: Meta information about the data source
meta_data <- data.frame(
  name = c("SOURCE", "SPECIES"),
  value = c("MyCustomDB", "Caenorhabditis elegans")
)

# Generate the package
makeLRBasePackage(
  lr_pair_data, 
  meta_data, 
  version = "0.99.0", 
  maintainer = "Name <email@example.com>", 
  author = "Name", 
  destDir = ".", 
  license = "Artistic-2.0"
)
```

### 2. Querying LRBase Objects
All `LRBase.XXX.eg.db` packages use a consistent interface. Once a package (e.g., `FANTOM5.Hsa.eg.db`) is loaded, you can query it using standard methods:

*   **Check available data types**: `columns(target.db)`
*   **Check searchable keys**: `keytypes(target.db)`
*   **Retrieve specific pairs**:
    ```R
    # Get ligands for specific receptors
    receptors <- c("123", "456")
    select(target.db, 
           keys = receptors, 
           columns = c("GENEID_L", "GENEID_R"), 
           keytype = "GENEID_R")
    ```

### 3. Metadata and Database Info
To inspect the provenance and technical details of the LR database:
*   `species(target.db)`: Common name.
*   `nomenclature(target.db)`: Scientific name.
*   `listDatabases(target.db)`: Sources of the LR pairs.
*   `dbInfo(target.db)`: Package metadata.
*   `dbconn(target.db)`: Returns the underlying SQLite connection.

## Tips and Best Practices
*   **NCBI Gene IDs**: The package is designed around Entrez Gene IDs (NCBI). Ensure your input data for `makeLRBasePackage` uses these identifiers rather than Gene Symbols to maintain compatibility.
*   **Integration with scTensor**: This package is a prerequisite for `scTensor`. If you are performing tensor decomposition on single-cell RNA-seq data to find cell-cell communication patterns, you will likely need to load the corresponding LRBase package for your species.
*   **Interactive Help**: Use `example('makeLRBasePackage')` to see a live demonstration of package creation using FANTOM5 demo data.

## Reference documentation
- [Introduction to LRBase.Cel.eg.db and LRBase.XXX.eg.db-type packages](./references/LRBase.Cel.eg.db.md)