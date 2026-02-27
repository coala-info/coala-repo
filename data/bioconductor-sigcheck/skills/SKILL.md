---
name: bioconductor-sigcheck
description: SigCheck verifies if a gene expression signature performs significantly better than random chance or existing signatures by calculating empirical p-values. Use when user asks to validate signature performance against random gene sets, compare results to known signatures, or perform permutation tests on survival data and features.
homepage: https://bioconductor.org/packages/release/bioc/html/SigCheck.html
---


# bioconductor-sigcheck

## Overview

SigCheck is used to verify if a derived gene expression signature performs significantly better than random chance or existing signatures. It addresses the "random signature" problem in genomic studies by providing empirical p-values through four primary checks:
1. **Random Signatures**: Compares performance against signatures of the same size composed of randomly selected genes.
2. **Known Signatures**: Compares performance against established signatures (e.g., NKI, GGI).
3. **Permuted Survival**: Checks if the signature still "works" when survival metadata is shuffled (reality check for signal).
4. **Permuted Features**: Checks performance when expression values are shuffled across samples.

## Core Workflow

### 1. Data Preparation
SigCheck requires an `ExpressionSet` object. Ensure your metadata (phenoData) does not contain `NA` values for the columns you intend to analyze.

```r
library(SigCheck)
library(Biobase)

# Clean data: remove samples with missing survival/class data
dataset <- dataset[, !is.na(dataset$survival_time)]
```

### 2. Initializing a SigCheckObject
The `sigCheck` function is the constructor. It establishes the baseline performance of your signature.

```r
check <- sigCheck(expressionSet = dataset, 
                  classes = "binary_outcome_column",
                  survival = "survival_time_column",
                  signature = my_gene_vector,
                  annotation = "feature_data_column_name",
                  validationSamples = which(dataset$series == "Validation"))
```

### 3. Running Validation Tests
You can run all checks at once or individually. A minimum of 1000 iterations is recommended for publication-quality empirical p-values.

```r
# Run all default checks (Random, Known, Permuted Survival, Permuted Features)
results <- sigCheckAll(check, iterations=1000)

# Run specific checks
randomRes <- sigCheckRandom(check, iterations=1000)
knownRes  <- sigCheckKnown(check)
```

### 4. Visualizing and Interpreting Results
SigCheck provides built-in plotting to compare your signature (red line) against the background distribution.

```r
# Plot Kaplan-Meier curves for the signature
sigCheck(check) 

# Plot distributions of the validation checks
sigCheckPlot(results)

# Access empirical p-values
results$checkRandom$checkPval
```

## Advanced Configuration

### Scoring Methods
By default, SigCheck uses the first principal component (`PCA1`) to score samples. You can modify how samples are divided into groups:

- **scoreMethod**: `"PCA1"` (default), `"High"` (mean expression), or `"classifier"` (SVM/ML).
- **threshold**: Default is `0.5` (median split). Use `c(0.33, 0.66)` to create High/Low groups while excluding the middle tier.

```r
# Example: Using mean expression and splitting at the 66th percentile
checkHigh <- sigCheck(check, scoreMethod="High", threshold=0.66)
```

### Classification Analysis
If survival time is unavailable, you can evaluate the signature based on its ability to classify binary phenotypes using machine learning (via `MLInterfaces`).

```r
# Omit the 'survival' parameter to trigger classification mode
checkClass <- sigCheck(dataset, 
                       classes="outcome", 
                       signature=my_sig, 
                       scoreMethod="classifier")

# View confusion matrix
checkClass@confusion
```

### Parallel Processing
For large iterations, use `BiocParallel` to speed up computations.

```r
library(BiocParallel)
register(MulticoreParam(workers=4), default=TRUE)
```

## Reference documentation

- [Checking gene expression signatures against random and known signatures with SigCheck](./references/SigCheck.md)