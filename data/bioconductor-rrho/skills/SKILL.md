---
name: bioconductor-rrho
description: This tool performs Rank-Rank Hypergeometric Overlap tests to identify and visualize statistically significant overlap between sorted gene lists. Use when user asks to compare differential expression signatures, evaluate agreement between genomic datasets, or test if the ordering of two or three lists is non-arbitrary.
homepage: https://bioconductor.org/packages/release/bioc/html/RRHO.html
---

# bioconductor-rrho

name: bioconductor-rrho
description: Perform Rank-Rank Hypergeometric Overlap (RRHO) tests to identify and visualize statistically significant overlap between two or three sorted gene lists. Use this skill when comparing differential expression signatures, evaluating agreement between genomic datasets, or testing if the ordering of two lists is non-arbitrary.

## Overview

The `RRHO` package implements the Rank-Rank Hypergeometric Overlap test to identify overlap between two sorted lists (typically genes ranked by differential expression statistics). It computes the significance of the overlap at every possible threshold (step size) to create a heatmap of agreement, allowing for the detection of overlap that might be missed by fixed-threshold methods like GSEA or standard Venn diagrams.

## Core Workflow: Comparing Two Lists

To compare two ranked lists, ensure both data frames contain a column for gene identifiers and a column for the ranking statistic (e.g., fold change, t-statistic, or -log p-value).

### 1. Data Preparation
Lists must contain the same set of genes, though their order will differ.
```r
# Example data structure
gene.list1 <- data.frame(GeneIdentifier = c("G1", "G2", "G3"), RankingVal = c(5.2, 4.1, -2.1))
gene.list2 <- data.frame(GeneIdentifier = c("G1", "G2", "G3"), RankingVal = c(3.8, -1.2, 2.5))
```

### 2. Running RRHO
The `RRHO` function computes the overlap matrix.
```r
library(RRHO)
res <- RRHO(gene.list1, gene.list2, 
            stepsize = 100, 
            alternative = "enrichment", 
            BY = TRUE)
```
- `stepsize`: Controls the resolution of the heatmap. Smaller steps are more precise but slower.
- `alternative`: Use "enrichment" for one-sided or "two.sided" for both over- and under-enrichment.
- `BY`: Set to `TRUE` to apply Benjamini-Yekutieli FDR correction.

### 3. Visualization
Use the `lattice` package to visualize the hypergeometric overlap matrix.
```r
# Nominal -log p-values
lattice::levelplot(res$hypermat)

# B-Y corrected p-values
lattice::levelplot(res$hypermat.by)
```

### 4. FWER Control (Permutation Testing)
To control the Family-Wise Error Rate (FWER), use `pvalRRHO` to perform permutations.
```r
# 100 permutations to calculate a global p-value
fwer_res <- pvalRRHO(res, 100)
print(fwer_res$pval)
```

## Comparing Three Lists

The `RRHOComparison` function tests if the difference between List 1 and List 3 is significantly different from the difference between List 2 and List 3.

```r
rrho.comp <- RRHOComparison(list1, list2, list3, 
                            stepsize = 10, 
                            labels = c("L1", "L2", "L3"),
                            plots = FALSE)

# Visualize the p-value of the difference
lattice::levelplot(rrho.comp$Pdiff)
```

## Tips and Interpretation

- **Input Ranking**: Ensure your ranking values are signed (e.g., sign of fold change * -log10 p-value) if you want to distinguish between up-regulated and down-regulated overlap.
- **Step Size**: For lists of ~10,000 genes, a step size of 100 is usually a good balance between resolution and speed.
- **Two-Sided Tests**: As of version 1.4.0, the package uses a robust tail-summation method for two-sided p-values to ensure Type I error control.
- **Output Objects**: The `RRHO` object contains `hypermat` (the matrix of -log p-values) and `genelist` (the processed input lists).

## Reference documentation

- [RRHO](./references/RRHO.md)