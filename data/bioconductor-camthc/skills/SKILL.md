---
name: bioconductor-camthc
description: Bioconductor-camthc performs unsupervised, supervised, and semi-supervised deconvolution of heterogeneous biological samples to estimate subpopulation proportions and specific expression profiles. Use when user asks to deconvolve mixed tissue data, estimate cell type proportions, identify molecular markers from mixture data, or characterize tissue heterogeneity using Convex Analysis of Mixtures.
homepage: https://bioconductor.org/packages/3.8/bioc/html/CAMTHC.html
---

# bioconductor-camthc

name: bioconductor-camthc
description: Unsupervised, supervised, and semi-supervised deconvolution of heterogeneous biological samples (gene expression, proteomics, DNA methylation) using Convex Analysis of Mixtures (CAM). Use this skill to estimate subpopulation proportions (A matrix) and specific expression profiles (S matrix) from mixed tissue data.

## Overview
CAMTHC implements the Convex Analysis of Mixtures (CAM) algorithm to characterize tissue heterogeneity. It assumes a linear mixing model ($X = AS$) where mixed expression is a weighted sum of subpopulation-specific expressions. It is particularly powerful because it can perform fully unsupervised deconvolution by identifying molecular markers directly from the mixture data without prior knowledge of cell types or proportions.

## Core Workflow: Unsupervised Deconvolution

### 1. Data Preparation
Input data must be in non-log linear space with non-negative values.
```r
library(CAMTHC)
# data should be a matrix: rows = genes/probes, cols = samples
# Remove missing values and all-zero rows beforehand
```

### 2. One-Step Analysis
The `CAM()` function wraps preprocessing, marker detection, and matrix estimation.
```r
# K: range of subpopulation numbers to test
# thres.low/high: percentage of low/high-expressed molecules to remove
set.seed(111) 
rCAM <- CAM(data, K = 2:5, thres.low = 0.30, thres.high = 0.95)
```

### 3. Model Selection
Use the Minimum Description Length (MDL) criterion to determine the optimal number of subpopulations ($K$).
```r
plot(MDL(rCAM), data.term = TRUE)
# Look for the K that minimizes the MDL value
```

### 4. Extracting Results
Once $K$ is chosen (e.g., $K=3$):
```r
Aest <- Amat(rCAM, 3)      # Proportion matrix
Sest <- Smat(rCAM, 3)      # Expression profile matrix
MGlist <- MGsforA(rCAM, 3) # Markers used for estimation
```

## Advanced Workflows

### Supervised Deconvolution
If markers, $S$, or $A$ are already known:
*   **From Markers:** `Aest <- AfromMarkers(data, MGlist)`
*   **From S Matrix:** Identify markers from $S$ using `MGstatistic()`, then use `AfromMarkers()`.
*   **From A Matrix:** Estimate $S$ using `Sest <- t(NMF::.fcnnls(A, t(data))$coef)`.

### Refinement and Re-estimation
Use `redoASest()` to refine $A$ and $S$ using Alternating Least Square (ALS) or to apply specific constraints (e.g., methylation values between 0 and 1).
```r
# methy = TRUE enforces S in [0,1] for DNA methylation data
rre <- redoASest(data, MGlist, maxIter = 10, methy = FALSE)
```

### Visualization
Visualize the scatter simplex to verify marker gene locations at vertices.
```r
simplexplot(data, Aest, MGlist)
```

## Tips for Specific Data Types
*   **Gene Expression:** Remove 30-50% low-expressed genes.
*   **Proteomics:** Remove fewer low-expressed proteins (0-10%).
*   **DNA Methylation:** 
    *   Use Beta-values (not M-values).
    *   Remove sex chromosomes if samples are mixed gender.
    *   Downsample CpG sites (e.g., to 50,000) to improve clustering speed.
    *   Set `methy = TRUE` in `redoASest()`.

## Reference documentation
- [CAMTHC User Manual (Rmd)](./references/camthc.Rmd)
- [CAMTHC User Manual (Markdown)](./references/camthc.md)