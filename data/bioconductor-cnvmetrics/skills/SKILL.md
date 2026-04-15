---
name: bioconductor-cnvmetrics
description: bioconductor-cnvmetrics quantifies the similarity between copy number variation profiles using overlap metrics and log2 ratio distances. Use when user asks to compare CNV profiles across samples, calculate similarity scores like Jaccard or Sørensen, simulate null distributions for significance testing, or visualize sample relationships via heatmaps.
homepage: https://bioconductor.org/packages/release/bioc/html/CNVMetrics.html
---

# bioconductor-cnvmetrics

name: bioconductor-cnvmetrics
description: Quantifying similarity between copy number profiles using overlap metrics (Sørensen, Jaccard, Szymkiewicz–Simpson) and log2 ratio distances. Use this skill when you need to compare CNV profiles from different samples, calculate similarity scores, simulate null distributions for significance testing, or visualize sample-to-sample relationships via heatmaps.

# bioconductor-cnvmetrics

## Overview

The `CNVMetrics` package provides tools to quantitatively measure the similarity between copy number variation (CNV) profiles. It supports two main approaches:
1. **Status-based metrics**: Using discrete calls (e.g., AMPLIFICATION, DELETION, LOH) to calculate overlap coefficients.
2. **Value-based metrics**: Using log2 ratio levels to calculate weighted Euclidean distances.

The package also includes a simulation engine to generate null distributions for assessing the significance of observed similarity scores.

## Core Workflow

### 1. Data Preparation

Data must be formatted as a `GRangesList`, where each element represents a sample.

```r
library(GenomicRanges)
library(CNVMetrics)

# Load data from a data.frame
# Required columns: chr, start, end, ID, state (for overlap) and/or log2ratio (for distance)
calls <- read.table("cnv_data.txt", header=TRUE, sep="\t")

# Convert to GRangesList
grl <- GenomicRanges::makeGRangesListFromDataFrame(calls, 
    split.field="ID", 
    keep.extra.columns=TRUE)
```

### 2. Calculating Similarity Metrics

#### Overlap Metrics (Status-based)
Calculates similarity based on genomic regions sharing specific states. Supported methods: `"sorensen"`, `"jaccard"`, `"szymkiewicz"`.

```r
# Default states are "AMPLIFICATION" and "DELETION"
metric_overlap <- calculateOverlapMetric(segmentData=grl, 
                                         method="sorensen", 
                                         nJobs=1)

# For custom states (e.g., LOH)
metric_loh <- calculateOverlapMetric(segmentData=grl, 
                                     states=c("LOH"), 
                                     method="jaccard")
```

#### Log2 Ratio Metrics (Value-based)
Calculates similarity based on the magnitude of copy number changes.

```r
metric_log2 <- calculateLog2ratioMetric(segmentData=grl, 
                                        method="weightedEuclideanDistance", 
                                        nJobs=1)
```

### 3. Visualization

Generate heatmaps using the `plotMetric` function, which wraps `pheatmap`.

```r
# Plotting overlap metrics (must specify type)
plotMetric(metric_overlap, type="AMPLIFICATION", main="Amplification Similarity")

# Plotting log2 ratio metrics
plotMetric(metric_log2, colorRange=c("white", "darkorange"))
```

### 4. Profile Simulation

Simulate profiles to assess the significance of observed metrics against a null distribution.

```r
# Select a reference sample (GRanges)
sample_ref <- grl[[1]]

set.seed(123)
# Generate 100 simulated profiles
sim_profiles <- processSim(curSample=sample_ref, nbSim=100)
```

## Implementation Tips

- **State Nomenclature**: The `state` column is case-sensitive. Ensure your input strings match the `states` parameter exactly.
- **Parallelization**: For large datasets, increase `nJobs` to utilize `BiocParallel`.
- **Reproducibility**: Always `set.seed()` before running simulations or metric calculations (especially if using multiple jobs) to ensure consistent results.
- **Missing Values**: `plotMetric` automatically replaces `NA` values with 0 for clustering and visualization.

## Reference documentation

- [Quantifying similarity between copy number profiles (Rmd)](./references/CNVMetrics.Rmd)
- [Quantifying similarity between copy number profiles (Markdown)](./references/CNVMetrics.md)