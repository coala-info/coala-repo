---
name: r-mixkernel
description: mixKernel is an R package for integrating multiple datasets using kernel-based methods and performing exploratory analysis. Use when user asks to compute kernel matrices, combine multiple data sources into a meta-kernel, perform Kernel Principal Component Analysis, or identify influential variables through feature selection.
homepage: https://cran.r-project.org/web/packages/mixkernel/index.html
---

# r-mixkernel

## Overview
`mixKernel` is an R package designed for the integration of multiple datasets (heterogeneous data) using kernel-based methods. It provides tools to compute kernels for various data types, combine them into a "meta-kernel" (consensus kernel), and perform Kernel Principal Component Analysis (KPCA) for visualization. It also includes methods for variable selection to identify important features contributing to the non-linear structure of the data.

## Installation
Install the package from CRAN:
```R
install.packages("mixKernel")
```

## Core Workflow

### 1. Kernel Computation
The first step is to transform each individual dataset into a kernel matrix.
- `compute.kernel()`: Computes a kernel matrix from a data frame or matrix. Supported kernels include "linear", "polynomial", and "radial basis".
- For specialized data like phylogenetic trees or categorical data, users can provide precomputed kernels.

```R
# Example: Computing a linear kernel
data(numibiome)
k1 <- compute.kernel(numibiome$genes, kernel.func = "linear")
```

### 2. Kernel Integration (Meta-Kernel)
To integrate multiple data sources, `mixKernel` combines individual kernels into a single meta-kernel.
- `combine.kernels()`: Merges multiple kernels.
  - `method = "full-UMKL"`: Unsupervised Multiple Kernel Learning (weighted sum).
  - `method = "STATIS"`: Optimal combination based on the STATIS method.
  - `method = "average"`: Simple arithmetic mean of kernels.

```R
# Combine two kernels using STATIS
meta_kernel <- combine.kernels(kernel1 = k1, kernel2 = k2, method = "STATIS")
```

### 3. Exploratory Analysis (Kernel PCA)
Visualize the integrated data using Kernel PCA.
- `kernel.pca()`: Performs PCA in the kernel feature space.
- `plotIndiv()`: Visualizes sample similarities (inherited/compatible with `mixOmics` style).

```R
# Perform KPCA on the meta-kernel
kpca_res <- kernel.pca(meta_kernel, ncomp = 5)
# Plot the first two components
plotIndiv(kpca_res, group = metadata$group, legend = TRUE)
```

### 4. Variable Selection
Identify which variables from the original datasets are most influential in the kernel space.
- `select.features()`: Uses a recursive feature elimination or sparse approach to identify key variables.

## Tips and Best Practices
- **Data Scaling**: Ensure continuous data is scaled before computing linear or RBF kernels to prevent variables with large magnitudes from dominating.
- **Kernel Choice**: Use "linear" for standard omics data unless non-linear relationships are explicitly expected, in which case "radial basis" is preferred.
- **Missing Data**: Kernel methods generally require complete data. Impute missing values before kernel computation.
- **Compatibility**: `mixKernel` is designed to work seamlessly with the `mixOmics` ecosystem; many visualization functions share similar arguments.

## Reference documentation
- [mixKernel Home Page](./references/home_page.md)