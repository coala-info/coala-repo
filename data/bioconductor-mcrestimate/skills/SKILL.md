---
name: bioconductor-mcrestimate
description: This tool estimates misclassification error rates in high-dimensional data using nested cross-validation. Use when user asks to estimate error rates for supervised classification, perform variable selection within a cross-validation loop, or build and apply classifiers for genomic data.
homepage: https://bioconductor.org/packages/3.6/bioc/html/MCRestimate.html
---

# bioconductor-mcrestimate

name: bioconductor-mcrestimate
description: Estimation of misclassification error in high-dimensional data (e.g., microarray) using cross-validation. Use this skill when performing supervised classification tasks in R where you need to estimate error rates, perform variable selection within a cross-validation loop, or build classifiers for new data using methods like Random Forest, PAM, SVM, or PLR.

# bioconductor-mcrestimate

## Overview

The `MCRestimate` package provides a framework for estimating the misclassification rate (MCR) of classification algorithms, particularly in the context of genomic data. Its primary strength is the rigorous use of nested cross-validation, ensuring that preprocessing steps like variable selection are included within the validation loop to avoid selection bias. It supports several popular classification wrappers and allows for parameter tuning.

## Core Workflow

### 1. Data Preparation
The package typically works with `ExpressionSet` objects. You must identify the phenotype column containing the class labels.

```r
library(MCRestimate)
library(golubEsets)
data(Golub_Train)
class.column <- "ALL.AML"
```

### 2. Defining Preprocessing and Parameters
Specify preprocessing methods (e.g., variance-based selection) and the range of parameters to be tested.

```r
# Example: Select top 250 or 1000 genes by variance
Preprocessingfunctions <- c("varSel.highest.var")
list.of.poss.parameter <- list(var.numbers = c(250, 1000))
```

### 3. Estimating Misclassification Error
Use the `MCRestimate` function to perform nested cross-validation.

```r
# Available wrappers: RF.wrap, PAM.wrap, PLR.wrap, SVM.wrap, GPLS.wrap
RF.estimate <- MCRestimate(Golub_Train, 
                           class.column, 
                           classification.fun = "RF.wrap",
                           thePreprocessingMethods = Preprocessingfunctions,
                           poss.parameters = list.of.poss.parameter,
                           cross.outer = 5,   # Number of outer CV folds
                           cross.inner = 5,   # Number of inner CV folds for tuning
                           cross.repeat = 3,  # Number of repetitions
                           plot.label = "Samples")
```

### 4. Visualizing Results
The plot function for an `MCRestimate` object shows the frequency of correct classification for each sample.

```r
plot(RF.estimate, rownames.from.object = TRUE, main = "Classification Accuracy")
```

### 5. Building and Using a Classifier
Once the error rate is estimated and the approach is validated, build a final classifier to predict classes for new data.

```r
# Build the classifier
RF.classifier <- ClassifierBuild(Golub_Train,
                                 class.column,
                                 classification.fun = "RF.wrap",
                                 thePreprocessingMethods = Preprocessingfunctions,
                                 poss.parameters = list.of.poss.parameter,
                                 cross.inner = 5)

# Predict on new data (ExpressionSet)
data(Golub_Test)
predictions <- RF.classifier$classifier.for.exprSet(Golub_Test)
```

## Key Functions and Wrappers

- `MCRestimate()`: Main function for cross-validation error estimation.
- `ClassifierBuild()`: Creates a classifier object for future predictions.
- `RF.wrap`: Wrapper for Random Forest.
- `PAM.wrap`: Wrapper for Prediction Analysis for Microarrays.
- `SVM.wrap`: Wrapper for Support Vector Machines.
- `PLR.wrap`: Wrapper for Penalized Logistic Regression.
- `GPLS.wrap`: Wrapper for Generalized Partial Least Squares.

## Tips for Success

- **Nested CV**: Always use `cross.inner` to tune parameters. If you tune parameters outside of the CV, your error estimates will be optimistically biased.
- **Computational Cost**: Cross-validation is resource-intensive. For initial testing, use small values for `cross.outer` and `cross.repeat`, but increase them (e.g., 5 or 10) for final results.
- **Custom Wrappers**: You can write custom wrappers for other R classification functions by following the signature of existing `.wrap` functions in the package.

## Reference documentation
- [How to use MCRestimate](./references/UsingMCRestimate.md)