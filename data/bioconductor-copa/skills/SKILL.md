---
name: bioconductor-copa
description: This package implements Cancer Outlier Profile Analysis to identify genes that are highly up-regulated in a subset of tumor samples. Use when user asks to find potential gene fusion partners, identify outlier expression profiles in cancer datasets, or perform pairwise comparisons to detect mutually exclusive gene outliers.
homepage: https://bioconductor.org/packages/release/bioc/html/copa.html
---

# bioconductor-copa

## Overview

The `copa` package implements Cancer Outlier Profile Analysis, a method designed to find genes that are highly up-regulated in only a subset of tumor samples. Traditional methods like t-tests fail to find these because the mean expression across all tumor samples might not be significantly different from normals. COPA is specifically useful for identifying potential gene fusion partners (e.g., TMPRSS2-ERG) where a translocation causes an oncogene to be driven by a constitutively active promoter in some, but not all, cancer cases.

## Typical Workflow

### 1. Data Preparation
COPA requires an `ExpressionSet` or a matrix of expression values. You also need a class label vector (numeric) where 1 typically represents normal samples and 2 represents tumor samples.

```r
library(copa)
library(colonCA)
data(colonCA)

# Extract expression and class labels (1 = normal, 2 = tumor)
# In colonCA, the 3rd column of pData contains 'n' and 't'
cl <- as.numeric(pData(colonCA)[,3])
```

### 2. Running COPA
The `copa` function centers and scales the data using the median and Median Absolute Deviation (MAD). It then identifies outliers based on a cutoff (default is 5).

```r
# pct: percentile cutoff for pre-filtering (default 0.95)
# maxgenes: warning threshold for number of genes (default 1000)
res <- copa(colonCA, cl, pct = 0.95)
```

### 3. Summarizing and Visualizing Results
COPA ranks gene pairs based on the number of mutually exclusive outlier samples.

```r
# View the distribution of outlier counts among pairs
tableCopa(res)

# Summary of pairs with a specific number of outliers (e.g., 9)
summaryCopa(res, 9)

# Plot the top gene pair (idx = 1)
# Samples are colored by class; outliers are highlighted
plotCopa(res, idx = 1, col = c("lightgreen", "salmon"))
```

### 4. Statistical Significance (Permutation)
To determine if the observed number of outliers is higher than what would be expected by chance, use `copaPerm`.

```r
# Run permutations (default 100, use 500-1000 for publication)
# This re-runs the COPA algorithm on shuffled class labels
prm <- copaPerm(colonCA, res, outlier.num = 9, p.num = 100)

# Calculate how many times permuted data met or exceeded observed outliers
sum(prm >= 9)
```

## Tips and Constraints

- **Computational Load**: COPA performs all pairwise comparisons. If your pre-filtering (`pct`) results in >1000 genes, the number of pairs grows quadratically. Use a higher `pct` (e.g., 0.98) if the function is too slow.
- **Outlier Definition**: The default cutoff is 5 MADs from the median. You can adjust this in the `copa` function if you find too few or too many outliers.
- **Mutual Exclusivity**: The algorithm specifically looks for pairs where Sample A has an outlier in Gene 1 and Sample B has an outlier in Gene 2, but rarely both in the same sample.
- **Annotation**: If using Affymetrix data with an available metadata package, provide the `lib` argument to `plotCopa` to see Gene Symbols instead of Probe IDs.

## Reference documentation

- [Using copa](./references/copa.md)