---
name: bioconductor-plpe
description: This tool identifies differentially expressed proteins or genes in paired high-throughput data using local pooled error methods. Use when user asks to perform paired t-tests, calculate Paired L-statistics or Lw-statistics, and estimate False Discovery Rates for proteomics or microarray datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/PLPE.html
---

# bioconductor-plpe

name: bioconductor-plpe
description: Statistical identification of differentially expressed proteins or genes in paired high-throughput data (e.g., LC-MS/MS proteomics or microarray). Use this skill to perform paired t-tests, Paired L-statistics (using local pooled error), and Paired Lw-statistics (weighted variance) with associated False Discovery Rate (FDR) estimation.

## Overview

The `PLPE` package provides specialized statistical tools for analyzing paired experimental designs in proteomics and genomics. It is particularly effective for data with low replication by "borrowing" error information from proteins with similar intensities (Local Pooled Error). It offers three main statistics:
1. **Paired t-test**: Standard comparison, but often underpowered with small samples.
2. **Paired L-statistic**: Uses median differences and local pooled error (LPE) variance estimates.
3. **Paired Lw-statistic**: A weighted average of individual and pooled variance estimates to balance biological variability and statistical power.

## Workflow and Usage

### 1. Data Preparation
Input data should be a matrix of intensities. It is recommended to log2-transform the data before analysis to handle right-skewed distributions.

```r
library(PLPE)
# Example using internal dataset
data(plateletSet)
x <- exprs(plateletSet)
x <- log2(x)
```

### 2. Experimental Design
Define the design matrix with two columns: `cond` (condition/group) and `pair` (pairing indicator).

```r
# Example: 3 pairs of 2 conditions
cond <- c(1, 2, 1, 2, 1, 2)
pair <- c(1, 1, 2, 2, 3, 3)
design <- cbind(cond, pair)
```

### 3. Computing Statistics
Use `lpe.paired` to calculate the M (log-ratio) and A (average intensity) values along with the L, Lw, and t-statistics.

```r
# q: percentage of interval partitions for pooling (0.1 = 10% of data per interval)
# data.type: "ms" for mass spectrometry or "cdna" for microarray
out <- lpe.paired(x = x, design = design, q = 0.1, data.type = "ms")

# View results (M, A, variances, statistics, and p-values)
head(out$test.out)
```

### 4. FDR Estimation
Estimate False Discovery Rates using a rank-invariant resampling technique.

```r
out.fdr <- lpe.paired.fdr(x, obj = out)

# View FDR results for L and Lw statistics
head(out.fdr$FDR)
```

## Tips and Interpretation
- **Weighting (w)**: The `Lw` statistic defaults to a weight of 0.5 between pooled and individual variance. This can be adjusted in `lpe.paired` to favor one over the other.
- **Interval Partition (q)**: If the intensity-variance relationship is highly non-linear, consider adjusting `q`. Smaller values of `q` provide more local estimates but require more data points to remain stable.
- **Missing Values**: Ensure data is pre-processed or imputed if necessary, as high-throughput proteomics often contains missing values that can affect variance pooling.

## Reference documentation
- [How to use the PLPE Package](./references/PLPE.md)