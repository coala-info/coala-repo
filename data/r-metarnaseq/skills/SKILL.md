---
name: r-metarnaseq
description: R package metarnaseq (documentation from project home).
homepage: https://cran.r-project.org/web/packages/metarnaseq/index.html
---

# r-metarnaseq

## Overview
The `metaRNASeq` package provides tools to combine p-values from independent RNA-Seq studies to identify consistently differentially expressed genes. It specifically implements two well-known meta-analysis techniques:
1. **Inverse Normal Method**: Weights p-values based on study-specific parameters.
2. **Fisher's Method**: A classical non-parametric approach to combining p-values.

The package is designed to work with p-values generated from standard differential expression tools like `DESeq2` or `edgeR`.

## Installation
To install the package from CRAN:
```R
install.packages("metaRNASeq")
```

## Core Functions

### P-value Combination
- `combP`: The primary function for combining p-values.
  - `method = "invnorm"`: Uses the inverse normal method.
  - `method = "fisher"`: Uses Fisher's method.
- `fishercomb`: Specific implementation of Fisher's combination method.
- `invnorm`: Specific implementation of the inverse normal combination method.

### Utility and Visualization
- `IDfilter`: Filters genes based on their presence across multiple studies.
- `adjpval`: Computes adjusted p-values (FDR) for the meta-analysis results.
- `sim_data`: Generates synthetic RNA-Seq data for testing meta-analysis workflows.

## Workflow Example

A typical meta-analysis workflow involves preparing p-values from multiple studies and then combining them.

```R
library(metaRNASeq)

# 1. Prepare p-values from Study A and Study B
# (Assuming pval1 and pval2 are vectors of p-values for the same genes)
pvals <- cbind(pval1, pval2)

# 2. Combine p-values using the Inverse Normal method
# Weights can be defined (e.g., based on sample size)
meta_results <- invnorm(pvals, weights = c(1, 1))

# 3. Combine p-values using Fisher's method
fisher_results <- fishercomb(pvals)

# 4. Adjust for multiple testing
adj_p <- p.adjust(meta_results, method = "BH")

# 5. Identify significant genes
significant_genes <- which(adj_p < 0.05)
```

## Tips for Success
- **Gene Alignment**: Ensure that the rows in your p-value matrix correspond to the exact same genes across all studies. Use `IDfilter` if some genes are missing in certain studies.
- **Independence**: These methods assume that the experiments being combined are independent.
- **Weighting**: In the inverse normal method, weights are often chosen as the square root of the sample size for each study.
- **One-sided vs Two-sided**: Ensure p-values are calculated consistently (usually two-sided) before combination.

## Reference documentation
- [metaRNASeq Home Page](./references/home_page.md)