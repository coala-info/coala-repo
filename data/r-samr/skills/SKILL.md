---
name: r-samr
description: The r-samr tool performs Significance Analysis of Microarrays to identify differentially expressed genes in microarray and sequencing data while controlling the False Discovery Rate. Use when user asks to identify significant features in genomic data, perform differential expression analysis, calculate False Discovery Rates via permutations, or analyze two-class, multiclass, quantitative, and survival outcomes.
homepage: https://cran.r-project.org/web/packages/samr/index.html
---

# r-samr

name: r-samr
description: Significance Analysis of Microarrays (SAM) for differential expression analysis in microarray and RNA-seq data. Use this skill to identify significant features (genes) correlated with various outcomes (two-class, multiclass, quantitative, survival, time-course) while controlling the False Discovery Rate (FDR).

## Overview

The `samr` package implements Significance Analysis of Microarrays (SAM), a statistical technique for determining whether changes in gene expression are statistically significant. It uses permutations to estimate the False Discovery Rate (FDR). It supports both traditional microarray data (Gaussian-based) and sequencing data (count-based via `SAMseq`).

## Installation

```R
install.packages("samr")
library(samr)
```

## Core Workflows

### 1. Simple Interface (Recommended)
For most users, the high-level `SAM` (for arrays) or `SAMseq` (for sequencing) functions are preferred as they wrap the estimation, delta table calculation, and significant gene identification into a single object.

**Microarray Example (Two-class unpaired):**
```R
# x: matrix (genes x samples), y: vector of 1s and 2s
samfit <- SAM(x, y, resp.type="Two class unpaired", nperms=100)

# View significant genes and plot
print(samfit)
plot(samfit)
```

**Sequencing Example (RNA-seq counts):**
```R
# x: matrix of raw counts, y: outcome vector
samfit <- SAMseq(x, y, resp.type="Two class unpaired", nperms=100)
print(samfit)
plot(samfit)
```

### 2. Advanced Manual Workflow
Use the `samr` core engine for finer control over the analysis steps.

1.  **Initialize Analysis:**
    ```R
    data <- list(x=x, y=y, geneid=as.character(1:nrow(x)), 
                 genenames=paste0("gene", 1:nrow(x)), logged2=TRUE)
    samr.obj <- samr(data, resp.type="Two class unpaired", nperms=100)
    ```
2.  **Compute Delta Table:** Evaluate FDR at different thresholds (delta).
    ```R
    delta.table <- samr.compute.delta.table(samr.obj)
    ```
3.  **Identify Significant Genes:** Choose a delta (e.g., 0.4) based on the desired FDR.
    ```R
    siggenes.table <- samr.compute.siggenes.table(samr.obj, del=0.4, data, delta.table)
    # Access results: siggenes.table$genes.up and siggenes.table$genes.lo
    ```
4.  **Visualize:**
    ```R
    samr.plot(samr.obj, del=0.4)
    ```

## Response Types (`resp.type`)

| Type | Description | `y` Format |
| :--- | :--- | :--- |
| `Two class unpaired` | Comparison of two independent groups | 1s and 2s |
| `Two class paired` | Comparison of two related groups | -1, 1, -2, 2 (pairs share abs value) |
| `Multiclass` | Comparison of 3+ groups | 1, 2, 3, ... |
| `Quantitative` | Correlation with continuous variable | Numeric vector |
| `Survival` | Time-to-event analysis | Numeric time; requires `censoring.status` |
| `One class` | Test if mean is different from 0 | Vector of 1s |
| `Timecourse` | Analysis of longitudinal data | Specific string format (e.g., "1Time1Start") |
| `Pattern discovery` | Eigengene-based analysis | No `y` required; uses `eigengene.number` |

## Key Functions

- `SAM()`: Simple wrapper for microarray data.
- `SAMseq()`: Simple wrapper for sequencing (count) data.
- `samr()`: The main engine for SAM analysis.
- `samr.compute.delta.table()`: Generates a table of FDR values for various delta thresholds.
- `samr.compute.siggenes.table()`: Extracts the list of significant genes for a specific delta.
- `samr.assess.samplesize()`: Estimates power and FDR for various sample sizes.
- `samr.plot()`: Generates the SAM Q-Q plot.
- `runSAM()`: Launches a Shiny-based graphical user interface.

## Tips and Best Practices

- **Data Transformation:** For `assay.type="array"`, data should generally be log-transformed. For `assay.type="seq"`, provide raw counts; `samr` handles normalization internally via `samr.estimate.depth`.
- **Missing Values:** `samr` can handle missing values in `x` using K-Nearest Neighbors (default `knn.neighbors=10`).
- **Permutations:** Use at least `nperms=100` for publication-quality FDR estimates.
- **Fold Change:** You can enforce a minimum fold change requirement using the `min.foldchange` argument in `samr.compute.siggenes.table`.
- **Survival Data:** When using `resp.type="Survival"`, `y` must be the time and `censoring.status` must be 1 for event/death and 0 for censored.

## Reference documentation

- [SAM: Significance Analysis of Microarrays](./references/reference_manual.md)