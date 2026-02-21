---
name: bioconductor-category
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/Category.html
---

# bioconductor-category

name: bioconductor-category
description: Analysis of genomic data using category-based methods, including Gene Set Enrichment Analysis (GSEA), Hypergeometric tests, and chromosome band analysis. Use this skill when performing pathway analysis, GO term enrichment, or identifying differentially expressed genomic regions (chromosome bands) in R.

## Overview
The `Category` package provides a framework for analyzing gene expression data in the context of predefined categories (e.g., KEGG pathways, GO terms, or chromosome bands). It allows for both parametric (Normal-theory) and non-parametric (permutation-based) testing to identify categories where constituent genes show coordinated changes in expression.

## Core Workflows

### 1. Pathway Analysis (KEGG/GO)
To identify pathways with significant coordinated expression changes:

```r
library(Category)
library(genefilter)

# 1. Compute per-gene statistics (e.g., t-tests)
ttests <- rowttests(eset, "group_variable")

# 2. Create an incidence matrix (Amat) mapping genes to pathways
# Example for hgu95av2 annotation
Amat <- t(PWAmat("hgu95av2"))

# 3. Filter pathways by size (e.g., at least 5 genes)
rs <- rowSums(Amat)
Amat_filtered <- Amat[rs >= 5, ]

# 4. Compute aggregate category statistics
# tA is the sum of t-statistics divided by the square root of category size
tA <- (Amat_filtered %*% ttests$statistic) / sqrt(rowSums(Amat_filtered))
```

### 2. Hypergeometric Testing for Chromosome Bands
Used to find over-representation of specific genomic regions in a list of "interesting" genes.

```r
# 1. Define parameters
params <- new("ChrMapHyperGParams",
              conditional = TRUE,        # Use hierarchical structure
              testDirection = "over",
              universeGeneIds = universe_entrez_ids,
              geneIds = selected_entrez_ids,
              annotation = "hgu95av2.db",
              pvalueCutoff = 0.05)

# 2. Run the test
hgans <- hyperGTest(params)

# 3. Summarize results
summary(hgans)
```

### 3. Linear Model GSEA (Global/Local)
Assesses if the distribution of gene statistics within a category is unusual using linear models.

```r
# 1. Define parameters for linear model testing
params <- new("ChrMapLinearMParams",
              conditional = TRUE,
              testDirection = "up",
              universeGeneIds = universe_entrez_ids,
              geneStats = tstats, # Named vector of t-statistics
              annotation = "hgu95av2.db",
              pvalueCutoff = 0.01,
              minSize = 4L)

# 2. Run the test
lmans <- linearMTest(params)
summary(lmans)
```

### 4. General Category Application
Use `applyByCategory` for custom functions (e.g., median, Wilcoxon test) across categories.

```r
# Compute median t-statistic per category
med_stats <- applyByCategory(ttests$statistic, Amat_filtered, FUN = median)

# Wilcoxon rank-sum test per category
wilcox_stats <- applyByCategory(ttests$statistic, Amat_filtered,
                                FUN = function(x) wilcox.test(x)$p.value)
```

## Visualization
*   **KEGGmnplot**: Plot mean expression of genes in a pathway across two groups.
*   **KEGG2heatmap**: Generate heatmaps for specific pathways with group-specific sidebars.
*   **qqnorm(tA)**: Check for pathways deviating from the null distribution of aggregate statistics.

## Key Tips
*   **Conditional Testing**: For chromosome bands or GO terms, set `conditional = TRUE`. This ensures that if a sub-band is significant, the parent band is only flagged if there is additional evidence beyond the sub-band.
*   **Gene Universe**: Always define a consistent gene universe (all genes passing non-specific filters) to avoid bias in Hypergeometric tests.
*   **Annotation**: Ensure the `annotation` slot in `Params` objects matches the Bioconductor `.db` package used (e.g., "hgu95av2").

## Reference documentation
- [Using Categories to Model Genomic Data](./references/Category.md)
- [Using Categories defined by Chromosome Bands](./references/ChromBand.md)