---
name: bioconductor-gsar
description: This tool performs multivariate nonparametric statistical tests for self-contained gene set analysis to identify biological differences between two conditions. Use when user asks to detect differential distribution, mean shifts, changes in variance, or net correlation structure rewiring in gene sets from microarray or normalized RNA-seq data.
homepage: https://bioconductor.org/packages/release/bioc/html/GSAR.html
---


# bioconductor-gsar

name: bioconductor-gsar
description: Multivariate statistical tests for self-contained gene set analysis (GSA). Use when analyzing differential expression of gene sets to detect changes in distribution, mean (shift), variance (scale), or net correlation structure between two biological conditions. Supports microarray and normalized RNA-seq data.

# bioconductor-gsar

## Overview

The GSAR (Gene Set Analysis in R) package provides a suite of multivariate nonparametric statistical tests for self-contained gene set analysis. Unlike competitive methods that compare a gene set against the rest of the genome, GSAR tests whether a specific gene set is differentially expressed between two phenotypes. It is particularly powerful for detecting complex biological changes beyond simple mean shifts, such as changes in variance or the "rewiring" of gene coexpression networks.

## Core Workflow

### 1. Data Preparation
GSAR requires a gene expression matrix (rows as genes, columns as samples) and a group label vector (e.g., 1 for control, 2 for treatment).

```r
library(GSAR)
# object: matrix of gene expression
# group: vector of labels (1 and 2)
# geneSets: list of gene sets (for wrapper functions)
```

### 2. Statistical Testing for a Single Gene Set
Choose a test based on the biological hypothesis:

*   **Differential Distribution**: Use `WWtest` (Wald-Wolfowitz) to detect any change in the multivariate distribution.
*   **Mean Shift**: Use `KStest`, `MDtest`, `ADtest`, or `CVMtest`. These use Minimum Spanning Tree (MST) ranking to detect shifts in the mean expression vector.
*   **Differential Variance (Scale)**: Use `RKStest`, `RMDtest`, `RADtest`, `RCVMtest`, or `AggrFtest`. These detect changes in the spread or scale of expression.
*   **Net Correlation Structure**: Use `GSNCAtest` to detect changes in the coexpression network (rewiring).

```r
# Example: Testing for differential coexpression
p_val <- GSNCAtest(target.pathway.matrix, group.label)
```

### 3. Analyzing Multiple Gene Sets
Use the `TestGeneSets` wrapper to apply a specific test across a list of pathways (e.g., from MSigDB).

```r
results <- TestGeneSets(
  object = expression_matrix,
  group = group_labels,
  geneSets = pathway_list,
  min.size = 10,
  max.size = 500,
  test = "GSNCAtest"
)
```

### 4. Network Visualization
Visualize the correlation structure using the `MST2` (union of the first and second Minimum Spanning Trees). This highlights "hub" genes that are highly correlated with others.

```r
plotMST2.pathway(
  object = pathway_matrix,
  group = group_labels,
  name = "Pathway_Name",
  cor.method = "pearson"
)
```

## Handling RNA-seq Data

GSAR tests are nonparametric and can be applied to RNA-seq data if properly normalized (e.g., RPKM, CPM, or log-transformed normalized counts).

*   **Zero Variance**: `GSNCAtest` will fail if a gene has zero standard deviation (common in RNA-seq with many zeros). Filter out genes with near-zero variance before testing.
*   **Permutation Skips**: If permutations result in zero-variance subsets, use the `max.skip` parameter in `GSNCAtest` to allow the test to continue.

## Tips for Interpretation

*   **Hub Genes**: In `GSNCAtest`, genes with high weight factors (typically > 1.0) are "hubs" that strongly influence the network structure. A change in the hub gene between conditions indicates significant biological rewiring.
*   **Self-contained vs. Competitive**: Remember that GSAR is self-contained. A significant p-value means the gene set itself changes between conditions, regardless of what the rest of the genome is doing.

## Reference documentation

- [Gene Set Analysis in R – the GSAR Package](./references/GSAR.md)