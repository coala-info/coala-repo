---
name: bioconductor-iterativebmasurv
description: This tool performs gene selection and survival analysis on high-dimensional microarray data using the iterative Bayesian Model Averaging algorithm. Use when user asks to identify predictive gene subsets for patient survival, account for model uncertainty, predict risk scores, or evaluate survival model performance through cross-validation.
homepage: https://bioconductor.org/packages/release/bioc/html/iterativeBMAsurv.html
---


# bioconductor-iterativebmasurv

name: bioconductor-iterativebmasurv
description: Use this skill to perform gene selection and survival analysis on high-dimensional microarray data using the iterative Bayesian Model Averaging (BMA) algorithm. This skill is appropriate for: (1) Identifying a small subset of genes predictive of patient survival, (2) Accounting for model uncertainty through weighted averaging, (3) Predicting risk scores and categorizing patients into high-risk or low-risk groups, and (4) Performing cross-validation to evaluate model performance.

# bioconductor-iterativebmasurv

## Overview

The `iterativeBMAsurv` package implements an iterative version of the Bayesian Model Averaging (BMA) algorithm specifically for survival analysis on high-dimensional data (where the number of variables/genes greatly exceeds the number of samples). It ranks genes using a univariate Cox Proportional Hazards Model and then iteratively applies BMA to a sliding window of top-ranked genes, discarding those with low posterior probabilities. This process results in a parsimonious set of genes and a weighted ensemble of models for robust survival prediction.

## Core Workflow

### 1. Data Preparation
The package requires a training data matrix (genes in columns, samples in rows), a survival time vector, and a censoring vector (0 = censored, 1 = event).

```r
library(iterativeBMAsurv)
library(BMA)

# Load example data
data(trainData)
data(trainSurv)
data(trainCens)
```

### 2. Training and Gene Selection
Use `iterateBMAsurv.train.wrapper` to identify relevant genes. This function assumes the input data is already sorted by univariate rank (e.g., via Cox log-likelihood).

```r
# nbest specifies the number of models to keep in each BMA iteration
ret.list <- iterateBMAsurv.train.wrapper(x=trainData, surv.time=trainSurv, cens.vec=trainCens, nbest=5)

# Extract results
ret.bic.surv <- ret.list$obj
gene.names <- ret.list$curr.names
top.genes <- gene.names[ret.bic.surv$probne0 > 0]
```

### 3. Prediction and Risk Assessment
Predict risk scores for test samples using the weighted average of the selected models.

```r
# Predict risk scores
y.pred.test <- apply(testData[, top.genes], 1, predictBicSurv, 
                     postprob.vec=ret.bic.surv$postprob, mle.mat=ret.bic.surv$mle)

# Categorize into High vs Low risk (e.g., 50% cutoff)
ret.table <- predictiveAssessCategory(y.pred.test, y.pred.train, testCens, cutPoint=50)
risk.groups <- ret.table$groups
```

### 4. Integrated Analysis
The function `iterateBMAsurv.train.predict.assess` automates the entire pipeline: univariate ranking, iterative BMA training, prediction, and statistical evaluation (p-values and chi-square).

```r
result <- iterateBMAsurv.train.predict.assess(
  train.dat=trainData, test.dat=testData, 
  surv.time.train=trainSurv, surv.time.test=testSurv, 
  cens.vec.train=trainCens, cens.vec.test=testCens, 
  p=100, nbest=20
)
```

## Visualization and Evaluation

### Heatmap of Models
Visualize the relationship between selected genes and models.
```r
imageplot.iterate.bma.surv(ret.list$obj)
```

### Cross-Validation
Evaluate the robustness of the parameters and gene selection.
```r
cv_results <- crossVal(exset=trainData, survTime=trainSurv, censor=trainCens, 
                       diseaseType="DLBCL", noRuns=1, noFolds=5, p=100, nbest=20)
```

## Key Parameters
- `p`: The number of top univariate genes to consider in the iterative process.
- `nbest`: The number of top models to retain in each BMA iteration.
- `maxNvar`: The window size for BMA (default 25).
- `cutPoint`: The percentile used to split high-risk and low-risk groups.

## Reference documentation
- [iterativeBMAsurv](./references/iterativeBMAsurv.md)