---
name: bioconductor-profilescoredist
description: This package calculates probability distributions of log-odds scores for DNA sequence motif matches to determine statistically sound score cutoffs. Use when user asks to regularize position count matrices, compute score distributions based on GC content, or estimate motif match cutoffs using false discovery and false negative rates.
homepage: https://bioconductor.org/packages/release/bioc/html/profileScoreDist.html
---


# bioconductor-profilescoredist

## Overview

The `profileScoreDist` package provides tools to determine statistically sound score cutoffs for DNA sequence motif matches (like transcription factor binding sites). Instead of using arbitrary percentage-based cutoffs (e.g., "80% of max score"), it uses a discrete convolution algorithm to calculate the exact probability distributions of log-odds scores. This allows researchers to select cutoffs based on specific error rate tolerances (FDR/FNR) tailored to the GC content of the sequences being searched.

## Typical Workflow

### 1. Matrix Regularization
Before computing distributions, a position count matrix (PCM) should be regularized. The `regularizeMatrix` function adds pseudocounts weighted by the strength of the signal at each position; positions with high information content receive fewer pseudocounts.

```r
library(profileScoreDist)
data(INR) # Example matrix
inr.reg <- regularizeMatrix(INR)
```

### 2. Computing Score Distributions
The `computeScoreDist` function calculates the probability distributions for both the signal (motif) and the background (null model). This is the computational core of the package.

*   **GC Content:** Background distributions depend heavily on GC content.
*   **Granularity:** Defines the interval between discrete scores (e.g., 0.05).

```r
# Compute for a specific GC content (e.g., 50%)
dist <- computeScoreDist(inr.reg, gc = 0.5, granularity = 0.05)

# Access components
sig <- signalDist(dist)
bg <- backgroundDist(dist)
sc <- score(dist)

# Visualize the distributions
plotDist(dist)
```

### 3. Estimating Cutoffs
Use `scoreDistCutoffs` to find the score threshold that meets your statistical criteria.

*   **FDR (alpha):** Probability of a false hit in a sequence of length $N$.
*   **FNR (beta):** Probability of missing a true site.
*   **Tradeoff (c):** Finds the point where $c \times FDR = FNR$.

```r
# Find cutoffs for a sequence of length 500 with 5% error targets
# c=1 finds the point where FDR = FNR
results <- scoreDistCutoffs(dist, n = 500, c = 1, alpha = 0.05, beta = 0.05)

results$cutoffa   # Score for 5% FDR
results$cutoffb   # Score for 5% FNR
results$cutoffopt # Score where FDR = FNR
```

## Tips for Large Scale Analysis
If analyzing sequences with varying GC content, pre-compute a list of distributions for a range of GC values:

```r
gcs <- seq(0.3, 0.7, by = 0.01)
dist_list <- lapply(gcs, function(x) computeScoreDist(inr.reg, x, 0.05))
# Map your sequences to the nearest pre-computed distribution based on their GC content
```

## Reference documentation

- [Using profileScoreDist](./references/profileScoreDist-vignette.md)