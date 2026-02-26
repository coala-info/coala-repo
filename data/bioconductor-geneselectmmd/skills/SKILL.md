---
name: bioconductor-geneselectmmd
description: This package implements a marginal mixture model to identify differentially expressed genes between two tissue types while estimating error rates like FDR and FNR. Use when user asks to select differentially expressed genes, estimate false discovery rates from gene expression data, or fit a three-component multivariate normal mixture model to genomic profiles.
homepage: https://bioconductor.org/packages/release/bioc/html/GeneSelectMMD.html
---


# bioconductor-geneselectmmd

## Overview

The `GeneSelectMMD` package implements a marginal mixture model (MMD) for selecting differentially expressed genes between two tissue types (e.g., case vs. control). It assumes the marginal distribution of gene profiles is a mixture of three multivariate normal components: over-expressed, non-differentially expressed, and under-expressed. This model-based approach allows for the direct estimation of error rates like False Discovery Rate (FDR) and False Negative Rate (FNR) from real data.

## Core Workflow

### 1. Data Preparation
The package accepts either a Bioconductor `ExpressionSet` or a standard data matrix. You must define a membership vector for subjects.

```r
library(GeneSelectMMD)

# Example with a matrix 'mat' where rows are genes and columns are samples
# memSubjects: 1 for case, 0 for control
memSubjects <- c(rep(1, n_cases), rep(0, n_controls))
```

### 2. Gene Selection
Use `gsMMD` for automated initial partitioning or `gsMMD2` if you want to provide a custom initial clustering.

**Standard approach (using t-test for initialization):**
```r
# For ExpressionSet
obj <- gsMMD(eSet, memSubjects, transformFlag = TRUE, transformMethod = "boxcox", scaleFlag = TRUE)

# For Matrix
obj <- gsMMD.default(mat, memSubjects, iniGeneMethod = "Ttest", transformFlag = TRUE)
```

**Custom initialization (e.g., using Wilcoxon):**
```r
# memIni: 1 (over), 2 (non-diff), 3 (under)
obj <- gsMMD2(eSet, memSubjects, memIni = my_initial_vector)
```

### 3. Interpreting Results
The output object contains:
- `memGenes`: Cluster membership (1=over, 2=non-diff, 3=under).
- `memGenes2`: Binary membership (1=differentially expressed, 0=not).
- `para`: Estimated model parameters (mixing proportions, means, variances, and correlations).

### 4. Estimating Error Rates
Unlike frequentist methods, MMD provides specific error estimates for the dataset:
```r
errors <- errRates(obj)
# Returns: FDR, FNDR, FPR, FNR
print(round(errors, 3))
```

### 5. Visualizing Model Fit
To check if the model fits the data (assuming marginal independence), plot the histogram of pooled expression levels against the estimated density:
```r
plotHistDensity(obj, plotFlag = "case", mytitle = "Case Group Fit", plotComponent = TRUE)
```

## Key Parameters and Tips

- **Transformation**: Setting `transformFlag = TRUE` with `transformMethod = "boxcox"` is recommended for microarray data to meet normality assumptions.
- **Scaling**: `scaleFlag = TRUE` scales gene profiles to have mean 0 and variance 1, which can stabilize EM convergence.
- **Performance**: Large datasets are processed efficiently via underlying Fortran 77 code. A dataset with 32,000 genes can typically be processed in under a minute.
- **Cluster Proportions**: `para[1:3]` provides the estimated proportions of over-expressed, non-differentially expressed, and under-expressed genes respectively.

## Reference documentation

- [Gene Selection Using GeneSelectMMD](./references/gsMMD.md)