---
name: bioconductor-depinfer
description: bioconductor-depinfer is a computational framework that uses regularized multivariate linear regression to infer protein dependencies from drug-protein affinity and phenotypic response data. Use when user asks to identify molecular protein dependencies, deconvolute drug inhibition effects, or prioritize pharmacological targets using LASSO regression.
homepage: https://bioconductor.org/packages/release/bioc/html/DepInfeR.html
---

# bioconductor-depinfer

## Overview

DepInfeR (Dependency Inference in R) is a computational framework that deconvolutes the phenotypic effects of drug inhibition to identify molecular protein dependencies. It uses regularized multivariate linear regression (LASSO) to assign a "dependence coefficient" to each protein for every sample. This allows for the identification of functional consequences of genomic aberrations and helps prioritize pharmacological targets for specific cancer subtypes or individual patients.

## Core Workflow

### 1. Data Preparation

DepInfeR requires two primary input matrices:
- **Drug-Protein Affinity Matrix (Y):** Rows are drugs, columns are proteins. Values are typically Kd (dissociation constants).
- **Drug Response Matrix (X):** Rows are drugs, columns are samples (e.g., cell lines). Values are phenotypic responses (e.g., z-scored AUC or IC50).

### 2. Pre-processing Affinity Data

Use `processTarget()` to transform Kd values and handle collinearity. Proteins with highly similar drug-binding profiles are grouped into clusters to ensure model stability.

```r
# targetMatrix: drugs as rows, proteins as columns, values as Kd
ProcessTargetResults <- processTarget(targetMatrix,
  KdAsInput = TRUE,      # Log and arctan transform Kd values
  removeCorrelated = TRUE, # Remove/cluster highly correlated targets
  cutoff = 0.8           # Cosine similarity cutoff
)

# Extract the processed matrix
targetInput <- ProcessTargetResults$targetMatrix
```

### 3. Pre-processing Response Data

The response matrix must not contain missing values. Common practices include:
- Filtering samples with high missingness.
- Imputing remaining values (e.g., using `missForest`).
- Scaling/Normalizing (e.g., column-wise z-scores of AUC).

```r
# Ensure drugs match between matrices
overlappedDrugs <- intersect(rownames(responseMatrix_scaled), rownames(targetInput))
targetInput <- targetInput[overlappedDrugs, ]
responseInput <- responseMatrix_scaled[overlappedDrugs, ]
```

### 4. Running the Inference Model

The `runLASSORegression()` function performs the multivariate LASSO regression. Use `BiocParallel` for faster execution.

```r
library(BiocParallel)
param <- MulticoreParam(workers = 2, RNGseed = 333)

result <- runLASSORegression(
  TargetMatrix = targetInput,
  ResponseMatrix = responseInput, 
  repeats = 100, # Higher repeats (e.g., 100) for robust estimation
  BPPARAM = param
)

# The output coefMat contains the protein dependence coefficients
dependenceMatrix <- result$coefMat
```

## Interpreting Results

- **Positive Coefficients:** Indicate a strong reliance on the protein for survival (dependency).
- **Zero Coefficients:** Indicate the protein is likely not essential in that sample context.
- **Negative Coefficients:** Suggest that inhibiting the protein might actually increase viability (less common, context-dependent).

## Downstream Analysis Tips

- **Visualization:** Use `pheatmap` to visualize the `coefMat`. Row-normalize (scale) the coefficients to highlight relative dependencies across samples.
- **Differential Dependency:** Use t-tests (for binary features like mutations) or ANOVA (for categorical features like cancer types) to find proteins associated with specific genotypes.
- **Target Clusters:** If `removeCorrelated = TRUE` was used, check `ProcessTargetResults$targetCluster` to see which proteins were grouped together. The regression selects one representative from each cluster.

## Reference documentation

- [DepInfeR Vignette (Rmd)](./references/vignette.Rmd)
- [DepInfeR Vignette (Markdown)](./references/vignette.md)