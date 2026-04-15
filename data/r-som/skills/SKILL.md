---
name: r-som
description: This tool implements Self-Organizing Maps for unsupervised learning, clustering, and dimensionality reduction of high-dimensional data. Use when user asks to train a SOM, cluster gene expression profiles, normalize datasets for neural networks, or visualize complex patterns in a low-dimensional grid.
homepage: https://cloud.r-project.org/web/packages/som/index.html
---

# r-som

name: r-som
description: Specialized skill for using the R package 'som' to implement Self-Organizing Maps (SOM). Use this skill when performing unsupervised learning, dimensionality reduction, or clustering on high-dimensional data, particularly for gene expression analysis or pattern recognition.

## Overview
The `som` package provides functions for Self-Organizing Maps, a type of artificial neural network that is trained using unsupervised learning to produce a low-dimensional (typically two-dimensional), discretized representation of the input space of the training samples, called a map. It is particularly well-suited for visualizing and clustering complex datasets like gene expression profiles.

## Installation
To install the package from CRAN:
```R
install.packages("som")
library(som)
```

## Core Workflow

### 1. Data Preparation
Data should be a matrix or data frame where rows are observations and columns are variables. It is highly recommended to normalize or standardize the data before training.
```R
# Example using the built-in filtering/normalization
data(yeast)
# Pre-process: filtering and log-transformation are common for gene data
# som.normalize scales data to mean 0 and variance 1
yeast.norm <- som.normalize(yeast)
```

### 2. Training the Map
The primary function is `som()`. You must specify the grid dimensions (xdim and ydim).
```R
# Initialize and train a 5x5 SOM
# topol: 'rect' or 'hexa'
# neigh: 'gaussian' or 'bubble'
foo <- som(yeast.norm, xdim=5, ydim=5, topol="rect", neigh="gaussian")
```

### 3. Visualizing Results
The package provides a `plot` method for `som` objects to visualize the codebook vectors (cluster profiles).
```R
# Plot the codebook vectors for each node
plot(foo)
```

## Key Functions
- `som(data, xdim, ydim, ...)`: Main training function. Parameters include `init` (initialization method), `alpha` (learning rate), and `iter` (number of iterations).
- `som.normalize(data, byrow=TRUE)`: Normalizes data to mean 0 and variance 1.
- `som.project(obj, data)`: Projects new data onto an existing SOM map to find the best-matching units (BMUs).
- `filtering(data, ...)`: Specifically for gene expression data; filters out genes with low variation or low intensity.

## Tips and Best Practices
- **Grid Size**: Start with a small grid (e.g., 5x5) to see broad clusters, then increase if more resolution is needed.
- **Topology**: Hexagonal (`hexa`) topology is often preferred over rectangular (`rect`) because every node has 6 neighbors at equal distance, leading to smoother maps.
- **Convergence**: If the map doesn't seem to represent the data well, increase the `iter` parameter or adjust the `alpha` learning rate.
- **Data Scale**: SOM is distance-based (Euclidean). Always ensure variables are on the same scale using `som.normalize` unless the relative magnitude of variables is meaningful.

## Reference documentation
- [som: Self-Organizing Map](./references/home_page.md)