---
name: r-rrcov
description: Skill for using the CRAN R package r-rrcov.
homepage: https://cloud.r-project.org/web/packages/rrcov/index.html
---

# r-rrcov

name: r-rrcov
description: Scalable robust estimators for multivariate location, scatter, PCA, and discriminant analysis. Use this skill when you need to perform robust multivariate analysis in R, specifically for identifying outliers, computing high breakdown point estimates (MCD, S-estimators, OGK), or performing robust PCA and discriminant analysis (LDA/QDA) to mitigate the effect of anomalous data.

# r-rrcov

## Overview
The `rrcov` package provides an object-oriented framework (S4 classes) for robust multivariate analysis. It is designed to handle outliers by providing high breakdown point estimators that remain reliable even when a significant portion of the data is contaminated. Key areas include robust location/scatter estimation, Principal Component Analysis (PCA), and Linear/Quadratic Discriminant Analysis (LDA/QDA).

## Installation
```R
install.packages("rrcov")
library(rrcov)
```

## Core Workflows

### 1. Robust Location and Scatter Estimation
The package provides several estimators for the location vector and covariance matrix.

*   **MCD (Minimum Covariance Determinant):** The most common high breakdown estimator.
    ```R
    # Fast MCD algorithm
    mcd <- CovMcd(x)
    summary(mcd)
    plot(mcd, which="dd") # Distance-Distance plot to identify outliers
    ```
*   **S-Estimators:** Good for high-dimensional data.
    ```R
    # Supports bisquare, Rocke-type, and Fast-S
    sest <- CovSest(x, method="bisquare")
    ```
*   **OGK (Orthogonalized Gnanadesikan-Kettenring):** Extremely fast, suitable for very large datasets.
    ```R
    ogk <- CovOgk(x)
    ```
*   **Automatic Selection:** Use `CovRobust()` to let the package choose the best estimator based on data size.
    ```R
    rob_cov <- CovRobust(x)
    ```

### 2. Robust Principal Component Analysis (PCA)
Robust PCA prevents outliers from skewing the principal components (loadings and scores).

*   **Covariance-based PCA:** Uses a robust covariance matrix (default is MCD).
    ```R
    pca_rob <- PcaCov(x)
    ```
*   **ROBPCA (Hubert's Method):** Combines projection pursuit and MCD; effective for high-dimensional data.
    ```R
    pca_hubert <- PcaHubert(x, k=2) # k is number of components
    plot(pca_hubert) # Diagnostic plot (Outlier Map)
    ```
*   **Projection Pursuit PCA:**
    ```R
    pca_grid <- PcaGrid(x)
    ```

### 3. Robust Discriminant Analysis
Used for classification when training groups may contain outliers.

*   **Linear Discriminant Analysis (LDA):**
    ```R
    # Using the Linda class (Robust LDA)
    lda_rob <- Linda(group ~ ., data = mydata)
    predict(lda_rob, newdata = test_data)
    ```
*   **Quadratic Discriminant Analysis (QDA):**
    ```R
    # Using the QdaCov class (Robust QDA)
    qda_rob <- QdaCov(group ~ ., data = mydata)
    ```

## Visualization Tools
The package uses S4 `plot()` methods to provide diagnostic graphics:
*   `which="dd"`: Distance-Distance plot (Robust vs. Classical Mahalanobis distances).
*   `which="tolEllipsePlot"`: 97.5% confidence ellipses (for bivariate data).
*   `which="screeplot"`: Comparison of robust and classical eigenvalues.
*   `which="outlierMap"`: For PCA, plots score distance vs. orthogonal distance.

## Tips for AI Agents
*   **S4 Structure:** Access results using accessor functions like `getCenter(obj)`, `getCov(obj)`, `getLoadings(obj)`, and `getScores(obj)` rather than `@` slots.
*   **Control Objects:** For complex simulations, use control classes (e.g., `CovControlMcd()`) to pass parameters to estimation functions.
*   **Large Data:** If `n > 50000` or `p > 20`, prefer `CovOgk()` or `PcaGrid()` for performance.

## Reference documentation
- [An Object Oriented Framework for Robust Multivariate Analysis](./references/rrcov.md)