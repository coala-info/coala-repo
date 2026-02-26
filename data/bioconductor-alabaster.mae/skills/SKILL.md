---
name: bioconductor-alabaster.mae
description: This package provides language-agnostic storage and retrieval for MultiAssayExperiment objects using the alabaster framework. Use when user asks to save MultiAssayExperiment objects to disk, load MultiAssayExperiment data from a directory, or manage portable multi-omics data artifacts.
homepage: https://bioconductor.org/packages/release/bioc/html/alabaster.mae.html
---


# bioconductor-alabaster.mae

## Overview

The `alabaster.mae` package is part of the **alabaster** ecosystem, designed to facilitate the "language-agnostic" storage of Bioconductor objects. It specifically handles `MultiAssayExperiment` (MAE) objects, which coordinate multiple different assays (e.g., RNA-seq, ChIP-seq, Proteomics) performed on the same set of biological samples. By using this package, users can save an entire MAE into a structured directory of HDF5 and JSON files, making the data easily shareable and reproducible across different environments.

## Core Workflow

The package follows the standard `alabaster` interface using two primary functions: `saveObject()` and `readObject()`.

### Saving a MultiAssayExperiment

To save an MAE object to disk, specify the object and a destination directory.

```r
library(alabaster.mae)

# Assuming 'mae' is an existing MultiAssayExperiment object
staging_dir <- tempfile("my_mae_data")

# Save the object to the directory
saveObject(mae, staging_dir)
```

The resulting directory will contain:
- `OBJECT`: A file identifying the object type.
- `sample_map.h5`: The mapping between primary samples and assay-specific columns.
- `sample_data/`: Global metadata for the samples.
- `experiments/`: Sub-directories for each individual assay (e.g., `SummarizedExperiment` or `SingleCellExperiment` objects), each saved using their respective `alabaster` handlers.

### Loading a MultiAssayExperiment

To reload a saved MAE, simply point `readObject()` to the directory.

```r
# Load the object back into R
roundtrip <- readObject(staging_dir)

# Confirm the class
class(roundtrip) 
# [1] "MultiAssayExperiment"
```

## Usage Tips

- **Dependencies**: `alabaster.mae` automatically triggers other `alabaster` packages (like `alabaster.se` for SummarizedExperiments or `alabaster.ranges` for genomic ranges) to handle the constituent parts of the MAE.
- **Portability**: The saved directory is designed to be portable. As long as the directory structure is maintained, it can be moved to different file systems or cloud storage and re-read into R.
- **Staging**: When using `saveObject()`, the directory should either not exist or be empty; `alabaster` prefers creating a fresh "artifact" to ensure data integrity.

## Reference documentation

- [Saving MultiAssayExperiments to artifacts and back again](./references/userguide.md)