---
name: bioconductor-sigfeature
description: The sigFeature package provides a hybrid feature selection approach for binary classification by combining Support Vector Machine Recursive Feature Elimination with t-statistics. Use when user asks to rank features for biomarker identification, perform feature selection for binary classification, or identify differentially significant features using SVM-RFE.
homepage: https://bioconductor.org/packages/release/bioc/html/sigFeature.html
---


# bioconductor-sigfeature

## Overview

The `sigFeature` package provides a hybrid feature selection approach for binary classification. While standard Support Vector Machine Recursive Feature Elimination (SVM-RFE) focuses solely on classification accuracy, `sigFeature` incorporates t-statistics to ensure selected features are also differentially significant between classes. This is particularly useful in bioinformatics for identifying biomarkers that are both statistically different and predictive.

## Core Workflow

### 1. Data Preparation
The package expects a feature matrix `x` (samples as rows, features as columns) and a label vector `y` (containing -1 and 1).

```r
library(sigFeature)
library(SummarizedExperiment)

# Load example data
data(ExampleRawData, package="sigFeature")
x <- t(assays(ExampleRawData)$counts)
y <- colData(ExampleRawData)$sampleLabels
```

### 2. Feature Ranking
Use `sigFeature()` to rank features based on the hybrid SVM-RFE and t-statistic weight.

```r
# Rank features (returns indices of features in descending order of importance)
sigfeatureRankedList <- sigFeature(x, y)

# View top 10 features
print(sigfeatureRankedList[1:10])
```

### 3. Classification and Validation
After ranking, use the top features to build a classifier (typically using `e1071`).

```r
library(e1071)

# Build model using top 100 features
model <- svm(x[, sigfeatureRankedList[1:100]], y, 
             type="C-classification", kernel="linear")

# Predict and evaluate
pred <- predict(model, x[, sigfeatureRankedList[1:100]])
table(pred, y)
```

### 4. Cross-Validation and Frequency Analysis
To obtain unbiased results, use k-fold stratified cross-validation.

```r
# Perform 10-fold cross-validation
results <- sigFeature.enfold(x, y, "kfold", 10)

# Rank features based on frequency across folds
# Useful for identifying robust features
FeatureFreq <- sigFeatureFrequency(x, results, 400, 400)
```

## Key Functions

- `sigFeature(x, y)`: Main ranking function. Combines SVM weights and t-statistics.
- `sigFeaturePvalue(x, y)`: Calculates p-values for features using Welch's t-test.
- `svmrfeFeatureRanking(x, y)`: Implementation of standard SVM-RFE for comparison.
- `sigFeature.enfold(x, y, ...)`: Performs stratified cross-validation.
- `sigCVError(n, FeatureList, data)`: Calculates cross-validation error for a specific number of features.
- `PlotErrors(errorList, min, max)`: Visualizes mean cross-validation errors and standard deviations.

## Tips for Success

- **Data Scaling**: SVM is sensitive to scale. Ensure your expression data is normalized (e.g., quantile normalization) before processing.
- **Parallel Processing**: Feature elimination is computationally expensive. For large datasets, consider using the `parallel` package if the environment supports it.
- **Feature Subsetting**: If the initial feature count is extremely high (e.g., >20,000 genes), consider a pre-filter step using `sigFeaturePvalue()` to reduce the search space and improve runtime.
- **Kernel Choice**: While `sigFeature` uses linear kernels for ranking, the resulting features can be used with other kernels in the final SVM model.

## Reference documentation

- [sigFeature: Significant feature selection using SVM-RFE & t-statistic](./references/vignettes.md)