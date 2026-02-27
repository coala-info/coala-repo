---
name: bioconductor-mudata
description: The MuData package provides a Bioconductor interface for reading and writing multimodal omics data in the HDF5-based .h5mu format. Use when user asks to read or write H5MU files, convert between MultiAssayExperiment objects and the MuData format, or handle large-scale multimodal datasets in backed mode.
homepage: https://bioconductor.org/packages/release/bioc/html/MuData.html
---


# bioconductor-mudata

## Overview
The `MuData` package provides a Bioconductor-native interface for the MuData (Multimodal Data) format. It facilitates cross-platform sharing of large-scale multimodal omics data by providing a bridge between R's `MultiAssayExperiment` (MAE) objects and the HDF5-based `.h5mu` file standard used extensively in the Python `muon` and `scanpy` ecosystems.

## Core Workflows

### 1. Reading and Writing H5MU Files
The primary functions for file I/O are `readH5MU` and `writeH5MU`.

```r
library(MuData)
library(MultiAssayExperiment)

# Write an existing MultiAssayExperiment to disk
writeH5MU(mae_object, "output_data.h5mu")

# Read an H5MU file into a MultiAssayExperiment object
mae <- readH5MU("input_data.h5mu")
```

### 2. Working with Large Datasets (Backed Mode)
For datasets that exceed available RAM, use the `backed = TRUE` argument. This loads matrices as `DelayedMatrix` objects, keeping the bulk of the data on disk.

```r
# Load data without reading full matrices into memory
mae_backed <- readH5MU("large_dataset.h5mu", backed = TRUE)

# Check class of an assay (will be DelayedMatrix)
class(assay(mae_backed[[1]]))
```

### 3. Integrating CITE-seq Data
MuData is commonly used to store CITE-seq data (RNA + ADT). You can combine `SingleCellExperiment` objects into an MAE and then export.

```r
# Example: Preparing a CITE-seq MAE
experiments <- list(
  RNA = sce_rna,
  ADT = sce_adt
)
mae <- MultiAssayExperiment(experiments)

# Export for use in Python/Muon
writeH5MU(mae, "citeseq_processed.h5mu")
```

## Key Functions Reference
- `readH5MU(file, backed = FALSE)`: Imports a `.h5mu` file. Returns a `MultiAssayExperiment`.
- `writeH5MU(mae, file)`: Exports a `MultiAssayExperiment` to a `.h5mu` file.
- `rhdf5::h5ls("file.h5mu")`: Useful for inspecting the internal HDF5 structure (e.g., checking `mod`, `obs`, or `var` groups) before loading.

## Implementation Tips
- **Modality Mapping**: In the `.h5mu` file, modalities are stored under the `mod` group. These become individual "experiments" within the R `MultiAssayExperiment`.
- **Metadata Preservation**: `colData` (cell metadata) and `rowData` (feature metadata) are synchronized during the conversion process.
- **Assay Layers**: Multiple assays (e.g., `counts` and `logcounts`) are stored in the `layers` subgroup of each modality in the H5MU file.
- **Reduced Dimensions**: PCA, UMAP, and TSNE results are typically stored in the `obsm` (observation metadata) slot. While `readH5MU` focuses on the core MAE structure, these can be inspected using `rhdf5` if they are not automatically mapped to `reducedDims`.

## Reference documentation
- [Blood CITE-seq with MuData](./references/Blood-CITE-seq.md)
- [Cord Blood CITE-seq with MuData](./references/Cord-Blood-CITE-seq.md)
- [Getting started with MuData for MultiAssayExperiment](./references/Getting-Started.md)