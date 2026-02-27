---
name: bioconductor-mariner
description: bioconductor-mariner is an R/Bioconductor package for the high-performance analysis and manipulation of 3D chromatin structure data like Hi-C and Micro-C. Use when user asks to manipulate paired genomic ranges, cluster or merge chromatin interactions, extract contact frequencies from .hic files, or perform aggregate peak analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/mariner.html
---


# bioconductor-mariner

name: bioconductor-mariner
description: Specialized R/Bioconductor package for exploring 3D chromatin structure data (Hi-C, Micro-C). Use when Claude needs to manipulate paired genomic ranges, cluster/merge chromatin interactions, extract contact frequencies from .hic files, or calculate loop enrichment.

# bioconductor-mariner

## Overview

`mariner` is a Bioconductor package designed for the analysis of 3D chromatin structure data. It extends the `InteractionSet` ecosystem to provide high-performance tools for handling genomic interactions. Key capabilities include converting BEDPE files to `GInteractions`, binning and snapping ranges to specific resolutions, merging redundant interaction sets across replicates, and extracting contact matrices from `.hic` files using HDF5-backed `DelayedArray` objects for memory efficiency.

## Core Workflows

### 1. Manipulating Paired Ranges

Convert BEDPE data and align interactions to genomic bins.

```R
library(mariner)
library(InteractionSet)

# Convert BEDPE to GInteractions
bedpe <- read.table("loops.bedpe", header = TRUE)
gi <- as_ginteractions(bedpe)

# Assign to fixed bins (e.g., 5kb)
# Note: mariner uses 0-based bins for .hic compatibility
binned <- assignToBins(x = gi, binSize = 5000, pos1 = 'center', pos2 = 'center')

# Snap ranges to nearest bins (allows anchors to span multiple bins)
snapped <- snapToBins(x = gi, binSize = 5000)
```

### 2. Clustering and Merging

Combine interactions from multiple replicates and select representative loops.

```R
# Create a list of GInteractions
giList <- list(Rep1 = gi1, Rep2 = gi2)

# Merge interactions within a 10kb radius
# Use a specific column (e.g., enrichment score) to select the best representative
mgi <- mergePairs(x = giList, radius = 10000, column = "Score", selectMax = TRUE)

# Access cluster information or source sets
clusters(mgi[1])
sets(mgi)
```

### 3. Extracting Hi-C Data

Pull contact frequencies (pixels) or submatrices from `.hic` files.

```R
# Ensure seqlevels match .hic file (e.g., 'ENSEMBL' for no 'chr' prefix)
GenomeInfoDb::seqlevelsStyle(mgi) <- 'ENSEMBL'

# Pull single pixel values
imat <- pullHicPixels(x = binned, files = hicFiles, binSize = 5000)
pixel_counts <- counts(imat)

# Pull submatrices (e.g., 3x3 matrices around loops)
regions <- pixelsToMatrices(x = binned, buffer = 1)
iarr <- pullHicMatrices(x = regions, files = hicFiles, binSize = 5000)
matrix_counts <- counts(iarr) # Returns a 4D DelayedArray
```

### 4. Aggregation and Enrichment

Perform Aggregate Peak Analysis (APA) and calculate enrichment scores.

```R
# Aggregate matrices across all interactions and files
agg_mat <- aggHicMatrices(x = iarr, by = "both")
plotMatrix(data = agg_mat)

# Calculate loop enrichment relative to local background
fg <- selectCenterPixel(mhDist = 0:1, buffer = 10)
bg <- selectTopLeft(n = 2, buffer = 10) + selectBottomRight(n = 2, buffer = 10)

enrichment <- calcLoopEnrichment(x = binned, files = hicFiles, fg = fg, bg = bg)
```

## Implementation Tips

- **Coordinate Systems**: `mariner` functions often return ranges that are `binSize + 1` in width because they convert 1-based Bioconductor ranges to 0-based bins used by `.hic` files.
- **Memory Management**: Functions like `pullHicMatrices` use `DelayedArray` and `HDF5Array`. Use the `blockSize` or `nBlocks` arguments in extraction/aggregation functions to tune memory usage.
- **Normalization**: Specify the `norm` argument (e.g., "KR", "VC", "NONE") in `pullHicPixels` or `calcLoopEnrichment` to match your analysis requirements.
- **Visualization**: `plotMatrix` is compatible with `plotgardener` for building complex genomic multi-panel figures.

## Reference documentation

- [Introduction to mariner](./references/mariner.md)
- [mariner Vignette Source](./references/mariner.Rmd)