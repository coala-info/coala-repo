---
name: bioconductor-poma
description: POMA provides a structured workflow for the pre-processing, statistical analysis, and visualization of metabolomics and other omics data. Use when user asks to create SummarizedExperiment objects, impute missing values, normalize data, detect outliers, perform univariate tests, conduct PCA or PLS-DA, or run machine learning models like Random Forest.
homepage: https://bioconductor.org/packages/release/bioc/html/POMA.html
---


# bioconductor-poma

## Overview

POMA (POst-processed Metabolomics Analysis) is a Bioconductor package designed to streamline the analysis of metabolomics and other omics data. It provides a structured workflow centered around the `SummarizedExperiment` class, moving from raw data preparation through pre-processing (imputation, normalization, outlier removal) to advanced statistical modeling and visualization.

## Core Workflow

### 1. Data Preparation
POMA uses `SummarizedExperiment` objects. You can create one from data frames using `PomaCreateObject()`.

```r
library(POMA)

# Create object from metadata (samples) and features (metabolites/proteins)
# target: data frame with sample info; features: data frame with abundance values
data <- PomaCreateObject(metadata = target, features = features)

# Load example data
data("st000336")
```

### 2. Pre-processing
The pre-processing block is essential for ensuring data quality before statistical testing.

*   **Imputation**: Handle missing values or zeros.
    ```r
    # KNN imputation, treating zeros as NA
    imputed <- st000336 %>% 
      PomaImpute(method = "knn", zeros_as_na = TRUE, cutoff = 20)
    ```
*   **Normalization**: Adjust for technical variation. Supported methods include "auto_scaling", "level_scaling", "log", "vast_scaling", and "log_pareto".
    ```r
    normalized <- imputed %>% 
      PomaNorm(method = "log_pareto")
    ```
*   **Outlier Detection**: Identify and remove samples that deviate significantly.
    ```r
    outliers_res <- PomaOutliers(normalized)
    # Plot distance-based outliers
    outliers_res$polygon_plot
    # Cleaned data
    pre_processed <- outliers_res$data
    ```

### 3. Visualization
Use built-in plotting functions to inspect data distributions.

*   **Boxplots**: `PomaBoxplots(normalized, x = "samples")`
*   **Density Plots**: `PomaDensity(normalized, x = "features")`

### 4. Statistical Analysis
POMA wraps several complex methods into intuitive functions.

*   **Univariate Analysis**: Perform t-tests, ANOVA, or Wilcoxon tests.
    ```r
    # T-test
    ttest_results <- PomaUnivariate(pre_processed, method = "ttest")
    # Volcano Plot
    PomaVolcano(imputed, pval = "adjusted", labels = TRUE)
    ```
*   **Multivariate Analysis**: PCA and PLS-DA.
    ```r
    # PCA
    pca_res <- PomaMultivariate(pre_processed, method = "pca")
    pca_res$scoresplot
    
    # PLS-DA
    plsda_res <- PomaMultivariate(pre_processed, method = "plsda")
    ```
*   **Correlation**: Pairwise correlations or Gaussian Graphical Models (glasso).
    ```r
    cor_res <- PomaCorr(pre_processed, corr_type = "pearson", coeff = 0.6)
    ```
*   **Machine Learning**: Lasso/Elasticnet and Random Forest.
    ```r
    # Random Forest with 10 variables
    rf_res <- PomaRandForest(pre_processed, nvar = 10)
    rf_res$MeanDecreaseGini_plot
    ```

## Tips for Success
*   **Pipe Compatibility**: POMA functions are designed to work with the `%>%` or `|>` operators.
*   **Theme Customization**: Most POMA plots accept a `theme_params` list to modify ggplot2 aesthetics (e.g., `legend_position`).
*   **Feature Selection**: Use `PomaLasso` with `ntest = NULL` to perform feature selection on the entire dataset.

## Reference documentation
- [Normalization Methods](./references/POMA-normalization.md)
- [Get Started Workflow](./references/POMA-workflow.md)