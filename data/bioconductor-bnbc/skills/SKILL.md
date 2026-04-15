---
name: bioconductor-bnbc
description: This tool performs normalization and batch correction for Hi-C contact matrices across multiple samples. Use when user asks to normalize Hi-C data, remove batch effects from contact matrices, perform logCPM transformations, or smooth Hi-C replicates using the BNBC algorithm.
homepage: https://bioconductor.org/packages/release/bioc/html/bnbc.html
---

# bioconductor-bnbc

name: bioconductor-bnbc
description: Normalization and batch correction for Hi-C contact matrices across multiple samples. Use this skill when you need to process Hi-C data to remove technical variation, perform logCPM transformations, smooth contact matrices, or apply the BNBC (Band-Wise Normalization and Batch Correction) algorithm to Hi-C replicates.

## Overview

The `bnbc` package is designed for the normalization and batch effect correction of Hi-C data across multiple samples. It operates on "bands" (diagonals) of contact matrices, acknowledging that Hi-C contact frequency decays exponentially with genomic distance. The core workflow involves representing data in `ContactGroup` objects, applying per-sample adjustments (logCPM and smoothing), and then performing cross-sample normalization using quantile normalization and ComBat.

## Core Workflow

### 1. Data Representation: The ContactGroup Class
`bnbc` uses the `ContactGroup` class to store Hi-C data for a single chromosome across multiple samples.

```r
library(bnbc)

# Create a ContactGroup from scratch
# rowData: GRanges of genomic bins
# contacts: list of square contact matrices (one per sample)
# colData: DataFrame of sample metadata (e.g., Batch, Condition)
cg <- ContactGroup(rowData = LociData, contacts = MatsList, colData = SampleData)

# Accessors
rowData(cg)
colData(cg)
contacts(cg)
```

### 2. Data Input
If your data is in `.cooler` or `.mcool` format, use the internal helper functions (requires `HiCBricks`).

```r
# 1. Generate genomic index
ixns <- bnbc:::getChrIdx(seqlengths(hg19)["chr22"], "chr22", step = 40000)

# 2. Load from cooler files
cg <- bnbc:::getChrCGFromCools(
    files = cool_files,
    chr = "chr22",
    step = 40000,
    index.gr = ixns,
    coldata = sample_metadata
)
```

### 3. Per-Sample Adjustments
Before cross-sample normalization, data must be transformed to account for sequencing depth and local noise.

```r
# Log-counts per million transformation
cg.cpm <- logCPM(cg)

# Smoothing (Box or Gaussian) to reduce binning artifacts
cg.smooth <- boxSmoother(cg.cpm, h = 5)
# OR: cg.smooth <- gaussSmoother(cg.cpm, radius = 3, sigma = 4)
```

### 4. BNBC Normalization
The `bnbc` function performs band-wise quantile normalization and batch correction.

```r
# batch: factor or vector indicating batch membership
# nbands: number of bands (diagonals) to normalize
cg.bnbc <- bnbc(cg.smooth, 
                batch = colData(cg.smooth)$Batch, 
                nbands = 11, 
                threshold = 1e7, 
                step = 4e4)
```

## Matrix Manipulation Utilities
`bnbc` provides efficient tools for interacting with matrix bands (diagonals).

```r
# Get a specific band (e.g., the 2nd diagonal)
b2 <- band(mat = matrix_obj, band.no = 2)

# Set/Update a specific band (maintains symmetry)
band(mat = matrix_obj, band.no = 2) <- b2 + 1

# Apply a function to all matrices in a ContactGroup
cg.modified <- cgApply(cg, FUN = my_function)
```

## Tips and Best Practices
- **Memory Management**: Process data one chromosome at a time. `ContactGroup` objects are designed for single-chromosome data.
- **Symmetry**: Ensure input matrices are square and symmetric. If you only have upper triangular data, mirror it to the lower triangle before creating the `ContactGroup`.
- **Band Selection**: Normalization is typically performed on the first $k$ bands where biological signal is strongest. The `nbands` parameter in `bnbc()` controls this.
- **Batch Correction**: Ensure the `batch` variable in `colData` correctly reflects the technical groupings (e.g., processing date or flow cell).

## Reference documentation
- [The bnbc User's Guide](./references/bnbc.md)