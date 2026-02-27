---
name: bioconductor-sfedata
description: The SFEData package provides a collection of real-world spatial transcriptomics datasets formatted as SpatialFeatureExperiment objects or raw technology outputs. Use when user asks to load example spatial transcriptomics data, access benchmark datasets for technologies like Xenium or Visium, or download raw data files for testing spatial data-loading functions.
homepage: https://bioconductor.org/packages/release/data/experiment/html/SFEData.html
---


# bioconductor-sfedata

## Overview

The `SFEData` package provides a collection of real-world spatial transcriptomics datasets. Most datasets are returned as `SpatialFeatureExperiment` objects, which integrate gene expression data with `sf` (Simple Features) geometries for tissue boundaries, cell segments, and other spatial annotations. It also provides raw output subsets from various technologies to test data-loading functions.

## Installation

Install the package via Bioconductor:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("SFEData")
library(SFEData)
```

## Loading SFE Datasets

Datasets are retrieved using specific functions named after the study or technology. Many functions use a `dataset` argument to select specific samples or subsets.

### Visium Data
```r
# Load a small subset for quick examples
sfe_small <- McKellarMuscleData(dataset = "small")

# Load the full dataset (includes spots outside tissue)
sfe_full <- McKellarMuscleData(dataset = "full")
```

### Xenium, CosMX, and MERFISH
```r
# Xenium: Human breast cancer (FFPE)
sfe_xenium <- JanesickBreastData(dataset = "rep1")

# CosMX: Human non-small cell lung cancer
sfe_cosmx <- HeNSCLCData()

# MERFISH: Mouse liver
sfe_merfish <- VizgenLiverData()
```

### Other Technologies
*   **Slide-seq2**: `BiermannMelaMetasData()` (Melanoma metastasis)
*   **seqFISH**: `LohoffGastrulationData()` (Mouse gastrulation)

## Accessing Raw Technology Outputs

Functions ending in `*Output()` download small subsets of raw data files (e.g., CSVs, H5, images) in the original format of the technology. These are not SFE objects but are used to test `SpatialFeatureExperiment` reading functions.

```r
# Download raw CosMX output files to a specific directory
raw_path <- CosMXOutput(file_path = "my_data_folder")

# Use the path with reading functions from other packages
# sfe <- readCosMX(raw_path)
```

## Usage Tips

1.  **Caching**: Datasets are downloaded and cached locally using `ExperimentHub`. Subsequent calls will load data from the cache rather than re-downloading.
2.  **Dependencies**: Loading these datasets will automatically trigger the loading of the `SpatialFeatureExperiment` package.
3.  **Sample IDs**: When working with functions like `McKellarMuscleData()`, check the `sample_id` in the resulting SFE object, especially when merging multiple datasets.
4.  **Geometry**: Use `rowGeometries(sfe)` or `colGeometries(sfe)` to inspect the spatial shapes (like cell boundaries) provided with the data.

## Reference documentation

- [Example SpatialFeatureExperiment datasets](./references/SFEData.Rmd)
- [SFEData Package Documentation](./references/SFEData.md)