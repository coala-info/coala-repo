---
name: bioconductor-csaw
description: This tool detects differentially bound regions in ChIP-seq data using a sliding window approach. Use when user asks to perform de novo peak calling, analyze genomic coverage changes, or conduct differential binding analysis between biological replicates.
homepage: https://bioconductor.org/packages/release/bioc/html/csaw.html
---


# bioconductor-csaw

name: bioconductor-csaw
description: Detect differentially bound regions in ChIP-seq data using a sliding window approach. Use this skill when performing de novo peak calling, analyzing genomic coverage changes, or conducting differential binding analysis between biological replicates using the csaw R package.

# bioconductor-csaw

## Overview

The `csaw` package implements a sliding window strategy for ChIP-seq analysis, moving away from traditional "peak calling" by counting reads in overlapping windows across the genome. This approach provides better statistical control and higher sensitivity for detecting differential binding (DB). It integrates closely with `edgeR` for statistical testing and `SummarizedExperiment` for data handling.

## Core Workflow

### 1. Data Loading and Window Counting
The primary entry point is counting reads from BAM files into windows.

```R
library(csaw)
library(Rsamtools)

# Define files and parameters
bam.files <- c("sample1.bam", "sample2.bam", "control1.bam", "control2.bam")
param <- readParam(minq=20, pe="none") # Adjust for paired-end if needed

# Count reads in sliding windows (default 50bp)
data <- windowCounts(bam.files, spacing=50, width=50, param=param)
```

### 2. Normalization
`csaw` provides methods to handle composition bias and efficiency differences.

*   **Trended normalization:** For data with non-linear biases.
*   **TMM normalization:** Using large bins (e.g., 10kb) to estimate normalization factors for background levels.

```R
# Binned counts for TMM normalization
binned <- windowCounts(bam.files, bin=TRUE, width=10000, param=param)
data <- normFactors(binned, se.out=data)
```

### 3. Filtering
Filter out uninteresting windows (those with low counts) to increase statistical power.

```R
# Filter by abundance relative to a global background
bin.stats <- binCounts(bam.files, bin=TRUE, width=10000, param=param)
filter.stat <- filterWindowsGlobal(data, bin.stats)
keep <- filter.stat$filter > log2(3) # Example threshold
data.filt <- data[keep,]
```

### 4. Statistical Testing (edgeR integration)
Convert the object to a `DGEList` and perform standard `edgeR` workflows.

```R
library(edgeR)
y <- asDGEList(data.filt)
design <- model.matrix(~condition)
y <- estimateDisp(y, design)
fit <- glmQLFit(y, design)
results <- glmQLFTest(fit, coef=2)
```

### 5. Multiple Testing Correction across Windows
Since windows are overlapping, p-values must be merged into regions.

```R
# Merge adjacent windows into regions (e.g., within 100bp)
merged <- mergeWindows(rowRanges(data.filt), tol=100)

# Combine p-values for each merged region
tab.combined <- combineTests(merged$id, results$table)
```

## Key Functions

- `windowCounts()`: Counts reads in sliding windows.
- `readParam()`: Specifies parameters for BAM file processing (mapping quality, fragments, etc.).
- `mergeWindows()`: Clusters overlapping or adjacent windows into larger genomic regions.
- `combineTests()`: Aggregates window-level p-values into region-level statistics using Simes' method.
- `calculateCPM()`: Computes counts-per-million for windows.
- `checkBimodality()`: Assesses the strand-specific shift in ChIP-seq data.

## Tips and Best Practices

- **Window Size:** For transcription factors, use small windows (e.g., 10-50bp). For histone marks, larger windows (e.g., 150-500bp) are more appropriate.
- **Fragment Length:** Use `maximizeCcf()` to estimate the average fragment length from the data to properly shift reads.
- **Blacklists:** Always filter out known problematic genomic regions (blacklists) using the `restrict` argument in `readParam()`.
- **Controls:** If using Input controls, use `filterWindowsControl()` to identify windows with significantly higher enrichment in the ChIP sample compared to the control.

## Reference documentation

- [Introducing the csaw package](./references/csaw.md)