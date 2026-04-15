---
name: bioconductor-dream4
description: The bioconductor-dream4 package provides synthetic gene regulatory network datasets and gold standard adjacency matrices from the DREAM4 challenge for benchmarking network inference algorithms. Use when user asks to access DREAM4 synthetic expression data, load gene regulatory network gold standards, or benchmark network inference software using simulated time series and knockout data.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/DREAM4.html
---

# bioconductor-dream4

## Overview
The `DREAM4` package provides 10 synthetic gene regulatory datasets used in the 2009 DREAM4 challenge. These datasets include five 10-node networks and five 100-node networks. Each dataset is stored as a `RangedSummarizedExperiment` containing both the simulated expression data and the "gold standard" adjacency matrix used to generate it. This allows for the rigorous assessment of network inference software (like `networkBMA`) by comparing inferred edges against known biological ground truth.

## Loading Data
The package contains 10 datasets named `dream4_010_01` through `dream4_010_05` (10-node) and `dream4_100_01` through `dream4_100_05` (100-node).

```r
library(DREAM4)
library(SummarizedExperiment)

# Load a specific dataset (e.g., 10-node network 1)
data(dream4_010_01)

# Inspect the object
show(dream4_010_01)

# Access the combined expression matrix (rows=genes, cols=experiments)
mtx.all <- assays(dream4_010_01)[[1]]

# Access the gold standard adjacency matrix
mtx.goldStandard <- metadata(dream4_010_01)[[1]]
```

## Data Structure and Extraction
Because `RangedSummarizedExperiment` requires uniform dimensions, all experimental conditions (time series, knockouts, etc.) are merged into a single assay matrix. Use string matching on column names to extract specific experiment types.

### Extracting Time Series
Time series data typically consists of 21 time points (t0 to t1000).
```r
# Extract the first perturbation time series
ts1.cols <- grep("perturbation.1.", colnames(mtx.all), fixed=TRUE)
mtx.ts1 <- mtx.all[, ts1.cols]

# For networkBMA, transpose so columns are genes and rows are time points
mtx.ts1_input <- t(mtx.ts1)
```

### Extracting Knockouts and Knockdowns
- **Knockouts (.ko)**: Transcription rate set to zero.
- **Knockdowns (.kd)**: Transcription rate reduced by half.
```r
# Extract all knockout columns
ko.cols <- grep(".ko", colnames(mtx.all), fixed=TRUE)
mtx.ko <- mtx.all[, ko.cols]
```

## Workflow: Network Inference Benchmarking
A typical workflow involves inferring a network from the expression data and validating it against the gold standard.

### 1. Prepare Gold Standard Table
Convert the adjacency matrix into a data frame of regulators and targets.
```r
mtx.gs <- metadata(dream4_010_01)[[1]]
idx <- which(mtx.gs == 1, arr.ind = TRUE)
tbl.gs <- data.frame(
  Regulator = rownames(mtx.gs)[idx[,1]],
  Target = colnames(mtx.gs)[idx[,2]],
  stringsAsFactors = FALSE
)
```

### 2. Run Inference (Example using networkBMA)
```r
library(networkBMA)
# Use time series data prepared earlier
# nTimePoints must match the number of rows in the transposed matrix
results <- networkBMA(mtx.ts1_input, nTimePoints=nrow(mtx.ts1_input), self=FALSE)
```

### 3. Assessment
Use the `networkBMA` assessment functions to calculate Precision and Recall.
```r
# Create contingency table
tbl.contingency <- contabs.netwBMA(results, tbl.gs)

# Calculate scores and Area Under Precision-Recall Curve (AUPR)
pr_scores <- scores(tbl.contingency, what = c("precision", "recall"))
aupr <- prc(tbl.contingency, plotit = TRUE)
```

## Tips for Success
- **Self-Edges**: The DREAM4 gold standards do not contain self-regulatory loops. Ensure your inference algorithm is configured to ignore self-edges (e.g., `self=FALSE`).
- **Priors**: You can simulate the effect of prior knowledge (like ChIP-seq data) by taking a subset of the gold standard, adding noise, and passing it to Bayesian inference tools as a `prior.prob` matrix.
- **Multifactorial Data**: Only the 100-node networks include multifactorial data (steady-state variations). These are useful for algorithms that do not require time-series information.

## Reference documentation
- [DREAM4](./references/DREAM4.md)
- [In Silico Network Challenge Description](./references/DREAM4_InSilico_Description.md)