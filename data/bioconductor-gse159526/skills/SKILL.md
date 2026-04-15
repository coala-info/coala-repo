---
name: bioconductor-gse159526
description: This tool provides access to human placental methylome DNA methylation data from the GSE159526 dataset via ExperimentHub. Use when user asks to retrieve raw rgset objects, access processed methylation matrices, or analyze cell-specific placental epigenetic data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/GSE159526.html
---

# bioconductor-gse159526

name: bioconductor-gse159526
description: Access and analyze placental methylome DNA methylation data from the GSE159526 dataset. Use this skill to retrieve raw rgset objects, processed methylation matrices, and sample metadata via ExperimentHub for cell-specific characterization of the human placenta.

# bioconductor-gse159526

## Overview

The GSE159526 package provides access to DNA methylation data from a cell-specific study of the human placental methylome. The data is hosted on Bioconductor's ExperimentHub and includes raw intensity data (IDATs), normalized methylation values, and detailed sample metadata. This dataset is primarily used for epigenetics research involving placental development and cell-type-specific methylation patterns.

## Data Retrieval Workflow

To use this package, you must interact with the `ExperimentHub` interface.

### 1. Initialize ExperimentHub and Query
Load the library and search for the GSE159526 records.

```r
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, "GSE159526")
```

### 2. Load Specific Data Objects
The package contains three primary resources. Access them using their unique ExperimentHub identifiers:

*   **Raw DNA Methylation Data (EH6130)**: Returns an `RGChannelSet` (rgset) object. This requires the `minfi` package to be loaded.
*   **Processed Data (EH6131)**: Returns a normalized and filtered DNA methylation data matrix.
*   **Sample Metadata (EH6132)**: Returns a `tibble` or `data.frame` containing sample information.

```r
# Load sample metadata first to understand the cohort
sample_info <- eh[['EH6132']]

# Load processed methylation matrix
meth_data <- eh[['EH6131']]

# Load raw data (requires minfi)
library(minfi)
raw_rgset <- eh[['EH6130']]
```

## Typical Analysis Tasks

### Inspecting Metadata
Examine the `sample_info` object to identify cell types, tissue sources, or patient demographics associated with the methylation profiles.

### Working with Raw Data
If using the `rgset` (EH6130), use `minfi` functions for quality control and normalization:
*   Use `detP()` to calculate detection p-values.
*   Use `preprocessQuantile()` or `preprocessNoob()` for normalization.

### Working with Processed Data
The processed matrix (EH6131) is ready for downstream statistical analysis, such as:
*   Differential methylation analysis using `limma`.
*   Cell-type deconvolution or composition analysis.
*   Visualization via heatmaps or PCA.

## Tips
*   **Caching**: ExperimentHub downloads data to a local cache. Subsequent calls to the same EH ID will be significantly faster.
*   **Memory**: The raw `rgset` (EH6130) can be memory-intensive. Ensure your R session has sufficient RAM when loading raw intensity data.
*   **Citation**: Use `citation("GSE159526")` to get the proper reference for the study (Yuan et al., 2021, BMC Genomics).

## Reference documentation
- [Access GSE159526 data using Bioconductor's ExperimentHub](./references/GSE159526.Rmd)
- [Access GSE159526 data using Bioconductor's ExperimentHub](./references/GSE159526.md)