---
name: bioconductor-cssq
description: This tool performs differential binding analysis for ChIP-seq data using a non-parametric pipeline that includes signal quantification, background correction, and normalization. Use when user asks to quantify ChIP-seq signal intensities, perform Anscombe transformation, normalize data using k-means clustering, or identify differentially bound regions in experiments with few replicates.
homepage: https://bioconductor.org/packages/release/bioc/html/CSSQ.html
---

# bioconductor-cssq

name: bioconductor-cssq
description: Perform differential binding analysis for ChIP-seq data using the CSSQ package. Use this skill to quantify signal intensities over regions of interest, perform background correction, Anscombe transformation, and k-means based normalization, and identify differentially bound regions using non-parametric statistical tests, especially in experiments with few replicates.

# bioconductor-cssq

## Overview
CSSQ (ChIP-seq signal quantifier) is a Bioconductor package designed for differential binding analysis of ChIP-seq data. It provides a statistically robust pipeline that handles signal-to-noise ratios, paired control (Input) experiments, and the common challenge of having few replicates (e.g., n=2). The package uses non-parametric approaches to calculate test statistics and p-values, ensuring sensitivity while controlling false discovery rates.

## Data Preparation
To use CSSQ, you need two primary inputs:
1.  **Regions of Interest**: A BED file containing the genomic coordinates to be quantified.
2.  **Sample Information**: A tab-separated text file or data frame containing:
    *   `Sample.Name`: Unique identifier for each sample.
    *   `Group`: Experimental group (e.g., "Treatment", "Control").
    *   `IP`: Filename of the IP BAM file.
    *   `IP_aligned_reads`: Total number of aligned reads in the IP sample.
    *   `IN`: Filename of the Input (control) BAM file.
    *   `IN_aligned_reads`: Total number of aligned reads in the Input sample.

## Core Workflow

### 1. Quantification and Background Correction
You can either have CSSQ count reads from BAM files or load pre-calculated counts.

```r
library(CSSQ)

# Option A: Count from BAM files (performs background correction)
countData <- getRegionCounts(
  bedFile = "regions.bed",
  sampleInfo = sampleInfoDataFrame,
  sampleDir = "path/to/bam/files"
)

# Option B: Load pre-calculated counts (no background correction)
countData <- loadCountData(
  countFile = "counts.txt",
  bedFile = "regions.bed",
  sampleInfo = sampleInfoDataFrame
)
```

### 2. Data Transformation
Apply the Anscombe transformation to stabilize variance.

```r
ansCountData <- ansTransform(countData)
```

### 3. Normalization
Normalize the transformed data across samples using a k-means clustering approach. The `numClusters` parameter should be chosen based on the data distribution.

```r
normInfo <- normalizeData(ansCountData, numClusters = 4)
```

### 4. Differential Binding Analysis
Perform non-parametric statistical tests to identify regions with significant differences between groups.

```r
# comparison: a vector of two group names (Target, Reference)
result <- DBAnalyze(normInfo, comparison = c("HSMM", "HESC"))

# The result is a GRanges object containing:
# adj.pval: Benjamini-Hochberg adjusted p-values
# FC: Fold change
```

## Simplified Workflow
For convenience, the `preprocessData` function wraps the counting, transformation, and normalization steps into a single call.

```r
# Run preprocessing
processedData <- preprocessData(
  bedFile = "regions.bed",
  sampleInfoFile = "sample_info.txt",
  sampleDir = "path/to/bams",
  numClusters = 4,
  noNeg = TRUE
)

# Run analysis
result <- DBAnalyze(processedData, comparison = c("GroupA", "GroupB"))
```

## Tips for Success
*   **Replicates**: CSSQ is specifically optimized for ChIP-seq experiments where only two replicates are available.
*   **Cluster Selection**: When using `normalizeData` or `preprocessData`, evaluate the data distribution to select an appropriate `numClusters`.
*   **Negative Values**: In `preprocessData`, setting `noNeg = TRUE` ensures that background-corrected counts do not drop below zero.
*   **Output**: The final `result` is a `GRanges` object, making it easy to export to BED/CSV or use with other Bioconductor tools like `rtracklayer` or `ChIPseeker`.

## Reference documentation
- [CSSQ](./references/CSSQ.md)