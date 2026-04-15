---
name: bioconductor-iterativebma
description: This tool performs gene selection and binary classification of high-dimensional microarray data using an iterative Bayesian Model Averaging approach. Use when user asks to identify predictive gene sets, perform classification on transcriptomic data with small sample sizes, or account for model uncertainty in gene expression analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/iterativeBMA.html
---

# bioconductor-iterativebma

name: bioconductor-iterativebma
description: Bayesian Model Averaging (BMA) for gene selection and classification of microarray data. Use this skill when you need to perform binary classification on high-dimensional transcriptomic data (where variables >> samples) using an iterative approach to identify a parsimonious set of predictive genes while accounting for model uncertainty.

# bioconductor-iterativebma

## Overview

The `iterativeBMA` package implements an improved Bayesian Model Averaging algorithm specifically designed for small-sample, high-dimensional data like microarrays. Traditional BMA is limited to ~30 variables; this package overcomes that by iteratively ranking genes (using BSS/WSS) and sliding a window of variables to select the most predictive models. It provides posterior probabilities for both the models and the individual genes, allowing for "soft" classification and assessment of gene importance.

## Typical Workflow

### 1. Data Preparation
The package expects training data as an `ExpressionSet` or a matrix, and class labels as a vector of 0 and 1.

```r
library(iterativeBMA)
library(Biobase)

# Load example data
data(trainData)  # ExpressionSet
data(trainClass) # Vector of 0s and 1s
```

### 2. Training the Model
Use `iterateBMAglm.train` to select relevant genes. The parameter `p` defines how many top-ranked genes (by BSS/WSS) to consider in the iterative process.

```r
# Train the model using the top 100 genes
ret.bic.glm <- iterateBMAglm.train(train.expr.set=trainData, trainClass, p=100)

# View selected genes (those with posterior probability > 0)
selected_genes <- ret.bic.glm$namesx[ret.bic.glm$probne0 > 0]
print(selected_genes)

# View posterior probabilities of the selected models
print(ret.bic.glm$postprob)
```

### 3. Prediction and Evaluation
You can predict class probabilities for new samples using the training results.

```r
data(testData)
data(testClass)

# Method A: Manual prediction using bma.predict
# Subset test data to include only selected genes
curr.test.dat <- t(exprs(testData)[selected_genes,])
y.pred.test <- apply(curr.test.dat, 1, bma.predict, 
                     postprobArr=ret.bic.glm$postprob, 
                     mleArr=ret.bic.glm$mle)

# Method B: All-in-one training and prediction
predictions <- iterateBMAglm.train.predict(trainData, testData, trainClass, p=100)

# Evaluate using Brier Score (lower is better)
score <- brier.score(predictions, testClass)
```

### 4. Visualization
Visualize the relationship between selected genes and models using a heatmap-style plot.

```r
# Create an image plot of the BMA results
imageplot.iterate.bma(ret.bic.glm)
```

## Key Functions and Components

- `iterateBMAglm.train`: The core function for gene selection. Returns a `bic.glm` object.
- `iterateBMAglm.train.predict.test`: A wrapper that performs training, prediction, and returns a summary of errors and Brier scores.
- `bma.predict`: Computes the weighted average of posterior probabilities across models for a single sample.
- `brier.score`: A measure of prediction accuracy; if probabilities are 0 or 1, it equals the number of errors.

**Important Object Fields in `ret.bic.glm`:**
- `namesx`: Names of variables considered in the final iteration.
- `postprob`: Posterior probabilities of the selected models.
- `probne0`: The probability (in percent) that each gene is included in the "true" predictive model.
- `which`: Matrix showing which genes are in which models.

## Tips
- **Binary Only**: This implementation is specifically for binary classification (0/1).
- **Window Size**: The algorithm uses a default window of 30 genes (`maxNvar`) for the underlying `leaps` algorithm.
- **Gene Ranking**: Initial ranking is done via BSS/WSS (Between-group Sum of Squares / Within-group Sum of Squares). Ensure your data is normalized before input.

## Reference documentation
- [iterativeBMA](./references/iterativeBMA.md)