---
name: bioconductor-ihw
description: IHW performs independent hypothesis weighting to increase statistical power in multiple testing by incorporating an informative covariate. Use when user asks to control the false discovery rate, adjust p-values using independent covariates, or perform weighted Benjamini-Hochberg or Bonferroni corrections.
homepage: https://bioconductor.org/packages/release/bioc/html/IHW.html
---


# bioconductor-ihw

## Overview

IHW is a multiple testing procedure that extends the Benjamini-Hochberg (BH) or Bonferroni methods by incorporating an independent covariate for each hypothesis. This covariate should be informative of the test's power or prior probability of being a true alternative, while remaining independent of the p-values under the null hypothesis. By assigning higher weights to tests more likely to be discoveries, IHW increases the total number of rejections while maintaining control over the False Discovery Rate (FDR) or Family-Wise Error Rate (FWER).

## Core Workflow

### 1. Basic IHW Analysis
The primary function is `ihw()`. It requires a formula where the left side is the p-values and the right side is the covariate.

```r
library(IHW)

# Basic usage for FDR control (default)
# pvalue: vector of p-values
# baseMean: vector of covariates (e.g., mean expression)
ihw_res <- ihw(pvalue ~ baseMean, data = de_results, alpha = 0.1)

# Get total number of rejections
rejections(ihw_res)

# Extract adjusted p-values
adj_p <- adj_pvalues(ihw_res)

# Extract weights
w <- weights(ihw_res)
```

### 2. FWER Control
To control the Family-Wise Error Rate instead of the FDR, use the `adjustment_type` argument.

```r
ihw_bonf <- ihw(pvalue ~ baseMean, data = de_results, alpha = 0.05, 
                adjustment_type = "bonferroni")
```

### 3. Diagnostic Plots
IHW provides several plotting methods to validate the weighting strategy and covariate choice.

```r
# Plot weights across strata and folds
plot(ihw_res)

# Plot the decision boundary (p-value threshold vs covariate)
plot(ihw_res, what = "decisionboundary")

# Compare raw p-values vs adjusted p-values
library(ggplot2)
ggplot(as.data.frame(ihw_res), aes(x = pvalue, y = adj_pvalue, col = group)) +
  geom_point(size = 0.25)
```

## Choosing a Covariate

A valid covariate must satisfy three criteria:
1. **Informative**: Correlated with the power of the test (e.g., higher mean counts in RNA-Seq often have more power).
2. **Independent under the Null**: The distribution of p-values for true nulls must not depend on the covariate.
3. **Unrelated to Dependence**: The covariate should not drive the correlation structure between tests (e.g., genomic position is often invalid due to Linkage Disequilibrium).

**Common Covariates:**
- **RNA-Seq**: `baseMean` (mean of normalized counts).
- **t-tests**: Overall variance across all samples.
- **eQTL**: SNP-gene distance.
- **GWAS**: Minor allele frequency.

## Advanced Usage: Incomplete P-value Lists

If you only have p-values below a certain threshold (e.g., from HMMER or MatrixEQTL), you can still use IHW by providing the total number of tests per stratum.

```r
# 1. Pre-stratify the covariate into factors
nbins <- 20
de_results$group <- groups_by_filter(de_results$covariate, nbins)

# 2. Calculate total counts per group from the full dataset
m_groups <- table(de_results$group)

# 3. Run IHW on the subset of reported p-values
ihw_sub <- ihw(p ~ group, data = reported_only_df, 
               alpha = 0.1, m_groups = m_groups)
```

## Tips for Success
- **Check Calibration**: Use `facet_wrap(~ group)` with `geom_histogram` to ensure p-value histograms are uniform at the tail (large p-values) for all covariate strata.
- **Data Splitting**: IHW uses random folds (default `nfolds = 5`) to avoid overfitting. Results may vary slightly between runs unless a seed is set.
- **Object Conversion**: Use `as.data.frame(ihw_res)` to get a tidy dataframe containing p-values, adjusted p-values, weights, and fold assignments.

## Reference documentation
- [Introduction to Independent Hypothesis Weighting with the IHW Package](./references/introduction_to_ihw.md)