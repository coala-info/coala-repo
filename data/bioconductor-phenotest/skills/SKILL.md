---
name: bioconductor-phenotest
description: The phenoTest package provides a framework for testing associations between gene expression data and phenotypic variables while facilitating gene set enrichment analysis. Use when user asks to test associations between expression sets and phenotypes, create epheno objects, perform gene set enrichment analysis, or visualize phenotypic associations through heatmaps and signature barplots.
homepage: https://bioconductor.org/packages/release/bioc/html/phenoTest.html
---

# bioconductor-phenotest

## Overview

The `phenoTest` package provides a structured framework for testing the association between gene expression data (typically in an `ExpressionSet`) and various phenotypic variables. It streamlines the process of performing univariate tests across multiple phenotypes and facilitates Gene Set Enrichment Analysis (GSEA). A core feature is the `epheno` object, which extends `ExpressionSet` to store association statistics like fold changes, hazard ratios, and p-values for easy retrieval and visualization.

## Core Workflow

### 1. Prepare Phenotypes
Define which variables in your `ExpressionSet` metadata (`pData`) to test. You must categorize them into a list:

```r
# Define survival as a matrix with 'event' and 'time' columns
surv_vars <- matrix(c("Relapse", "Months2Relapse"), ncol=2, byrow=TRUE)
colnames(surv_vars) <- c('event', 'time')

vars2test <- list(
  survival = surv_vars,
  categorical = 'lymph.node.status',
  continuous = 'Tumor.size',
  ordinal = 'Grade' # Optional
)
```

### 2. Create an epheno Object
The `ExpressionPhenoTest` function performs the underlying linear modeling (via `limma`) or Cox regression (via `survival`).

```r
library(phenoTest)
# approach can be 'frequentist' (default) or 'bayesian'
epheno <- ExpressionPhenoTest(eset, vars2test, p.adjust.method='BH')
```

### 3. Extract Results
Use specific getter methods to retrieve statistics from the `epheno` object:

*   **P-values:** `getSignif(epheno)`
*   **Fold Changes:** `getFc(epheno)`
*   **Hazard Ratios:** `getHr(epheno)`
*   **Group Means:** `getMeans(epheno)`
*   **Summary:** `getSummaryDif(epheno)` (returns FC or HR depending on variable type)

### 4. Gene Set Enrichment Analysis (GSEA)
`phenoTest` implements a GSEA version that tests if a gene set is *more* enriched than a random set of genes (competitive null hypothesis).

```r
# Works with lists, GeneSet, or GeneSetCollection
my_gsea <- gsea(x=epheno, gsets=mySignature, B=1000, p.adjust='BH')

# View summary table
summary(my_gsea)

# Plot enrichment scores
plot(my_gsea, selGsets='My Signature Name')
```

## Visualization and Export

*   **Heatmaps:** `heatmapPhenoTest(eset, signature, vars2test)` clusters samples by a gene set and tests the cluster association with phenotypes.
*   **Signature Barplots:** 
    *   `barplotSignifSignatures(epheno, signature)`: Shows % of up/down regulated genes.
    *   `barplotSignatures(epheno, signature)`: Shows average log2 fold change or hazard ratio.
*   **Export:** Use `export2csv(epheno, ...)` or `epheno2html(epheno, ...)` for shareable reports.

## Tips and Best Practices

*   **Parallelization:** `ExpressionPhenoTest` supports `mc.cores` for Unix-based systems to speed up computation.
*   **Subsetting:** You can subset `epheno` objects like `ExpressionSet` objects: `epheno[, 'Tumor.size']` or `epheno[, phenoClass(epheno) == 'survival']`.
*   **Wilcoxon Test:** For faster GSEA without permutations, use `test='wilcox'` in the `gsea` function.
*   **Continuous Variables:** By default, continuous variables are divided into 3 categories for mean calculations; adjust this using the `continuousCategories` argument in `ExpressionPhenoTest`.

## Reference documentation

- [phenoTest](./references/phenoTest.md)