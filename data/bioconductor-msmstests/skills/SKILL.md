---
name: bioconductor-msmstests
description: This package performs statistical tests for identifying differentially expressed proteins in label-free LC-MS/MS experiments using spectral counts. Use when user asks to identify differentially expressed proteins from spectral count data, perform differential proteomics analysis using GLMs, or apply reproducibility filters to LC-MS/MS results.
homepage: https://bioconductor.org/packages/release/bioc/html/msmsTests.html
---

# bioconductor-msmstests

name: bioconductor-msmstests
description: Statistical tests for label-free LC-MS/MS differential expression analysis using spectral counts. Use this skill when performing differential proteomics analysis to identify differentially expressed proteins (DEPs) using Poisson, Quasi-likelihood, or Negative Binomial GLMs, and when applying post-test filters (signal strength and effect size) to improve reproducibility.

# bioconductor-msmstests

## Overview

The `msmsTests` package provides statistical tools for identifying differentially expressed proteins in LC-MS/MS experiments based on spectral counts (SpC). It addresses the high-dimensionality and low-replicate nature of proteomics data by implementing Generalized Linear Models (GLMs) and a critical post-test "reproducibility filter." This filter excludes features with low signal strength or small effect sizes, which often lead to false positives in spectral counting.

## Core Workflow

### 1. Data Preparation
The package works with `MSnSet` objects. Data should be pre-processed to remove null features (rows with all zeros).

```r
library(msmsTests)
data(msms.spk)

# Pre-process: remove all-zero rows
e <- pp.msms.data(msms.spk)

# Define normalization factors (column sums)
div <- apply(exprs(e), 2, sum)
```

### 2. Statistical Testing
Choose a GLM based on your experimental design and number of replicates:

*   **Poisson GLM (`msms.glm.pois`)**: Best for very few replicates (2-3) where biological variability is expected to be low.
*   **Quasi-likelihood GLM (`msms.glm.qlll`)**: Distribution-free model that accounts for overdispersion. Recommended when you have 4+ replicates.
*   **Negative Binomial GLM (`msms.edgeR`)**: Uses `edgeR`'s empirical Bayes methods to share information across features. Suitable for low replicates (2+) while allowing for overdispersion.

```r
null.f <- "y ~ 1"
alt.f <- "y ~ treat"

# Example: Quasi-likelihood
res <- msms.glm.qlll(e, alt.f, null.f, div=div)

# Example: Negative Binomial (requires treatment factor name)
res.nb <- msms.edgeR(e, alt.f, null.f, div=div, fnm="treat")
```

### 3. Handling Batch Effects
If samples were processed in different batches, include a blocking factor in the model to improve sensitivity.

```r
null.f <- "y ~ batch"
alt.f <- "y ~ treat + batch"
res.blocked <- msms.glm.qlll(e, alt.f, null.f, div=div)
```

### 4. Post-test Filter for Reproducibility
Use `test.results` to apply the recommended reproducibility filters:
*   **minSpC**: Minimum average spectral counts in the most abundant condition (default: 2).
*   **minLFC**: Minimum Log2 Fold Change (default: 1).

```r
# Apply filter: Adjusted p-value < 0.05, SpC > 2, LFC > 1
final.tbl <- test.results(res, e, pData(e)$treat, "ConditionA", "ConditionB", 
                          div, alpha=0.05, minSpC=2, minLFC=1, method="BH")$tres

# Identify Differentially Expressed Proteins (DEPs)
deps <- rownames(final.tbl)[final.tbl$DEP]
```

## Visualization

### Volcano Plots
Visualize the relationship between effect size and statistical significance, highlighting filtered results.

```r
res.volcanoplot(final.tbl, max.pval=0.05, min.LFC=1)
```

### P-value Distribution by Fold Change
Check the distribution of p-values across different fold-change bins to validate filter cut-offs.

```r
pval.by.fc(final.tbl$adjp, final.tbl$LogFC)
```

## Tips for Success
*   **Normalization**: Always provide the `div` parameter (usually column sums of the spectral counts) to account for differences in total sampling depth between runs.
*   **Filtering**: The post-test filter is often more effective at controlling False Discovery Rate (FDR) than strict p-value adjustment alone in proteomics.
*   **Model Selection**: If the Poisson model yields too many significant results that don't replicate, switch to Quasi-likelihood or Negative Binomial to account for overdispersion.

## Reference documentation
- [msmsTests package: LC-MS/MS post test filters to improve reproducibility](./references/msmsTests-Vignette.md)
- [msmsTests package: Blocks design to compensate batch effects](./references/msmsTests-Vignette2.md)