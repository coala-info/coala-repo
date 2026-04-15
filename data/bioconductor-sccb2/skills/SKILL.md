---
name: bioconductor-sccb2
description: This tool performs cell detection in droplet-based single-cell RNA sequencing data to distinguish true cells from background empty droplets. Use when user asks to call cells from raw 10x Genomics data, filter empty droplets using the scCB2 algorithm, or prepare high-quality count matrices for downstream analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/scCB2.html
---

# bioconductor-sccb2

name: bioconductor-sccb2
description: Cell detection in droplet-based single-cell RNA sequencing (scRNA-seq) data using the scCB2 package. Use this skill to distinguish true cells from background empty droplets by clustering similar barcodes and conducting statistical tests. Ideal for processing 10x Genomics raw data (Cell Ranger output or HDF5) and preparing high-quality count matrices for downstream analysis with Seurat or other tools.

## Overview

The `scCB2` package provides an improved method for cell calling in droplet-based scRNA-seq. It extends the `EmptyDrops` approach by grouping similar barcodes into clusters before testing them against a background distribution. This increases the power to detect real cells, especially those with lower RNA content, while maintaining control over the False Discovery Rate (FDR).

## Core Workflow

### 1. Loading Data
`scCB2` is designed to work seamlessly with 10x Genomics output.

```r
library(scCB2)

# Read from a directory containing barcodes.tsv, features.tsv, and matrix.mtx
# Supports both Cell Ranger v2 and v3 (compressed) formats
raw_mat <- Read10xRaw(dir = "/path/to/raw/data")

# For HDF5 files, use the QuickCB2 wrapper or standard HDF5 readers
```

### 2. Evaluating Background Cutoff
The "lower" parameter (default 100) defines which barcodes are used to estimate the background empty droplet distribution.

```r
# Check if the default cutoff of 100 is appropriate
check_cutoff <- CheckBackgroundCutoff(raw_mat)
check_cutoff$recommended_cutoff
```
*Tip: A good cutoff should put >90% of barcodes or >10% of total UMI counts into the background.*

### 3. Cell Calling (The CB2 Algorithm)
Use `CB2FindCell` for detailed control or `QuickCB2` for an automated pipeline.

**Detailed Approach:**
```r
# Run CB2 with FDR control and parallel processing
CBOut <- CB2FindCell(raw_mat, FDR_threshold = 0.01, lower = 100, Ncores = 2)

# Extract the filtered count matrix
# MTfilter: removes cells with mitochondrial proportion > 0.25
real_cells <- GetCellMat(CBOut, MTfilter = 0.25)
```

**All-in-One Approach:**
```r
# Directly from directory to Seurat object
seurat_obj <- QuickCB2(dir = "/path/to/raw/data", AsSeurat = TRUE)
```

### 4. Downstream Integration
The output of `GetCellMat` is a sparse matrix compatible with standard scRNA-seq workflows.

```r
# Create Seurat object manually
library(Seurat)
seurat_obj <- CreateSeuratObject(counts = real_cells)

# Save to 10x format for other tools
DropletUtils::write10xCounts(path = "./filtered_feature_bc_matrix", x = real_cells)
```

## Key Considerations
- **Multiplets:** `scCB2` does not explicitly filter for doublets or multiplets. Use packages like `DoubletFinder` or `scDblFinder` after cell calling.
- **Low-Quality Cells:** While `scCB2` distinguishes cells from background, some identified "cells" may be damaged. Always use `MTfilter` in `GetCellMat` or perform standard QC filtering afterwards.
- **Computational Speed:** For a dataset with ~8,000 cells, processing typically takes less than 10 minutes using 6 cores.

## Reference documentation

- [CB2 improves power of cell detection in droplet-based single-cell RNA sequencing data](./references/scCB2.md)
- [scCB2 Vignette Source](./references/scCB2.Rmd)