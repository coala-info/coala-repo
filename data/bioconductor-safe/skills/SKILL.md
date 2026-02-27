---
name: bioconductor-safe
description: The safe package implements a resampling-based framework for pathway analysis that accounts for gene-gene correlations. Use when user asks to perform significance analysis of function and expression, conduct pathway enrichment analysis with sample permutations, or identify significant functional categories across various experimental designs.
homepage: https://bioconductor.org/packages/release/bioc/html/safe.html
---


# bioconductor-safe

## Overview

The `safe` package implements Significance Analysis of Function and Expression, a robust resampling-based framework for pathway analysis. Unlike many methods that assume gene independence, `safe` accounts for gene-gene correlations by permuting sample labels. It utilizes a two-stage process: "local" statistics assess individual feature associations with a phenotype, and "global" statistics measure the enrichment of those associations within functional categories (e.g., GO, KEGG, REACTOME) relative to the rest of the genome.

## Core Workflow

### 1. Data Preparation
Input requires an expression matrix (features x samples) and a response vector/phenotype data. Missing values must be imputed.

```r
library(safe)
# e.mat: matrix of expression data
# y.vec: vector of response (0/1, factor, or continuous)
```

### 2. Building Category Matrices
Functional categories are represented as a sparse matrix ($C$) where rows are features and columns are categories. Use `getCmatrix` to build these from Bioconductor annotation packages.

```r
# Example: Building REACTOME categories for hgu133a platform
C.mat <- getCmatrix(gene.list = as.list(reactomeEXTID2PATHID), 
                    present.genes = entrez_ids, 
                    prefix = "REACTOME:", 
                    min.size = 10, max.size = 500)
```

### 3. Running SAFE
The primary function is `safe()`. It defaults to a Student's t-statistic (local) and Wilcoxon rank sum (global) with 1000 permutations.

```r
# Basic execution
results <- safe(e.mat, y.vec, platform = "hgu133a.db", annotate = "REACTOME")

# Using a pre-built C matrix
results <- safe(e.mat, y.vec, C.mat = C.mat)
```

### 4. Interpreting Results
Use `safe.toptable` for a summary and `gene.results` to inspect specific genes within a significant category.

```r
# View top 10 significant pathways
safe.toptable(results, number = 10)

# Inspect genes in a specific category
gene.results(results, cat.name = "REACTOME:R-HSA-69183", gene.names = genes)

# Visualize with a SAFE-plot
safeplot(results, cat.name = "REACTOME:R-HSA-69183")
```

## Advanced Experimental Designs

| Design | Argument `local` | Response `y.vec` Format |
| :--- | :--- | :--- |
| **Two-sample** | `"t.Student"` (default) | Binary (0/1) or 2-level factor |
| **Welch Test** | `"t.Welch"` | Binary (unequal variance) |
| **Multi-class** | `"f.ANOVA"` | Factor with >2 levels |
| **Continuous** | `"t.LM"` | Numeric vector |
| **Paired** | `"t.paired"` | Vector of +/- integers (e.g., `c(1, -1, 2, -2)`) |
| **Survival** | Use `getCOXresiduals` | Right-censored time/event data |
| **Covariates** | Use `getXYresiduals` | Matrix `Z.mat` for adjustment |

### Survival Analysis Example
```r
library(survival)
# Calculate martingale residuals first
Xy <- getCOXresiduals(e.mat, survival_time, event_status)
# Run safe on residuals
results <- safe(Xy$X.star, Xy$y.star, C.mat = C.mat)
```

## Performance Tips

*   **Parallel Processing**: Set `parallel = TRUE` after registering a backend (e.g., `doParallel`) to speed up permutations.
*   **Bootstrap**: Use `method = "bootstrap.t"` for potentially higher power than standard permutations.
*   **Multiple Testing**: Default is `error = "FDR.BH"`. For stricter control accounting for category correlation, use `error = "FDR.YB"` or `"FWER.WY"`.
*   **Soft Categories**: Use `by.gene = TRUE` in `getCmatrix` to perform analysis at the gene level rather than the probeset level.

## Reference documentation
- [Significance Analysis of Function and Expression](./references/SAFEmanual3.md)