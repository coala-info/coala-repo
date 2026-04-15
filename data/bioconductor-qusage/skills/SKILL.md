---
name: bioconductor-qusage
description: This tool performs gene set enrichment analysis by accounting for inter-gene correlations and calculating a complete probability density function for gene set activity. Use when user asks to perform gene set enrichment analysis, account for variance inflation factors, handle paired samples or linear mixed models in pathway analysis, combine results across studies via meta-analysis, or visualize gene set activity distributions.
homepage: https://bioconductor.org/packages/release/bioc/html/qusage.html
---

# bioconductor-qusage

name: bioconductor-qusage
description: Quantitative Set Analysis for Gene Expression (qusage). Use this skill to perform gene set enrichment analysis (GSEA) that accounts for inter-gene correlations using a Variance Inflation Factor (VIF) and quantifies gene set activity with a complete probability density function (PDF). Use when analyzing microarray or RNA-seq data to compare gene set activity between groups, handle paired samples, perform meta-analysis across studies, or visualize pathway-level distributions.

# bioconductor-qusage

## Overview
The `qusage` package implements a statistical method for gene set enrichment that provides a more nuanced view than simple p-values. It calculates a complete Probability Density Function (PDF) for each gene set, allowing for better quantification of gene set activity and post-hoc comparisons. It is particularly robust because it accounts for inter-gene correlations (via VIF) and can handle complex experimental designs including paired samples and linear mixed models.

## Core Workflow

### 1. Basic Analysis
The simplest entry point is the `qusage` wrapper function, which performs gene-level comparisons, aggregates data into gene sets, and calculates VIF in one step.

```r
library(qusage)

# Inputs: 
# eset: Matrix of log2 expression or ExpressionSet
# labels: Character vector of group labels (e.g., "control", "treatment")
# contrast: String defining the comparison (e.g., "treatment-control")
# geneSets: List of character vectors (gene symbols/IDs)

qs.results <- qusage(eset, labels, contrast, geneSets)

# Extract results
p.vals <- pdf.pVal(qs.results)
q.vals <- p.adjust(p.vals, method="fdr")
table <- qsTable(qs.results, number=10)
```

### 2. Handling Complex Designs
*   **Paired Samples:** Provide a `pairVector` (e.g., patient IDs) to the `qusage` function.
    ```r
    qs.results <- qusage(eset, labels, contrast, geneSets, pairVector=patientIds)
    ```
*   **Linear Mixed Models (qgen):** Use `qgen` for longitudinal data or when adjusting for covariates (Age, Gender).
    ```r
    # design: dataframe with metadata
    # fixed: formula for fixed effects
    # contrast.factor: the factor in the formula to test
    results <- qgen(eset, design, fixed=~Time*Group, contrast.factor=~Time*Group, 
                    contrast="GroupA.T1 - GroupA.T0", geneSets=geneSets, 
                    random=~1|SubjectID)
    ```

### 3. Meta-Analysis
Combine results from multiple independent studies using numerical convolution.
```r
# List of QSarray objects from different studies
combined <- combinePDFs(list(study1.qs, study2.qs))
p.vals <- pdf.pVal(combined)
```

## Visualization

*   **Density Curves:** View the PDF of gene set activation.
    ```r
    plot(qs.results) # Automatically calls plotDensityCurves
    ```
*   **Confidence Intervals:** Compare multiple gene sets (default for >10 sets).
    ```r
    plotCIs(qs.results)
    ```
*   **Gene-level Distributions:** Visualize how individual genes contribute to the pathway PDF.
    ```r
    plotGeneSetDistributions(qs.results, path.index=1)
    ```

## Key Functions and Parameters
*   `read.gmt(file)`: Utility to load MSigDB gene set files.
*   `pdf.pVal(qs.results)`: Calculates p-values from the PDF.
*   `calcBayesCI(qs.results)`: Calculates confidence intervals for gene set activity.
*   `n.points`: In `qusage` or `aggregateGeneSet`, increase this (e.g., `2^14`) for very small sample sizes (degrees of freedom < 5) to ensure smooth PDF sampling.
*   `var.equal`: In `makeComparison`, set to `FALSE` (default) to use Welch’s t-test, or `TRUE` to use LIMMA-style pooled variance.

## Reference documentation
- [qusage Package Vignette](./references/qusage.md)