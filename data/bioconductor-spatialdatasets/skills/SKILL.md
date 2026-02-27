---
name: bioconductor-spatialdatasets
description: This package provides a curated collection of publicly available spatially-resolved omics datasets pre-formatted into standard Bioconductor classes. Use when user asks to load example spatial transcriptomics or proteomics data, access SpatialExperiment objects for benchmarking, or retrieve curated datasets from studies like Keren 2018 or Vannan 2025.
homepage: https://bioconductor.org/packages/release/data/experiment/html/SpatialDatasets.html
---


# bioconductor-spatialdatasets

## Overview

The `SpatialDatasets` package provides a curated collection of publicly available spatially-resolved omics datasets. These datasets are pre-formatted into standard Bioconductor classes, primarily `SpatialExperiment`, making them immediately compatible with downstream analysis tools like `spatstat`, `ggspavis`, and `BayesSpace`.

## Installation

Install the package using `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("SpatialDatasets")
```

## Loading Datasets

Datasets are typically loaded using specific accessor functions. Most return a `SpatialExperiment` (SPE) object.

### SpatialExperiment Datasets
The following functions load data directly into an R session:

*   **Keren et al. (2018) - MIBI-TOF (Breast Cancer):**
    ```r
    spe <- spe_Keren_2018()
    ```
*   **Ferguson et al. (2022) - IMC (Squamous Cell Carcinoma):**
    ```r
    spe <- spe_Ferguson_2022()
    ```
*   **Schurch et al. (2020) - CODEX (Colorectal Cancer):**
    ```r
    spe <- spe_Schurch_2020()
    ```
*   **Ali et al. (2020) - IMC (Breast Cancer):**
    ```r
    spe <- spe_Ali_2020()
    ```
*   **Amancherla et al. (2025) - Xenium (Heart Transplant):**
    ```r
    spe <- spe_Amancherla_2025()
    ```
*   **Vannan et al. (2025) - Xenium (Pulmonary Fibrosis):**
    ```r
    spe <- spe_Vannan_2025()
    ```

### Image Data (CytoImageList)
For datasets containing raw or processed images (like the Ferguson IMC data), you must unzip the provided resource and load it using `cytomapper`.

```r
library(cytomapper)
library(HDF5Array)

# Get path to the zipped images
zip_path <- Ferguson_Images()
tmp_dir <- tempfile()
unzip(zip_path, exdir = tmp_dir)

# Load as CytoImageList
images <- loadImages(
  tmp_dir,
  single_channel = TRUE,
  on_disk = TRUE,
  h5FilesPath = getHDF5DumpDir()
)
```

## Typical Workflow

1.  **Load the Library:** `library(SpatialDatasets)` and `library(SpatialExperiment)`.
2.  **Retrieve Data:** Call the specific accessor function (e.g., `spe <- spe_Keren_2018()`).
3.  **Inspect Metadata:** Check `colData(spe)` for sample identifiers, cell types, or clinical variables.
4.  **Access Coordinates:** Use `spatialCoords(spe)` to retrieve the X and Y positions of cells/spots.
5.  **Access Assays:** Use `assay(spe, "counts")` or `assay(spe, "intensities")` depending on the platform.

## Tips for Usage

*   **ExperimentHub:** These datasets are hosted on ExperimentHub. The first time you call an accessor, the data will be downloaded and cached locally. Subsequent calls will load the data from the cache.
*   **Memory Management:** Some datasets (like Vannan 2025) contain over 1.6 million cells. Ensure your R environment has sufficient RAM or use `DelayedArray` approaches if the object is backed by HDF5.
*   **Column Names:** Note that some datasets use `x` and `y` for spatial coordinates, while others (like Ali 2020) may use `Location_Center_X` and `Location_Center_Y`. Always check `spatialCoordsNames(spe)`.

## Reference documentation

- [The SpatialDatasets package](./references/SpatialDatasets_overview.md)