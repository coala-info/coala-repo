---
name: bioconductor-pcatools
description: PCAtools provides a comprehensive suite of functions for conducting and visualizing Principal Component Analysis in R, specifically optimized for bioinformatics data. Use when user asks to perform dimensionality reduction, determine the number of significant principal components, visualize sample relationships via biplots, or correlate components with experimental metadata.
homepage: https://bioconductor.org/packages/release/bioc/html/PCAtools.html
---


# bioconductor-pcatools

## Overview

PCAtools provides a comprehensive suite of functions for Principal Component Analysis (PCA) in R, specifically tailored for bioinformatics workflows. It goes beyond simple dimensionality reduction by providing tools to determine the optimal number of components to retain, identifying the specific variables (e.g., genes) driving variation in each component, and correlating components with clinical or experimental metadata.

## Core Workflow

### 1. Data Preparation
PCAtools requires a numerical matrix (e.g., normalized expression values) where variables are rows and samples are columns. It is highly recommended to provide a `metadata` data frame where row names match the column names of the data matrix.

```r
library(PCAtools)
# mat: numeric matrix
# metadata: data frame with sample information
p <- pca(mat, metadata = metadata, removeVar = 0.1)
```

### 2. Determining PCs to Retain
Use these metrics to decide how many principal components are meaningful for downstream analysis:

*   **Horn's Parallel Analysis:** `parallelPCA(mat)`
*   **Elbow Method:** `findElbowPoint(p$variance)`
*   **Variance Threshold:** `which(cumsum(p$variance) > 80)[1]` (e.g., for 80% variance)

### 3. Visualization Suite

#### Scree Plot
Visualizes the percentage of variance explained by each PC.
```r
screeplot(p, vline = c(horn_limit, elbow_limit))
```

#### Biplot
The primary tool for visualizing sample relationships.
```r
biplot(p, 
       colby = 'Condition', 
       shape = 'Batch',
       showLoadings = TRUE, 
       lab = NULL) # Set lab=NULL to remove sample names for cleaner plots
```

#### Loadings Plot
Identifies which variables (genes) contribute most to specific PCs.
```r
plotloadings(p, components = getComponents(p, 1:5), rangeRetain = 0.01)
```

#### Eigencor Plot
Correlates PCs with metadata to identify biological or technical drivers of variation.
```r
eigencorplot(p, metavars = c('Age', 'Gender', 'Treatment', 'Survival'))
```

#### Pairs Plot
Explores pairwise relationships between multiple PCs simultaneously.
```r
pairsplot(p, components = getComponents(p, 1:5))
```

## Advanced Usage

### Accessing Internal Data
The `pca` object stores the transformed coordinates and the variable weights:
*   **Sample Coordinates:** `p$rotated`
*   **Variable Loadings:** `p$loadings`
*   **Variance Explained:** `p$variance`

### Mapping IDs
If your matrix uses IDs (e.g., Ensembl or Probe IDs), map them to Symbols before plotting loadings for better interpretability:
```r
rownames(p$loadings) <- mapIds(org.Hs.eg.db, keys = rownames(p$loadings), column = 'SYMBOL', keytype = 'ENSEMBL')
```

### Prediction on New Data
While `pca` objects don't support `predict()` directly, you can cast them to `prcomp` for projection:
```r
p.prcomp <- list(sdev = p$sdev, rotation = data.matrix(p$loadings), x = data.matrix(p$rotated), center = TRUE, scale = TRUE)
class(p.prcomp) <- 'prcomp'
predict(p.prcomp, newdata = t(new_matrix))
```

## Reference documentation

- [PCAtools: everything Principal Component Analysis](./references/PCAtools.Rmd)
- [PCAtools: everything Principal Component Analysis (Markdown)](./references/PCAtools.md)