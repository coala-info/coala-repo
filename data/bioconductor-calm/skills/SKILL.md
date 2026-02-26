---
name: bioconductor-calm
description: The calm package estimates the conditional local False Discovery Rate by incorporating auxiliary covariate information into multiple testing procedures. Use when user asks to improve statistical power in genomic experiments, estimate conditional local FDR, or calculate global FDR using contextual information.
homepage: https://bioconductor.org/packages/release/bioc/html/calm.html
---


# bioconductor-calm

## Overview
The `calm` package provides tools for multiple testing procedures that utilize auxiliary covariate information. In genomic experiments where thousands of tests are conducted simultaneously, `calm` improves statistical power by estimating the **conditional local False Discovery Rate (CLfdr)**—the posterior probability of a null hypothesis being true given both the test statistic and available contextual information.

## Core Workflow

### 1. Data Preparation
The package typically works with $z$-values. If you have $t$-statistics from a differential expression analysis (e.g., `limma`), transform them first:

```r
# Transform t-statistics to z-values
# df is the degrees of freedom from the linear model
z <- qnorm(pt(t_stat, df))
```

### 2. Covariate Normalization
For stability in estimation, covariates (like gene length or prior study statistics) should be normalized, often using ranks:

```r
# Normalize a single covariate to [0, 1] range
x_norm <- rank(covariate) / length(covariate)
```

### 3. Estimating Conditional Local FDR (CLfdr)
The `CLfdr` function is the primary tool for modeling the relationship between your test statistics and covariates.

```r
library(calm)

# Single covariate
fit <- CLfdr(x = x_norm, y = z_values)

# Multiple covariates (matrix format)
x_mat <- cbind(cov1_norm, cov2_norm)
colnames(x_mat) <- c("PriorStudy", "GeneLength")
fit <- CLfdr(x = x_mat, y = z_values)
```

**Note on Bandwidth:** If `CLfdr` takes too long (it can take 20+ minutes for large datasets), you can manually specify the `bw` parameter if known from previous runs or pilot subsets.

### 4. Estimating Global FDR
After obtaining the local FDR values, use `EstFDR` to calculate the adjusted FDR for the entire set of hypotheses.

```r
# Combine results if you analyzed groups separately
all_fdr <- fit$fdr 

# Calculate global FDR
FDR_adjusted <- EstFDR(all_fdr)

# Identify significant hits (e.g., at 1% level)
significant_genes <- names(FDR_adjusted)[FDR_adjusted < 0.01]
```

## Key Functions
- `CLfdr(x, y, ...)`: Estimates the conditional local FDR. `x` is the covariate (vector or matrix), `y` is the vector of $z$-values.
- `EstFDR(fdr)`: Converts local FDR values into global FDR estimates for significance testing.
- `data("pso")`: Loads the example psoriasis dataset containing $z$-values, gene lengths, and microarray $t$-statistics.

## Tips for Success
- **Directional Information:** Use $z$-values instead of $p$-values to preserve the direction of effect (up-regulated vs. down-regulated), which `calm` utilizes for better modeling.
- **Missing Data:** If some genes lack auxiliary information, split the dataset into groups (e.g., one group with all covariates, one with only a subset) and combine the `fdr` results before calling `EstFDR`.
- **Covariate Choice:** Auxiliary information should be potentially informative of the likelihood of a gene being differentially expressed (e.g., conservation scores, expression levels in related tissues).

## Reference documentation
- [Introduction to calm](./references/calm_intro.md)
- [Introduction to calm (RMarkdown)](./references/calm_intro.Rmd)