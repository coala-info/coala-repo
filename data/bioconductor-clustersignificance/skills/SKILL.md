---
name: bioconductor-clustersignificance
description: This tool provides a statistical framework to assess the separation of pre-defined class clusters in dimensionality-reduced data. Use when user asks to test cluster separation significance, project data onto principal curves or mean lines, and calculate p-values for group differences in PCA or PCoA space.
homepage: https://bioconductor.org/packages/release/bioc/html/ClusterSignificance.html
---

# bioconductor-clustersignificance

name: bioconductor-clustersignificance
description: Statistical assessment of class cluster separation in dimensionality-reduced data (e.g., PCA, PCoA). Use this skill to determine if clusters representing known classes (e.g., disease vs. healthy) are significantly separated compared to random permutations.

# bioconductor-clustersignificance

## Overview

The `ClusterSignificance` package provides a statistical framework to test the separation between pre-defined groups (classes) in reduced dimensional space. It transforms multi-dimensional data into a single dimension via projection, calculates a separation score based on ROC-like metrics (sensitivity/specificity), and estimates p-values through Monte Carlo permutations.

## Core Workflow

The analysis follows a three-stage process: **Projection** -> **Classification** -> **Permutation**.

### 1. Projection
Project data points onto a one-dimensional line. Choose a method based on your data dimensions and class count.

*   **Principal Curve Projection (PCP):** Best for >2 dimensions or >2 classes. Requires at least 5 points per class.
    ```r
    library(ClusterSignificance)
    # mat: matrix with samples as rows, dimensions as columns
    # classes: character vector of class labels
    prj <- pcp(mat, classes, normalize = TRUE)
    plot(prj)
    ```
*   **Mean Line Projection (MLP):** Best for exactly 2 dimensions and 2 classes. Draws a line through class means.
    ```r
    prj <- mlp(mat, classes)
    plot(prj)
    ```

### 2. Separation Classification
Calculate the separation score and Area Under the Curve (AUC) for the projected points.

```r
cl <- classify(prj)
plot(cl)
# Retrieve AUC values
getData(cl, "AUC")
```

### 3. Score Permutation
Test the null hypothesis that class labels are independent of the features.

```r
# iter: number of permutations (10^4 recommended for publication)
pe <- permute(mat = mat, iter = 100, classes = classes, projmethod = "pcp")
plot(pe)

# Get p-values and confidence intervals
pvalue(pe)
conf.int(pe, conf.level = 0.95)
```

## Practical Applications

### Post-PCA Analysis
A common use case is verifying if clusters seen in a PCA plot are statistically distinct.

```r
pca_res <- prcomp(expression_matrix, scale = TRUE)
pc_scores <- pca_res$x[, 1:3] # Use first 3 PCs
prj <- pcp(pc_scores, group_labels)
# Follow with classify() and permute()
```

### Handling Large Iterations
If permutations are computationally heavy, you can run them in batches and concatenate the results.

```r
pe1 <- permute(mat, iter=50, classes=classes, projmethod="pcp")
pe2 <- permute(mat, iter=50, classes=classes, projmethod="pcp")
pe_combined <- c(pe1, pe2)
pvalue(pe_combined)
```

## Key Considerations
*   **Input Format:** Input matrices must have samples in rows and dimensions in columns.
*   **P-value Estimates:** Since this uses Monte Carlo sampling, p-values are estimates. Always check `conf.int()` to ensure the upper bound of the confidence interval is below your alpha threshold (e.g., 0.05).
*   **Assumptions:** The method assumes "exchangeability" (the null hypothesis implies labels can be shuffled without changing the joint distribution).
*   **Principal Curve Tuning:** If the curve doesn't fit well, you can adjust the degrees of freedom using the `df` argument in both `pcp()` and `permute()`. **Note:** The `df` value must be identical in both functions for valid results.

## Reference documentation
- [ClusterSignificance Vignette](./references/ClusterSignificance-vignette.Rmd)
- [ClusterSignificance Vignette (Markdown)](./references/ClusterSignificance-vignette.md)