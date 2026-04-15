---
name: bioconductor-retrofit
description: RETROFIT performs reference-free deconvolution of spatial transcriptomics data to estimate cell-type mixtures using a Bayesian non-negative matrix factorization framework. Use when user asks to estimate cell-type proportions in spatial transcriptomics data without a reference, decompose gene-by-spot expression matrices, or annotate deconvolved components using marker genes or external single-cell data.
homepage: https://bioconductor.org/packages/release/bioc/html/retrofit.html
---

# bioconductor-retrofit

name: bioconductor-retrofit
description: Reference-free deconvolution of spatial transcriptomics (ST) data using the RETROFIT statistical method. Use this skill when you need to estimate cell-type mixtures in ST data without a single-cell reference, or when you want to annotate deconvolved components using marker genes or external scRNA-seq data.

# bioconductor-retrofit

## Overview

The `retrofit` package provides a reference-free approach to deconvolving spatial transcriptomics (ST) data. Unlike many methods that require a matched single-cell reference, RETROFIT uses a Bayesian non-negative matrix factorization framework to decompose the gene-by-spot expression matrix into cell-type-specific gene expressions and their corresponding spatial proportions.

## Core Workflow

### 1. Data Preparation
The input should be a gene expression matrix `X` of order $G \times S$ (Genes x Spots).

```r
library(retrofit)
# Example: Load provided colon data
utils::data("vignetteColonData")
X <- vignetteColonData$a3_x
```

### 2. Deconvolution
The primary function is `decompose()`. It breaks the matrix `X` into:
- `w`: Gene-by-component matrix ($G \times L$)
- `h`: Component-by-spot matrix ($L \times S$)
- `th`: Theta vector ($L$ components)

```r
# L should be higher than the expected number of cell types
iterations <- 4000 
L <- 16
result <- retrofit::decompose(X, L=L, iterations=iterations)

H <- result$h
W <- result$w
```

### 3. Cell-Type Annotation
After deconvolution, components must be mapped to biological cell types. This can be done in two ways:

**Option A: Using a Single-Cell Reference**
Correlate the estimated gene profiles ($W$) with an external scRNA-seq reference.
```r
sc_ref <- vignetteColonData$sc_ref # G x K matrix
K <- ncol(sc_ref)
annotated <- annotateWithCorrelations(sc_ref, K, W, H)

# Proportions are in annotated$h_prop
```

**Option B: Using Marker Genes**
Map components based on the expression of known marker gene lists.
```r
marker_ref <- vignetteColonData$marker_ref # List of marker vectors
K <- length(marker_ref)
annotated <- retrofit::annotateWithMarkers(marker_ref, K, W, H)
```

### 4. Combined Execution
You can perform deconvolution and correlation-based annotation in a single step using the `retrofit()` wrapper:
```r
result <- retrofit::retrofit(X, sc_ref=sc_ref_w, iterations=4000, L=20, K=10)
```

## Diagnostics and Optimization

### Optimal Lambda ($\lambda$)
To choose the best sparsity parameter, use the `delta_metric()` function on a correlation matrix of estimated vs. marker expressions. A higher $\delta$ indicates better performance.
```r
utils::data("lambdaCorrelationData")
delta_metric(lambdaCorrelationData$cor_matrix)
```

### Visualization Tips
- **Proportions**: Use `rowSums(H_prop) / ncol(H_prop)` to find the global abundance of cell types.
- **Spatial Mapping**: Combine `H_prop` with spot coordinates (`imagerow`, `imagecol`) to plot spatial distributions using `ggplot2`.
- **Dominant Types**: Identify the primary cell type per spot using `apply(H_prop, 2, which.max)`.

## Reference documentation

- [Retrofit Colon Vignette (Rmd)](./references/ColonVignette.Rmd)
- [Retrofit Colon Vignette (Markdown)](./references/ColonVignette.md)
- [Retrofit Simulation Vignette (Rmd)](./references/SimulationVignette.Rmd)
- [Retrofit Simulation Vignette (Markdown)](./references/SimulationVignette.md)