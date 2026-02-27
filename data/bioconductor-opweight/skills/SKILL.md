---
name: bioconductor-opweight
description: This tool performs optimal p-value weighting to increase power in multiple hypothesis testing by using external covariates. Use when user asks to compute weights for p-values, perform covariate rank weighting, or increase statistical power in high-dimensional data analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/OPWeight.html
---


# bioconductor-opweight

name: bioconductor-opweight
description: Perform Optimal P-value Weighting (OPW) to increase power in multiple hypothesis testing using external covariates (filter statistics). Use this skill when you need to compute weights for p-values based on the probabilistic relationship between test statistics and covariates, particularly for high-dimensional data like RNA-seq.

# bioconductor-opweight

## Overview

The `OPWeight` package implements the Covariate Rank Weighting (CRW) method. It improves the power of multiple hypothesis testing by assigning weights to p-values using an external covariate (e.g., `baseMean` in RNA-seq). Unlike other methods, it computes optimal weights without requiring explicit estimation of effect sizes for every test, instead using a probabilistic relationship between the ranking of tests and the mean effect size.

## Core Workflow

The primary function is `opw()`, which performs the entire weighting and testing procedure.

### 1. Basic Usage

To run the standard analysis, you need a vector of p-values and a corresponding vector of covariates (filter statistics).

```r
library(OPWeight)

# pvalue: vector of p-values
# filter: vector of covariates (must be positive for internal Box-Cox)
# effectType: "continuous" (default) or "binary"
# alpha: significance level (FDR or FWER)
# tail: 1 for one-tailed, 2 for two-tailed tests

results <- opw(pvalue = my_pvals, 
               filter = my_covariates, 
               effectType = "continuous", 
               alpha = 0.05, 
               method = "BH", 
               tail = 2)

# Access results
results$rejections      # Number of rejected hypotheses
results$nullProp        # Estimated proportion of true nulls (pi0)
results$weight          # Calculated weights for each test
results$rejections_list # Data frame of significant features
```

### 2. Data Preparation Tips

*   **Positive Covariates:** The internal `box-cox` transformation requires positive values. If your covariates contain zeros or negative values, add a small constant: `covariates <- covariates + 0.0001`.
*   **Independence:** Ensure the covariate is independent of the test statistic under the null hypothesis but informative under the alternative.
*   **Effect Type:** Use `effectType = "continuous"` if effect sizes vary across features, or `"binary"` if you expect a fixed effect size for all alternative hypotheses.

### 3. Advanced/Manual Weighting

If you want to use a custom model (e.g., GLM) instead of the default Box-Cox linear regression to find the relationship between test statistics and covariates, you can compute parameters manually and pass them to `opw()`.

*   **`prob_rank_givenEffect`**: Computes the probability of a rank given a mean effect.
*   **`weight_continuous_nwt`**: Computes weights using the Newton-Raphson algorithm (fast).
*   **`weight_continuous`**: Computes weights using a grid search (slower but robust).

```r
# Example: Providing pre-computed weights
opw_res <- opw(pvalue = my_pvals, 
               filter = my_covariates, 
               weight = pre_computed_weights, 
               alpha = 0.1)
```

## Interpreting Results

The `opw` object contains:
*   `totalTests`: Total number of hypotheses.
*   `nullProp`: The estimated $\pi_0$.
*   `ranksProb`: The probability $P(r_i | \epsilon_i)$ used to derive weights.
*   `weight`: The optimal weights assigned to each p-value.
*   `rejections`: Count of significant results after weighting.

## Reference documentation

- [Introduction to OPWeight](./references/OPWeight.Rmd)
- [OPWeight Vignette](./references/OPWeight.md)