---
name: bioconductor-ocplus
description: This tool provides statistical methods for sample size assessment and identifying differentially expressed genes in microarray experiments using False Discovery Rate. Use when user asks to calculate theoretical or empirical operating characteristics, determine required sample sizes for microarray studies, or identify differentially expressed genes using local FDR methods.
homepage: https://bioconductor.org/packages/release/bioc/html/OCplus.html
---


# bioconductor-ocplus

name: bioconductor-ocplus
description: Tools for sample size assessment and data analysis in microarray experiments using False Discovery Rate (FDR). Use this skill to calculate theoretical operating characteristics (TOC), estimate empirical operating characteristics (EOC), and identify differentially expressed genes using 1D and 2D local FDR.

## Overview
The `OCplus` package provides a statistical framework for microarray experiments based on the False Discovery Rate (FDR). It is designed to help researchers navigate the trade-off between FDR and sensitivity (power) during both the experimental design phase (sample size calculation) and the analysis phase (identifying differentially expressed genes).

## Core Workflows

### 1. Sample Size Assessment
Before conducting an experiment, use these functions to determine the required number of replicates.

*   **`samplesize(p0, D, crit)`**: Calculates the global FDR for a given proportion of non-differentially expressed (non-DE) genes (`p0`), a specific effect size (`D`, log2-fold change), and a threshold for the top percentage of genes (`crit`).
    ```r
    # Example: 95% non-DE, 2-fold change (D=1), top 1% genes
    ss <- samplesize(p0=0.95, D=1, crit=0.01)
    print(ss)
    plot(ss)
    ```
*   **`TOC(n, p0, D)`**: Generates Theoretical Operating Characteristics. It shows the trade-off between FDR and sensitivity for a specific sample size `n`.
    ```r
    TOC(n=20, p0=0.95, D=1)
    ```

### 2. Identifying Differentially Expressed (DE) Genes
Once data is collected, use these functions to identify DE genes.

*   **`EOC(data, group)`**: Computes Empirical Operating Characteristics. Returns t-statistics, p-values, FDR, and sensitivity for each gene.
    ```r
    # data: matrix of log-expression; group: vector of group labels
    result_eoc <- EOC(simdat, colnames(simdat))
    topDE(result_eoc, co=0.1) # Extract genes with FDR < 0.1
    ```
*   **`fdr1d(data, group)`**: Calculates the local (univariate) FDR for each gene. This is often more powerful than global FDR as it uses smoothing.
    ```r
    result_fdr1d <- fdr1d(simdat, colnames(simdat))
    plot(result_fdr1d)
    ```
*   **`fdr2d(data, group, p0)`**: Calculates the 2D local FDR using both the t-statistic and the log standard error. This is the most powerful method but requires careful smoothing.
    ```r
    # It is recommended to provide p0 from fdr1d or tMixture
    result_fdr2d <- fdr2d(simdat, colnames(simdat), p0=p0(result_fdr1d))
    plot(result_fdr2d)
    ```

### 3. Estimating the Proportion of non-DE Genes (p0)
Accurate estimation of `p0` is critical for FDR calculations.

*   **`tMixture(tt, nq)`**: Fits a mixture of t-distributions to observed t-statistics.
    ```r
    tt <- tstatistics(simdat, colnames(simdat))
    tm <- tMixture(tt, nq=3)
    tm$p0.est # The estimated proportion of non-DE genes
    ```

## Tips and Interpretation
*   **Comparing Methods**: Use `OCshow(sim1, sim2, sim3)` to graphically compare the performance of different FDR methods on the same dataset.
*   **Smoothing in 2D**: If `fdr2d` results look erratic, adjust the `smooth` parameter. Use `lines(average.fdr(sim3))` on a `fdr1d` plot to check if the 2D average matches the 1D estimate.
*   **Extracting Results**: Use `topDE(object, co)` to consistently extract significant genes across different `OCplus` output objects.
*   **p0 Estimation**: If `tMixture` gives unexpected results, try varying the starting value for `p0` (e.g., `tMixture(tt, nq=3, p0=0.80)`).

## Reference documentation
- [OCplus](./references/OCplus.md)