---
name: bioconductor-hcadata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/HCAData.html
---

# bioconductor-hcadata

name: bioconductor-hcadata
description: Access and download Human Cell Atlas (HCA) datasets as SingleCellExperiment objects. Use this skill when you need to retrieve large-scale single-cell RNA-seq data from the HCA project for analysis in R/Bioconductor, particularly for immune cell census data from bone marrow or umbilical cord blood.

# bioconductor-hcadata

## Overview

The `HCAData` package provides a streamlined interface to the Human Cell Atlas (HCA) project datasets. It retrieves data via `ExperimentHub` and returns it as a `SingleCellExperiment` object. A key feature is its use of `HDF5Array`, which allows users to work with massive datasets (hundreds of thousands of cells) without loading the entire count matrix into memory, only accessing subsets as needed.

## Installation

```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("HCAData")
```

## Core Workflow

### 1. List Available Datasets
To see which datasets are currently available for download:

```R
library(HCAData)
HCAData()
```

### 2. Load a Dataset
Pass the dataset name (from the list above) to the `HCAData()` function. This downloads the HDF5 count matrix and associated metadata.

```R
# Load the Bone Marrow dataset
sce_bm <- HCAData("ica_bone_marrow")

# Load the Cord Blood dataset
sce_cb <- HCAData("ica_cord_blood")
```

### 3. Inspect the Object
The resulting object is a `SingleCellExperiment`. Note that the `counts` assay is typically a `DelayedMatrix` (HDF5-backed).

```R
sce_bm
# View row (gene) and column (cell) metadata
rowData(sce_bm)
colData(sce_bm)
```

## Data Processing Tips

### Subsampling for Efficiency
Because HCA datasets are very large (e.g., >300,000 cells), it is often practical to subset the data for initial exploratory analysis.

```R
set.seed(42)
# Randomly sample 1000 cells
sce_subset <- sce_bm[, sample(ncol(sce_bm), 1000)]
```

### Realizing Data
If you have subset the data to a small enough size and wish to speed up computations, you can "realize" the HDF5-backed matrix into a standard in-memory matrix.

```R
library(scuttle)
# Convert DelayedMatrix to standard matrix in memory
counts(sce_subset) <- as.matrix(counts(sce_subset))
```

### Standard Pre-processing
Typical downstream steps using `scater` and `scran`:

1.  **Feature Naming**: Use `uniquifyFeatureNames` to handle gene symbols.
2.  **Quality Control**: Use `addPerCellQC` to identify low-quality cells (e.g., high mitochondrial content).
3.  **Normalization**: Use `librarySizeFactors` or `computeSumFactors` (deconvolution).
4.  **Variance Modelling**: Use `modelGeneVarByPoisson` to find highly variable genes.
5.  **Dimensionality Reduction**: Use `denoisePCA`, `runTSNE`, or `runUMAP`.

## Interactive Exploration
The `iSEE` package is the recommended tool for interactive exploration of these datasets.

```R
library(iSEE)
iSEE(sce_subset)
```

## Reference documentation

- [Accessing the Human Cell Atlas datasets](./references/hcadata.md)