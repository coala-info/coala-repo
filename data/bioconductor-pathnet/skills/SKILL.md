---
name: bioconductor-pathnet
description: PathNet is an R package that performs pathway enrichment analysis by integrating differential expression data with biological network topology. Use when user asks to identify enriched pathways using direct and indirect evidence, calculate combined gene evidence scores, or analyze contextual associations between pathways.
homepage: https://bioconductor.org/packages/release/bioc/html/PathNet.html
---


# bioconductor-pathnet

## Overview

PathNet is an R package that enhances pathway enrichment analysis by incorporating topological information from biological networks. Unlike standard hypergeometric tests that treat genes as independent entities, PathNet considers the connectivity of genes. It uses "Direct Evidence" (from differential expression) and "Indirect Evidence" (from a gene's neighbors in a network) to calculate a "Combined Evidence" score. It also identifies "Contextual Associations," which are pathway-pathway interactions driven by differentially expressed genes.

## Installation

```r
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("PathNet")
BiocManager::install("PathNetData") # Contains required adjacency and pathway data
```

## Core Workflow

The primary interface is the `PathNet()` function. It can perform enrichment analysis, contextual analysis, or both.

### 1. Data Preparation

PathNet requires three specific inputs:
- **Direct Evidence**: A matrix where the first column is the NCBI Entrez Gene ID and subsequent columns are p-values (transformed as -log10(p-value)).
- **Adjacency Matrix (A)**: A square matrix representing the pooled pathway network (1 for edge, 0 otherwise). Row names must be Entrez Gene IDs.
- **Pathway Information**: A data frame with columns: `id1` (Gene ID), `id2` (Gene ID), and `title` (Pathway Name).

```r
library(PathNet)
library(PathNetData)

# Load example data
data(A)
data(pathway)
data(brain_regions)

# Ensure adjacency matrix matches the genes in your expression data
gene_ID <- brain_regions[,1]
A_subset <- A[rownames(A) %in% gene_ID, rownames(A) %in% gene_ID]
```

### 2. Running PathNet

```r
results <- PathNet(
  Enrichment_Analysis = TRUE,
  Contextual_Analysis = TRUE,
  DirectEvidence_info = brain_regions,
  Adjacency = A_subset,
  pathway = pathway,
  Column_DirectEvidence = 2, # Index of the column in DirectEvidence_info to use
  n_perm = 2000,             # Number of permutations
  threshold = 0.05,          # p-value threshold for significance
  use_sig_pathways = FALSE   # If TRUE, contextual analysis only uses enriched pathways
)
```

### 3. Interpreting Results

The output is a list containing:

- **`enrichment_results`**: A matrix of pathways sorted by `p_PathNet_FWER`.
  - `p_Hyper`: Standard enrichment p-value.
  - `p_PathNet`: Enrichment p-value considering network topology.
  - `p_PathNet_FWER`: Recommended score for identifying significant pathways.
- **`enrichment_combined_evidence`**: A matrix showing the `pDirectEvidence`, `pIndirectEvidence`, and `pCombinedEvidence` for each gene.
- **`conn_p_value`**: A square matrix where element [i, j] is the significance of the contextual association (cross-talk) between pathway i and pathway j.
- **`pathway_overlap`**: A square matrix showing the statistical significance of gene overlap between pathways (static, not expression-dependent).

## Usage Tips

- **P-value Transformation**: Input p-values must be -log10 transformed. If your data contains raw p-values, transform them first: `-log10(p_values)`.
- **Gene IDs**: PathNet is designed for NCBI Entrez Gene IDs. Ensure all inputs (Direct Evidence, Adjacency, and Pathway data) use the same ID system.
- **Computational Cost**: Enrichment analysis is relatively fast (~4 mins), but Contextual Analysis on all pathway pairs can take significantly longer (~2 hours). Use `use_sig_pathways = TRUE` to reduce time by only testing cross-talk between enriched pathways.
- **Indirect Evidence**: This is only calculated for genes present in the KEGG pathway with at least one neighbor. For other genes, Combined Evidence equals Direct Evidence.

## Reference documentation

- [PathNet](./references/PathNet.md)