---
name: bioconductor-timeomics
description: bioconductor-timeomics provides a multivariate framework for the analysis, integration, and clustering of longitudinal multi-omics data. Use when user asks to model temporal feature expression, cluster features with similar time profiles, or integrate multiple time-course omics datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/timeOmics.html
---

# bioconductor-timeomics

## Overview

The `timeOmics` package provides a multivariate framework for the analysis and integration of longitudinal omics data. It handles the complexity of time-course experiments by modeling feature expression as a function of time, clustering features with similar temporal profiles, and integrating multiple omics datasets (e.g., transcriptomics and metabolomics) measured on the same samples.

## Typical Workflow

### 1. Data Preprocessing
Data should be in a matrix or data frame with samples in **rows** and features in **columns**.
*   **Platform-specific:** Apply standard normalization (log, scale, CLR for microbiome).
*   **Time-specific:** Filter features with low variation over time using a coefficient of variation (CV) threshold.

```r
# Example CV filtering
remove.low.cv <- function(X, cutoff = 0.5){
  cv <- unlist(lapply(as.data.frame(X), function(x) abs(sd(x)/mean(x))))
  return(X[, cv > cutoff])
}
data.filtered <- remove.low.cv(your_data, 0.5)
```

### 2. Time Modeling (LMMS)
Model each feature using Linear Mixed Model Splines to account for inter-individual variability and summarize features into unique time profiles.
*   **Note:** Requires the `lmms` package (available via GitHub `cran/lmms`).
*   **Filtering:** Use `lmms.filter.lines` to remove noisy profiles based on homoscedasticity (Breusch-Pagan test) and Mean Squared Error (MSE).

```r
# Modeling
lmms.output <- lmms::lmmSpline(data = data.filtered, time = time_vector,
                               sampleID = rownames(data.filtered), 
                               timePredict = unique_time_points)
modelled.data <- t(slot(lmms.output, 'predSpline'))

# Filtering noisy profiles
filter.res <- lmms.filter.lines(data = data.filtered, lmms.obj = lmms.output, time = time_vector)
profile.filtered <- filter.res$filtered
```

### 3. Longitudinal Clustering
Group features using multivariate methods from `mixOmics`.
*   **Single-Omic:** Use `pca`.
*   **Two-Omics:** Use `pls`.
*   **Multi-Omics (3+):** Use `block.pls`.

**Optimization:** Use `getNcomp` to determine the number of components (clusters) based on the silhouette coefficient.

```r
# PCA Example
pca.res <- mixOmics::pca(X = profile.filtered, ncomp = 2, scale = FALSE, center = FALSE)
pca.cluster <- getCluster(pca.res)

# Visualization
plotLong(pca.res, title = "Longitudinal Clustering")
```

### 4. Feature Selection (Signatures)
Use "sparse" versions of the methods (`spca`, `spls`, `block.spls`) to identify a minimal signature of features for each cluster.
*   Use `tuneCluster.spca` or `tuneCluster.spls` to optimize the number of features (`keepX`) to retain.

```r
tune.spca <- tuneCluster.spca(X = profile.filtered, ncomp = 2, test.keepX = c(2:10))
spca.res <- mixOmics::spca(X = profile.filtered, ncomp = 2, 
                           keepX = tune.spca$choice.keepX, scale = FALSE)
```

### 5. Post-hoc Evaluation
Validate clustering quality using proportionality distances. A good cluster should have significantly lower intra-cluster distance compared to the background.

```r
res.prop <- proportionality(pca.res)
plot(res.prop) # Visualizes inside vs outside distances
# Check res.prop$pvalue for Wilcoxon test results
```

## Key Functions
*   `lmms.filter.lines()`: Filters out features that do not follow a clear temporal trend.
*   `getNcomp()`: Tunes the number of components for PCA/PLS models using silhouette scores.
*   `getCluster()`: Extracts cluster assignments (positive/negative contribution per component).
*   `plotLong()`: Specialized plotting function for longitudinal clusters.
*   `proportionality()`: Calculates association measures to validate clusters a posteriori.

## Reference documentation
- [timeOmics Vignette (Rmd)](./references/vignette.Rmd)
- [timeOmics Vignette (Markdown)](./references/vignette.md)