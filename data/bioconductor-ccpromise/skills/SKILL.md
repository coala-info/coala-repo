---
name: bioconductor-ccpromise
description: This tool integrates two types of molecular data to test their association with multiple phenotypic endpoints using a pattern-based approach. Use when user asks to perform integrative genomic analysis, test associations between molecular regulators and targets, or evaluate biological data against multiple clinical endpoints.
homepage: https://bioconductor.org/packages/release/bioc/html/CCPROMISE.html
---


# bioconductor-ccpromise

## Overview

CCPROMISE is an R package designed to integrate two distinct types of molecular data (typically a regulator like methylation and a target like expression) and test their association with multiple phenotypic endpoints. It uses a "pattern-based" approach where the user defines the expected biological direction of association (e.g., negative association with drug resistance and positive association with survival).

## Core Workflow

### 1. Data Preparation
CCPROMISE requires two `ExpressionSet` objects and a pattern definition.
*   **ESet**: Primary genomic data (e.g., Gene Expression).
*   **MSet**: Secondary genomic data (e.g., DNA Methylation).
*   **Note**: Both sets must have matching subject IDs and orders. The `phenoData` slot must contain the endpoint variables.

### 2. Defining the Promise Pattern
The pattern is a data frame that guides the statistical test by defining the "most interesting" biological evidence.

```r
# Example pattern definition
# stat.func: spearman.rstat, jung.rstat (for survival), or pearson.rstat
# stat.coef: direction/weight (e.g., -1 for negative association)
exmplPat <- data.frame(
  stat.func = c("spearman.rstat", "spearman.rstat", "jung.rstat"),
  stat.coef = c(-0.33, -0.33, -0.33),
  endpt.vars = c("LC50", "MRD22", "EFSTIME,EFSCENSOR"),
  stringsAsFactors = FALSE
)
```

### 3. Running the Analysis
There are two primary functions depending on the level of analysis:

#### Gene Level Analysis (`CCPROMISE`)
Integrates data at the gene level using a gene set mapping.

```r
test1 <- CCPROMISE(
  geneSet = exmplGeneSet,    # List mapping genes to probes/features
  ESet = exmplESet,          # ExpressionSet 1
  MSet = exmplMSet,          # ExpressionSet 2
  promise.pattern = exmplPat,# Defined pattern
  strat.var = NULL,          # Stratification variable if any
  prlbl = c('LC50', 'MRD22', 'EFS', 'Combined'), # Labels for endpoints
  EMlbl = c("Expr", "Methyl"), # Labels for data types
  nbperm = TRUE,             # Use fast negative binomial permutation
  nperms = 100               # Number of permutations
)

# View results
head(test1$PRres)
```

#### Probe Pair Level Analysis (`PrbPROMISE`)
Performs analysis at the specific probe/feature pair level.

```r
test2 <- PrbPROMISE(
  geneSet = exmplGeneSet,
  ESet = exmplESet,
  MSet = exmplMSet,
  promise.pattern = exmplPat,
  nbperm = TRUE,
  nperms = 100
)

# View correlation results between probe pairs
head(test2$CORres)
# View PROMISE results
head(test2$PRres)
```

## Key Parameters
*   `nbperm`: Set to `TRUE` to enable fast permutation based on the negative binomial distribution, which is significantly more efficient for large genomic datasets.
*   `max.ntail`: The number of permutations in the tail used to estimate the p-value when `nbperm` is TRUE.
*   `geneSet`: A data frame or list that maps the identifiers in `ESet` and `MSet` to a common biological unit (e.g., Gene Symbol).

## Interpreting Results
*   **Stat columns**: Represent the association statistic for each endpoint and data type.
*   **Pval columns**: Permutation-based p-values indicating the significance of the observed pattern.
*   **Combined Stat/Pval**: The final integrated evidence across both genomic platforms and all endpoints.

## Reference documentation
- [An Introduction to CCPROMISE](./references/CCPROMISE.md)