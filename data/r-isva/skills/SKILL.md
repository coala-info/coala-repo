---
name: r-isva
description: Skill for using the CRAN R package r-isva.
homepage: https://cran.r-project.org/web/packages/isva/index.html
---

# r-isva

## Overview
The `isva` package provides an algorithm for feature selection in the presence of potential confounding factors. It uses Independent Component Analysis (ICA) to identify surrogate variables that capture non-biological or unwanted variation, allowing for more robust identification of features associated with a primary variable of interest.

## Installation
To install the package from CRAN:
```R
install.packages("isva")
```
Note: `isva` depends on the Bioconductor package `qvalue`, which may need to be installed separately via `BiocManager::install("qvalue")`.

## Main Functions and Workflow

### 1. Estimating the Number of Surrogate Variables
Before running ISVA, use `EstDimRMT` to estimate the number of significant components (latent variables) in the data using Random Matrix Theory.
```R
# data.m: matrix with features in rows and samples in columns
# ncov: number of known covariates to include in the null model
rmt.obj <- EstDimRMT(data.m, ncov = 1)
n.isv <- rmt.obj$dim
```

### 2. Running ISVA
The core function `isvaFn` performs the Independent Surrogate Variable Analysis.
```R
# pheno.v: the primary variable of interest (e.g., case/control)
# n.isv: number of surrogate variables to estimate
isva.obj <- DoISVA(data.m, pheno.v, nsv = n.isv)

# Access the estimated surrogate variables
isvs <- isva.obj$isv
```

### 3. Feature Selection
ISVA identifies features significantly associated with the phenotype while accounting for the estimated surrogate variables.
```R
# Get p-values and q-values for features
pvalues <- isva.obj$p
qvalues <- isva.obj$q

# Identify significant features (e.g., FDR < 0.05)
sig_features <- which(qvalues < 0.05)
```

## Tips and Best Practices
- **Data Orientation**: Ensure your input matrix has features (genes, probes) as rows and samples as columns.
- **ICA Methods**: The package uses `fastICA` or `JADE` for independent component extraction.
- **Comparison with SVA**: Unlike standard Surrogate Variable Analysis (SVA) which uses PCA, ISVA uses ICA, which can be more effective at capturing non-Gaussian confounding signals.
- **Known Covariates**: If you have known batch effects or covariates (e.g., age, sex), include them in the model to ensure ISVA identifies *additional* unknown factors.

## Reference documentation
- [isva: Independent Surrogate Variable Analysis](./references/home_page.md)