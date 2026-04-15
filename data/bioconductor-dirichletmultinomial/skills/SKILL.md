---
name: bioconductor-dirichletmultinomial
description: This package implements Dirichlet-Multinomial models for analyzing high-dimensional count data through clustering and classification. Use when user asks to identify the optimal number of clusters in taxonomic profiles, assign samples to phenotypic groups using generative classifiers, or compare model fits using Laplace approximation.
homepage: https://bioconductor.org/packages/release/bioc/html/DirichletMultinomial.html
---

# bioconductor-dirichletmultinomial

## Overview

The `DirichletMultinomial` package provides an efficient implementation of the Dirichlet-Multinomial distribution for analyzing high-dimensional count data, such as taxonomic profiles from microbiome studies. It addresses the "over-dispersion" common in multinomial data by allowing the multinomial parameters to follow a Dirichlet distribution. Key capabilities include:
- **Clustering**: Identifying the optimal number of Dirichlet components ($k$) in a dataset.
- **Classification**: Building generative classifiers to assign samples to phenotypic groups.
- **Model Validation**: Using Laplace approximation, AIC, and BIC for model selection and cross-validation for performance assessment.

## Core Workflow

### 1. Data Preparation
Input data must be a matrix of counts where rows are samples and columns are taxa (or features).

```r
library(DirichletMultinomial)
# count: matrix of samples (rows) x taxa (columns)
# Ensure counts are integers
```

### 2. Model Fitting and Clustering
Use `dmn()` to fit a model for a specific number of components ($k$). Typically, you fit multiple values of $k$ to find the best fit.

```r
# Fit for k = 1 to 7
fit <- lapply(1:7, dmn, count = count, verbose = TRUE)

# Compare model fit using Laplace, AIC, or BIC
lplc <- sapply(fit, laplace)
best_k <- which.min(lplc)
best_fit <- fit[[best_k]]
```

### 3. Interpreting Clusters
Once the best model is selected, extract mixture weights and sample assignments.

```r
# Mixture weights (pi) and homogeneity (theta)
mixturewt(best_fit)

# Posterior probabilities of sample assignment to components
post_prob <- mixture(best_fit)

# Assign samples to the most likely component
assignments <- mixture(best_fit, assign = TRUE)
```

### 4. Generative Classification
To classify samples based on groups (e.g., "Healthy" vs "Disease"), use `dmngroup()`.

```r
# pheno: factor vector of group labels
# k: vector of components to test for each group
bestgrp <- dmngroup(count, pheno, k = 1:5)

# Predict group membership for new data
predictions <- predict(bestgrp, count, assign = TRUE)

# Confusion matrix
table(Observed = pheno, Predicted = predictions)
```

### 5. Visualization
The package provides specialized functions for visualizing DM models.

```r
# Heatmap showing samples arranged by Dirichlet component
heatmapdmn(count, fit[[1]], best_fit, 30)

# Scatter plot matrix of fitted values (log scale)
splom(log(fitted(best_fit)))
```

## Tips and Best Practices
- **Parallelization**: For large datasets or cross-validation, use `mclapply` from the `parallel` package to fit models for different $k$ values simultaneously.
- **Model Selection**: The Laplace approximation is generally preferred over AIC/BIC for Dirichlet-Multinomial model selection.
- **Sparsity**: DM models are robust to the sparsity typically found in microbiome data, but extremely rare taxa (e.g., singletons) may still be filtered during preprocessing to improve computational efficiency.
- **Theta ($\theta$)**: This parameter represents homogeneity. Larger values indicate that the samples within a component are more similar to each other (less over-dispersion).

## Reference documentation
- [DirichletMultinomial](./references/DirichletMultinomial.md)