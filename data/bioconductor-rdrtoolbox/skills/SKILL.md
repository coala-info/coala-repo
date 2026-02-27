---
name: bioconductor-rdrtoolbox
description: This tool performs nonlinear dimension reduction using Isomap and Locally Linear Embedding algorithms. Use when user asks to perform feature extraction on high-dimensional data, simulate synthetic datasets like Swiss Roll, or validate clusters using the Davis-Bouldin Index.
homepage: https://bioconductor.org/packages/release/bioc/html/RDRToolbox.html
---


# bioconductor-rdrtoolbox

name: bioconductor-rdrtoolbox
description: Nonlinear dimension reduction using Isomap and Locally Linear Embedding (LLE). Use this skill when you need to perform feature extraction on high-dimensional data (like microarray gene expression), simulate synthetic datasets (Swiss Roll or block-diagonal covariance matrices), or validate clusters using the Davis-Bouldin Index.

## Overview
The `RDRToolbox` package provides tools for nonlinear dimension reduction, specifically designed for data lying on or near nonlinear submanifolds. It implements two primary algorithms:
1.  **Locally Linear Embedding (LLE)**: Preserves local properties by representing samples as linear combinations of neighbors.
2.  **Isomap**: Preserves global properties by capturing geodesic distances between samples.

The package also includes utilities for data simulation, 2D/3D visualization, and cluster validation.

## Typical Workflow

### 1. Data Preparation
Data should be formatted as an $N \times D$ matrix, where $N$ is the number of samples and $D$ is the number of features.

```R
library(RDRToolbox)
# Example: Load your data
# data_matrix <- as.matrix(my_data)
```

### 2. Dimension Reduction

#### Locally Linear Embedding (LLE)
Use `LLE` for a specific target dimension and number of neighbors ($k$).
```R
# Reduce to 2 dimensions with 10 neighbors
reduced_lle <- LLE(data = data_matrix, dim = 2, k = 10)
```

#### Isomap
Use `Isomap` to compute embeddings. It can handle multiple target dimensions simultaneously and help estimate intrinsic dimensionality via residual variance.
```R
# Compute Isomap for dimensions 1 through 10
# plotResiduals helps identify where variance stops decreasing significantly
isomap_results <- Isomap(data = data_matrix, dims = 1:10, k = 10, plotResiduals = TRUE)

# Access a specific embedding
reduced_isomap <- isomap_results$dim2
```

### 3. Visualization
The `plotDR` function handles 2D and 3D plotting. 3D plots require the `rgl` package.
```R
# 2D Plot with labels
plotDR(data = reduced_lle, labels = class_labels, axesLabels = c("Comp 1", "Comp 2"))

# 3D Plot (interactive if rgl is installed)
plotDR(data = reduced_lle_3d, labels = class_labels)
```

### 4. Cluster Validation
The Davis-Bouldin Index (DB-Index) evaluates cluster separation. Smaller values (close to or < 1) indicate better separation.
```R
db_index <- DBIndex(data = reduced_lle, labels = class_labels)
```

## Data Simulation
For testing and benchmarking, the package provides two generators:

*   **Swiss Roll**: `swissData <- SwissRoll(N = 1000, Plot = TRUE)`
*   **Gene Expression Simulator**: Generates normally distributed data with block-diagonal covariance.
    ```R
    # 20 samples, 1000 genes, 100 differentially expressed genes
    sim <- generateData(samples = 20, genes = 1000, diffgenes = 100)
    simData <- sim[[1]]
    simLabels <- sim[[2]]
    ```

## Tips and Best Practices
*   **Intrinsic Dimension**: Use `Isomap` with `plotResiduals = TRUE`. The point where the residual variance curve flattens suggests the intrinsic dimensionality of the data.
*   **Memory/Speed**: Isomap uses Floyd's Algorithm for shortest paths; for very large datasets, computational costs may increase significantly.
*   **Modified Isomap**: Set `mod = TRUE` in the `Isomap` function to use a version that respects both nearest and farthest neighbors.

## Reference documentation
- [RDRToolbox Vignette](./references/vignette.md)