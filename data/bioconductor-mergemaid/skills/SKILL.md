---
name: bioconductor-mergemaid
description: This tool facilitates multi-study gene expression analysis by merging datasets across platforms and assessing gene reproducibility through integrative correlation. Use when user asks to merge gene expression datasets, calculate integrative correlation coefficients, or fit joint linear, logistic, and Cox models across multiple studies.
homepage: https://bioconductor.org/packages/3.5/bioc/html/MergeMaid.html
---


# bioconductor-mergemaid

name: bioconductor-mergemaid
description: Expert assistance for the MergeMaid Bioconductor package. Use this skill to facilitate multi-study gene expression analysis, including merging datasets across platforms, calculating integrative correlation coefficients for gene reproducibility, and fitting joint models (linear, logistic, Cox) across multiple studies.

# bioconductor-mergemaid

## Overview

MergeMaid is an R package designed for the "merging" and joint analysis of gene expression datasets from multiple studies or platforms. It avoids the need for direct cross-platform normalization by focusing on **integrative correlation**, which measures the consistency of gene-gene correlation structures across different datasets. This allows researchers to identify reproducible genes and perform meta-analysis-like modeling (linear, logistic, or Cox regression) across combined studies.

## Core Workflow

### 1. Data Preparation and Merging
The primary data structure is the `mergeExpressionSet`. You must provide gene identifiers (e.g., Entrez ID, Symbol) as row names for each dataset.

```r
library(MergeMaid)

# Assume exp1, exp2 are ExpressionSet objects or matrices
# Merging handles common genes and averages replicates with the same ID
mset <- mergeExprs(exp1, exp2, studyNames=c("StudyA", "StudyB"))

# Accessing data
common_genes <- geneNames(mset)
all_data <- exprs(mset) # Returns a list of matrices
```

### 2. Assessing Gene Reproducibility (Integrative Correlation)
Use `intCor` to determine which genes behave similarly across studies. A high integrative correlation suggests the gene's relationship with other genes is preserved across platforms.

```r
# Calculate integrative correlation
mcor <- intCor(mset)

# Extract coefficients
ic_scores <- integrative.cors(mcor)

# Visualize reproducibility vs. null distribution (via permutation)
intcorDens(mset, mcor)
```

### 3. Modeling Outcomes
Fit models to each study simultaneously to compare effect sizes or significance.

```r
# Example: Cox Proportional Hazards for survival data
# 'surv_obj' must be present in the phenoData of the studies
mcoeff <- modelOutcome(mset, outcome="surv_obj", family="cox")

# Extract results
z_scores <- zscore(mcoeff)
coeffs <- coeff(mcoeff)

# Compare coefficients between Study 1 and Study 2
plot(coeff(mcoeff)[,1], coeff(mcoeff)[,2], 
     xlab="Study A Coeff", ylab="Study B Coeff")
```

## Key Functions and Classes

| Function | Class Returned | Purpose |
| :--- | :--- | :--- |
| `mergeExprs()` | `mergeExpressionSet` | Combines multiple datasets into one object. |
| `intCor()` | `mergeCor` | Computes integrative correlation coefficients. |
| `modelOutcome()` | `mergeCoeff` | Fits 'linear', 'logistic', or 'cox' models across studies. |
| `intcorDens()` | N/A (Plot) | Compares observed integrative correlation to a null distribution. |

## Tips for Success
- **Gene IDs:** Ensure row names across all input objects use the same ID system (e.g., all Gene Symbols or all Entrez IDs). `mergeExprs` relies on these strings for matching.
- **Replicates:** If a dataset has multiple probes for the same gene ID, `mergeExprs` automatically averages them.
- **Intersection:** Use `intersection(mset)` to get a single `ExpressionSet` containing only the genes present in every study.
- **Visualization:** Use the `plot` method on `mergeCor` objects to visualize pairwise correlations between studies.

## Reference documentation
- [MergeMaid](./references/MergeMaid.md)