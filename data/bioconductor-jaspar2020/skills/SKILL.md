---
name: bioconductor-jaspar2020
description: This package provides access to transcription factor binding profiles from the JASPAR 2020 database. Use when user asks to retrieve position frequency matrices by ID or name, filter motifs by species or taxonomic group, and fetch data for sequence logo generation.
homepage: https://bioconductor.org/packages/release/data/annotation/html/JASPAR2020.html
---

# bioconductor-jaspar2020

name: bioconductor-jaspar2020
description: Access and retrieve transcription factor binding profiles from the JASPAR 2020 database. Use this skill when you need to fetch Position Frequency Matrices (PFMs) by ID, name, or specific criteria (species, taxonomic group, collection) for motif analysis and sequence logo generation.

# bioconductor-jaspar2020

## Overview
The `JASPAR2020` package is a Bioconductor data package containing the 8th release of the JASPAR database. It is designed to be used in conjunction with the `TFBSTools` package to retrieve curated, non-redundant transcription factor (TF) binding profiles stored as Position Frequency Matrices (PFMs).

## Core Workflow

### 1. Initialization
Always load both the data package and the interface package:
```R
library(JASPAR2020)
library(TFBSTools)
```

### 2. Retrieving Specific Matrices
You can retrieve matrices using unique JASPAR IDs or common TF names.

*   **By ID:** Returns a `PFMatrix` (single ID) or `PFMatrixList` (vector of IDs).
    ```R
    # Single ID
    pfm <- getMatrixByID(JASPAR2020, ID = "MA0139.1")
    
    # Multiple IDs
    pfm_list <- getMatrixByID(JASPAR2020, ID = c("MA0139.1", "MA1102.1"))
    ```

*   **By Name:** Useful when the specific version ID is unknown.
    ```R
    pfm <- getMatrixByName(JASPAR2020, name = "CTCF")
    ```

### 3. Filtering and Searching
Use `getMatrixSet` with an options list to filter the database based on metadata.

**Common Filter Criteria:**
*   `species`: NCBI Taxon ID (e.g., 9606 for Human, 10090 for Mouse).
*   `collection`: "CORE", "UNVALIDATED", etc.
*   `matrixtype`: "Pfm", "Pwm", "Icm".
*   `tax_group`: "vertebrates", "insects", "plants", "fungi", "nematodes", "urochordates".
*   `all_versions`: Boolean (TRUE/FALSE).

```R
opts <- list()
opts[["species"]] <- 9606
opts[["tax_group"]] <- "vertebrates"
opts[["collection"]] <- "CORE"

pfm_set <- getMatrixSet(JASPAR2020, opts)
```

### 4. Visualization
Convert the PFM to an Information Content Matrix (ICM) to plot a sequence logo.
```R
pfm <- getMatrixByID(JASPAR2020, ID = "MA0139.1")
icm <- toICM(pfm)
seqLogo(icm)
```

## Tips and Best Practices
*   **Object Types:** `getMatrixByID` and `getMatrixByName` return a `PFMatrix` object if one match is found, but a `PFMatrixList` if multiple IDs/names are provided. Always check the class if your downstream code expects a specific format.
*   **Metadata:** Access metadata (like species, family, or class) via the `tags()` function or by accessing the `@tags` slot of the `PFMatrix` object.
*   **TFBSTools Integration:** This package only provides the data. For scanning sequences or calculating matrix similarity, refer to `TFBSTools` functions like `searchSeq` or `PWMSimilarity`.

## Reference documentation
- [JASPAR2020](./references/JASPAR2020.md)