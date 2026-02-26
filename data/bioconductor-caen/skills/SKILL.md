---
name: bioconductor-caen
description: The bioconductor-caen package implements a feature selection method for single-cell RNA-seq data using category number encoding and Spearman correlation. Use when user asks to select differentially expressed genes, estimate classification error rates, or perform zero-inflated Poisson linear discriminant analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/CAEN.html
---


# bioconductor-caen

## Overview

The `CAEN` package implements a feature selection method specifically designed for single-cell RNA-seq (scRNA-seq) data. It operates by encoding category numbers to account for both inter-class differences and intra-category variability. The workflow typically involves data pre-processing, feature selection via Spearman correlation with encoded categories, and classification error estimation using the selected features.

## Core Workflow

### 1. Data Preparation
The package works with `SummarizedExperiment` objects. Ensure your expression data is formatted accordingly, where rows are transcripts/genes and columns are samples.

```r
library(CAEN)
library(SummarizedExperiment)

# Load example data
data("realData")
# x: SummarizedExperiment object
# y: Numeric vector of class labels (e.g., 1, 1, 2, 2)
y <- c(rep(1, 18), rep(2, 18))
```

### 2. Estimating Parameters
Before feature selection, estimate the probability parameters required for the classification model.

```r
# Estimate parameters for training and testing sets
prob <- estimatep(x = realData, y = y, xte = realData, beta = 1, type = "mle")
```

### 3. Feature Selection with CAEN
The `CAEN` function identifies the most differentially expressed genes.

```r
# K: Number of classes
# gene_no_list: Number of top features to select
myscore <- CAEN(dataTable = realData, y = y, K = 2, gene_no_list = 100)

# Results
# myscore$r  : Correlation coefficients for all genes
# myscore$np : Indices of the top selected features
```

### 4. Classification and Error Rate
Use the selected features to perform classification using Zero-Inflated Poisson Linear Discriminant Analysis (ZIPLDA).

```r
# Extract selected features
selected_indices <- myscore$np
datx <- t(assay(realData)[selected_indices, ])
probb <- prob[selected_indices, ]

# Cross-validation to find the best rho (tuning parameter)
zipldacv.out <- ZIPLDA.cv(x = datx, y = y, prob0 = t(probb))

# Final classification
ZIPLDA.out <- ZIPLDA(x = datx, y = y, xte = datx, 
                     transform = FALSE, 
                     prob0 = t(probb), 
                     rho = zipldacv.out$bestrho)

# Predicted classes
classResult <- ZIPLDA.out$ytehat
```

## Simulation Utilities
You can generate synthetic datasets to test workflows using `newCountDataSet`.

```r
# n: samples, p: features, K: classes
dat <- newCountDataSet(n = 100, p = 500, K = 4, param = 10, sdsignal = 2, drate = 0.2)

# Access simulated data
train_data <- dat$sim_train_data
is_de_label <- dat$isDE # True differential gene labels
```

## Usage Tips
- **Category Encoding**: The CAEN method is particularly robust because it considers intra-category differences, making it suitable for heterogeneous single-cell populations.
- **Data Transformation**: When using `ZIPLDA`, the `transform` parameter determines if the data should be transformed. For raw count data, `FALSE` is often appropriate as the model handles the Poisson distribution.
- **Memory**: For very large scRNA-seq datasets, ensure the `SummarizedExperiment` object is handled efficiently, as the correlation calculations can be memory-intensive.

## Reference documentation
- [CAEN Tutorial](./references/CAEN.md)