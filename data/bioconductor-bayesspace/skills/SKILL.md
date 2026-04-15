---
name: bioconductor-bayesspace
description: BayesSpace is a Bayesian statistical method for clustering and enhancing the resolution of spatial gene expression data. Use when user asks to perform spatial clustering, enhance data resolution to sub-spot levels, or impute gene expression at higher resolution.
homepage: https://bioconductor.org/packages/release/bioc/html/BayesSpace.html
---

# bioconductor-bayesspace

## Overview
BayesSpace is a Bayesian statistical method for clustering and enhancing the resolution of spatial gene expression data. Unlike non-spatial clustering methods, BayesSpace leverages the spatial orientation of spots to improve the identification of tissue compartments. It can also "enhance" the resolution of the data by predicting expression and cluster labels at sub-spot levels, effectively providing higher resolution than the original experiment.

## Core Workflow

### 1. Data Loading and Preparation
BayesSpace works with `SingleCellExperiment` (SCE) objects. It requires `array_row` and `array_col` in the `colData`.

```r
library(BayesSpace)
library(SingleCellExperiment)

# Load 10x Visium data
sce <- readVisium("path/to/spaceranger/outs/")

# Pre-process: log-normalize and PCA
# platform can be "Visium" or "ST"
set.seed(102)
sce <- spatialPreprocess(sce, platform="Visium", n.PCs=15, n.HVGs=2000, log.normalize=TRUE)
```

### 2. Selecting Number of Clusters (q)
Use `qTune` to evaluate the pseudo-log-likelihood across different cluster numbers.

```r
sce <- qTune(sce, qs=seq(2, 10), platform="Visium", d=15)
qPlot(sce) # Look for the "elbow" to select q
```

### 3. Spatial Clustering
The `spatialCluster` function performs the clustering. Use at least 10,000 iterations (`nrep`) for production runs.

```r
set.seed(149)
sce <- spatialCluster(sce, q=4, platform="Visium", 
                      init.method="mclust", model="t", 
                      nrep=10000, burn.in=1000)

# Visualize results
clusterPlot(sce)
```

### 4. Enhanced Resolution Analysis
Enhance the resolution of the principal components and cluster labels to sub-spots.

```r
# jitter.scale=0 enables adaptive MCMC tuning
sce.enhanced <- spatialEnhance(sce, q=4, platform="Visium", d=15,
                               model="t", jitter.scale=0,
                               nrep=10000, burn.in=1000)

# Plot sub-spot clusters
clusterPlot(sce.enhanced)
```

### 5. Enhancing Gene Expression (Imputation)
Since `spatialEnhance` only operates on PCs, use `enhanceFeatures` to impute specific gene expression at the sub-spot level.

```r
markers <- c("PMEL", "CD2", "CD19")
sce.enhanced <- enhanceFeatures(sce.enhanced, sce,
                                feature_names=markers,
                                nrounds=0) # 0 enables auto-tuning for xgboost

# Visualize enhanced expression
featurePlot(sce.enhanced, "PMEL")
```

## Key Functions and Parameters
- `spatialPreprocess()`: Essential first step. Adds metadata and computes PCA.
- `spatialCluster()`: The main clustering engine. `gamma` controls the spatial prior strength (default 2).
- `spatialEnhance()`: Creates a new SCE with sub-spot resolution.
- `enhanceFeatures()`: Imputes gene expression using `xgboost` (default), `linear`, or `dirichlet` models.
- `mcmcChain()`: Accesses the underlying Markov chains if `save.chain=TRUE` was used.

## Tips for Success
- **Random Seeds**: Always use `set.seed()` before clustering or enhancement to ensure reproducibility.
- **Platform Specification**: Ensure the `platform` argument matches your data ("Visium" or "ST") as this defines the spot adjacency structure.
- **Iteration Count**: For quick testing, `nrep=1000` is fine, but use `nrep=10000` (clustering) or `nrep=100000` (enhancement) for publication-quality results.
- **Memory Management**: Enhanced SCE objects are significantly larger than the original spot-level objects.

## Reference documentation
- [BayesSpace](./references/BayesSpace.md)
- [BayesSpace Rmd](./references/BayesSpace.Rmd)