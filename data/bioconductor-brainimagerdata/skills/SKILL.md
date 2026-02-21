---
name: bioconductor-brainimagerdata
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/brainImageRdata.html
---

# bioconductor-brainimagerdata

name: bioconductor-brainimagerdata
description: Access and load brain maps and gene expression data for the brainImageR package. Use this skill when a user needs to retrieve prenatal or adult human brain spatial data, image masks, or expression metadata from the Allen Brain Institute via ExperimentHub for use in spatial and temporal brain enrichment analyses.

# bioconductor-brainimagerdata

## Overview

The `brainImageRdata` package is a data experiment package that provides the necessary data structures for the `brainImageR` companion package. It contains high-quality brain maps, image masks, and gene expression data derived from the Allen Brain Institute. These datasets are essential for performing spatial enrichment analysis (visualizing gene expression on brain slices) and temporal analysis (predicting developmental timepoints).

The data is hosted on Bioconductor's `ExperimentHub`, meaning it is downloaded on demand rather than stored locally within the package installation.

## Data Access Workflow

To use these datasets, you must use the `ExperimentHub` interface. The data is generally intended to be consumed internally by `brainImageR` functions, but can be accessed manually for custom analyses.

### Initializing ExperimentHub

```r
library(ExperimentHub)
hub <- ExperimentHub()
# Search for brainImageRdata resources
query(hub, "brainImageRdata")
```

### Loading Specific Datasets

Datasets are identified by "EH" accessors. Below are the primary categories:

#### 1. Spatial Analysis Data (Prenatal & Adult)
Used for `SpatialEnrichment`, `CreateBrain`, and `PlotBrain` in the companion package.

*   **Image Masks**: `hub[["EH1434"]]` (Prenatal) and `hub[["EH1435"]]` (Adult).
*   **Dimensions & Outlines**: Required for reconstructing brain images.
    *   Dimensions: `EH1436` (Prenatal), `EH1437` (Adult).
    *   Outlines: `EH1440` (Prenatal), `EH1441` (Adult).
*   **Tissue Abbreviations**: `EH1438` (Prenatal), `EH1439` (Adult).
*   **Available Slices**: `EH1443` (Prenatal), `EH1444` (Adult).

#### 2. Expression and Metadata
Used to map genes to specific microdissected brain regions.

*   **Expression Matrices**: `hub[["EH1445"]]` (Prenatal), `hub[["EH1446"]]` (Adult).
*   **Sample Metadata**: `hub[["EH1447"]]` (Prenatal), `hub[["EH1448"]]` (Adult).
*   **Gene Metadata**: `hub[["EH1449"]]` (Common to both).

#### 3. Temporal Analysis Data
Used for the `predict_time` function to estimate the developmental age of a sample.

*   **Scaled Expression (8wpc - 40y)**: `hub[["EH1451"]]`.
*   **Temporal Metadata**: `hub[["EH1450"]]`.

## Usage Tips

*   **Internal Referencing**: Most users do not need to load these objects manually. If you are using `brainImageR`, ensure `ExperimentHub` is functional and has internet access, as the package will call these IDs automatically.
*   **Memory Management**: These objects (especially the image masks and expression matrices) can be large. Load only the specific EH IDs required for your current analysis.
*   **Metadata Exploration**: To see the full description of any object before downloading, use `hub["EH1434"]` (single bracket) to view the metadata record.

## Reference documentation

- [brainImageRdata](./references/brainImageRdata.md)