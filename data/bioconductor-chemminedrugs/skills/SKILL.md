---
name: bioconductor-chemminedrugs
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ChemmineDrugs.html
---

# bioconductor-chemminedrugs

name: bioconductor-chemminedrugs
description: Access and utilize the DrugBank data set stored in a pre-built SQLite database. Use this skill when you need to perform compound searches, retrieve drug information, or access pre-computed chemical features using the ChemmineR ecosystem.

# bioconductor-chemminedrugs

## Overview
The `ChemmineDrugs` package provides a curated, pre-built SQLite database of the DrugBank data set. It is designed to work seamlessly with the `ChemmineR` package, allowing users to query drug compounds and their associated features without needing to manually parse large external data files.

## Typical Workflow

### 1. Loading the Package and Locating Data
To use the package, first load it and verify the location of the included SQLite database files.

```r
library(ChemmineDrugs)

# List the included database files
dir(system.file("extdata", package="ChemmineDrugs"))
```

### 2. Connecting to the DrugBank Database
The primary way to interact with this package is through the `DrugBank()` function, which returns a connection object compatible with `ChemmineR` functions.

```r
library(ChemmineR)
library(ChemmineDrugs)

# Establish a connection to the DrugBank SQLite database
conn <- DrugBank()
```

### 3. Querying Compounds
Once the connection is established, use `ChemmineR` functions to search or retrieve data.

*   **Search by ID**: Retrieve specific compounds using their DrugBank identifiers.
*   **Feature Retrieval**: Access pre-computed descriptors or structural information stored within the database.
*   **Substructure/Similarity Search**: Use the connection object within `ChemmineR` search functions to find drugs similar to a query molecule.

## Tips
*   **Dependency**: This package is a data provider. Most functional operations (searching, plotting, clustering) require the `ChemmineR` package to be loaded.
*   **DUD Database**: Note that the Directory of Useful Decoys (DUD) is no longer bundled directly in this package due to size. Use the `DUD()` function from `ChemmineR` to download it if needed.
*   **Database Management**: Always ensure you close database connections if you are performing heavy iterative queries to manage system resources.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)