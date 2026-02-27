---
name: bioconductor-rmagpie
description: This tool performs machine learning and feature selection for microarray data using robust one-layer and two-layer external cross-validation. Use when user asks to train SVM or NSC classifiers, perform recursive feature elimination, estimate unbiased error rates for genomic data, or classify new samples.
homepage: https://bioconductor.org/packages/release/bioc/html/Rmagpie.html
---


# bioconductor-rmagpie

name: bioconductor-rmagpie
description: Machine learning and feature selection for microarray data using external one-layer and two-layer cross-validation. Use this skill when you need to train classifiers (SVM or NSC), perform Recursive Feature Elimination (RFE), or estimate unbiased error rates for high-dimensional genomic data.

# bioconductor-rmagpie

## Overview
`Rmagpie` provides a framework for robust classification and feature selection in microarray studies. Its primary strength is the implementation of "external" cross-validation (one-layer and two-layer), which prevents selection bias by ensuring feature selection is performed within the cross-validation loops. It supports Support Vector Machines (SVM) with Recursive Feature Elimination (RFE) and Nearest Shrunken Centroids (NSC).

## Core Workflow

### 1. Data Preparation
Data must be stored in an `ExpressionSet` object.
```R
library(Rmagpie)
data('vV70genesDataset') # Example dataset: vV70genes
```

### 2. Define Feature Selection Options
Choose between RFE-SVM or NSC.
- **RFE-SVM**: Create a `geneSubsets` object.
  ```R
  # High speed (powers of 2) or slow (decrement by 1)
  subsets <- new("geneSubsets", speed="high", maxSubsetSize=20)
  ```
- **NSC**: Create a `thresholds` object.
  ```R
  myThresholds <- new("thresholds", optionValues=c(0, 0.1, 0.5, 1.0))
  ```

### 3. Initialize the Assessment
The `assessment` object centralizes all experiment parameters.
```R
myAssessment <- new("assessment",
  dataset = vV70genes,
  noFolds1stLayer = 9,
  noFolds2ndLayer = 10,
  classifierName = "svm", # 'svm' or 'nsc'
  featureSelectionMethod = 'rfe', # 'rfe' or 'nsc'
  typeFoldCreation = "original", # 'naive', 'balanced', or 'original'
  svmKernel = "linear",
  noOfRepeats = 3,
  featureSelectionOptions = subsets)
```

### 4. Run Cross-Validation
- **One-Layer**: Estimates error rates for specific subset sizes/thresholds.
  ```R
  myAssessment <- runOneLayerExtCV(myAssessment)
  ```
- **Two-Layer**: Provides an unbiased estimate of the error rate after choosing the optimal feature subset.
  ```R
  myAssessment <- runTwoLayerExtCV(myAssessment)
  ```

### 5. Final Classification
Train the final model on the full dataset and predict new samples.
```R
# Train final model
myAssessment <- findFinalClassifier(myAssessment)

# Classify new samples from a text file
# File format: genes in rows, samples in columns, first row/col are names
newSamplesFile <- "path/to/data.txt"
predictions <- classifyNewSamples(myAssessment, newSamplesFile)
```

## Accessing Results
Use `getResults(object, layer, topic, ...)` to extract specific data.

- **Layer Argument**: `1` (1-layer summary), `c(1, i)` (ith repeat of 1-layer), `2` (2-layer summary).
- **Topics**: `'errorRate'`, `'genesSelected'`, `'bestOptionValue'`, `'executionTime'`.
- **Error Types**: `'cv'`, `'se'`, `'fold'`, `'class'`.

```R
# Get CV error rates for one-layer
cv_rates <- getResults(myAssessment, 1, topic='errorRate', errorType='cv')

# Get frequency of genes selected in one-layer
gene_freq <- getResults(myAssessment, 1, topic='genesSelected', genesType='frequ')
```

## Visualization
- `plotErrorsSummaryOneLayerCV(myAssessment)`: Average error rate vs. subset size.
- `plotErrorsRepeatedOneLayerCV(myAssessment)`: Individual repeat error rates.
- `plotErrorsFoldTwoLayerCV(myAssessment)`: Fold-specific error rates in the second layer.

## Reference documentation
- [Magpie_examples](./references/Magpie_examples.md)