---
name: bioconductor-mirlab
description: miRLAB automates the pipeline for exploring miRNA-mRNA relationships by applying computational inference methods to matched expression profiles and validating results against experimental evidence. Use when user asks to predict miRNA targets using correlation or causal inference methods, rank miRNA-mRNA interactions, or validate predictions against ground truth datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/miRLAB.html
---


# bioconductor-mirlab

## Overview
miRLAB is a "dry lab" environment for exploring miRNA-mRNA relationships. It automates the pipeline of collecting matched expression profiles, applying computational inference methods, and validating results against experimental evidence. It is particularly useful for researchers comparing different target prediction algorithms or analyzing new TCGA datasets.

## Core Workflow

### 1. Data Preparation
Input data must be a CSV file where rows are samples and columns are miRNAs and mRNAs. The first row must contain gene symbols.

```r
library(miRLAB)
# Load data (returns a matrix)
data_path <- "path/to/your_data.csv"
dataset <- Read(data_path)

# Identify column indices for miRNAs (cause) and mRNAs (effect)
# Example: first 35 columns are miRNAs, rest are mRNAs
cause <- 1:35
effect <- 36:ncol(dataset)
```

### 2. Computational Inference
miRLAB provides several methods to predict miRNA targets. Most follow a consistent syntax: `Method(dataset, cause, effect)`.

*   **Correlation-based:** `Pearson(dataset, cause, effect)` or `Spearman(dataset, cause, effect)`
*   **Information Theory:** `MI(dataset, cause, effect)` (Mutual Information)
*   **Regression-based:** `Lasso(dataset, cause, effect)` or `ElasticPostLasso(dataset, cause, effect)`
*   **Causal Inference:** `IDA(dataset, cause, effect, "stable", 0.01)`

Each function returns a matrix of scores where columns are miRNAs and rows are mRNAs.

### 3. Post-processing and Ranking
After obtaining scores, you can extract top-ranked targets for specific miRNAs or across the entire dataset.

```r
# Get top 10 targets for the 3rd miRNA in the results matrix
# bRank(score_matrix, miRNA_index, top_k, decrease_sorting)
top_targets <- bRank(pearson_results, 3, 10, TRUE)

# Get top 100 interactions across the whole matrix
top_interactions <- Extopk(pearson_results, 100)
```

### 4. Validation
Validate predictions against a ground truth CSV (two columns: miRNA, mRNA).

```r
groundtruth_path <- "path/to/groundtruth.csv"
# Returns the subset of predictions found in the ground truth
confirmed_targets <- Validation(top_targets, groundtruth_path)
```

## Tips and Best Practices
*   **Standardization:** Ensure miRNA and mRNA symbols in your expression data match the symbols used in your ground truth file (e.g., using HGNC symbols).
*   **Method Comparison:** Since no single method is best for all datasets, it is recommended to run multiple methods (e.g., Pearson and Lasso) and compare the overlap of their top predictions.
*   **TCGA Data:** miRLAB includes internal utilities to fetch data; check `getDataTCGA` if working with cancer genomics.

## Reference documentation
- [miRLAB Vignette (Rmd)](./references/miRLAB-vignette.Rmd)
- [miRLAB Vignette (Markdown)](./references/miRLAB-vignette.md)