---
name: bioconductor-m3dexampledata
description: This package provides example single-cell RNA-Seq data from mouse embryos for testing and demonstrating the M3Drop analysis tool. Use when user asks to load example scRNA-Seq datasets, access the Mmus_example_list object, or provide sample data for benchmarking differential expression and feature selection workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/M3DExampleData.html
---


# bioconductor-m3dexampledata

name: bioconductor-m3dexampledata
description: Provides access to and instructions for using the M3DExampleData Bioconductor package. Use this skill when you need to load example single-cell RNA-Seq data (Deng et al. 2014) for testing, benchmarking, or demonstrating the M3Drop differential expression and feature selection package.

# bioconductor-m3dexampledata

## Overview
M3DExampleData is a specialized data package for Bioconductor that provides a subset of single-cell RNA-Seq expression data from mouse embryos (Deng et al. 2014). It is primarily designed to serve as the primary testing and demonstration dataset for the `M3Drop` package, which identifies differentially expressed genes based on dropout rates.

The dataset contains:
- A subset of mouse 2-cell embryos and blastocysts.
- Gene names provided as HGNC symbols.
- Labels indicating sampling timepoints.

## Loading the Data
To use this data, you must first load the package and then use the `data()` function to bring the object into your environment.

```r
# Load the package
library(M3DExampleData)

# Load the specific example dataset
data(Mmus_example_list)
```

## Data Structure
The primary object provided is `Mmus_example_list`. It is a list containing two main components:

1.  **data**: A numeric matrix of gene expression values (typically raw or normalized counts). Rows represent genes (HGNC symbols) and columns represent individual cells.
2.  **labels**: A character vector or factor indicating the experimental condition or timepoint for each cell in the `data` matrix.

### Inspecting the Object
```r
# Check the structure
str(Mmus_example_list)

# Access the expression matrix
expr_matrix <- Mmus_example_list$data

# Access the cell labels
cell_labels <- Mmus_example_list$labels

# View dimensions
dim(expr_matrix)
table(cell_labels)
```

## Typical Workflow
This package is almost exclusively used as input for `M3Drop` workflows.

```r
library(M3DExampleData)
library(M3Drop)

# Load data
data(Mmus_example_list)

# 1. Clean/Filter data (standard M3Drop step)
normalized_data <- M3DropConvertData(Mmus_example_list$data, is.counts=TRUE)

# 2. Run M3Drop feature selection
# This identifies genes with higher dropout rates than expected by their expression level
DE_genes <- M3DropFeatureSelection(normalized_data, mt_method="BHT", mt_threshold=0.05)
```

## Tips
- **Gene Symbols**: Note that while the data is from *Mus musculus*, the documentation indicates gene names are provided as HGNC symbols (typically used for human). Ensure your downstream annotation pipelines account for this.
- **Data Type**: The data is a subset. It is intended for functional demonstrations and may not be suitable for biological discovery on its own.
- **Memory**: As a "LazyData" package, the data is not loaded into memory until you explicitly call `data(Mmus_example_list)`.

## Reference documentation
- [M3DExampleData Reference Manual](./references/reference_manual.md)