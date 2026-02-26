---
name: bioconductor-genemeta
description: This tool performs meta-analysis of microarray data to combine results from multiple studies. Use when user asks to identify consistently differentially expressed genes across experiments, calculate effect sizes, assess study homogeneity, or fit fixed and random effects models.
homepage: https://bioconductor.org/packages/release/bioc/html/GeneMeta.html
---


# bioconductor-genemeta

name: bioconductor-genemeta
description: Meta-analysis of microarray data to combine results from multiple studies. Use when comparing two phenotypes across different experiments to identify consistently differentially expressed genes using Fixed Effects Models (FEM) or Random Effects Models (REM).

# bioconductor-genemeta

## Overview

The `GeneMeta` package provides tools for the meta-analysis of microarray experiments. It focuses on combining data from multiple studies that address the same biological question (e.g., tumor vs. normal) to improve statistical power and inference. It supports both Fixed Effects Models (FEM), which assume a common effect across studies, and Random Effects Models (REM), which account for between-study variability.

## Core Workflow: Manual Meta-Analysis

If you need to perform the meta-analysis step-by-step to inspect intermediate statistics:

1.  **Calculate Effect Sizes (d) for each study:**
    Use `getdF` to get the initial effect size and `dstar` to adjust for bias.
    ```r
    # For each study (eset1, eset2...)
    d1 <- getdF(eset1, labels1) # labels are 0/1
    d_adj1 <- dstar(d1, length(labels1))
    var_d1 <- sigmad(d_adj1, sum(labels1==0), sum(labels1==1))
    ```

2.  **Assess Homogeneity (Cochran's Q):**
    Combine adjusted means and variances into matrices to calculate the Q statistic.
    ```r
    mymns <- cbind(d_adj1, d_adj2)
    myvars <- cbind(var_d1, var_d2)
    my_Q <- f.Q(mymns, myvars)
    # Compare my_Q to a Chi-square distribution with (k-1) degrees of freedom
    ```

3.  **Fit the Model:**
    *   **Fixed Effects Model (FEM):** Use if studies are homogeneous (Q is small).
        ```r
        muFEM <- mu.tau2(mymns, myvars)
        sdFEM <- var.tau2(myvars)
        ZFEM <- muFEM / sqrt(sdFEM)
        ```
    *   **Random Effects Model (REM):** Use if studies are heterogeneous.
        ```r
        # Estimate between-study variance (tau^2)
        tau2 <- tau2.DL(my_Q, num_studies, my_weights = 1/myvars)
        myvarsDL <- myvars + tau2
        muREM <- mu.tau2(mymns, myvarsDL)
        varREM <- var.tau2(myvarsDL)
        ZREM <- muREM / sqrt(varREM)
        ```

## High-Level Analysis Functions

For a more automated workflow, use the wrapper functions:

### zScores
Computes the meta-analysis scores for a list of ExpressionSets.
```r
esets <- list(Study1, Study2)
classes <- list(labels1, labels2)
# Combine specific experiments (e.g., 1 and 2)
results <- zScores(esets, classes, useREM = FALSE, CombineExp = 1:2)
```
The output includes:
*   `MUvals`: Overall mean effect size.
*   `zSco`: The combined Z-score.
*   `Qvals`: Cochran's Q statistic per gene.
*   `Qpvalues`: P-value for the hypothesis of homogeneity.

### zScoreFDR
Estimates the False Discovery Rate (FDR) using a permutation-based (SAM-type) approach.
```r
scoresFDR <- zScoreFDR(esets, classes, useREM = FALSE, nperm = 50, CombineExp = 1:2)
# Access results for positive, negative, or two-sided effects
pos_fdr <- scoresFDR$pos
```

## Visualization

*   **IDR Plot:** Shows the Integration Driven Discovery Rate—the fraction of genes identified in the meta-analysis that were not found in individual studies at the same threshold.
    ```r
    IDRplot(results, Combine = 1:2)
    ```
*   **Count Plot:** Compares the number of genes below an FDR threshold across different studies and the combined analysis.
    ```r
    CountPlot(scoresFDR, Score = "FDR", kindof = "two.sided")
    ```

## Tips for Success
*   **Identifier Matching:** Ensure that the row names (gene identifiers) of all ExpressionSets are matched and in the same order before combining.
*   **Phenotype Coding:** Phenotype labels must be converted to numeric 0 and 1 for the functions to process them correctly.
*   **Model Selection:** Always check the Q-statistic histogram. If the mean of Q is significantly higher than the degrees of freedom (number of studies - 1), prefer the Random Effects Model (REM).

## Reference documentation
- [GeneMeta](./references/GeneMeta.md)