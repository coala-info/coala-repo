---
name: bioconductor-chromswitch
description: This tool detects chromatin state switches in genomic regions between two biological conditions using epigenomic data such as ChIP-seq or DNase-seq. Use when user asks to identify differences in chromatin states, perform hierarchical clustering of samples based on peak features, or score the similarity between sample clusters and biological groups.
homepage: https://bioconductor.org/packages/3.8/bioc/html/chromswitch.html
---


# bioconductor-chromswitch

name: bioconductor-chromswitch
description: Detect chromatin state switches in genomic regions between two biological conditions using epigenomic data (ChIP-seq, DNase-seq, ChromHMM). Use this skill to perform hierarchical clustering of samples based on peak features and score the similarity between clusters and biological groups.

## Overview

The `chromswitch` package identifies genomic regions where chromatin states differ significantly between two groups of samples. It transforms epigenomic features (like peaks) into a sample-by-feature matrix using either a **Summary** strategy (using statistics like mean/max signal) or a **Binary** strategy (presence/absence of unique peaks). It then uses hierarchical clustering and external validity measures (Consensus score) to predict switches.

## Core Workflow

### 1. Data Preparation

The package requires three main inputs:
- **Query Regions**: A `GRanges` object of regions to test.
- **Metadata**: A `data.frame` with `Sample` and `Condition` columns (Condition must have exactly two levels).
- **Features**: A named list of `GRanges` objects (one per sample) containing peaks or states.

```r
library(chromswitch)
library(rtracklayer)

# 1. Query regions
query <- import("query.bed", format = "BED")

# 2. Metadata
metadata <- read.delim("metadata.tsv")

# 3. Peaks (ENCODE narrowPeak format helper)
peak_paths <- list.files(pattern = "\\.bed$")
peaks <- readNarrowPeak(paths = peak_paths, metadata = metadata)
names(peaks) <- metadata$Sample
```

### 2. Detecting Switches (Wrapper Functions)

#### Summary Strategy
Best when quantitative signal (e.g., fold change, q-value) is informative.
```r
results_summary <- callSummary(
  query = query,
  metadata = metadata,
  peaks = peaks,
  summarize_columns = c("qValue", "signalValue"),
  normalize = TRUE, # Recommended
  filter = TRUE,
  filter_thresholds = c(10, 4)
)
```

#### Binary Strategy
Best for identifying the presence/absence of specific peak architectures.
```r
results_binary <- callBinary(
  query = query,
  metadata = metadata,
  peaks = peaks,
  reduce = TRUE, # Merge nearby peaks
  gap = 300,     # Max distance to merge
  p = 0.4        # Reciprocal overlap for "same" peak
)
```

### 3. Interpreting Results

The output is a `data.frame` with the following key columns:
- **Consensus**: The primary score (range -1 to 1). A value near 1 indicates a strong chromatin state switch matching the biological conditions.
- **Average_Silhouette**: Measures cluster separation/quality.
- **K**: The number of clusters identified.
- **Sample Columns**: Cluster assignments for each individual sample.

```r
# Filter for high-confidence switches
switches <- results_summary[results_summary$Consensus >= 0.75, ]
```

## Step-by-Step Modular Analysis

For finer control, you can run the pipeline manually:

1.  **Filter & Normalize**: `filterPeaks()` and `normalizePeaks()` to handle outliers and scale signal.
2.  **Retrieve**: `retrievePeaks()` to extract peaks overlapping a specific query region.
3.  **Matrix Construction**: 
    - `summarizePeaks()`: Creates a matrix of mean/median/max stats.
    - `binarizePeaks()`: Creates a 1/0 matrix of peak presence.
4.  **Cluster**: `cluster()` to perform the final analysis and optionally generate heatmaps.

```r
# Example of manual clustering for one region
lp <- retrievePeaks(peaks = peaks_norm, metadata = metadata, region = query[1])
ft_mat <- summarizePeaks(lp, mark = "H3K4me3", fraction = TRUE)
res <- cluster(ft_mat, query = query[1], metadata = metadata, heatmap = TRUE)
```

## Tips for Success

- **Normalization**: Always set `normalize = TRUE` when using `callSummary` to prevent high-signal samples from dominating the clustering.
- **Column Names**: Ensure `summarize_columns` or `filter_columns` match the metadata column names in your `GRanges` objects exactly (case-sensitive).
- **Parallelization**: Use the `BPPARAM` argument (e.g., `BiocParallel::MulticoreParam()`) to speed up analysis across many query regions.

## Reference documentation

- [An introduction to chromswitch for detecting chromatin state switches](./references/chromswitch_intro.Rmd)
- [An introduction to chromswitch for detecting chromatin state switches (Markdown)](./references/chromswitch_intro.md)