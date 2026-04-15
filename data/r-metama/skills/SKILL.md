---
name: r-metama
description: This tool performs meta-analysis of transcriptomic data to identify differentially expressed genes across multiple studies. Use when user asks to combine p-values from independent experiments, integrate moderated effect sizes, or find common differentially expressed genes across heterogeneous datasets.
homepage: https://cran.r-project.org/web/packages/metama/index.html
---

# r-metama

name: r-metama
description: Meta-analysis of microarray data to identify differentially expressed genes (DEGs). Use this skill when combining results from multiple independent transcriptomic studies using p-value combination or moderated effect size integration.

# r-metama

## Overview
The metaMA package provides functions to combine transcriptomic data from different studies. It specifically handles the integration of either p-values or modified effect sizes to improve the statistical power in finding differentially expressed genes across heterogeneous datasets.

## Installation
To install the package from CRAN:
install.packages("metaMA")

## Main Workflows

### 1. Data Preparation
The package expects data from multiple studies to be organized into lists:
- A list of expression matrices (genes in rows, samples in columns).
- A list of class labels (e.g., 0 for control, 1 for treatment).
- Genes must be matched across all studies (same row names/order).

### 2. P-value Combination
Use this approach to combine significance levels from individual studies.
- Function: pvalcombination(data, labels, method)
- Methods: "fisher" (default) or "stouffer".
- Returns: Combined p-values and FDR-adjusted values for each gene.

Example:
library(metaMA)
# data_list is a list of matrices, labels_list is a list of group vectors
result <- pvalcombination(data = data_list, labels = labels_list)
de_genes <- which(result$adjp < 0.05)

### 3. Effect Size Combination
Use this approach to integrate moderated effect sizes, which is often more robust than p-value combination.
- Function: EScombination(data, labels)
- This method calculates moderated effect sizes for each study and then combines them.
- Returns: Combined effect sizes, p-values, and adjusted p-values.

Example:
result_es <- EScombination(data = data_list, labels = labels_list)
significant_genes <- result_es$DifferentialAnalysis

### 4. Working with P-values directly
If you already have p-values from different studies (e.g., from limma or other tests), use:
- rowPvalCombined(p_matrix, method): Where p_matrix is a matrix with genes in rows and studies in columns.

## Tips for Success
- ID Mapping: Ensure all datasets use the same gene identifiers (e.g., Entrez IDs or Gene Symbols) before running the combination functions.
- Filtering: It is recommended to filter out low-expression genes or non-informative probes within each study before meta-analysis to reduce the multiple testing burden.
- SMVar Integration: metaMA can use the SMVar (Structural Model for Variances) approach for better variance estimation in small sample sizes.

## Reference documentation
- [metaMA Home Page](./references/home_page.md)