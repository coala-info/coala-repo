---
name: bioconductor-stexampledata
description: This package provides a collection of curated spatial transcriptomics datasets from various platforms formatted as SpatialExperiment objects. Use when user asks to load example spatial transcriptomics data, access standardized datasets for benchmarking, or retrieve spatial data from platforms like Visium, Xenium, and CosMx.
homepage: https://bioconductor.org/packages/release/data/experiment/html/STexampleData.html
---


# bioconductor-stexampledata

name: bioconductor-stexampledata
description: Provides access to a collection of curated spatial transcriptomics (ST) datasets from various platforms (Visium, Xenium, CosMx, MERSCOPE, etc.) formatted as SpatialExperiment objects. Use this skill when you need to load standardized example ST data for tutorials, benchmarking, or demonstrating spatial analysis workflows in R.

# bioconductor-stexampledata

## Overview
The `STexampleData` package provides a standardized collection of spatial transcriptomics datasets from multiple technological platforms. Most datasets are pre-formatted into the `SpatialExperiment` Bioconductor class, making them immediately compatible with modern spatial analysis tools. These datasets are ideal for testing algorithms, creating reproducible examples, or learning spatial data structures.

## Installation
Install the package using `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("STexampleData")
```

## Loading Data
There are two primary ways to load datasets: using named accessor functions or querying `ExperimentHub`.

### Method 1: Named Accessors (Recommended)
This is the most direct way to load a specific dataset.

```r
library(STexampleData)
library(SpatialExperiment)

# Load a specific dataset (e.g., Visium Human DLPFC)
spe <- Visium_humanDLPFC()

# Inspect the object
spe
```

### Method 2: ExperimentHub
Use this method to browse or programmatically select datasets.

```r
library(ExperimentHub)
eh <- ExperimentHub()
myfiles <- query(eh, "STexampleData")

# Load by ID
spe <- myfiles[["EH9628"]]
```

## Available Datasets by Platform

### 10x Genomics Visium
*   `Visium_humanDLPFC()`: Human brain dorsolateral prefrontal cortex (subset).
*   `Visium_mouseCoronal()`: Adult mouse brain coronal section.
*   `Janesick_breastCancer_Visium()`: Human breast cancer FFPE tissue.

### 10x Genomics Xenium (In Situ)
*   `Janesick_breastCancer_Xenium_rep1()`: Human breast cancer (replicate 1).
*   `Janesick_breastCancer_Xenium_rep2()`: Human breast cancer (replicate 2).

### Other High-Resolution / In Situ Platforms
*   `seqFISH_mouseEmbryo()`: Mouse embryogenesis (subset).
*   `SlideSeqV2_mouseHPC()`: Mouse hippocampus and surrounding regions.
*   `CosMx_lungCancer()`: NanoString CosMx human non-small cell lung cancer.
*   `MERSCOPE_ovarianCancer()`: Vizgen MERSCOPE human ovarian cancer.
*   `STARmapPLUS_mouseBrain()`: STARmap PLUS mouse brain section.
*   `ST_mouseOB()`: Legacy Spatial Transcriptomics (Stahl et al.) mouse olfactory bulb.

### Single-Cell RNA-seq (Reference)
*   `Janesick_breastCancer_Chromium()`: Returns a `SingleCellExperiment` object for integration with the breast cancer spatial datasets.

## Typical Workflow
1.  **Load the library**: `library(STexampleData)`
2.  **Retrieve the object**: `spe <- Visium_humanDLPFC()`
3.  **Access spatial data**:
    *   `spatialCoords(spe)`: Get x, y coordinates.
    *   `imgData(spe)`: Access associated histology images (for Visium).
4.  **Access expression data**:
    *   `counts(spe)`: Get the raw count matrix.
    *   `rowData(spe)`: Get gene metadata.
    *   `colData(spe)`: Get spot/cell metadata (often includes ground truth or cell type labels).

## Reference documentation
- [STexampleData overview](./references/STexampleData_overview.md)