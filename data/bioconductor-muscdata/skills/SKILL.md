---
name: bioconductor-muscdata
description: This tool retrieves multi-sample, multi-group single-cell RNA sequencing datasets formatted as SingleCellExperiment objects from the muscData package. Use when user asks to load complex experimental design scRNA-seq data, access the Kang18 or Crowell19 datasets, or retrieve benchmark data for differential state analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/muscData.html
---

# bioconductor-muscdata

name: bioconductor-muscdata
description: Access and load multi-sample, multi-group single-cell RNA sequencing (scRNA-seq) datasets from the muscData package. Use this skill when you need to retrieve complex experimental design datasets (e.g., Kang18_8vs8, Crowell19_4vs4) formatted as SingleCellExperiment objects for downstream analysis like differential state discovery.

## Overview

The `muscData` package provides a collection of publicly available scRNA-seq datasets characterized by complex experimental designs involving multiple samples across multiple conditions (e.g., control vs. treatment). These datasets are stored as `SingleCellExperiment` (SCE) objects and are hosted on Bioconductor's `ExperimentHub`.

## Available Datasets

The package currently includes the following key datasets:

- `Kang18_8vs8`: 10x PBMC data from 8 Lupus patients (16 samples total) before and after 6h treatment with INF-beta.
- `Crowell19_4vs4`: Single-nuclei RNA-seq data from 8 CD-1 mice (4 vehicle, 4 LPS-treated).

## Loading Data

There are two primary ways to load data from this package.

### 1. Using Accessor Functions (Recommended)
The simplest method is to call the dataset ID as a function. This returns a `SingleCellExperiment` object containing raw counts in the `counts` assay and metadata in `colData`.

```r
library(muscData)

# Load the Kang et al. dataset
sce <- Kang18_8vs8()

# View the object
sce
```

### 2. Using ExperimentHub
You can also use the `ExperimentHub` interface for more granular control or to search for specific versions.

```r
library(ExperimentHub)
eh <- ExperimentHub()

# Query for muscData resources
(q <- query(eh, "muscData"))

# Load via ExperimentHub ID (e.g., EH2259 for Kang18_8vs8)
sce <- eh[["EH2259"]]

# Alternatively, load using metadata search terms
sce <- loadResources(eh, "muscData", c("PBMC", "INF-beta"))[[1]]
```

## Data Structure and Metadata

Once loaded, the `SingleCellExperiment` object typically contains:
- **Assays**: Unfiltered raw `counts`.
- **colData**: Cell-level metadata such as `ind` (individual/sample ID), `stim` (condition/treatment), and `cluster` (cell type assignments).
- **rowData**: Gene-level metadata (e.g., ENSEMBL and SYMBOL).
- **reducedDims**: Pre-computed embeddings like `TSNE` (if available).

To view metadata without loading the full dataset:
```r
Kang18_8vs8(metadata = TRUE)
```

## Downstream Analysis Tips

- **Visualization**: Use the `scater` package for standard plots or `iSEE` for interactive exploration of the SCE object.
- **Differential State Analysis**: These datasets are specifically designed for benchmarking tools like `muscat` which perform multi-sample multi-group differential analysis.
- **Filtering**: The counts provided are raw; standard quality control and filtering (e.g., based on mitochondrial content or library size) should be performed before analysis.

## Reference documentation
- [Multi-sample multi-group scRNA-seq data](./references/muscData.Rmd)
- [Multi-sample multi-group scRNA-seq data](./references/muscData.md)