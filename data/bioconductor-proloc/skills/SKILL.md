---
name: bioconductor-proloc
description: The pRoloc package provides infrastructure and machine learning algorithms for the analysis and visualization of spatial proteomics data to determine sub-cellular protein localization. Use when user asks to manage quantitative proteomics data, visualize organelle separation using PCA plots, or predict protein localization using supervised machine learning and Bayesian modeling.
homepage: https://bioconductor.org/packages/release/bioc/html/pRoloc.html
---

# bioconductor-proloc

## Overview

The `pRoloc` package is the standard Bioconductor tool for spatial proteomics. It provides infrastructure to manage quantitative proteomics data (via `MSnSet` objects) and implements specialized algorithms to determine the sub-cellular localization of proteins. The workflow typically involves importing fractionated mass-spectrometry data, performing quality control on organelle markers, and using machine learning to predict the localization of "unknown" proteins based on the distribution profiles of known "marker" proteins.

## Core Workflow

### 1. Data Import and Preparation
Data is managed in `MSnSet` containers. You can create these from CSV files containing expression data and metadata.

```r
library(pRoloc)
library(MSnbase)

# Import from a single CSV (ecol defines columns with quantitation data)
my_data <- readMSnSet2("data.csv", ecol = 7:10, fnames = "Protein.ID")

# Add markers from pRoloc's internal database
# Supported: "dmel", "hsap", "mmus", "atha", etc.
my_markers <- pRolocmarkers("hsap")
my_data <- addMarkers(my_data, my_markers)
```

### 2. Visualization and QC
Before classification, visualize the separation of organelle clusters.

*   **PCA Plots**: The primary tool for viewing data separation.
    ```r
    plot2D(my_data, fcol = "markers")
    addLegend(my_data, fcol = "markers", where = "bottomright", cex = 0.6)
    ```
*   **Profile Plots**: View protein intensity distributions across fractions.
    ```r
    plotDist(my_data[which(fData(my_data)$markers == "Mitochondrion"), ])
    ```
*   **Resolution Metrics**: Quantify how well organelles are separated using `QSep`.
    ```r
    q <- QSep(my_data)
    plot(q)
    ```

### 3. Supervised Machine Learning (SVM Example)
The standard pipeline involves optimizing parameters, then running the classifier.

```r
# 1. Parameter Optimization (Grid search for sigma and cost)
params <- svmOptimisation(my_data, fcol = "markers", times = 10)
plot(params)
best_params <- getParams(params)

# 2. Classification
res <- svmClassification(my_data, params)

# 3. Thresholding (Filter low-confidence assignments)
# Use orgQuants to set organelle-specific thresholds (e.g., 50th percentile)
ts <- orgQuants(res, fcol = "svm", t = 0.5)
res <- getPredictions(res, fcol = "svm", t = ts)
```

### 4. Bayesian Modeling (TAGM)
For uncertainty quantification, use the T-augmented Gaussian Mixture (TAGM) models.

```r
# MAP estimation (faster)
res_map <- tagmMapTrain(my_data)
res_map <- tagmPredict(my_data, res_map)

# MCMC (provides full uncertainty distribution)
res_mcmc <- tagmMcmcTrain(my_data)
res_mcmc <- tagmPredict(my_data, res_mcmc)
```

## Key Functions Reference

*   `pRolocmarkers()`: Lists or retrieves default marker sets for various species.
*   `getMarkers()`: Summarizes the number of markers per organelle.
*   `plot2D()`: Supports PCA, t-SNE, and UMAP (via `method` argument).
*   `highlightOnPlot()`: Overlays specific proteins of interest on a PCA plot.
*   `orgQuants()`: Calculates score thresholds to maintain specific discovery rates.
*   `pRolocVis()`: (from `pRolocGUI`) Launches an interactive web interface for data exploration.

## Tips for Success
*   **The "unknown" tag**: `pRoloc` functions expect non-marker proteins to be labeled as `"unknown"` in the marker column.
*   **Class Imbalance**: If some organelles have very few markers, use `classWeights()` to balance the SVM.
*   **Normalization**: Ensure data is normalized (usually to the sum of intensities per protein) using `normalise(obj, method = "sum")` before analysis.

## Reference documentation
- [Using pRoloc for spatial proteomics data analysis](./references/v01-pRoloc-tutorial.md)
- [Machine learning techniques available in pRoloc](./references/v02-pRoloc-ml.md)
- [Bayesian spatial proteomics with pRoloc](./references/v03-pRoloc-bayesian.md)
- [A transfer learning algorithm for spatial proteomics](./references/v05-pRoloc-transfer-learning.md)