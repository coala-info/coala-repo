---
name: r-mixomics
description: This tool provides multivariate analysis and integration of large biological datasets using the mixOmics R package. Use when user asks to perform PCA or PLS-DA, integrate multiple omics layers with DIABLO, or combine datasets across different studies using MINT.
homepage: https://cran.r-project.org/web/packages/mixomics/index.html
---

# r-mixomics

name: r-mixomics
description: Expert guidance for using the mixOmics R package to perform multivariate analysis and integration of biological datasets. Use this skill when analyzing single-omics data (PCA, PLS-DA), integrating multiple omics layers on the same samples (N-integration/DIABLO), or integrating datasets across different studies (P-integration/MINT).

# r-mixomics

## Overview
mixOmics is a comprehensive R toolkit dedicated to the exploration and integration of biological datasets (transcriptomics, proteomics, metabolomics, microbiome, etc.). It specializes in multivariate methods that reduce data dimensionality and identify key biomarkers through sparse (variable selection) models.

## Installation
To install the package from CRAN:
```R
install.packages("mixOmics")
```
Note: For the latest development version or Bioconductor dependencies, use:
```R
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("mixOmics")
```

## Main Functions and Methods

### Single-Omics Analysis
*   `pca(X, ...)` / `spca(X, ...)`: (Sparse) Principal Component Analysis for unsupervised exploration.
*   `plsda(X, Y, ...)` / `splsda(X, Y, ...)`: (Sparse) Partial Least Squares Discriminant Analysis for supervised classification and variable selection.

### N-Integration (Integrating multiple datasets on the same samples)
*   `pls(X, Y, ...)` / `spls(X, Y, ...)`: (Sparse) PLS to find correlations between two datasets.
*   `block.splsda(X, Y, ...)`: Also known as **DIABLO**. Integrates multiple omics blocks (X) to discriminate a categorical outcome (Y).
*   `wrapper.rgcca()` / `wrapper.sgcca()`: General framework for multi-block integration.

### P-Integration (Integrating datasets across different studies)
*   `mint.splsda(X, Y, study, ...)`: Integrates independent studies by accounting for batch effects within the model.

### Microbiome Analysis
*   `logratio.transfo(X, logratio = 'CLR')`: Centered Log Ratio transformation for compositional data.

## General Workflow
1.  **Preprocessing**: Ensure data is normalized. For microbiome data, apply CLR transformation.
2.  **Initial Exploration**: Use `pca()` to check for outliers or batch effects.
3.  **Parameter Tuning**: Use `tune()` functions (e.g., `tune.splsda()`, `tune.block.splsda()`) to determine the optimal number of components and the number of variables to select (`keepX`).
4.  **Final Model**: Run the chosen method with the tuned parameters.
5.  **Performance Assessment**: Use `perf()` with cross-validation to evaluate the error rate and stability of selected variables.
6.  **Visualization**: Interpret results using the suite of plotting functions.

## Visualization Tips
*   **Sample Plots**: `plotIndiv()` visualizes samples on the component space. Use `group` and `legend = TRUE` for supervised models.
*   **Variable Plots**: `plotVar()` (Correlation Circle Plots) shows the contribution of variables to the components.
*   **Loadings**: `plotLoadings()` displays the importance/contribution of each selected variable on a specific component.
*   **Integration Plots**:
    *   `cim()`: Clustered Image Maps (heatmaps).
    *   `network()`: Relevance networks showing associations between variables.
    *   `circosPlot()`: Specifically for DIABLO to show correlations between different omics blocks.

## Reference documentation
- [mixOmics Home Page](./references/home_page.md)