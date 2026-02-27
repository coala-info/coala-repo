---
name: bioconductor-scfa
description: SCFA is a multi-omics data integration framework that performs cancer subtyping and clinical risk prediction using consensus factor analysis. Use when user asks to identify molecular subtypes from multi-omics data, integrate disparate biological datasets, or predict patient survival risk scores.
homepage: https://bioconductor.org/packages/release/bioc/html/SCFA.html
---


# bioconductor-scfa

## Overview
SCFA (Subtyping via Consensus Factor Analysis) is a robust framework for cancer subtyping and clinical risk prediction. It addresses the challenges of high-dimensional multi-omics data by using a three-stage process:
1. **Feature Filtering**: Uses an autoencoder to identify genes/features with significant contributions.
2. **Factor Analysis**: Generates multiple factor representations of the data.
3. **Consensus Ensemble**: Identifies stable subtypes shared across representations.

The package is particularly effective for integrating disparate data types (e.g., gene expression and methylation) to find clinically relevant patient groups.

## Installation
SCFA requires the `torch` package for its autoencoder component.
```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("SCFA")

library(SCFA)
# Ensure C++ libtorch is installed for neural network computations
torch::install_torch()
```

## Typical Workflow

### 1. Data Preparation
Input data should be a list of matrices. Each matrix represents a different omics type (e.g., mRNA, miRNA).
- **Rows**: Samples (patients)
- **Columns**: Features (genes, probes)
- **Requirement**: Samples must be in the same order across all matrices.

```r
# Example with GBM dataset
data("GBM")
dataList <- GBM$data      # List of matrices
survivalData <- GBM$survival # Data frame with 'Survival' and 'Death'
```

### 2. Multi-omics Subtyping
Use the `SCFA` function to assign patients to clusters.
```r
set.seed(1)
subtype_assignments <- SCFA(dataList, ncores = 4L)

# Validate with survival analysis
library(survival)
coxFit <- coxph(Surv(time = Survival, event = Death) ~ as.factor(subtype_assignments), 
                data = survivalData)
summary(coxFit)
```

### 3. Risk Score Prediction
Use `SCFA.class` to predict risk scores for new patients based on a training set with known survival outcomes.
```r
# Survival time must be positive
survivalData$Survival <- survivalData$Survival - min(survivalData$Survival) + 1

# trainList/testList: lists of matrices
# trainSurvival: a Surv object
risk_scores <- SCFA.class(trainList, trainSurvival, testList, ncores = 4L)

# Higher risk_scores indicate higher probability of earlier events
```

## Tips and Best Practices
- **Parallelization**: Use the `ncores` parameter in `SCFA` and `SCFA.class` to speed up the factor analysis and ensemble steps.
- **Reproducibility**: Always set a seed (`set.seed()`) before running SCFA, as the autoencoder and factor analysis components involve stochastic processes.
- **Data Scaling**: While SCFA handles high-dimensional data well, ensure that features are appropriately pre-processed (e.g., log-transformation for expression data) before integration.
- **Survival Analysis**: When using `SCFA.class`, ensure the survival times in your training data are strictly positive.

## Reference documentation
- [SCFA package manual](./references/Example.md)
- [SCFA Vignette Source](./references/Example.Rmd)