---
name: r-imputelcmd
description: R package imputelcmd (documentation from project home).
homepage: https://cran.r-project.org/web/packages/imputelcmd/index.html
---

# r-imputelcmd

## Overview
The `imputeLCMD` package provides a collection of methods specifically designed for left-censored missing data imputation. In proteomics, missing values often arise because the peptide/protein concentration is below the mass spectrometer's detection limit (Missing Not At Random - MNAR). This package offers algorithms like QRILC, KNN-TN, and specialized EM-based approaches to handle these cases, alongside a hybrid method for mixed MAR/MNAR scenarios.

## Installation
To install the package from CRAN:
```R
install.packages("imputeLCMD")
```

## Core Functions

### MNAR Imputation (Left-Censored)
*   `impute.QRILC(dataSet)`: Imputes missing data using Quantile Regression Imputation of Left-Censored data. This is the recommended starting point for proteomics data.
*   `impute.MinDet(dataSet)`: Imputes missing values by the minimum observed value in the dataset.
*   `impute.MinProb(dataSet)`: Imputes missing values by a random draw from a Gaussian distribution centered on a low quantile.
*   `impute.MAR(dataSet, method = "knn")`: Wrapper for Missing At Random (MAR) methods (e.g., KNN or SVD).

### Hybrid Imputation
*   `impute.Mixture(dataSet, ind.MAR)`: Handles complex scenarios where some missing values are MAR and others are MNAR. `ind.MAR` is a logical matrix indicating which cells are MAR.

### Data Generation and Simulation
*   `generate.ExpressionData(nSamples, nProteins)`: Generates a synthetic log-transformed expression matrix.
*   `insertMIs(dataSet, ratio, threshold)`: Artificially inserts missing values (both random and left-censored) into a dataset for benchmarking.

## Workflows

### Standard Proteomics Workflow
1.  **Log-transform** your protein/peptide intensity data.
2.  **Identify** missingness patterns. If missing values are concentrated in low-intensity features, assume MNAR.
3.  **Apply QRILC**:
    ```R
    library(imputeLCMD)
    # Assuming 'data_matrix' has proteins in rows and samples in columns
    imputed_data <- impute.QRILC(data_matrix)[[1]]
    ```

### Hybrid Workflow (MAR + MNAR)
If you have biological replicates where a protein is missing in all replicates of one condition (MNAR) but only occasionally missing in others (MAR):
1.  Create a logical mask `mar_mask` where `TRUE` represents MAR values.
2.  Run the mixture model:
    ```R
    imputed_hybrid <- impute.Mixture(data_matrix, ind.MAR = mar_mask)
    ```

## Tips
*   **Data Orientation**: Ensure your data matrix is correctly oriented. Most functions expect proteins/peptides as rows and samples as columns.
*   **Log Scale**: Always use log-transformed data (e.g., log2 or log10) before applying these imputation methods, as they assume underlying Gaussian distributions.
*   **QRILC Output**: `impute.QRILC` returns a list. The first element `[[1]]` is the imputed matrix.

## Reference documentation
- [imputeLCMD: Left-Censored Missing Data Imputation](./references/home_page.md)