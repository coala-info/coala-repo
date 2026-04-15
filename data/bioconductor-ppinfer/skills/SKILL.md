---
name: bioconductor-ppinfer
description: This tool infers functionally related proteins using protein-protein interaction networks and Support Vector Machines. Use when user asks to identify putative protein functions, find proteins closely related to a target set, or perform network-based functional enrichment analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/PPInfer.html
---

# bioconductor-ppinfer

name: bioconductor-ppinfer
description: Infer functionally related proteins using protein-protein interaction (PPI) networks and Support Vector Machines (SVM). Use this skill to identify putative functions of proteins, find closely related proteins to a target set, and perform network-based functional enrichment analysis (ORA/GSEA).

## Overview

PPInfer implements a network-based statistical learning method to infer protein functions. It uses a kernel Support Vector Machine (KSVM) based on the regularized Laplacian matrix of a PPI network. The package employs a unique two-step approach: first using a One-Class SVM (OCSVM) to identify background/pseudo-absence proteins, followed by a classical binary SVM to rank proteins most closely related to a user-provided target set.

## Core Workflow

### 1. Network and Kernel Preparation
The package works with `igraph` objects or adjacency matrices. A kernel matrix must be generated from the graph to represent protein similarities.

```r
library(PPInfer)
library(igraph)

# Load or create a graph (e.g., from igraph)
# K <- net.kernel(graph) 
```

### 2. Inferring Related Proteins
The primary function is `net.infer()`. It requires a target set of proteins (interesting proteins) and a pre-calculated kernel matrix.

```r
# target_proteins: vector of protein names/IDs matching kernel rownames
# K: kernel matrix
# top: number of top related proteins to return
results <- net.infer(target_proteins, K, top = 20)

# Access results
results$top    # Names of the top inferred proteins
results$score  # SVM scores for ranking
results$CVerror # Cross-validation error
```

For iterative semi-supervised learning, use `net.infer.ST()` (Self-Training), which builds the classifier incrementally.

### 3. Species-Specific PPI Inference
PPInfer provides wrapper functions for Human and Mouse that handle ID mapping via `biomaRt`.

```r
# For Human
# K.9606 is the human kernel matrix (often downloaded from Zenodo)
human_results <- ppi.infer.human(list.proteins, K.9606, input="entrezgene", output="entrezgene", top=100)

# For Mouse
mouse_results <- ppi.infer.mouse(list.proteins, K.10090, input="entrezgene", output="entrezgene", top=100)
```

### 4. Functional Enrichment Analysis
After identifying related proteins, you can perform Over-Representation Analysis (ORA) or Gene Set Enrichment Analysis (GSEA).

```r
# ORA
res_ora <- ORA(pathways, results$top)
ORA.barplot(res_ora, category = "Category", pvalue = "pvalue")

# GSEA (requires scores)
# Scale scores for GSEA
scaled_scores <- as.numeric(scale(results$score))
names(scaled_scores) <- results$top
res_gsea <- fgsea(pathways, scaled_scores, nperm=1000)

# Visualize GSEA network
enrich.net(res_gsea, pathways, pvalue.cutoff = 0.25)
```

## Usage Tips

- **Kernel Matrices**: Calculating kernels for large networks (like STRING) is computationally expensive. It is recommended to download pre-calculated matrices for Human (Taxon 9606) and Mouse (Taxon 10090) from public repositories like Zenodo as indicated in the package documentation.
- **ID Mapping**: When using `net.infer` directly, ensure the `target_proteins` IDs exactly match the `rownames` of the kernel matrix.
- **Constraint**: The number of target proteins ($n$) must be less than half the total proteins ($N$) in the kernel matrix ($N - 2n > 0$) for the pseudo-absence selection logic to function correctly.
- **Pseudo-absence**: The package automatically defines "other class" proteins by selecting those with zero similarity to the target class via OCSVM before running the final binary SVM.

## Reference documentation

- [PPInfer](./references/PPInfer.md)