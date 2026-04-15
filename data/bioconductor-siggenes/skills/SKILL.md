---
name: bioconductor-siggenes
description: This tool identifies differentially expressed genes in high-dimensional genomic data using Significance Analysis of Microarrays (SAM) and Empirical Bayes Analysis of Microarrays (EBAM). Use when user asks to identify significant variables, estimate False Discovery Rate, perform SAM or EBAM analysis, or find differentially expressed genes across experimental conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/siggenes.html
---

# bioconductor-siggenes

name: bioconductor-siggenes
description: Perform Significance Analysis of Microarrays (SAM) and Empirical Bayes Analysis of Microarrays (EBAM) to identify differentially expressed genes and estimate False Discovery Rate (FDR). Use this skill when analyzing high-dimensional genomic data (e.g., microarray, SNP) to find significant variables across different experimental conditions (one-class, two-class paired/unpaired, multi-class, or categorical).

# bioconductor-siggenes

## Overview

The `siggenes` package provides tools for identifying differentially expressed genes in high-dimensional data. It implements two major methodologies:
1.  **SAM (Significance Analysis of Microarrays):** A non-parametric approach that uses permutations to estimate the FDR and identifies significant genes based on a threshold $\Delta$ (distance between observed and expected scores).
2.  **EBAM (Empirical Bayes Analysis of Microarrays):** A Bayesian approach that models the distribution of test statistics as a mixture of null and non-null components, identifying genes based on posterior probabilities.

## Core Workflows

### 1. SAM Analysis (Significance Analysis of Microarrays)

Use `sam()` for the primary analysis. It automatically detects the experimental design based on the `cl` (class labels) vector.

```R
library(siggenes)

# Basic SAM analysis (Two-class unpaired)
# data: matrix/ExpressionSet (rows=genes, cols=samples)
# cl: 0 and 1 for groups
sam.out <- sam(data, cl, rand = 123)

# View summary table for various Delta values
print(sam.out)

# Find Delta for a specific FDR target
findDelta(sam.out, fdr = 0.05)

# Get gene-specific info for a chosen Delta (e.g., Delta = 1.2)
sum.sam <- summary(sam.out, 1.2)
head(sum.sam@mat.sig) # Matrix of significant genes
```

### 2. EBAM Analysis (Empirical Bayes)

EBAM typically requires finding an optimal fudge factor ($a_0$) first using `find.a0()`.

```R
# 1. Find optimal fudge factor a0
find.out <- find.a0(data, cl, rand = 123)
plot(find.out) # Visualize logit-transformed posterior probabilities

# 2. Run EBAM using the suggested a0
ebam.out <- ebam(find.out)

# 3. View results for a specific posterior probability threshold (delta)
# Note: In EBAM, delta is a probability (e.g., 0.9)
summary(ebam.out, delta = 0.9)
```

## Class Label Specifications (`cl`)

The package identifies the analysis type based on the `cl` argument:
*   **One-class:** Vector of 1s.
*   **Two-class unpaired:** Vector of 0s and 1s.
*   **Two-class paired:** Vector of integers where pairs are $k$ and $-k$ (e.g., `c(-1, -2, 1, 2)`).
*   **Multi-class:** Integers $1, 2, \dots, g$.
*   **Categorical (SNPs):** Integers $1, 2, 3$ (for genotypes).

## Visualization and Interaction

*   **SAM Plot:** `plot(sam.out, delta = 1.5)` generates the observed vs. expected plot.
*   **Interactive Identification:** `identify(sam.out)` allows clicking on points in a SAM plot to see gene names.
*   **Delta Plot:** `plot(sam.out)` (without a specific delta) shows FDR and number of genes vs. Delta.
*   **EBAM Plot:** `plot(ebam.out, delta = 0.9)` shows posterior probabilities.

## Exporting Results

*   **Excel:** `sam2excel(sam.out, delta = 1.5, file = "results.csv")`
*   **HTML:** `sam2html(sam.out, delta = 1.5, filename = "results.html")` (can include links to Entrez/NCBI if `chip` is provided).

## Tips for Success

*   **Reproducibility:** Always set the `rand` argument in `sam()`, `ebam()`, or `find.a0()` because these methods rely on permutations.
*   **Method Selection:** Use `method = wilc.stat` for Wilcoxon rank-sum (non-parametric) or `method = d.stat` (default) for moderated t-statistics.
*   **Fudge Factor:** In SAM, the fudge factor $s_0$ is calculated automatically to minimize the coefficient of variation of the median absolute deviation of the scores.

## Reference documentation

- [identify.sam](./references/identify.sam.md)
- [plot.ebam](./references/plot.ebam.md)
- [plot.finda0](./references/plot.finda0.md)
- [plot.sam](./references/plot.sam.md)
- [print.ebam](./references/print.ebam.md)
- [print.finda0](./references/print.finda0.md)
- [print.sam](./references/print.sam.md)
- [siggenes](./references/siggenes.md)
- [siggenesRnews](./references/siggenesRnews.md)
- [summary.ebam](./references/summary.ebam.md)
- [summary.sam](./references/summary.sam.md)