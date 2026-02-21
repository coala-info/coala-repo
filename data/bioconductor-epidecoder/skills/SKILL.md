---
name: bioconductor-epidecoder
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/epidecodeR.html
---

# bioconductor-epidecoder

## Overview

The `epidecodeR` package integrates epigenomic/epitranscriptomic event data with differential expression data. It tests the hypothesis that genes with a higher degree of chemical modification (e.g., more m6A peaks or histone marks) show significant shifts in their log2 fold-change (log2FC) distributions compared to genes with fewer or no modifications.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("epidecodeR")
library(epidecodeR)
```

## Core Workflow

### 1. Prepare Input Data
The package requires two primary inputs:
*   **Events Data**: Either a `.txt` file (columns: `id`, `counts`) or a `.bed` file (columns: `chr`, `start`, `end`, and optionally `id` in the 4th column).
*   **DEG Data**: A three-column file (columns: `id`, `log2foldchange`, `p-value`).

**Note**: IDs must match exactly between files (e.g., Ensembl versions like `.9` vs `.10` will fail to map).

### 2. Run Integration Analysis
Use the `epidecodeR()` function to group genes by event density and calculate cumulative probabilities.

```r
# Example using BED file and DEG list
epiobj <- epidecodeR(
  events = "path/to/peaks.bed",
  deg = "path/to/deg.txt",
  pval = 0.05,      # P-value cutoff for DEG inclusion
  param = 3,        # Grouping strategy (1, 2, or 3)
  ints = c(2, 4)    # Intervals for groups (e.g., 0, 1, 2-4, 5+)
)
```

**Grouping Parameters (`param`):**
*   `1`: [0 events] vs [1+ events]
*   `2`: [0 events], [1-N events], [(N+1)+ events]
*   `3`: [0 events], [1 event], [2-N events], [(N+1)+ events]
*   `ints`: Defines the value of `N`.

### 3. Visualization
Generate Cumulative Distribution Function (CDF) plots and boxplots to visualize shifts in log2FC.

```r
# CDF Plot
makeplot(epiobj, 
         lim = c(-5, 5), 
         title = "Impact of m6A on Expression", 
         xlab = "log2FC", 
         type = "both") # 't' for theoretical, 'e' for empirical, 'both'

# Boxplot with ANOVA/Tukey significance results
plot_test(epiobj, 
          title = "Significance Testing", 
          ylab = "log2FC")
```

### 4. Accessing Results
The `epidecodeR` object contains processed tables and statistical tests.

```r
# Get gene counts per group
get_grpcounts(epiobj)

# Get specific gene lists for a group (e.g., group "5+")
tables <- get_grptables(epiobj)
high_mod_genes <- tables$'5+'

# Get statistical tables
theoretical <- get_theoretical_table(epiobj)
empirical <- get_empirical_table(epiobj)
```

## Advanced Options

*   **GTF Integration**: If using a BED file without IDs, provide a `gtf_file` and `id_type` (e.g., "gene_name") to map coordinates to genes.
*   **Promoter Regions**: Use the `boundaries` argument (numeric) to extend gene coordinates upstream/downstream when counting overlaps with BED peaks.

## Reference documentation

- [epidecodeR: a functional exploration tool for epigenetic and epitranscriptomic regulation](./references/epidecodeR.Rmd)
- [epidecodeR: a functional exploration tool for epigenetic and epitranscriptomic regulation](./references/epidecodeR.md)