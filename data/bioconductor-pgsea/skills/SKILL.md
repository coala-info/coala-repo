---
name: bioconductor-pgsea
description: "PGSEA calculates sample-specific enrichment scores for gene signatures within expression data using a parametric z-score approach. Use when user asks to perform parametric gene set enrichment analysis, calculate enrichment scores for individual samples, or visualize gene set activity across a dataset."
homepage: https://bioconductor.org/packages/3.5/bioc/html/PGSEA.html
---


# bioconductor-pgsea

## Overview

PGSEA (Parametric Gene Set Enrichment Analysis) is a Bioconductor package designed to determine the enrichment of defined gene signatures (molecular concepts) within gene expression data. Unlike methods that provide a single enrichment score for a whole group, PGSEA calculates a score for every sample in a dataset, allowing for sample-specific analysis and visualization. It uses a parametric approach (z-score based) to determine if the genes in a set are significantly up- or down-regulated compared to the rest of the expression profile.

## Core Workflows

### 1. Data Preparation
PGSEA requires a matrix of expression data (or an `ExpressionSet`) and a collection of gene sets.
*   **Expression Data**: Should be in ratio form (experiment/reference) or include reference samples to generate ratios on the fly.
*   **Gene Sets**: Stored as `smc` (Simple Molecular Concepts) objects or `GeneSetCollection` objects.

### 2. Creating and Loading Gene Sets
You can create gene sets manually, read them from `.gmt` files, or generate them from Gene Ontology (GO).

```r
library(PGSEA)

# Manual creation of an smc object
my_concept <- new("smc", ids = c("gene1", "gene2"), reference = "my_source")

# Reading from a .gmt file
datadir <- system.file("extdata", package = "PGSEA")
gmt_sets <- readGmt(file.path(datadir, "sample.gmt"))

# Generating from GO
go_sets <- go2smc()
```

### 3. Running PGSEA
The `PGSEA()` function is the primary tool. If the data is not already ratios, use the `ref` argument to specify indices of reference samples.

```r
# Using an ExpressionSet (eset) and a list of concepts (cl)
# ref defines the control samples used to calculate ratios
pg_results <- PGSEA(eset, cl = gmt_sets, ref = 1:5)

# To return all results without p-value filtering (useful for downstream linear modeling)
pg_unfiltered <- PGSEA(eset, cl = gmt_sets, ref = 1:5, p.value = NA)
```

### 4. Visualization
The `smcPlot` function is specifically designed to visualize PGSEA results, typically showing samples on the x-axis and gene sets on the y-axis.

```r
# Basic plot
smcPlot(pg_results, col = .rwb, scale = c(-12, 12))

# Advanced plot with sample grouping (factor)
groups <- factor(c(rep("Control", 5), rep("Treatment", 5)))
smcPlot(pg_results, groups, show.grid = TRUE, margins = c(1, 1, 7, 15), col = .rwb)
```

### 5. Statistical Analysis of Results
Because PGSEA returns a matrix of scores per sample, you can use standard linear modeling (like `limma`) to find gene sets that significantly differ between conditions.

```r
library(limma)
design <- model.matrix(~ 0 + groups)
fit <- lmFit(pg_unfiltered, design)
# ... follow standard limma workflow (contrasts.fit, eBayes, topTable)
```

## Tips and Best Practices
*   **Identifier Matching**: Ensure the gene identifiers in your `smc` objects (the `ids` slot) match the row names of your expression matrix exactly (e.g., both use Entrez IDs).
*   **Reference Samples**: The `ref` argument is critical. It should point to the "normal" or "baseline" samples in your matrix.
*   **Interpreting Scores**: A positive score indicates the gene set is generally up-regulated in that sample relative to the reference; a negative score indicates down-regulation.
*   **Missing Values**: `PGSEA` returns `NA` for gene sets that do not meet the significance threshold unless `p.value = NA` is specified.

## Reference documentation
- [PGSEA Basics and GO](./references/PGSEA.md)
- [PGSEA Workflow with GEO Data and Limma](./references/PGSEA2.md)