---
name: bioconductor-bayesknockdown
description: This tool uses a Bayesian framework to estimate the posterior probability of regulatory relationships between a predictor gene and potential targets in genetic perturbation experiments. Use when user asks to estimate posterior probabilities of gene regulation, analyze knockdown or over-expression data, and perform differential expression analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/BayesKnockdown.html
---


# bioconductor-bayesknockdown

## Overview

The `BayesKnockdown` package provides a Bayesian framework to estimate the posterior probability of a relationship between a predictor (typically a knocked-down gene) and multiple potential targets. It is specifically designed for genetic perturbation data but is applicable to any over-expression or knockdown experiments. It utilizes Zellner’s g-prior to balance signal and noise and allows for the incorporation of informative prior probabilities.

## Core Functions

### BayesKnockdown()
The primary function for calculating posterior probabilities of regulation.

```r
# x: vector of expression levels for the predictor (knockdown gene)
# y: matrix of expression levels for potential targets (genes in rows, experiments in columns)
# prior: prior probability of a relationship (default 0.5)
# g: Zellner's g-prior (default sqrt(n))
results <- BayesKnockdown(x, y, prior = 0.5, g = sqrt(length(x)))
```

### BayesKnockdown.es()
A wrapper for `ExpressionSet` objects from the `Biobase` package.

```r
# eset: An ExpressionSet object
# predictor: Character string of the feature name to use as the predictor
results <- BayesKnockdown.es(eset, "FEATURE_NAME")
```

### BayesKnockdown.diffExp()
Tests for differential expression between two conditions (e.g., drug vs. control).

```r
# y1: Matrix for condition 1 (genes in rows)
# y2: Matrix for condition 2 (genes in rows)
diff_results <- BayesKnockdown.diffExp(y1, y2)
```

## Typical Workflows

### 1. Analyzing Knockdown Data
When you have a specific gene that was knocked down across multiple replicates or experiments:

1.  **Prepare Data**: Ensure the predictor gene `x` and target matrix `y` have matching columns (experiments).
2.  **Set Priors**: For large-scale screens (like LINCS L1000), use a conservative prior (e.g., `0.0005`) to account for the sparsity of regulatory networks.
3.  **Run Inference**:
    ```r
    library(BayesKnockdown)
    data(lincs.kd)
    # Row 1 is the knockdown gene, rows 2:N are targets
    probs <- BayesKnockdown(lincs.kd[1,], lincs.kd[-1,], prior = 0.0005)
    ```
4.  **Visualize**: Use a barplot to identify high-probability targets.
    ```r
    barplot(probs, ylab = "Posterior Probability", ylim = c(0, 1))
    ```

### 2. Differential Expression Analysis
To find genes that behave differently between two groups:

```r
# y1 and y2 are matrices where rows are genes
# Columns do not need to be equal in number between y1 and y2
diff_probs <- BayesKnockdown.diffExp(group1_matrix, group2_matrix)

# Identify genes with high posterior probability (> 0.5 or > 0.9)
significant_genes <- names(diff_probs[diff_probs > 0.9])
```

## Implementation Tips

*   **g-prior Selection**: The default `g = sqrt(n)` is a recommended compromise. Larger values of `g` assume a stronger expected signal relative to noise.
*   **Interpreting Results**: Values close to 1.0 indicate a very high likelihood of a regulatory relationship or differential expression, while values near 0 indicate no evidence of a relationship.
*   **Data Normalization**: Ensure expression data is normalized (e.g., log-transformed) before running `BayesKnockdown`, as the underlying model assumes normally distributed errors.

## Reference documentation

- [BayesKnockdown](./references/BayesKnockdown.md)