---
name: bioconductor-mvgst
description: This tool performs multivariate and directional gene set testing to identify differentially active biological processes across multiple experimental contrasts. Use when user asks to classify Gene Ontology terms into activity profiles across multiple contrasts, perform meta-analysis of one-sided p-values, or identify gene sets that are collectively up-regulated or down-regulated across different experimental conditions.
homepage: https://bioconductor.org/packages/3.5/bioc/html/mvGST.html
---


# bioconductor-mvgst

name: bioconductor-mvgst
description: Multivariate and Directional Gene Set Testing (mvGST) for identifying differentially active biological processes across multiple contrasts. Use this skill when analyzing gene expression data (Affymetrix, RNA-Seq, etc.) to classify Gene Ontology (GO) terms into activity profiles across multiple experimental comparisons. It is specifically useful for meta-analysis of one-sided p-values to determine if gene sets are collectively up-regulated, down-regulated, or unchanged across different conditions or strata.

## Overview

The `mvGST` package provides a statistical framework to characterize gene sets (primarily GO terms) when an experiment involves multiple null hypotheses per gene. It uses Stouffer's method to combine one-sided p-values from gene-level contrasts into gene-set-level results. It classifies each gene set into a "profile" (e.g., up-regulated in contrast A, no change in contrast B) and provides tools for visualization and multiple testing correction.

## Core Workflow

### 1. Data Preparation
The package requires a matrix of **one-sided p-values**.
- **Rows**: Genes (Probe IDs, Ensembl, etc.)
- **Columns**: Contrasts (e.g., Treatment vs. Control).
- **Directionality**: Small p-values (~0) indicate up-regulation; large p-values (~1) indicate down-regulation.

```r
# Example structure of p-value matrix
#             Contrast1  Contrast2
# Gene1       0.001      0.995
# Gene2       0.040      0.450
```

### 2. Generating Profile Tables
The `profileTable` function is the primary tool for classifying gene sets.

```r
library(mvGST)
# For Affymetrix data
results <- profileTable(pvals_matrix, 
                        gene.ID = "affy", 
                        affy.chip = "hgu133plus2", 
                        organism = "hsapiens",
                        minsize = 10, 
                        maxsize = 200)

# For RNA-Seq (Ensembl) data
results <- profileTable(pvals_matrix, 
                        gene.ID = "ensembl", 
                        organism = "hsapiens")
```

**Key Arguments:**
- `gene.ID`: Type of ID ("affy", "ensembl", "entrez", "symbol").
- `organism`: "hsapiens", "mmusculus", etc.
- `sig.level`: FDR threshold (default 0.05).
- `mult.adj`: Adjustment method ("BY" for Benjamini-Yekutieli, or "SFL" for Short Focus Level).

### 3. Interpreting and Extracting Results
The output of `profileTable` shows the number of GO terms belonging to specific activity profiles (1 = Up, -1 = Down, 0 = No Change).

```r
# View the profile summary table
results

# Extract specific GO terms from a profile (e.g., row 7, column 2 of the table)
specific_sets <- pickOut(results, row = 7, col = 2)

# Find the profile for a specific GO ID
go2Profile(c("GO:0002274"), results)
```

### 4. Visualization
Use `graphCell` to generate a GO graph where significant nodes for a specific profile are highlighted.

```r
# Visualize GO terms from a specific profile table cell
graphCell(results, row = 7, col = 2, interact = TRUE)
```

## Multiple Comparison Adjustments

- **Default (BY)**: The Benjamini-Yekutieli adjustment is used to control FDR while accounting for the dependency inherent in nested GO terms.
- **Short Focus Level (SFL)**: Controls family-wise error rate (FWER) within the GO graph structure. Note: SFL is computationally intensive and requires all ancestor/offspring nodes to be present.

```r
# Manual SFL adjustment for a vector of p-values
sfl_pvals <- p.adjust.SFL(pvals_vector, ontology = "BP", sig.level = 0.10)
```

## Tips for Success
- **Contrast Naming**: If column names in your p-value matrix contain a dot (e.g., `Low.RS4`), `mvGST` treats the string after the dot as a **stratum**. This allows for stratified analysis (e.g., comparing treatments within different cell lines).
- **One-sided P-values**: If you have two-sided p-values and the direction of change (log fold change), convert them:
  - If $logFC \ge 0$: $p_{one-sided} = p_{two-sided} / 2$
  - If $logFC < 0$: $p_{one-sided} = 1 - (p_{two-sided} / 2)$

## Reference documentation
- [mvGST: Multivariate and Directional Gene Set Testing](./references/mvGST.md)