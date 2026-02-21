---
name: bioconductor-geva
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/geva.html
---

# bioconductor-geva

name: bioconductor-geva
description: Analysis of differential gene expression across multiple experimental comparisons. Use this skill to perform Gene Expression Variation Analysis (GEVA) on logFC and p-value tables from microarray or RNA-seq data to classify genes as similar, factor-dependent, or factor-specific.

## Overview

The `geva` package implements a pipeline to identify genes with consistent or condition-dependent expression patterns across multiple experiments. It transforms differential expression (DE) results into a Summarization-Variation (SV) space, where "S" represents the central log-fold change and "V" represents the variation across experiments. The workflow involves data input, summarization, quantile/cluster-based delimitation, and final classification using ANOVA for factor-based analysis.

## Workflow and Core Functions

### 1. Data Input and Pre-processing

Input requires at least two DE result tables containing `logFC` and `adj.P.Val` columns.

```r
library(geva)

# Option A: Read from tab-delimited files
files <- c("exp1.txt", "exp2.txt", "exp3.txt")
ginput <- geva.read.tables(files, col.values="logFC", col.pvals="adj.P.Val")

# Option B: Merge from R data.frames/matrices
ginput <- geva.merge.input(df1, df2, df3)

# Option C: Convert from limma MArrayLM objects
dt1 <- limma::topTable(fit1, number=Inf, sort.by="none")
dt2 <- limma::topTable(fit2, number=Inf, sort.by="none")
ginput <- geva.merge.input(dt1, dt2)

# Post-processing
ginput <- geva.input.correct(ginput) # Remove NA/Inf
ginput <- geva.input.filter(ginput, p.value.cutoff = 0.05) # Filter insignificant rows
ginput <- geva.input.rename.rows(ginput, attr.column = "Symbol") # Resolve probe duplicates
```

### 2. SV Analysis (Summarization and Variation)

Calculates the S (summary) and V (variation) coordinates for each gene.

```r
# Default uses mean and standard deviation
gsummary <- geva.summarize(ginput, summary.method="mean", variation.method="sd")

# Plot the SV-space
plot(gsummary)
```

### 3. Delimitation and Clustering

Partitions the SV-space to separate relevant genes from the "basal" (non-DE) central mass.

```r
# Quantile detection
gquants <- geva.quantiles(gsummary, quantile.method="range.slice")

# Cluster analysis (separates the central agglomeration)
gcluster <- geva.cluster(gsummary, cluster.method="hierarchical", resolution=0.3)

# Combine for visualization
groupsets(gsummary) <- gquants
groupsets(gsummary) <- gcluster
plot(gsummary)
```

### 4. Final Classification and Factor Analysis

Assigns final labels to genes. If experimental groups (factors) are provided, it performs ANOVA to find condition-specific patterns.

```r
# Define factors (optional but recommended)
factors(gsummary) <- c("GroupA", "GroupA", "GroupB", "GroupB")

# Finalize results
gresults <- geva.finalize(gsummary, gquants, gcluster, p.value=0.05)

# Visualize final classifications
plot(gresults)
```

### 5. Extracting Results

```r
# Get full table
res_table <- results.table(gresults)

# Get only relevant genes (similar, factor-dependent, factor-specific)
top_genes <- top.genes(gresults, add.cols = "Symbol")
```

## Quick Analysis Shortcut

For a rapid pipeline execution:

```r
# Performs summarize -> quantiles -> cluster -> finalize in one call
gresults <- geva.quick(ginput, resolution=0.3)
```

## Classification Definitions

- **basal**: Low logFC, low variation (near origin).
- **similar**: High logFC, low variation (consistent across all experiments).
- **sparse**: High variation, no clear pattern relative to factors.
- **factor-dependent**: Low variation within factors, high variation between factors.
- **factor-specific**: Relevant logFC/low variation specifically within one factor.

## Reference documentation

- [Gene Expression Variation Analysis (GEVA)](./references/geva.md)
- [GEVA Vignette Source](./references/geva.Rmd)