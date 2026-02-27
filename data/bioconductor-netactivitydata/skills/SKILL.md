---
name: bioconductor-netactivitydata
description: This package provides pre-trained gene set activity models and annotations for transcriptomic analysis using GTEx and TCGA data. Use when user asks to load weight matrices, access gene set annotations, or retrieve model data for computing pathway activity scores.
homepage: https://bioconductor.org/packages/release/data/experiment/html/NetActivityData.html
---


# bioconductor-netactivitydata

name: bioconductor-netactivitydata
description: Access and utilize pre-trained gene set activity models for transcriptomic analysis. Use when Claude needs to load, inspect, or provide data for the NetActivity package, specifically involving GTEx or TCGA-based models for GO Biological Processes and KEGG pathways.

# bioconductor-netactivitydata

## Overview
NetActivityData is a Bioconductor data package that provides pre-trained models for use with the `NetActivity` R package. It contains weights and annotations for two primary models:
1. **GTEx model (`gtex_gokegg`)**: Trained using GTEx data, focusing on general tissue expression.
2. **TCGA model (`tcga_gokegg`)**: Trained using TCGA data, focusing on cancer-related transcriptomics.

Each model consists of a weight matrix (mapping genes to gene sets) and an annotation object containing metadata and gene-specific weights.

## Installation
Install the package using BiocManager:
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("NetActivityData")
library(NetActivityData)
```

## Using the GTEx Model
The GTEx model uses ENSEMBL IDs and covers 1,518 gene sets across 8,758 genes.

### Loading and Inspecting Weights
```r
data(gtex_gokegg)
# View a subset of the weight matrix (Gene Sets x Genes)
gtex_gokegg[1:5, 1:5]
```

### Accessing Annotations
The annotation object provides the full names of terms and specific weight vectors.
```r
data(gtex_gokegg_annot)
head(gtex_gokegg_annot)

# Access specific term names
gtex_gokegg_annot$Term[1:5]
```

## Using the TCGA Model
The TCGA model follows the same structure as the GTEx model but is optimized for cancer datasets.

### Loading and Inspecting Weights
```r
data(tcga_gokegg)
# View dimensions
dim(tcga_gokegg)
```

### Accessing Detailed Weights and Symbols
The annotation data frame contains list-columns for weights using both ENSEMBL IDs and Gene Symbols.
```r
data(tcga_gokegg_annot)

# Extract weights for the first gene set (ENSEMBL)
tcga_gokegg_annot$Weights[[1]]

# Extract weights for the first gene set (Gene Symbols)
tcga_gokegg_annot$Weights_SYMBOL[[1]]
```

## Workflow Integration
These data objects are typically passed to `NetActivity` functions to compute gene set scores from new expression data.
1. Load the desired model (GTEx or TCGA).
2. Ensure your input expression data uses ENSEMBL IDs to match the model weights.
3. Use the weight matrix to transform gene expression into pathway activity scores.

## Reference documentation
- [NetActivityData](./references/NetActivityData.md)