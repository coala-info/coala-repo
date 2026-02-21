---
name: bioconductor-jaspar2016
description: the package TFBSTools (>= 1.8.1).
homepage: https://bioconductor.org/packages/release/data/experiment/html/JASPAR2016.html
---

# bioconductor-jaspar2016

## Overview
The `JASPAR2016` package is a data-only Bioconductor experiment data package. It provides a SQLite interface to the JASPAR 2016 database, which contains a curated set of transcription factor binding profiles. This package is designed to be used in conjunction with the `TFBSTools` package, which provides the functional interface for searching and manipulating the matrices stored within `JASPAR2016`.

## Workflow and Usage

### Initialization
To use the database, you must load both the data package and the interface package:

```r
library(JASPAR2016)
library(TFBSTools)
```

### Querying Matrices
The primary function for retrieving data is `getMatrixSet()`. You pass the `JASPAR2016` object as the first argument and a list of search criteria as the `opts` argument.

#### Common Search Options (opts)
- `species`: Taxon ID (e.g., 9606 for Homo sapiens, 10090 for Mus musculus).
- `collection`: The JASPAR collection (e.g., "CORE", "CNE", "PHYLOFACTS").
- `type`: The experimental method (e.g., "SELEX", "ChIP-seq").
- `all_versions`: Boolean; if TRUE, returns all versions of a matrix rather than just the latest.
- `name`: The name of the transcription factor.
- `ID`: The JASPAR ID (e.g., "MA0001.1").

### Examples

#### 1. Retrieve all Human SELEX matrices
```r
opts <- list()
opts[["species"]] <- 9606
opts[["type"]] <- "SELEX"
opts[["all_versions"]] <- TRUE
PFMatrixList <- getMatrixSet(JASPAR2016, opts)
```

#### 2. Retrieve matrices by experimental type
```r
opts2 <- list()
opts2[["type"]] <- "SELEX"
PFMatrixList2 <- getMatrixSet(JASPAR2016, opts2)
```

### Data Structures
- **JASPAR2016 Object**: A thin class storing the path to the SQLite database.
- **PFMatrixList**: The result of `getMatrixSet()`, containing `PFMatrix` objects. These can be converted to Position Weight Matrices (PWMs) or Position Probability Matrices (PPMs) using `TFBSTools` functions like `toPWM()`.

## Tips
- Always ensure `TFBSTools` is loaded; `JASPAR2016` itself does not contain the search logic.
- If you are looking for the most recent JASPAR data, check if a newer version of the JASPAR data package (e.g., JASPAR2022) is available, as `JASPAR2016` is specific to the 2016 release.
- Use `names(PFMatrixList)` to see the JASPAR IDs of the retrieved motifs.

## Reference documentation
- [JASPAR2016 Reference Manual](./references/reference_manual.md)