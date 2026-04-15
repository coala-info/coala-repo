---
name: bioconductor-rtopper
description: This tool performs Gene Set Enrichment analysis across multiple genomic platforms to integrate multi-omics data. Use when user asks to perform gene set enrichment analysis across multiple genomic platforms, integrate multi-omics data using logistic models, or combine GSE results from separate platforms.
homepage: https://bioconductor.org/packages/release/bioc/html/RTopper.html
---

# bioconductor-rtopper

name: bioconductor-rtopper
description: Perform Gene Set Enrichment (GSE) analysis across multiple genomic platforms (e.g., DGE, CNV, Methylation). Use this skill to integrate multi-omics data using two approaches: (1) Integration of data followed by GSE (INTEGRATION + GSE) or (2) Separate GSE on individual platforms followed by result integration (GSE + INTEGRATION).

# bioconductor-rtopper

## Overview

The `RTopper` package provides a framework for integrating data from distinct genomic platforms (e.g., Affymetrix, Agilent, CNV, Methylation) using Gene Set Enrichment (GSE). It allows researchers to determine if functional gene sets (FGS) are coordinately associated with a phenotype across different types of measurements.

## Data Preparation

Input data must follow a specific structure:
1.  **Genomic Measurements**: A list of data frames. Each list item is a platform. Data frames must have genes as rows and patients as columns.
2.  **Phenotype Data**: A data frame with two columns: patient IDs and group indicators (0/1).
3.  **Consistency**: All platforms must contain the same genes (row names) and the same patients (column names matching phenotype rows).

```R
library(RTopper)
data(exampleData) # Loads 'dat' (list of platforms) and 'pheno' (phenotype)

# Convert to gene-centered list for analysis
dataDr <- convertToDr(dat, pheno, nPlatforms = 4)
```

## Workflow 1: INTEGRATION + GSE

This approach integrates genomic data measurements using a logistic model first, then performs GSE on the integrated score.

1.  **Compute Integrated Score**:
    ```R
    # method can be "bic", "aic", or "dev"
    bicStatInt <- computeDrStat(dataDr, columns = 1:4, method = "bic", integrate = TRUE)
    ```

2.  **Run Batch GSE**:
    ```R
    # fgsList is a named list of gene sets (e.g., GO or KEGG)
    gseABS.int <- runBatchGSE(dataList = bicStatInt, fgsList = fgsList)
    ```

## Workflow 2: GSE + INTEGRATION

This approach performs GSE on each platform separately and then integrates the resulting p-values.

1.  **Compute Separate Scores**:
    ```R
    bicStatSep <- computeDrStat(dataDr, columns = 1:4, method = "bic", integrate = FALSE)
    ```

2.  **Run Batch GSE on Platforms**:
    ```R
    gseABS.sep <- runBatchGSE(dataList = bicStatSep, fgsList = fgsList)
    ```

3.  **Combine Results**:
    ```R
    # Methods: "geometricMean", "mean", "median", "min", "max"
    gseCombined <- combineGSE(gseABS.sep, method = "geometricMean")
    ```

## Advanced GSE Options

The `runBatchGSE` function wraps `limma::geneSetTest`. You can customize the test:

*   **Directionality**: Use `absolute = FALSE` with `alternative = "up"`, "down", or "either".
*   **Simulation**: Use `nsim = 1000` for permutation-based p-values.
*   **Custom Functions**: Pass a user-defined function to `gseFunc`.

## Multiple Testing Correction

Adjust p-values across all gene sets and platforms:
```R
# Default is Benjamini-Hochberg ("BH")
gseAdjusted <- adjustPvalGSE(gseABS.int, proc = "BH")
```

## Tips
*   **Gene Identifiers**: Ensure gene symbols or IDs in your `fgsList` match the row names of your genomic data.
*   **Platform Selection**: The `columns` argument in `computeDrStat` allows you to select specific platforms from your `dataDr` object.
*   **Integration Method**: "bic" (Bayesian Information Criterion) is often preferred for penalized likelihood ratios in this context.

## Reference documentation
- [RTopper](./references/RTopper.md)