---
name: bioconductor-affixcan
description: AffiXcan estimates the genetic component of gene expression by modeling the relationship between total binding affinity scores and transcript levels. Use when user asks to train GReX models, impute genetically regulated expression, or perform transcriptome-wide association studies using transcription factor binding affinity.
homepage: https://bioconductor.org/packages/release/bioc/html/AffiXcan.html
---


# bioconductor-affixcan

name: bioconductor-affixcan
description: Training and applying statistical models to estimate Genetically Regulated Expression (GReX) using Total Binding Affinity (TBA) scores. Use this skill when you need to perform eQTL discovery or Transcriptome-Wide Association Studies (TWAS) by modeling gene expression based on transcription factor binding affinity in regulatory regions.

## Overview
AffiXcan (Total Binding AFFInity-eXpression sCANner) is a functional approach for estimating the genetic component of gene expression (GReX). Unlike SNP-based methods that rely on individual variants with large effect sizes, AffiXcan uses Total Binding Affinity (TBA) scores—calculated from Position-specific Weight Matrices (PWMs) and DNA segments—to capture the aggregate effect of multiple variants in regulatory regions. It employs Principal Component Analysis (PCA) on these scores to build linear models for gene expression.

## Core Workflow

### 1. Training GReX Models
The training phase requires real expression data, TBA matrices for regulatory regions, and a mapping between genes and regions.

```r
library(AffiXcan)
library(MultiAssayExperiment)
library(SummarizedExperiment)

# 1. Load TBA matrices (MultiAssayExperiment)
# Each assay should be a matrix: rows = individuals, cols = PWMs
tba_data <- readRDS("path/to/tba_matrices.rds")

# 2. Load Expression data (SummarizedExperiment)
# Rows = genes, columns = individuals
load("exprMatrix.RData")

# 3. Load Gene-Region associations
# Must contain columns: "REGULATORY_REGION" and "EXPRESSED_REGION"
load("regionAssoc.RData")

# 4. Train the models
training_results <- affiXcanTrain(
    exprMatrix = exprMatrix, 
    assay = "values",           # Name of the assay in exprMatrix
    tbaPaths = "path/to/tba.rds", 
    regionAssoc = regionAssoc, 
    cov = trainingCovariates,   # Optional: population structure PCs
    varExplained = 80,          # % variance for PCA selection
    scale = TRUE
)
```

### 2. Imputing GReX
Once models are trained, you can estimate GReX in a new population using their TBA scores.

```r
# TBA must be calculated on the same regions/PWMs as training
imputed_grex <- affiXcanImpute(
    tbaPaths = "path/to/testing_tba.rds",
    affiXcanTraining = training_results,
    scale = TRUE
)

# Access the GReX matrix
grex_matrix <- assays(imputed_grex)$GReX
```

### 3. Cross-Validation
To evaluate model performance before final imputation, use the `kfold` argument in the training function.

```r
cv_results <- affiXcanTrain(
    exprMatrix = exprMatrix, 
    assay = "values",
    tbaPaths = "path/to/tba.rds", 
    regionAssoc = regionAssoc, 
    varExplained = 80, 
    scale = TRUE, 
    kfold = 5  # Performs 5-fold cross-validation
)
# Note: CV output is a performance report and cannot be used for imputation.
```

## Key Considerations
- **TBA Scores**: These are typically pre-computed using external tools like `vcf_rider` from phased VCF files.
- **Region Mapping**: A single gene can be associated with multiple regulatory regions. AffiXcan will include PCs from all associated regions in the linear model.
- **Parallelization**: Functions support `BiocParallel`. You can pass a `BiocParallelParam` object via the `BPPARAM` argument to speed up PCA and model fitting.
- **Data Consistency**: Ensure that the IDs for individuals and regions match across the TBA matrices, expression matrix, and association table.

## Reference documentation
- [AffiXcan](./references/AffiXcan.md)