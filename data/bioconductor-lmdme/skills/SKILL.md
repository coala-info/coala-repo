---
name: bioconductor-lmdme
description: This tool performs linear model decomposition and multivariate analysis on high-throughput biological data from experiments with multiple factors. Use when user asks to perform ANOVA-PCA, ANOVA-Simultaneous Component Analysis, or ANOVA-PLS to decompose variability sources and visualize interaction patterns in datasets like RNA-seq or metabolomics.
homepage: https://bioconductor.org/packages/release/bioc/html/lmdme.html
---

# bioconductor-lmdme

name: bioconductor-lmdme
description: Linear Model Decomposition for Designed Multivariate Experiments (LMDME). Use this skill to perform ANOVA-PCA (APCA), ANOVA-Simultaneous Component Analysis (ASCA), and ANOVA-PLS on high-throughput biological data (microarray, RNA-seq, metabolomics). It is specifically designed for experiments with multiple factors (e.g., time, dose, genotype) where you need to decompose variability sources and visualize interaction patterns.

## Overview

The `lmdme` package provides a framework for ANOVA-based decomposition of multivariate datasets. It allows users to specify complex linear models using standard R formula syntax, estimate coefficients via maximum likelihood (leveraging `limma`), and then apply dimensionality reduction (PCA or PLS) to specific terms (e.g., main effects or interactions). This is particularly powerful for identifying gene expression patterns driven by specific experimental factors while filtering out noise or unrelated variability.

## Core Workflow

### 1. Data Preparation
The package requires a gene expression matrix (genes in rows, samples in columns) and a design data frame describing the experimental factors.

```R
library(lmdme)
# M: matrix of expression values (g x n)
# design: data.frame with factors (n rows)
```

### 2. Model Fitting and Decomposition
Use the `lmdme` function to fit the linear model. This performs the iterative ANOVA decomposition.

```R
# Fit a two-way ANOVA model with interaction
fit <- lmdme(model = ~factorA * factorB, data = M, design = design)

# View the decomposition steps
fit
```

### 3. Statistical Inference
Identify significant features (e.g., genes) for a specific term using F-tests.

```R
# Get p-values for the interaction term
pvals <- F.p.values(fit, term = "factorA:factorB")

# Select features with p < 0.001
significant_ids <- pvals < 0.001
```

### 4. Multivariate Analysis (PCA/PLS)
Apply PCA (ASCA/APCA) or PLS to the estimated coefficients or residuals of a specific term.

```R
# Perform ASCA on the interaction term for significant genes
decomposition(fit, 
              decomposition = "pca", 
              type = "coefficient", 
              term = "factorA:factorB", 
              subset = significant_ids, 
              scale = "row")

# Perform PLS on the same term
fit.plsr <- fit
decomposition(fit.plsr, 
              decomposition = "plsr", 
              term = "factorA:factorB", 
              subset = significant_ids)
```

### 5. Visualization
The package provides specialized plotting functions to interpret the multivariate results.

```R
# Biplot of the PCA/PLS results
biplot(fit, xlabs = "o", expand = 0.7)

# Loading plot to see factor effects across components
loadingplot(fit, term.x = "factorA", term.y = "factorB")

# Scree plot for variance explanation
screeplot(fit)
```

## Key Functions

- `lmdme()`: Main entry point for model fitting and ANOVA decomposition.
- `decomposition()`: Applies PCA or PLS to a fitted `lmdme` object.
- `F.p.values()`: Extracts p-values for the ANOVA terms.
- `biplot()`: Visualizes scores and loadings.
- `loadingplot()`: Visualizes the effect of factors on the principal components.
- `components()`: Extracts the PCA/PLS components.

## Tips for Success

- **Balanced Designs**: While `lmdme` uses maximum likelihood (more flexible than traditional ASCA), balanced designs are still preferred for cleaner orthogonality in ANOVA decomposition.
- **Scaling**: Use `scale = "row"` in the `decomposition` function to focus on the pattern of change across conditions rather than absolute magnitude.
- **Term Selection**: When calling `decomposition`, the `term` argument must exactly match the name shown in the `fit` object summary (e.g., "time:oxygen").
- **Residual Analysis**: To perform ANOVA-PCA (APCA) as described by De Haan, set `type = "residuals"` in the `decomposition` function.

## Reference documentation

- [lmdme: Linear Models on Designed Multivariate Experiments in R](./references/lmdme-vignette.md)