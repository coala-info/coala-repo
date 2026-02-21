---
name: bioconductor-celltree
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/cellTree.html
---

# bioconductor-celltree

name: bioconductor-celltree
description: Inference and visualization of hierarchical tree structures from single-cell RNA-seq data using Latent Dirichlet Allocation (LDA) topic modeling. Use this skill when you need to perform dimension reduction, identify latent gene groups (topics), build backbone trees for cell differentiation paths, or perform Gene Ontology (GO) enrichment analysis on single-cell datasets.

# bioconductor-celltree

## Overview
The `cellTree` package uses Latent Dirichlet Allocation (LDA)—a technique borrowed from natural language processing—to model single-cell RNA-seq data. It treats cells as "documents" and gene expression levels as "word counts." This allows for the discovery of latent "topics" (biological processes) that drive cell states. The package is particularly effective for visualizing complex differentiation trajectories through "backbone trees," which identify representative cells along a biological continuum.

## Installation
```R
if (!requireNamespace("BiocManager", quietly=TRUE)) install.packages("BiocManager")
BiocManager::install("cellTree")
library(cellTree)
```

## Typical Workflow

### 1. Data Preparation
Input should be a gene expression matrix (genes as rows, cells as columns) with HGNC gene symbols and cell identifiers.
```R
# Example using HSMM data
library(HSMMSingleCell)
data(HSMM_expr_matrix)

# cellTree handles log-transformation and variance filtering automatically in compute.lda
```

### 2. Fitting the LDA Model
You must determine the number of topics ($k$). A good rule of thumb is the number of major biological processes or differentiation steps expected.
```R
# Automatically select best k (e.g., between 3 and 8) using the 'maptpx' method
lda.results = compute.lda(HSMM_expr_matrix, k.topics=3:8, method="maptpx")

# Or use a fixed k with the Gibbs sampling method (slower but potentially more accurate)
# lda.results = compute.lda(HSMM_expr_matrix, k.topics=6, method="Gibbs")
```

### 3. Building and Visualizing the Tree
Once the model is fitted, compute cell distances and build a backbone tree. Providing group labels (e.g., time points) helps root the tree.
```R
# Get time point or group information
data(HSMM_sample_sheet)
days = as.numeric(as.character(HSMM_sample_sheet$Hours))

# Compute the backbone tree
# width.scale.factor adjusts the "closeness" required for cells to join a branch
b.tree = compute.backbone.tree(lda.results, days, width.scale.factor=1.2)

# Plotting
ct.plot.grouping(b.tree) # Color by group/time
ct.plot.topics(b.tree)   # Show topic distribution pie charts for each cell
```

### 4. Gene Set Enrichment (GO Analysis)
Identify the biological functions associated with each latent topic.
```R
library(org.Hs.eg.db)

# Compute GO enrichment for Cellular Components (CC) or Biological Processes (BP)
go.results = compute.go.enrichment(lda.results, org.Hs.eg.db, 
                                   ontology.type="CC", 
                                   p.val.threshold=0.01)

# View unique terms for Topic 1
go.results$unique[[1]]

# Plot the GO DAG for specific topics
ct.plot.go.dag(go.results, only.topics=c(1:3))
```

### 5. Exporting Results
```R
# Get a table of cells ranked by their position in the tree
cell.table = cell.ordering.table(b.tree)

# Export to LaTeX for reports
cell.ordering.table(b.tree, write.to.tex.file="cell_summary.tex")
```

## Key Functions
- `compute.lda`: Fits the LDA model. Supports `maptpx`, `Gibbs`, and `VEM` methods.
- `compute.backbone.tree`: Constructs the hierarchical structure. Set `only.mst=TRUE` for a standard Minimum Spanning Tree.
- `get.cell.dists`: Calculates Chi-square distances between cells based on topic distributions.
- `ct.plot.grouping` / `ct.plot.topics`: Primary visualization functions for the resulting tree.
- `compute.go.enrichment`: Performs Kolmogorov-Smirnov tests on gene rankings per topic.

## Reference documentation
- [cellTree Vignette](./references/cellTree-vignette.md)