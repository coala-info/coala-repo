---
name: bioconductor-tenxbusdata
description: The TENxBUSData package provides streamlined access to pre-processed 10X Genomics datasets in the BUS format for single-cell RNA-seq analysis. Use when user asks to download 10X Genomics BUS files, list available single-cell datasets, or retrieve example data for BUSpaRse workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/TENxBUSData.html
---

# bioconductor-tenxbusdata

## Overview

The `TENxBUSData` package is a Bioconductor ExperimentData package that provides streamlined access to several 10X Genomics datasets already processed into the BUS (Barcode, UMI, Set) format. This format is a highly efficient intermediate representation of single-cell RNA-seq data. The package serves as a data provider for downstream analysis in R, particularly for workflows involving the `BUSpaRse` package, which converts BUS files into sparse matrices for standard single-cell analysis.

## Installation and Setup

To use this package, ensure `BiocManager` and `ExperimentHub` are installed:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("TENxBUSData")
library(TENxBUSData)
library(ExperimentHub)
```

## Typical Workflow

### 1. List Available Datasets
You can query ExperimentHub to see the specific datasets available through this package:

```r
eh <- ExperimentHub()
listResources(eh, "TENxBUSData")
```

### 2. Download BUS Data
Use the `TENxBUSData()` function to download a specific dataset to a local directory.

**Available Dataset IDs:**
- `"hgmm100"`: 100 1:1 Mixture of Human (HEK293T) and Mouse (NIH3T3) Cells (v2)
- `"hgmm1k"`: 1k 1:1 Mixture of Human (HEK293T) and Mouse (NIH3T3) Cells (v3)
- `"pbmc1k"`: 1k PBMCs from a Healthy Donor (v3)
- `"neuron10k"`: 10k Brain Cells from an E18 Mouse (v3)

**Example Download:**
```r
# Downloads the 100 cell mixture to a folder named 'out_hgmm100' in the current directory
TENxBUSData(dest_path = ".", dataset = "hgmm100", force = FALSE)
```

### 3. Inspect Downloaded Files
The function creates a subdirectory (e.g., `./out_hgmm100`) containing the following files required for BUS analysis:
- `matrix.ec`: The equivalence class file.
- `output.sorted` or `output.sorted.txt`: The sorted BUS file containing barcode, UMI, and equivalence class information.
- `transcripts.txt`: The list of transcripts used for the mapping.

```r
list.files("./out_hgmm100")
```

## Integration with Downstream Tools

Once the files are downloaded, they are typically processed using the `BUSpaRse` package to create a gene-count matrix:

```r
# Example conceptual usage with BUSpaRse
# library(BUSpaRse)
# tr2g <- transcript2gene(species = "Homo sapiens", ...)
# res_mat <- make_sparse_matrix("./out_hgmm100/output.sorted.txt", 
#                               tr2g = tr2g, est_ncells = 100)
```

## Reference documentation

- [Downloading BUS data](./references/downloading-10x-hgmm-data.md)
- [Downloading BUS data (Rmd)](./references/downloading-10x-hgmm-data.Rmd)