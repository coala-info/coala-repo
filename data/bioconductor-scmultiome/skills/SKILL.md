---
name: bioconductor-scmultiome
description: This tool provides access to pre-processed single-cell multiomic datasets and transcription factor binding site data from Bioconductor. Use when user asks to list available multiome datasets, retrieve specific experiments as MultiAssayExperiment objects, or access genomic binding site data for human and mouse genomes.
homepage: https://bioconductor.org/packages/release/data/experiment/html/scMultiome.html
---


# bioconductor-scmultiome

name: bioconductor-scmultiome
description: Access and manage single-cell multiomic datasets (scRNA-seq, scATAC-seq) from Bioconductor. Use this skill to list available multiome datasets, retrieve specific experiments as MultiAssayExperiment objects, and access transcription factor binding site data (ChIP-seq) for hg19, hg38, and mm10 genomes.

# bioconductor-scmultiome

## Overview

The `scMultiome` package provides a collection of pre-processed public single-cell multiomic datasets. These datasets are packaged into `MultiAssayExperiment` (MAE) objects, which integrate multiple modalities (like gene expression and chromatin accessibility) on a per-cell basis. A key feature of this package is its ability to selectively load specific modalities into memory from HDF5 files, which is essential for handling large multiomic data.

## Installation

```r
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("scMultiome")
```

## Basic Workflow

### 1. List Available Datasets
Use `listDatasets()` to see a table of available studies, including species, cell numbers, and disk size.

```r
library(scMultiome)
listDatasets()
```

### 2. Retrieve a Dataset
Datasets are accessed via specific accessor functions (e.g., `PBMC_10x()`, `reprogramSeq()`, `prostateENZ()`).

```r
# Load a specific dataset
mae <- PBMC_10x()

# View metadata without downloading the full object
PBMC_10x(metadata = TRUE)
```

### 3. Selective Loading
Because multiomic data can be large, you can specify which experiments to load.

```r
# Only load the RNA-seq modality
mae_rna <- PBMC_10x(experiments = "rna")
```

### 4. Access Transcription Factor Binding Sites
The package provides `GRangesList` objects containing TF binding sites compiled from ENCODE and ChIP-Atlas.

```r
# Access hg38 TF binding data from ChIP-Atlas
tfs <- tfBinding(genome = "hg38", source = "atlas")
```

## Data Structures

*   **MultiAssayExperiment (MAE):** The primary container. Use `experiments(mae)` to see modalities and `colData(mae)` for cell-level metadata.
*   **SingleCellExperiment:** Individual experiments within the MAE (e.g., `mae[[1]]`) typically follow this class, supporting `reducedDims` (PCA, UMAP) and `altExps`.
*   **DelayedMatrix:** Assays are often represented as `DelayedMatrix` objects to save memory by keeping data on disk until needed.

## Developer Tasks: Adding Datasets

If contributing data, use the following utility functions:
*   `saveMAE(mae, fileName)`: Saves an MAE into HDF5 format, splitting modalities for selective loading.
*   `testFile(fileName)`: Validates that the saved HDF5 file can be reconstructed into an MAE.
*   `makeMakeMetadata("dataset_name")`: Generates a template script for ExperimentHub metadata.
*   `uploadFile(file, sasToken)`: Uploads the processed HDF5 file to Bioconductor staging.

## Reference documentation

- [scMultiome tutorial](./references/scMultiome.md)