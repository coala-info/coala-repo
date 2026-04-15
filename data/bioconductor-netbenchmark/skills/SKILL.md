---
name: bioconductor-netbenchmark
description: The netbenchmark package provides a standardized framework for evaluating and comparing gene regulatory network inference algorithms using various data sources and performance metrics. Use when user asks to benchmark gene regulatory network inference methods, evaluate algorithm performance using precision-recall curves, or integrate custom network inference wrappers into a testing pipeline.
homepage: https://bioconductor.org/packages/3.8/bioc/html/netbenchmark.html
---

# bioconductor-netbenchmark

## Overview

The `netbenchmark` package provides a standardized framework for evaluating gene regulatory network (GRN) inference algorithms. It addresses the challenge of high-heterogeneity in biological data by allowing users to test multiple methods against various data sources (simulated or real) with minimal code. The package includes several built-in state-of-the-art algorithms and supports the integration of custom methods via wrapper functions.

## Core Workflow

### 1. Basic Benchmarking
The primary function is `netbenchmark()`. It automates data sampling, noise addition, network inference, and performance evaluation.

```r
library(netbenchmark)

# Run a benchmark using all available methods on a toy dataset
results <- netbenchmark(
  methods = "all",           # Options: "all", "all.fast", or specific names
  datasources.names = "Toy", # Data source from grndata package
  datasets.num = 2,          # Number of datasets to generate
  experiments = 40,          # Number of experiments per dataset
  local.noise = 20,          # Local noise level
  global.noise = 10,         # Global noise level
  verbose = FALSE
)
```

### 2. Evaluating Results
The function returns a list where the first element is typically the $AUPR_{20}$ (Area Under Precision-Recall curve for the top 20% of possible edges).

```r
# View AUPR results
aupr_table <- results[[1]]
print(aupr_table)

# Extract just the scores (excluding metadata columns)
scores <- aupr_table[, -(1:2)]
boxplot(scores, main="Method Comparison", ylab="AUPR20")
```

### 3. Custom Method Integration
To test a new algorithm, create a wrapper function that accepts a data matrix and returns a weighted adjacency matrix with named rows and columns.

```r
# Define a custom wrapper (e.g., simple Spearman correlation)
Spearmancor <- function(data) {
  cor(data, method = "spearman")
}

# Run benchmark with custom and built-in methods
comp <- netbenchmark(
  datasources.names = "syntren300",
  methods = c("all.fast", "Spearmancor"),
  verbose = FALSE
)
```

### 4. Visualizing Precision-Recall Curves
The package stores detailed PR data in the returned list (typically the 5th element).

```r
# Plot mean PR curves for the first datasource
PR_data <- comp[[5]][[1]]
plot(PR_data$rec[,1], PR_data$pre[,1], type="l", xlab="Recall", ylab="Precision")
# Add lines for other methods
lines(PR_data$rec[,2], PR_data$pre[,2], col="red")
```

## Key Parameters for `netbenchmark()`
- `methods`: Character vector. Use `"all"` for all methods, `"all.fast"` for computationally efficient ones, or a vector of function names.
- `datasources.names`: Names of datasets (usually from the `grndata` package, e.g., "Toy", "syntren300", "gnw2000").
- `noiseType`: Type of noise to add (e.g., `"normal"`, `"lognormal"`).
- `experiments`: Number of samples/experiments to use from the datasource.

## Tips
- **Data Dependencies**: `netbenchmark` relies heavily on the `grndata` package for source networks and expression data.
- **Performance**: Some methods (like those in `"all"`) are computationally expensive. Use `"all.fast"` for quick iterations or large networks.
- **Matrix Format**: Ensure custom wrappers return a square matrix where `rownames(result)` and `colnames(result)` match the input data column names.

## Reference documentation
- [Netbenchmark](./references/netbenchmark.md)