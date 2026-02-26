---
name: bioconductor-hicaggr
description: bioconductor-hicaggr performs Aggregated Peak Analysis (APA) to visualize and quantify genomic 3D conformation data. Use when user asks to integrate 1D genomic features with HiC data, perform matrix balancing, extract submatrices for specific genomic coordinates, or generate APA plots to analyze interaction patterns.
homepage: https://bioconductor.org/packages/release/bioc/html/HicAggR.html
---


# bioconductor-hicaggr

name: bioconductor-hicaggr
description: Analysis of genomic 3D conformation data (HiC) using Aggregated Peak Analysis (APA). Use this skill to integrate 1D genomics data (ChIP-seq peaks, ATAC-seq, genomic features) with 3D HiC data to visualize and quantify interactions between features of interest, perform matrix balancing, observed/expected corrections, and differential APA between conditions.

## Overview

HicAggR is a Bioconductor package designed to simplify the extraction of interaction signals from HiC data. It centers on Aggregated Peak Analysis (APA), allowing users to extract submatrices surrounding specific genomic coordinates (e.g., enhancer-promoter pairs, CTCF sites) and aggregate them to visualize genome-wide interaction patterns. It supports common formats like `.hic`, `.cool`, `.mcool`, and `.h5`.

## Typical Workflow

1.  **Import 1D Features**: Load genomic coordinates (peaks, TSS, TADs) as `GRanges`.
2.  **Index Features**: Map features to HiC bins using `IndexFeatures`.
3.  **Search Pairs**: Form potential interaction couples (e.g., A <-> B) using `SearchPairs`.
4.  **Import & Process HiC**: Load 3D data with `ImportHiC`, then apply `BalanceHiC` and `OverExpectedHiC`.
5.  **Extract Submatrices**: Extract contact values for pairs using `ExtractSubmatrix`.
6.  **Aggregate & Plot**: Summarize interactions with `Aggregation` and visualize with `ggAPA`.

## Core Functions and Usage

### 1. Data Import and Processing

```r
library(HicAggR)

# Import HiC data (supports .hic, .cool, .mcool, .h5)
hicLst <- ImportHiC(
    file = "path/to/data.hic",
    hicResolution = 5000,
    chrom_1 = c("chr1", "chr2")
)

# Normalize and correct for distance
hicLst <- BalanceHiC(hicLst)
hicLst <- OverExpectedHiC(hicLst, method = "mean_non_zero")
```

### 2. Feature Indexing and Pairing

Features must be indexed to the same resolution as the HiC data.

```r
# Index GRanges features
feat_index <- IndexFeatures(
    gRangeList = list(Peaks = my_peaks_gr),
    chromSizes = my_chrom_sizes_df,
    binSize = 5000
)

# Search for pairs within distance constraints (e.g., 25kb to 100kb)
pairs_gni <- SearchPairs(
    indexAnchor = feat_index,
    minDist = "25KB",
    maxDist = "100KB"
)
```

### 3. Submatrix Extraction

Extraction can be "Point Feature" (`pf`) for specific pixels or "Region Feature" (`rf`) for scaled regions (like TADs).

```r
# Extract submatrices (101x101 pixels)
mtx_lst <- ExtractSubmatrix(
    genomicFeature = pairs_gni,
    hicLst = hicLst,
    referencePoint = "rf",
    matriceDim = 101
)
```

### 4. Aggregation and Visualization

Before aggregation, use `PrepareMtxList` to handle orientation (ensuring anchors are on the Y-axis and baits on the X-axis).

```r
# Prepare and Aggregate
mtx_lst <- PrepareMtxList(mtx_lst, orientate = TRUE)
agg_mtx <- Aggregation(mtx_lst, aggFun = "mean")

# Plot APA Heatmap
ggAPA(
    aggregatedMtx = agg_mtx,
    title = "APA: Peaks <-> Peaks",
    colorScale = "density"
)
```

## Advanced Operations

### Differential APA
To compare two conditions (e.g., Control vs. Treatment):

```r
diff_agg <- Aggregation(
    ctrlMatrices = mtx_lst_ctrl,
    matrices = mtx_lst_treat,
    aggFun = "mean",
    diffFun = "substraction", # or "log2+1"
    scaleCorrection = TRUE
)
ggAPA(diff_agg, title = "Differential APA")
```

### Quantification
Extract specific values (e.g., the central 3x3 pixels) from the submatrices:

```r
center_values <- GetQuantif(
    matrices = mtx_lst,
    areaFun = "center",
    operationFun = "mean"
)
```

## Tips for Success

*   **Orientation**: Always use `OrientateMatrix()` or `PrepareMtxList(orientate = TRUE)` for heterotypic pairs (A <-> B) to ensure the heatmap isn't a mix of A-on-Y and B-on-Y orientations.
*   **Memory Management**: HiC matrices can be large. Use the `chrom_1` and `chrom_2` arguments in `ImportHiC` to load only the chromosomes necessary for your analysis.
*   **Filtering**: Use `FilterInteractions` to subset your pairs or submatrices based on metadata (e.g., distance, peak score) before aggregation.
*   **Expected Values**: `OverExpectedHiC` supports multiple methods: `mean_non_zero` (default), `lieberman`, and `mean_total`.

## Reference documentation

- [HicAggR - Quick start](./references/HicAggR.md)
- [HicAggR - In depth tutorial](./references/InDepth.Rmd)