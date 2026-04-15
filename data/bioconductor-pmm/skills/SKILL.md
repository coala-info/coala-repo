---
name: bioconductor-pmm
description: This tool fits the Parallel Mixed Model to identify hits and compare results across multiple RNAi screening conditions. Use when user asks to identify hits in high-throughput screens, estimate local false discovery rates for gene knock-downs, or visualize sharedness across different pathogens or cell lines.
homepage: https://bioconductor.org/packages/release/bioc/html/pmm.html
---

# bioconductor-pmm

name: bioconductor-pmm
description: Fits the Parallel Mixed Model (PMM) for hit selection and cross-comparison of RNAi screens performed under multiple conditions. Use this skill when analyzing high-throughput screening data (like infection rates or cell counts) where genes are targeted by multiple independent siRNAs across different pathogens or cell lines.

## Overview

The `pmm` package implements a statistical framework for identifying "hits" in parallel RNAi screens. It combines a linear mixed model (LMM) with local False Discovery Rate (fdr) estimation. It is particularly effective for gaining statistical power by simultaneously considering knock-down effects across all conditions while accounting for siRNA-specific variability.

## Core Workflow

### 1. Data Preparation
Input data must be a `data.frame` where each row is an independent RNAi experiment.
*   **Required Columns**: Gene identifier, Condition (e.g., pathogen), and Readout (numeric).
*   **Replicates**: Biological replicates (identical siRNA + identical condition) should be averaged before input.
*   **Multiple siRNAs**: The model expects multiple independent siRNAs (different seeds) per gene.

### 2. Fitting the Model
Use the `pmm()` function to estimate gene effects ($c_{cg}$) and local FDR.

```r
library(pmm)
data(kinome) # Example dataset

# Basic fit
fit <- pmm(kinome, 
           readout = "InfectionIndex", 
           gene.col = "GeneName", 
           condition.col = "condition")

# View results (GeneID, ccg.Condition, fdr.Condition)
head(fit)
```

**Key Parameters:**
*   `readout`: Column name of the measurement.
*   `gene.col`: Column name for gene identifiers.
*   `condition.col`: Column name for conditions.
*   `weight`: (Optional) Column name for RNAi weights based on library quality.
*   `ignore`: (Optional) Minimum number of siRNA replicates required per gene to be included.
*   `simplify`: If `FALSE`, returns a list containing the matrix, the raw LMM fit, and individual random effects ($a_g$ and $b_{cg}$).

### 3. Interpreting Results
*   **$c_{cg}$ effect**: A positive value indicates the readout increased upon knock-down; a negative value indicates it decreased.
*   **fdr**: Local False Discovery Rate. Lower values indicate higher confidence in the hit.

### 4. Visualization
The `hitheatmap()` function creates a color-coded summary of effects.

```r
# Visualize hits with FDR < 0.2
hitheatmap(fit, threshold = 0.2)

# Include sharedness score in the heatmap
hitheatmap(fit, threshold = 0.2, sharedness.score = TRUE)
```
*   **Red**: Positive effect.
*   **Blue**: Negative effect.
*   **Yellow Star**: Significant hit based on the threshold.

### 5. Sharedness Score
The sharedness score ($sh_g$) ranges from 0 to 1, indicating if a gene is a hit in a single condition (0) or consistently across all conditions (1).

```r
sh <- sharedness(fit, threshold = 0.2)
# Results include GeneID and Sharedness value
```

## Tips for Success
*   **Z-Scoring**: If your data is Z-scored, the fixed effect for conditions ($\mu_c$) will typically be near 0.
*   **Missing Data**: `pmm` handles missing combinations (e.g., a gene not tested in one specific condition) by returning `NA` for those cells.
*   **Customizing Plots**: `hitheatmap` accepts standard graphical parameters like `cex.axis`, `mar`, and `main`. Use `na.omit = TRUE` to hide incomplete gene-condition sets.

## Reference documentation
- [Fitting the Parallel Mixed Model with the PMM R-package](./references/pmm-package.md)