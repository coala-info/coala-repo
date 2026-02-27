---
name: bioconductor-scthi.data
description: This package provides curated single-cell RNA-seq datasets from glioma studies for testing and demonstrating ligand-receptor interaction analyses. Use when user asks to load example glioma expression matrices, access scTHI tutorial data, or retrieve curated single-cell datasets for tumor-host interaction modeling.
homepage: https://bioconductor.org/packages/release/data/experiment/html/scTHI.data.html
---


# bioconductor-scthi.data

name: bioconductor-scthi.data
description: Access and use example single-cell RNA-seq datasets from the scTHI.data package. Use this skill when a user needs to load glioma-related single-cell expression matrices and metadata for testing the scTHI (single-cell Tumor-Host Interaction) package or for demonstrating ligand-receptor interaction analysis.

# bioconductor-scthi.data

## Overview

The `scTHI.data` package is a Bioconductor ExperimentData package providing curated single-cell RNA-seq datasets. These datasets are specifically designed to support the `scTHI` package, which identifies significant ligand-receptor interactions between tumor cells and their microenvironment. The data includes expression matrices and clinical/cell-type annotations from public glioma studies (H3K27M and IDH-mutant gliomas).

## Data Loading and Usage

To use the datasets, first load the library and then use the `data()` function to load specific objects into the R environment.

```r
# Load the package
library(scTHI.data)

# List available datasets in the package
data(package = "scTHI.data")
```

### Available Datasets

The package provides three primary sets of data:

1.  **H3K27M Glioma Data (Filbin et al., 2018)**
    *   `H3K27`: A 21,673 x 527 expression matrix (Patient BCH836).
    *   `H3K27.meta`: A 527 x 9 data frame containing cell annotations.
    
2.  **IDH-mutant Glioma Data (Venteicher et al., 2017)**
    *   `MGH45`: A 17,584 x 608 expression matrix.
    *   `MGH45.annotation`: A 608 x 2 data frame with cell annotations.

3.  **Synthetic/Tutorial Data**
    *   `scExample`: A small 2,000 x 100 matrix used for quick demonstrations and manual examples.

### Typical Workflow

These datasets are typically used as input for the `scTHI` scoring functions.

```r
# Load H3K27 data
data(H3K27)
data(H3K27.meta)

# Inspect the data
dim(H3K27)
head(H3K27.meta)

# Example: Preparing for scTHI analysis
# Usually requires a count matrix and a vector of cell types
cell_types <- H3K27.meta$cell_type # Replace with actual column name from meta
```

## Tips for Usage

*   **Matrix Format**: The expression matrices are standard R `matrix` objects. If your analysis pipeline requires `SingleCellExperiment` or `Seurat` objects, you will need to wrap these matrices using the respective constructors (e.g., `SingleCellExperiment(assays = list(counts = H3K27))`).
*   **Gene Symbols**: The rows are indexed by gene symbols. Ensure your ligand-receptor database matches this nomenclature.
*   **Memory**: While these are "example" datasets, the H3K27 and MGH45 matrices are of moderate size. Ensure sufficient RAM is available when loading multiple datasets simultaneously.

## Reference documentation

- [scTHI.data Reference Manual](./references/reference_manual.md)