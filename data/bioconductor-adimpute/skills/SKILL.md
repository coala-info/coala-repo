---
name: bioconductor-adimpute
description: ADImpute performs imputation of dropout values in single-cell RNA-sequencing data using multiple methods and ensemble approaches. Use when user asks to impute missing gene expression values, evaluate the performance of different imputation methods, or distinguish between biological and technical zeros in scRNA-seq datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/ADImpute.html
---

# bioconductor-adimpute

name: bioconductor-adimpute
description: Imputation of dropout values in single-cell RNA-sequencing (scRNA-seq) data using multiple methods (Baseline, DrImpute, SAVER, Network) and ensemble approaches. Use this skill when needing to predict unmeasured gene expression, evaluate the best imputation method per gene, or handle biological vs. technical zeros in scRNA-seq datasets.

## Overview
ADImpute is an R package designed to address the "dropout" problem in single-cell RNA-seq data, where genes are expressed but not detected due to technical limitations. It provides a unified interface for several imputation methods and introduces an "Ensemble" approach that selects the best-performing method for each individual gene based on cross-validation.

## Core Workflow

### 1. Data Preparation
ADImpute works with normalized data (e.g., RPM/TPM) or `SingleCellExperiment` objects.
```r
library(ADImpute)
# Using demo data
data_norm <- NormalizeRPM(ADImpute::demo_data)
```

### 2. Method Evaluation (Ensemble Preparation)
To use the Ensemble method, you must first determine which imputation technique works best for each gene in your specific dataset.
```r
# Evaluate multiple methods
methods_per_gene <- EvaluateMethods(
  data = data_norm, 
  do = c("Baseline", "DrImpute", "Network"),
  cores = 2, 
  net.coef = ADImpute::demo_net
)
```

### 3. Performing Imputation
You can run a single method, multiple methods, or the Ensemble result.
```r
# Ensemble Imputation
imputed_results <- Impute(
  data = data_norm, 
  do = "Ensemble", 
  method.choice = methods_per_gene,
  net.coef = ADImpute::demo_net
)

# Access specific results
ensemble_matrix <- imputed_results$Ensemble
```

## Key Functions and Parameters

- `Impute()`: The main interface for imputation.
    - `do`: Character vector of methods: `"Baseline"`, `"DrImpute"`, `"SAVER"`, `"Network"`, or `"Ensemble"`.
    - `true.zero.thr`: Numeric (0-1). If set (e.g., `0.3`), the package estimates the probability that a zero is a "biological zero" (true non-expression) rather than a technical dropout. Values below this threshold are set back to zero after imputation.
    - `net.coef`: Required for the `"Network"` method; provides regulatory models.
- `EvaluateMethods()`: Quantifies imputation error per gene by masking known values and attempting to recover them.
- `NormalizeRPM()`: Helper to normalize raw counts to Reads Per Million.

## Working with SingleCellExperiment
ADImpute integrates directly with `SingleCellExperiment` (SCE) objects.
```r
sce <- ADImpute::demo_sce
sce <- NormalizeRPM(sce = sce)
sce <- EvaluateMethods(sce = sce)
sce <- Impute(sce = sce)
# Results are stored in assays(sce)
```

## Tips and Best Practices
- **Network Method**: Requires a coefficient matrix (`net.coef`). Use the provided `demo_net` for testing, but real-world applications require models relevant to the specific organism/tissue.
- **Biological Zeros**: Always consider using `true.zero.thr` to avoid over-imputation of genes that are legitimately silenced in certain cell types.
- **Parallelization**: Use the `cores` argument in `Impute` and `EvaluateMethods` to speed up processing on large datasets.

## Reference documentation
- [ADImpute tutorial (RMarkdown)](./references/ADImpute_tutorial.Rmd)
- [ADImpute tutorial (Markdown)](./references/ADImpute_tutorial.md)