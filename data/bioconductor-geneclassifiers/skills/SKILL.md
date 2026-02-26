---
name: bioconductor-geneclassifiers
description: This tool applies linear gene classifiers to gene expression data to estimate patient prognosis and risk scores. Use when user asks to list available classifiers, prepare ExpressionSet data for classification, run classifiers on normalized microarray data, or handle missing probe-sets via reweighting.
homepage: https://bioconductor.org/packages/release/bioc/html/geneClassifiers.html
---


# bioconductor-geneclassifiers

name: bioconductor-geneclassifiers
description: Use this skill to apply linear gene classifiers (like EMC92, UAMS70) to gene expression data for patient risk stratification. It supports handling missing probe-sets via reweighting and performs necessary batch corrections. Use when you need to: (1) List available classifiers, (2) Prepare ExpressionSet data for classification, (3) Run classifiers on normalized microarray data, and (4) Handle missing covariates in independent datasets.

## Overview

The `geneClassifiers` package implements several validated linear models for estimating patient prognosis, primarily in multiple myeloma. It automates the workflow of preprocessing normalized microarray data, applying model weights, and performing batch correction to generate risk scores and classifications. A key feature is its ability to "reweight" models when specific probe-sets are missing from the input data, using the covariance structure of the original training data to maintain predictive accuracy.

## Typical Workflow

### 1. Explore Available Classifiers
Use `showClassifierList()` to see implemented models and their required normalization methods (e.g., MAS5.0, GCRMA).

```r
library(geneClassifiers)
showClassifierList()

# Get detailed parameters for a specific model
classifier <- getClassifier("EMC92")
getWeights(classifier)
getDecisionBoundaries(classifier)
```

### 2. Prepare Input Data
Input must be a Bioconductor `ExpressionSet`. You must specify the normalization method used during the initial data processing to ensure it matches the classifier's requirements.

```r
# Example using MAS5.0 normalized data
# targetValue is usually 500 for MAS5.0
fixedData <- setNormalizationMethod(myExpressionSet, 
                                    method = "MAS5.0", 
                                    targetValue = 500)
```

### 3. Run Classification
The `runClassifier` function performs the preprocessing and scoring.

```r
# Standard run
results <- runClassifier("EMC92", fixedData)

# Extract results
scores <- getScores(results)
classes <- getClassifications(results)
```

### 4. Handling Missing Probe-sets
If your dataset is missing probe-sets required by the classifier, `runClassifier` will throw an error. You can enable the reweighting algorithm to redistribute weights to the remaining covariates.

```r
# Run with reweighting enabled for missing covariates
results_rw <- runClassifier("EMC92", 
                            fixedData, 
                            allow.reweighted = TRUE)
```

## Important Considerations

- **Sample Size**: The package performs batch correction by default. This requires at least **20 samples** to accurately estimate means and standard deviations. For smaller cohorts, you may need to set `do.batchcorrection = FALSE`, though this may invalidate the classification thresholds.
- **Normalization**: Ensure the normalization method used (MAS5.0 vs GCRMA) matches the classifier's requirements. The package attempts to detect mismatches but manual verification is recommended.
- **Data Integrity**: For best results, provide the full ExpressionSet. If probe-sets are filtered out before using this package, the `targetValue` for MAS5.0 must be provided manually.

## Reference documentation

- [Handling missing probe-sets in a linear gene classifier](./references/MissingCovariates.md)
- [geneClassifiers: User Guide and Workflow](./references/geneClassifiers.md)