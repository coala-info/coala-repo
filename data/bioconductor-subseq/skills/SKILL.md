---
name: bioconductor-subseq
description: The bioconductor-subseq package performs downsampling on RNA-Seq count matrices to simulate lower sequencing depths and evaluate experimental power. Use when user asks to subsample count data, determine if sequencing depth is sufficient, or estimate the impact of additional sequencing on differential expression results.
homepage: https://bioconductor.org/packages/release/bioc/html/subSeq.html
---

# bioconductor-subseq

## Overview

The `subSeq` package allows researchers to perform "downsampling" on RNA-Seq count matrices. By simulating lower sequencing depths from existing data, it helps answer experimental design questions: "Do I have enough reads?" and "Would more lanes improve my power?" It supports built-in differential expression (DE) handlers and allows for custom analysis methods.

## Core Workflow

### 1. Data Preparation
The input must be a count matrix where rows are genes and columns are samples. It is recommended to filter out very low-count genes before subsampling.

```r
library(subSeq)
# hammer.counts: matrix of counts
# hammer.design: data frame with treatment column
counts <- hammer.counts[rowSums(hammer.counts) >= 5, ]
```

### 2. Defining Proportions
Select a range of proportions (0 to 1). A logarithmic scale is often best to capture the rapid power increase at low depths.

```r
proportions <- 10^seq(-2, 0, 0.5) # e.g., 0.01, 0.03, 0.1, 0.31, 1.0
```

### 3. Running Subsampling
Use the `subsample` function. You can specify multiple DE methods simultaneously.

```r
subsamples <- subsample(counts, 
                        proportions, 
                        method = c("edgeR", "voomLimma", "DESeq2"), 
                        treatment = hammer.design$protocol)
```

### 4. Summarizing and Plotting
The `subsamples` object is a large table. Use `summary()` to aggregate metrics (significant genes, correlations, MSE) by depth.

```r
# Generate summary metrics
ss_summary <- summary(subsamples)

# Plot default metrics (Significance, FDP, Spearman, MSE)
plot(ss_summary)

# Custom ggplot2 visualization
library(ggplot2)
ggplot(ss_summary, aes(x = depth, y = significant, col = method)) + geom_line()
```

## Advanced Usage

### Custom Handlers
If you use a non-standard DE method, write a handler function that takes a count matrix and returns a data frame with `coefficient` and `pvalue` columns.

```r
my_handler <- function(count.matrix, treatment) {
    # ... perform analysis ...
    return(data.frame(coefficient = res$logFC, pvalue = res$p.value))
}

subsamples <- subsample(counts, proportions, method = "my_handler", treatment = design$group)
```

### Reproducibility and Combining Runs
`subSeq` stores the random seed. You can use it to add more methods to an existing run or extract the exact matrix used at a specific depth.

```r
# Get seed from previous run
seed <- getSeed(subsamples)

# Run a new method with the same seed
subsamples_new <- subsample(counts, proportions, method = "DESeq2", 
                            treatment = design$group, seed = seed)

# Combine results
combined <- combineSubsamples(subsamples, subsamples_new)

# Generate the specific matrix for a 10% subsample
sub_mat <- generateSubsampledMatrix(counts, 0.1, seed = seed)
```

## Key Metrics
- **significant**: Number of genes meeting the FDR threshold (default 0.05).
- **pearson/spearman**: Correlation of fold-change estimates between the subsample and the full ("oracle") dataset.
- **eFDP (Estimated False Discovery Proportion)**: The average local FDR (from the full dataset) of genes called significant at the reduced depth. This is the preferred metric for checking if lower depth introduces false positives.
- **percent**: The fraction of genes found significant in the full dataset that are also significant at this depth.

## Reference documentation
- [subSeq Package Vignette](./references/subSeq.md)