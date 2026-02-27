---
name: bioconductor-sagx
description: This package provides statistical tools for analyzing high-throughput gene expression data using penalized t-tests and permutation-based p-value estimation. Use when user asks to identify differentially expressed genes, estimate false discovery rates using isotonic regression, or perform restandardized gene set enrichment analysis.
homepage: https://bioconductor.org/packages/3.5/bioc/html/SAGx.html
---


# bioconductor-sagx

## Overview
The `SAGx` package provides a suite of statistical tools for the analysis of high-throughput gene expression data. Its primary strength lies in the `samroc` methodology, which utilizes a penalized t-test (incorporating a "fudge factor" to stabilize variance) and permutation-based p-value estimation. The package also includes specialized functions for isotonic regression-based FDR estimation and restandardized GSEA.

## Typical Workflow

### 1. Penalized T-Tests with samrocN
Use `samrocN` to identify differentially expressed genes using a linear model approach.

```r
library(SAGx)

# data: matrix of expression values (genes in rows, samples in columns)
# formula: a standard R formula, e.g., ~ as.factor(groups)
samroc.res <- samrocN(data = my_data, formula = ~ groups)

# View summary
show(samroc.res)

# Plot densities of the test statistic vs. permutation null distribution
plot(samroc.res)
```

### 2. Estimating FDR and Local FDR
After running a samroc analysis, use `pava.fdr` to estimate the False Discovery Rate and local FDR using isotonic regression.

```r
# Extract p-values from the samroc result object
pvals <- samroc.res@pvalues

# Calculate FDRs
fdrs <- pava.fdr(ps = pvals)

# fdrs$pava.fdr: estimated FDR
# fdrs$pava.local.fdr: estimated local FDR

# Visualize FDR vs p-values
plot(pvals, fdrs$pava.local.fdr, col = "red", xlab = "p-value", ylab = "FDR")
lines(lowess(pvals, fdrs$pava.fdr), col = "blue")
```

### 3. Gene Set Enrichment Analysis (GSEA)
Perform GSEA based on the samroc test statistics. This implementation includes restandardization to account for correlation structures.

```r
# samroc: result from samrocN or samrocNboot
# probeset: vector of probe IDs corresponding to the data rows
# pway: a list where each element is a vector of probe IDs for a pathway
gsea.res <- GSEA.mean.t(samroc = samroc.res, 
                        probeset = my_probe_ids, 
                        pway = my_pathways_list[1], 
                        type = "original", 
                        two.side = FALSE)
```

## Key Functions
- `samrocN`: Performs penalized t-tests using a linear model framework.
- `samrocNboot`: Similar to `samrocN` but specifically designed for bootstrap/permutation-heavy workflows.
- `pava.fdr`: Estimates FDR and local FDR using the Pool Adjacent Violators Algorithm (PAVA).
- `GSEA.mean.t`: Conducts gene set enrichment analysis based on the mean of the absolute values of the test statistics.

## Tips and Interpretation
- **Fudge Factor**: The "fudge factor" (a) in the denominator of the t-statistic helps prevent genes with very small variances from dominating the results. `samrocN` estimates this automatically.
- **p0 Estimation**: The package estimates the proportion of unchanged genes (`p0`). This value is accessible via `samroc.res@p0` and is used in FDR calculations.
- **P-value Calculation**: `SAGx` uses a refined permutation p-value calculation to avoid p-values of exactly zero, which is critical for downstream log-transformations or FDR modeling.

## Reference documentation
- [Samroc example](./references/samroc-ex.md)