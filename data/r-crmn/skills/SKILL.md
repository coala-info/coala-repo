---
name: r-crmn
description: "Implements the Cross-contribution Compensating Multiple     standard Normalization (CCMN) method described in Redestig et     al."
homepage: https://cran.r-project.org/web/packages/crmn/index.html
---

# r-crmn

## Overview
The `crmn` package implements the Cross-contribution Robust Multiple standard Normalization (CRMN) method. It is designed to correct for technical variation in metabolomics data by using internal standards (ISs) while accounting for the fact that analytes themselves can sometimes cause variation in those standards.

## Installation
Install the package from CRAN:
```R
install.packages("crmn")
library(crmn)
```

## Data Structures
The package supports two input formats:
1.  **ExpressionSet**: A Biobase object. Requires a feature data column (default tag "IS") to identify internal standards.
2.  **Matrix**: A standard R matrix. Requires a logical vector (`standards`) to identify which rows are internal standards.

## Core Workflow

### 1. Prepare Data
If using an `ExpressionSet`, ensure internal standards are tagged:
```R
# Example using the built-in 'mix' dataset
data(mix)
# Check standards and analytes
Ys <- standards(mix)
Ya <- analytes(mix)
```

### 2. Fit Normalization Model
Use `normFit` to create a normalization model. For CRMN, you must provide the experimental design (factors).
```R
# Using a factor name from pData
nfit <- normFit(mix, "crmn", factor="type")

# Or using a design matrix
G <- model.matrix(~-1 + mix$type)
nfit <- normFit(mix, "crmn", factor=G)

# Check the number of principal components selected
sFit(nfit)$ncomp
```

### 3. Apply Normalization
Use `normPred` to apply the fitted model to the data.
```R
normed.crmn <- normPred(nfit, mix, factor="type")
```

### 4. One-Step Normalization
The `normalize` function acts as a wrapper for fitting and predicting.
```R
# CRMN method
normed.crmn <- normalize(mix, "crmn", factor="type")

# NOMIS method
normed.nomis <- normalize(mix, "nomis")

# Single Internal Standard method
normed.one <- normalize(mix, "one", one="Hexadecanoate_13C4")
```

## Alternative Normalization Methods
-   `nomis`: Optimal selection of multiple internal standards.
-   `one`: Divide by a single user-defined internal standard.
-   `ri`: Divide by the internal standard closest in retention index (requires RI data in `fData`).
-   `totL2`: Square sum of each sample is equalized (no IS required).
-   `median` / `avg`: Median or average of each sample equals one (no IS required).

## Visualization and Diagnostics
-   `plot(nfit)`: Shows basic statistics and optimization of the normalization model.
-   `slplot(sFit(nfit)$fit$pc)`: Visualizes the systematic error ($T_Z$) identified by CRMN.

## Reference documentation
- [The crmn Package](./references/crmn.md)