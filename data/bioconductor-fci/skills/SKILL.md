---
name: bioconductor-fci
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/fCI.html
---

# bioconductor-fci

## Overview

The `fCI` package implements the f-divergence Cutoff Index to identify differentially expressed genes (DEGs). Unlike methods that rely on large sample sizes for statistical power, fCI identifies DEGs by comparing the distribution of fold-changes between control-control replicates (the null hypothesis/system noise) and case-control pairs. It is highly versatile, supporting raw counts, normalized expression (RPKM/FPKM), and ratio data across multiple "omics" platforms simultaneously.

## Core Workflow

### 1. Data Preparation and Normalization
Input data should be a data frame or matrix with genes as rows and samples as columns.

```r
library(fCI)

# Example: Total library size normalization for raw counts
normalized_data <- total.library.size.normalization(raw_counts_df)

# Example: Trimmed sum normalization (removes top/bottom 5% outliers)
trimmed_data <- trim.size.normalization(raw_counts_df)
```

### 2. Finding DEGs (Standard Analysis)
The primary function is `find.fci.targets`. You must specify the column indices for control and case samples.

```r
# Initialize the NPCI object
fci_obj <- new("NPCI")

# Perform analysis
# control_cols: e.g., c(1,2,3), case_cols: e.g., c(4,5,6)
fci_obj <- find.fci.targets(fci_obj, control_cols, case_cols, data_source)

# Extract results
degs <- show.targets(fci_obj)
head(degs)
```

### 3. Multi-dimensional / Proteogenomic Analysis
fCI can integrate different data types (e.g., RNA-seq and Proteomics) by passing lists of indices.

```r
# Example: Integrating Proteomics (cols 1-2 control, 5-6 case) 
# and Transcriptomics (cols 7-8 control, 11-12 case)
fci_obj <- find.fci.targets(fci_obj, 
                            list(1:2, 7:8),   # Control indices for both dimensions
                            list(5:6, 11:12), # Case indices for both dimensions
                            "data_file.txt")
```

### 4. Visualization and Interpretation
Use the `figures()` function to view the kernel density plots comparing the control-control (noise) and case-control distributions.

```r
figures(fci_obj)
```
*   **fCI_Prob_Score**: In the output table, this represents the frequency a gene was identified as a DEG across all pairwise combinations. A score of 1.0 means it was found in 100% of pairs.
*   **Divergence**: The algorithm seeks a local minimum of f-divergence (default: Hellinger distance) to determine the fold-change cutoff.

## Advanced Configuration
You can manually set runtime variables such as specific fold-change cutoffs to test or toggle kernel density centering.

```r
fci_obj <- setfCI(fci_obj, 
                  ctrl_idx = 7:8, 
                  case_idx = 11:12, 
                  f_range = seq(1.1, 3.0, by=0.1), 
                  center = TRUE)
```

## Tips for Success
*   **Small Sample Sizes**: fCI is specifically designed to work effectively with very few replicates (even n=2).
*   **Data Types**: Ensure your input is "Tab" delimited if loading from a file, or a standard R data frame.
*   **Null Results**: If `show.targets()` returns "No differentially expressed genes are found!", it indicates the case-control distribution does not significantly deviate from the control-control noise distribution.

## Reference documentation
- [fCI](./references/fCI.md)