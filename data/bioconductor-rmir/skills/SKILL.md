---
name: bioconductor-rmir
description: The RmiR package integrates miRNA and gene expression data by matching miRNAs with their predicted or validated mRNA targets across multiple databases. Use when user asks to couple miRNA and gene expression levels, identify anti-correlated miRNA-target pairs, or analyze miRNA-target expression trends in time-course experiments.
homepage: https://bioconductor.org/packages/3.6/bioc/html/RmiR.html
---


# bioconductor-rmir

## Overview

The `RmiR` package facilitates the integrated analysis of miRNA and gene expression data. It allows researchers to match miRNA expression levels with their predicted or validated mRNA targets by querying multiple databases simultaneously via the `RmiR.Hs.miRNA` package. It is particularly useful for identifying anti-correlated miRNA-target pairs in both single-point and time-course experiments.

## Core Workflow

### 1. Data Preparation
Input data must be data frames containing identifiers and expression values (usually log-fold changes).

```r
# Gene data frame: 'genes' (probe/ID) and 'expr' (numeric)
genes <- data.frame(genes=c("A_23_P171258", "A_23_P150053"), expr=c(1.21, -1.50))

# miRNA data frame: 'mirna' (mature name) and 'expr' (numeric)
mirna <- data.frame(mirna=c("hsa-miR-148b", "hsa-miR-27b"), expr=c(1.23, 3.52))
```

### 2. Coupling miRNA and Gene Expression
Use `read.mir` to find targets. By default, it searches TargetScan and PicTar and returns the intersection.

```r
library(RmiR)
# Basic coupling using probe IDs and a Bioconductor annotation package
results <- read.mir(genes=genes, mirna=mirna, annotation="hgug4112a.db")

# Change stringency: at.least=1 returns the union of all databases
results_union <- read.mir(genes=genes, mirna=mirna, annotation="hgug4112a.db", at.least=1)

# Using different identifiers (probes, genes, alias, ensembl, unigene)
results_alias <- read.mir(genes=genes_alias, mirna=mirna, annotation="hgug4112a.db", id="alias")
```

### 3. Time Course Analysis
To analyze trends across multiple time points, use `RmiRtc`.

```r
# 1. Create read.mir objects for each time point
res1 <- read.mir(gene=gene_t1, mirna=mir_t1, annotation="hgug4112a.db")
res2 <- read.mir(gene=gene_t2, mirna=mir_t2, annotation="hgug4112a.db")
res3 <- read.mir(gene=gene_t3, mirna=mir_t3, annotation="hgug4112a.db")

# 2. Combine into a time-course object
res_tc <- RmiRtc(timeline=c("res1", "res2", "res3"), timevalue=c(12, 24, 48))

# 3. Filter by correlation (e.g., strong anti-correlation) and expression level
res_fil <- readRmiRtc(res_tc, correlation=-0.9, exprLev=1, annotation="hgug4112a.db")
```

### 4. Visualization
`RmiR` provides plotting functions to visualize the expression trends of a gene and its targeting miRNAs.

```r
# Plot a single experiment result
plotRmiRtc(res1[res1$gene_id==351,], svgname="res1_351.svg", svgTips=TRUE)

# Plot time-course trends
# This shows the gene expression vs. multiple miRNAs over time
plotRmiRtc(res_fil, gene_id=351, legend.x=30, legend.y=0)
```

## Tips and Best Practices
- **Database Selection**: The package relies on `RmiR.Hs.miRNA`. Ensure this is installed to access databases like mirBase, targetScan, miRanda, tarBase, and PicTar.
- **Identifier Matching**: If `read.mir` returns fewer results than expected, verify that the `id` parameter matches your input (e.g., use `id="genes"` for Entrez IDs).
- **Averaging**: By default, `read.mir` averages multiple probes for the same gene. To keep probes separate, use `id.out="probes"`.
- **SVG Output**: The `plotRmiRtc` function can generate interactive SVG files with tooltips if the `RSVGTipsDevice` package is available.

## Reference documentation
- [RmiR](./references/RmiR.md)