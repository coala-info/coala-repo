---
name: bioconductor-logicfs
description: This tool identifies SNP interactions and performs feature selection using logic regression for binary classification tasks. Use when user asks to identify important combinations of binary variables, perform bagged logic regression, or transform SNP data into binary dummy variables.
homepage: https://bioconductor.org/packages/release/bioc/html/logicFS.html
---

# bioconductor-logicfs

name: bioconductor-logicfs
description: Identification of SNP interactions and feature selection using logic regression. Use this skill when analyzing binary or categorical data (especially SNP data) to find Boolean combinations of variables that predict a case-control status, measure interaction importance, or perform bagged logic regression.

# bioconductor-logicfs

## Overview
The `logicFS` package provides tools for identifying interesting combinations of binary variables (interactions) using logic regression as a wrapper. While designed for Single Nucleotide Polymorphism (SNP) data, it is applicable to any binary classification task. It features importance measures for interactions, a bagging version of logic regression, and an implementation of the Quine-McCluskey algorithm for minimizing Boolean expressions.

## Core Workflow

### 1. Data Preparation
Logic regression requires binary predictors. For SNP data (typically coded 1, 2, 3), use `make.snp.dummy` to transform categorical genotypes into binary dummy variables.

```r
library(logicFS)
data(data.logicfs) # Loads data.logicfs (matrix) and cl.logicfs (labels)

# Transform SNPs into binary dummy variables
bin.snps <- make.snp.dummy(data.logicfs)
```

### 2. Feature Selection with logicFS
The `logicFS` function identifies important interactions by fitting multiple logic regression models (Bagging).

```r
# Set annealing parameters to control the search algorithm
my.anneal <- logreg.anneal.control(start = 2, end = -2, iter = 10000)

# Run feature selection
log.out <- logicFS(bin.snps, cl.logicfs, 
                   B = 20,               # Number of logic regression models
                   nleaves = 10,         # Max variables per model
                   rand = 1234,          # Seed for reproducibility
                   anneal.control = my.anneal)

# View the most important interactions
print(log.out)
```

### 3. Bagged Logic Regression
For classification and prediction, use `logic.bagging`. This function performs ensemble learning and calculates out-of-bag (OOB) error rates.

```r
# Fit bagged logic regression
bag.out <- logic.bagging(bin.snps, cl.logicfs, 
                         B = 20, 
                         nleaves = 10, 
                         anneal.control = my.anneal)

# Predict classes for new data
cl.preds <- predict(bag.out, bin.snps)

# Calculate misclassification rate
mean(cl.preds != cl.logicfs)
```

### 4. Visualizing Importance
You can plot the importance of the identified interactions. By default, variables are coded (X1, X2, etc.) to save space.

```r
# Plot variable importance
plot(log.out)

# Plot with original variable names
plot(log.out, coded = FALSE)
```

## Key Functions
- `logicFS()`: Main interface for feature selection and measuring interaction importance.
- `logic.bagging()`: Performs bagged logic regression for classification.
- `make.snp.dummy()`: Converts 1/2/3 genotype coding into binary dummy variables.
- `vim.logicFS()`: Specifically extracts variable importance measures from a logicFS object.
- `predict.logicBagging()`: Predicts the class of new observations using a bagged logic regression model.

## Tips
- **Annealing Control**: The search for logic expressions is stochastic. If results are inconsistent, increase the `iter` parameter in `logreg.anneal.control`.
- **Interpretation**: In the output, `!SNP_1` denotes the negation (NOT) of the first dummy variable for that SNP.
- **Multiple Trees**: By default, a single tree approach is used. You can allow multiple logic trees per model by adjusting the `ntrees` argument in `logicFS` or `logic.bagging`.

## Reference documentation
- [Identifying interesting SNP interactions with logicFS](./references/logicFS.md)