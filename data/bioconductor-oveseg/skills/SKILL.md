---
name: bioconductor-oveseg
description: This tool detects tissue or cell-specific marker genes in multi-group datasets using the One Versus Everyone Subtype Exclusively-expressed Genes test. Use when user asks to identify genes uniquely expressed in one subtype, perform marker gene detection across multiple groups, or calculate subtype-specific p-values for transcriptomic and proteomic data.
homepage: https://bioconductor.org/packages/release/bioc/html/OVESEG.html
---

# bioconductor-oveseg

name: bioconductor-oveseg
description: Detect tissue/cell-specific marker genes (MGs) using the One Versus Everyone Subtype Exclusively-expressed Genes (OVESEG) test. Use this skill to identify genes uniquely expressed in one subtype compared to all others in multi-group datasets (Microarray, RNA-seq, Proteomics).

## Overview

OVESEG is a statistically-principled method for detecting marker genes (MGs) across multiple subtypes. Unlike standard differential expression which often compares two groups, OVESEG uses a "One Versus Everyone" approach. It employs a mixture null distribution model and a permutation scheme to assess the significance of genes that are exclusively upregulated in a specific subtype, even when non-marker genes exhibit complex expression patterns across other groups.

## Data Preparation

Before running OVESEG, ensure your data meets these requirements:
- **Transformation**: Data must be normally distributed (e.g., log2 for microarray/proteomics, logCPM for RNA-seq, logit2 for DNA methylation).
- **Filtering**: Remove low-expressed molecules and any rows with missing values.
- **Normalization**: Data should be normalized and batch-corrected.
- **Format**: Input should be a matrix, `DataFrame`, or `SummarizedExperiment`.

## Core Workflow

### 1. Microarray or Log-transformed Data
For data where the mean-variance relationship is stable:

```r
library(OVESEG)
library(BiocParallel)

# y: expression matrix, group: factor of subtype labels
rtest <- OVESEGtest(y, group, 
                    NumPerm = 999, 
                    BPPARAM = SnowParam())
```

### 2. RNA-seq Count Data
For RNA-seq, use `limma::voom` to handle the mean-variance relationship:

```r
library(limma)
library(OVESEG)

# count: raw count matrix
design <- model.matrix(~0 + factor(group))
yvoom <- voom(count, design)

rtest <- OVESEGtest(yvoom$E, group, 
                    weights = yvoom$weights, 
                    NumPerm = 999,
                    BPPARAM = SnowParam())
```

## Interpreting Results

The `OVESEGtest` function returns a list containing three types of p-values:
- `pv.overall`: Significance of the gene being a marker for *any* subtype.
- `pv.oneside`: Subtype-specific p-values for the most likely upregulated subtype.
- `pv.multiside`: `pv.oneside` corrected for the number of subtypes (K) and truncated at 1.

### Multiple Testing Correction
Always apply FDR control to the results:

```r
# Using fdrtool for q-values
library(fdrtool)
qv.overall <- fdrtool(rtest$pv.overall, statistic="pvalue", plot=FALSE)$qval
```

## Useful Intermediate Functions

### Ranking Genes without Permutations
If p-values are not required, use `OVESEGtstat` to rank genes by their marker-gene potential:

```r
tstats <- OVESEGtstat(y, group)
```

### Analyzing Expression Patterns
To estimate the distribution of null hypothesis components or visualize upregulation patterns:

```r
# Posterior probabilities of null components
ppnull <- postProbNull(y, group)

# Probability of a subtype being upregulated under the null
null_dist <- nullDistri(ppnull)

# Ratios of all possible upregulation patterns (2^K - 1 patterns)
patterns <- patternDistri(rtest)
```

## Tips
- **Parallelization**: Use `BPPARAM` to speed up the permutation process, which is the most computationally intensive step.
- **Variance Estimation**: By default, OVESEG uses `limma`'s empirical Bayes moderated variance (`alpha="moderated"`). You can provide a specific constant `alpha` if needed.
- **Filtering**: A common threshold for filtering is keeping genes where the maximum group mean exceeds a specific log-expression value (e.g., `log2(64)` for microarray).

## Reference documentation
- [OVESEG User Manual](./references/OVESEG.md)
- [OVESEG Vignette](./references/OVESEG.Rmd)