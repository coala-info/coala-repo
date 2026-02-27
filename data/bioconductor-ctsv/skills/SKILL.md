---
name: bioconductor-ctsv
description: This tool identifies cell-type-specific spatially variable genes in bulk spatial transcriptomics data by integrating cell-type proportions. Use when user asks to detect genes with spatial expression patterns within specific cell types, perform cell-type-aware spatial transcriptomics analysis, or identify spatially variable genes after deconvolution.
homepage: https://bioconductor.org/packages/release/bioc/html/CTSV.html
---


# bioconductor-ctsv

name: bioconductor-ctsv
description: Identify cell-type-specific spatially variable (SV) genes in bulk spatial transcriptomics (ST) data. Use this skill when you need to perform spatial transcriptomics analysis that accounts for cell-type proportions (deconvolution) to find genes with spatial expression patterns within specific cell types.

# bioconductor-ctsv

## Overview

The `CTSV` package provides a statistical framework for detecting cell-type-specific spatially variable genes. While standard spatial transcriptomics tools identify genes that vary across space at a bulk level, `CTSV` integrates cell-type proportions (derived from deconvolution methods like RCTD, SPOTlight, or CARD) to pinpoint which specific cell types are driving the spatial variation. It is highly scalable, supporting datasets with tens of thousands of genes and hundreds of spatial spots.

## Installation

Install the package via BiocManager:

```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("CTSV")
```

## Core Workflow

### 1. Data Preparation
CTSV requires three primary inputs:
- **SpatialExpression**: A `SpatialExperiment` object containing the raw count bulk ST data.
- **Cell-Type Proportions (W)**: An $n \times K$ matrix where $n$ is the number of spots and $K$ is the number of cell types.
- **Coordinates**: Spatial coordinates (usually stored within the `SpatialExperiment` object).

```R
library(CTSV)
library(SpatialExperiment)

# Example of loading data
data("CTSVexample_data", package="CTSV")
spe <- CTSVexample_data[[1]] # SpatialExperiment object
W <- CTSVexample_data[[2]]   # Proportion matrix
```

### 2. Running the CTSV Model
The main function `CTSV` performs the detection. It is recommended to use multiple cores for efficiency.

```R
# Run the main analysis
# num_core: Number of cores for parallel processing
result <- CTSV(spe, W, num_core = 8)
```

### 3. Interpreting Results
The output is a list containing:
- `pval`: A $G \times 2K$ matrix of combined p-values (where $G$ is the number of genes).
- `qval`: A $G \times 2K$ matrix of adjusted q-values.

The $2K$ columns represent the spatial variation across two axes (usually x and y) for each of the $K$ cell types.

### 4. Identifying SV Genes
Use the `svGene` function to filter genes based on a False Discovery Rate (FDR) threshold.

```R
# Extract SV genes at 5% FDR
re <- svGene(result$qval, fdr = 0.05)

# Access the 0-1 indicator matrix
re$SV

# Access the list of gene names per cell type
re$SVGene
```

## Tips and Best Practices
- **Deconvolution First**: CTSV does not perform deconvolution itself. You must provide the cell-type proportion matrix `W` using external tools like RCTD or CARD before running `CTSV`.
- **Parallelization**: For large datasets (e.g., 20,000 genes), always set `num_core` to 4 or 8 to significantly reduce computation time.
- **SpatialExperiment**: Ensure your spatial coordinates are correctly assigned in the `SpatialExperiment` object, as `CTSV` retrieves them automatically from the object metadata.

## Reference documentation

- [Applying CTSV to Spatial Transcriptomics Data](./references/CTSV.Rmd)
- [CTSV Vignette](./references/CTSV.md)