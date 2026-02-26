---
name: r-kernlab
description: This tool provides a comprehensive framework for kernel-based machine learning methods in R, including support vector machines, Gaussian processes, and spectral clustering. Use when user asks to perform classification, regression, dimensionality reduction via Kernel PCA, novelty detection, or spectral clustering using kernel methods.
homepage: https://cloud.r-project.org/web/packages/kernlab/index.html
---


# r-kernlab

name: r-kernlab
description: Expert guidance for using the 'kernlab' R package for kernel-based machine learning. Use this skill when performing classification, regression, clustering, dimensionality reduction (KPCA), or novelty detection using Support Vector Machines (SVM), Gaussian Processes, or Spectral Clustering in R.

## Overview

The `kernlab` package provides a comprehensive S4-based framework for kernel methods in R. It includes implementations of Support Vector Machines (SVM), Relevance Vector Machines (RVM), Gaussian Processes, Kernel PCA, Kernel CCA, Spectral Clustering, and a range of kernel functions (RBF, Polynomial, Laplace, etc.). It is highly modular, allowing users to define custom kernels or use built-in vectorized kernel primitives.

## Installation

```R
install.packages("kernlab")
library(kernlab)
```

## Core Workflow: Support Vector Machines (ksvm)

The `ksvm` function is the primary interface for classification, regression, and novelty detection.

### Classification
```R
# C-SVC classification with RBF kernel
model <- ksvm(Species ~ ., data = iris, kernel = "rbfdot", 
              kpar = "automatic", C = 10, prob.model = TRUE)

# Predict classes or probabilities
preds <- predict(model, iris)
probs <- predict(model, iris, type = "probabilities")
```

### Regression
```R
# epsilon-SVR regression
reg_model <- ksvm(x, y, type = "eps-svr", kernel = "laplacedot")
```

### Novelty Detection (One-Class SVM)
```R
# Detect outliers (nu is the expected fraction of outliers)
novelty <- ksvm(x, type = "one-svc", kernel = "rbfdot", nu = 0.1)
```

## Kernel Functions

Kernels are created using "creator" functions. They can be passed to algorithms via the `kernel` argument.

- `vanilladot()`: Linear kernel
- `rbfdot(sigma = 0.1)`: Gaussian RBF kernel
- `polydot(degree = 2, scale = 1, offset = 1)`: Polynomial kernel
- `laplacedot(sigma = 0.1)`: Laplace kernel
- `tanhdot(scale = 1, offset = 1)`: Hyperbolic tangent kernel
- `anovadot(sigma = 1, degree = 1)`: ANOVA RBF kernel

**Tip:** Use `sigest(y ~ x, data = df)` to estimate the optimal `sigma` range for RBF kernels.

## Dimensionality Reduction and Clustering

### Kernel PCA (kpca)
```R
# Project data into 2 dimensions
kpc <- kpca(~., data = df, kernel = "rbfdot", features = 2)
rotated_data <- rotated(kpc)
# Project new data
new_projection <- predict(kpc, new_data)
```

### Spectral Clustering (specc)
```R
# Cluster data into 3 groups
sc <- specc(as.matrix(df), centers = 3)
plot(df, col = sc) # sc is a vector of cluster assignments
```

## Advanced Utilities

### Kernel Matrix Operations
- `kernelMatrix(kernel, x)`: Computes the Gram matrix $K_{ij} = k(x_i, x_j)$.
- `kernelMult(kernel, x, alpha)`: Computes kernel expansions $f = K\alpha$ efficiently.
- `inc.chol(x, kernel)`: Performs Incomplete Cholesky Decomposition for large datasets to avoid storing the full $N \times N$ matrix.

### Quadratic Programming (ipop)
For custom optimization needs, `ipop` provides an interior-point solver for quadratic programming problems:
```R
# minimize c'x + 1/2 x'Hx subject to b <= Ax <= b + r
res <- ipop(c, H, A, b, l, u, r)
```

## Reference documentation

- [kernlab: An S4 Package for Kernel Methods in R](./references/kernlab.md)