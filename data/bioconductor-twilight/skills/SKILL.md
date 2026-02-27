---
name: bioconductor-twilight
description: This tool performs statistical analysis of differential gene expression and correlation using local False Discovery Rate estimation and permutation-based testing. Use when user asks to estimate local false discovery rates, calculate permutation-based p-values, filter permutations for hidden confounders, or visualize the twilight zone between differential and non-differential expression.
homepage: https://bioconductor.org/packages/release/bioc/html/twilight.html
---


# bioconductor-twilight

name: bioconductor-twilight
description: Statistical analysis of differential gene expression and correlation using local False Discovery Rate (fdr) estimation. Use this skill to calculate permutation-based p-values, estimate the percentage of non-induced genes (pi0), filter permutations for hidden confounders, and visualize the "twilight zone" between clear differential and non-differential expression.

# bioconductor-twilight

## Overview
The `twilight` package provides a stochastic search algorithm (Successive Exclusion Procedure - SEP) to estimate the local false discovery rate (fdr) in high-throughput experiments. It is primarily used for two-condition comparisons (e.g., Treatment vs. Control) or correlation analysis with clinical parameters. A key feature is its ability to filter permutations to remove the influence of hidden confounders, ensuring the null distribution is correctly described.

## Core Workflow

### 1. Testing for Differential Expression
Use `twilight.pval` to compute permutation-based p-values and q-values for two-condition data.

```r
library(twilight)

# xin: ExpressionSet or matrix (rows=genes, cols=samples)
# yin: Binary vector of condition labels (e.g., 1 and 2)
# method: "fc" (fold change/log-ratio), "t" (t-test), or "z" (Z-test with fudge factor)
# B: Number of permutations
# filtering: Set to TRUE to invoke the permutation filtering algorithm
result_pval <- twilight.pval(xin = my_data, yin = my_labels, method = "fc", B = 1000, filtering = TRUE)

# View summary
print(result_pval)
# Access results table (observed/expected scores, p-values, q-values)
head(result_pval$result)
```

### 2. Testing for Correlation
To find genes correlated with a continuous clinical parameter:

```r
# method: "pearson" or "spearman"
# yin: Numerical vector of clinical values
result_corr <- twilight.pval(xin = my_data, yin = clinical_vector, method = "spearman", B = 1000)
```

### 3. Estimating Local FDR (Successive Exclusion Procedure)
After calculating p-values, use `twilight` to estimate the local fdr and the proportion of non-induced genes ($\pi_0$).

```r
# B: Number of bootstrap samples for confidence intervals
# lambda: Regularization parameter (NULL for automatic detection)
result_fdr <- twilight(xin = result_pval, B = 1000)

# Access pi0 estimate and bootstrap confidence intervals
result_fdr$pi0
result_fdr$boot.ci
```

### 4. Visualization
The package provides a specialized plotting function for `twilight` objects.

```r
# Observed vs Expected scores (SAM-style plot)
plot(result_fdr, which = "scores")

# Local FDR vs p-values
plot(result_fdr, which = "fdr")

# Volcano plot (Observed scores vs Local FDR)
plot(result_fdr, which = "volcano")

# Effect size distribution (Alternative vs Mixture)
plot(result_fdr, which = "effectsize")
```

## Advanced Functions

### Permutation Filtering
If you need to manually inspect or use filtered permutations (e.g., to check for uniformity of p-values under the null):

```r
# Returns a matrix of filtered permutations
filtered_perms <- twilight.filtering(xin = my_data, yin = my_labels, method = "fc", num.perm = 100)

# Use these permutations in a subsequent p-value calculation
result_filtered <- twilight.pval(my_data, my_labels, yperm = filtered_perms)
```

### Manual Permutation Enumeration
For small sample sizes, `twilight.combi` can enumerate all possible permutations.

```r
# pin: TRUE for paired data
# bin: TRUE for balanced permutations
perms <- twilight.combi(my_labels, pin = FALSE, bin = FALSE)
```

## Tips for Usage
- **Data Scale**: Input data must be on an additive scale (e.g., log2 or arsinh). The package does not perform this transformation for you.
- **Parallelization**: For large bootstrap runs in `twilight()`, use the `clus` argument to pass a cluster object from the `snow` package.
- **Pooled P-values**: `twilight` uses pooled p-values (all genes combined) rather than gene-wise p-values, which provides better resolution and monotonicity.
- **Fudge Factor**: In `method = "z"`, the fudge factor `s0` defaults to the median of pooled standard deviations if not specified.

## Reference documentation
- [User’s Guide to the Bioconductor Package twilight](./references/tr_2004_01.md)