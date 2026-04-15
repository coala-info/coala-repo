---
name: bioconductor-jaspar2022
description: This tool provides access to the JASPAR 2022 database for retrieving transcription factor binding profiles and position frequency matrices. Use when user asks to fetch motif matrices by ID or name, filter the JASPAR database by species or collection, or retrieve transcription factor binding profiles for motif analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/JASPAR2022.html
---

# bioconductor-jaspar2022

name: bioconductor-jaspar2022
description: Access and retrieve transcription factor binding profiles from the JASPAR 2022 database. Use this skill when you need to fetch Position Frequency Matrices (PFMs) by ID, name, or specific criteria (species, collection, taxonomic group) for motif analysis and TFBS enrichment.

## Overview

The `JASPAR2022` package is a data package providing the 9th release of the JASPAR database. It is designed to be used in conjunction with the `TFBSTools` package, which provides the interface for querying and manipulating the motif data. The database contains curated, non-redundant transcription factor (TF) binding profiles across six taxonomic groups.

## Core Workflow

To use this skill, you must load both the data package and the interface package:

```r
library(JASPAR2022)
library(TFBSTools)
```

### 1. Retrieving Specific Matrices

You can retrieve matrices if you know their JASPAR ID (e.g., "MA0139.1") or the TF name (e.g., "CTCF").

*   **By ID**: Returns a `PFMatrix` (single ID) or `PFMatrixList` (multiple IDs).
    ```r
    pfm <- getMatrixByID(JASPAR2022, ID = "MA0139.1")
    pfm_list <- getMatrixByID(JASPAR2022, ID = c("MA0139.1", "MA1102.1"))
    ```
*   **By Name**: Useful when the specific version ID is unknown.
    ```r
    pfm <- getMatrixByName(JASPAR2022, name = "Arnt")
    ```

### 2. Filtering the Database

Use `getMatrixSet` to fetch all matrices matching specific metadata criteria. Criteria are passed as a named list.

Common filter keys:
*   `species`: NCBI Taxon ID (e.g., 9606 for Human, 10090 for Mouse).
*   `collection`: e.g., "CORE", "UNVALIDATED".
*   `type`: Experiment type, e.g., "ChIP-seq", "SELEX".
*   `tax_group`: e.g., "vertebrates", "plants", "insects".
*   `all_versions`: Boolean; if TRUE, retrieves all versions of a matrix rather than just the latest.

```r
opts <- list()
opts[["species"]] <- 9606
opts[["tax_group"]] <- "vertebrates"
opts[["collection"]] <- "CORE"

pfm_list <- getMatrixSet(JASPAR2022, opts)
```

### 3. Downstream Analysis with TFBSTools

Once you have a `PFMatrix` object, you typically convert it for visualization or scanning:

*   **Sequence Logo**:
    ```r
    # Convert PFM to Information Content Matrix (ICM) first
    seqLogo(toICM(pfm))
    ```
*   **Matrix Conversion**: Use `toPWM()` to convert to a Position Weight Matrix for scanning genomic sequences.

## Tips and Best Practices

*   **Object Types**: Functions returning multiple matrices result in a `PFMatrixList`. Access individual matrices using standard list indexing: `pfm_list[[1]]`.
*   **Taxon IDs**: When filtering by species, use the numeric NCBI Taxonomy ID rather than the string name for better reliability.
*   **Memory**: The `JASPAR2022` object itself is a pointer to a database; it does not load all matrices into memory until you request them via the `getMatrix` functions.

## Reference documentation

- [JASPAR2022](./references/JASPAR2022.md)