---
name: bioconductor-multiassayexperiment
description: The MultiAssayExperiment package provides a coordinated container for managing and synchronizing multi-omics data across different assays and biological specimens. Use when user asks to create a multi-omics object, perform coordinated subsetting across multiple experiments, or reshape multi-assay data into long or wide formats for analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/MultiAssayExperiment.html
---


# bioconductor-multiassayexperiment

## Overview

The `MultiAssayExperiment` package provides a powerful R/Bioconductor container for managing multi-omics experiments. It solves the "bookkeeping" problem of relating different types of data (e.g., gene expression, mutations, protein abundance) measured on the same set of biological specimens. It ensures that any subsetting operation (by feature, sample, or assay) maintains synchronization across all data components.

## Core Components

A `MultiAssayExperiment` (MAE) object consists of three main slots:
1.  **`ExperimentList`**: A list-like container holding the actual data (e.g., `SummarizedExperiment`, `matrix`, `RaggedExperiment`).
2.  **`colData`**: A `DataFrame` containing primary metadata about the biological units (e.g., patient age, sex, clinical stage).
3.  **`sampleMap`**: A "graph" (three-column `DataFrame`) that links the `colData` rows to the columns of the experiments in the `ExperimentList`.

## Key Workflows

### 1. Creating a MultiAssayExperiment
If your sample names are identical across all assays and match the `colData` rownames, the constructor can often build the `sampleMap` automatically.

```r
library(MultiAssayExperiment)

# Basic construction
mae <- MultiAssayExperiment(
    experiments = list(rna = rna_se, mut = mut_matrix),
    colData = patient_metadata
)

# Using prepMultiAssay for complex/mismatched data
prepped <- prepMultiAssay(exp_list, col_data, sample_map)
mae <- MultiAssayExperiment(
    experiments = prepped$experiments,
    colData = prepped$colData,
    sampleMap = prepped$sampleMap
)
```

### 2. Coordinated Subsetting
The most powerful feature of MAE is the three-dimensional `[` operator: `mae[i, j, k]`.
-   **`i` (Rows)**: Subset by feature names (e.g., gene symbols) or `GRanges`.
-   **`j` (Columns)**: Subset by primary biological unit (e.g., Patient ID) or logical vectors based on `colData`.
-   **`k` (Assays)**: Subset by experiment name or index.

```r
# Subset to specific genes across all assays
mae_subset <- mae[c("TP53", "PTEN"), , ]

# Subset to only Stage IV patients
mae_stg4 <- mae[, mae$pathologic_stage == "stage iv", ]

# Subset to a specific assay
mae_rna <- mae[, , "RNASeq2GeneNorm"]
```

### 3. Data Extraction and Reshaping
Convert the complex container into formats suitable for downstream analysis or visualization.

-   **`longFormat`**: Returns a "tidy" `DataFrame` with one row per observation.
-   **`wideFormat`**: Returns a `DataFrame` with one row per primary unit, useful for correlation analysis.
-   **`assay(mae, i)`**: Quickly extract the matrix for the $i$-th experiment.
-   **`getWithColData(mae, i)`**: Extract a single assay and automatically append `colData` to its internal metadata.

```r
# Create a tidy table for ggplot2
df_long <- longFormat(mae[c("MAPK14"), , ], colDataCols = c("sex", "age"))

# Get common samples across all assays
mae_complete <- mae[, complete.cases(mae), ]
```

### 4. Management Helpers
-   **`intersectRows(mae)`**: Keep only features present in every experiment.
-   **`intersectColumns(mae)`**: Keep only biological units present in every experiment.
-   **`mergeReplicates(mae)`**: Use a summary function (like `mean`) to collapse technical replicates within assays.
-   **`c(mae, new_assay, mapFrom = 1L)`**: Concatenate a new experiment to an existing MAE.

## Tips for Success
-   **Endomorphism**: Most subsetting functions (`subsetByRow`, `subsetByColumn`) return a `MultiAssayExperiment` object.
-   **Double Brackets**: Use `mae[[1]]` or `mae[["assayName"]]` to extract the raw underlying data object (e.g., the `SummarizedExperiment`).
-   **Validation**: If the constructor fails, use `prepMultiAssay` to see which samples or experiments are failing to map correctly.

## Reference documentation
- [MultiAssayExperiment: The Integrative Bioconductor Container](./references/MultiAssayExperiment.md)
- [MultiAssayExperiment Cheatsheet](./references/MultiAssayExperiment_cheatsheet.md)
- [MultiAssayExperiment: Quick Start Guide](./references/QuickStartMultiAssay.md)
- [Using HDF5Array with MultiAssayExperiment](./references/UsingHDF5Array.md)