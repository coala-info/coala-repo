---
name: bioconductor-pd.mapping250k.sty
description: This package provides annotation and platform design information for the Affymetrix Mapping 250K Sty SNP array. Use when user asks to process CEL files from the Mapping250K_Sty platform, perform feature-level preprocessing, or conduct genotype calling using the oligo or crlmm packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mapping250k.sty.html
---


# bioconductor-pd.mapping250k.sty

name: bioconductor-pd.mapping250k.sty
description: Annotation package for the Affymetrix Mapping 250K Sty SNP array. Use this skill when processing or analyzing CEL files from the Mapping250K_Sty platform using the oligo or crlmm packages. It provides the necessary platform design information for feature-level preprocessing, normalization, and genotype calling.

# bioconductor-pd.mapping250k.sty

## Overview

The `pd.mapping250k.sty` package is a Bioconductor annotation resource specifically designed for the Affymetrix Mapping 250K Styrenyl (Sty) SNP array. It contains the SQLite database mapping probe identifiers to their physical locations and sequences on the array. This package is not intended to be used in isolation but serves as a critical dependency for high-level oligonucleotide analysis packages.

## Typical Workflow

The most common use case for this package is during the initialization of an analysis session for SNP microarrays.

1.  **Loading the Library**:
    While you can load the package directly, it is typically loaded automatically by `oligo` when reading CEL files.
    ```r
    library(pd.mapping250k.sty)
    ```

2.  **Data Import**:
    When using the `oligo` package to read CEL files produced by the 250K Sty array, this package provides the required geometry and annotation.
    ```r
    library(oligo)
    # Assuming .CEL files for the 250K Sty chip are in the working directory
    celFiles <- list.celfiles()
    data <- read.celfiles(celFiles)
    ```

3.  **Preprocessing and Genotyping**:
    Once the data object is created, you can perform Robust Multichip Analysis (RMA) or genotype calling. The `pd.mapping250k.sty` package ensures that the probes are correctly grouped into their respective SNP sets.
    ```r
    # Preprocessing
    eset <- rma(data)

    # Genotype calling using CRLMM
    library(crlmm)
    calls <- crlmm(celFiles)
    ```

## Usage Tips

-   **Platform Identification**: Ensure your CEL files are specifically from the "Mapping250K_Sty" array. If you are using the "Mapping250K_Nsp" array, you must use the `pd.mapping250k.nsp` package instead.
-   **Database Access**: You can inspect the underlying SQLite database if needed, though this is rarely required for standard workflows:
    ```r
    conn <- db(pd.mapping250k.sty)
    dbListTables(conn)
    ```
-   **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient memory when working with large batches of 250K SNP arrays.

## Reference documentation

- [pd.mapping250k.sty Reference Manual](./references/reference_manual.md)