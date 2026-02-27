---
name: bioconductor-tdbasedufeadv
description: This tool performs advanced tensor decomposition-based unsupervised feature extraction for multi-omics data integration. Use when user asks to integrate datasets sharing features or samples, perform unsupervised feature extraction using HOSVD, or conduct drug-disease integration and multi-omics projection.
homepage: https://bioconductor.org/packages/release/bioc/html/TDbasedUFEadv.html
---


# bioconductor-tdbasedufeadv

name: bioconductor-tdbasedufeadv
description: Advanced Tensor Decomposition (TD) based Unsupervised Feature Extraction (UFE) for multi-omics data integration. Use this skill to perform integrated analysis of multiple datasets sharing either features or samples, including drug-disease integration, multi-omics projection, and enrichment analysis of selected features.

# bioconductor-tdbasedufeadv

## Overview

The `TDbasedUFEadv` package extends the `TDbasedUFE` framework to handle complex multi-omics integration scenarios. It allows for unsupervised feature extraction (typically genes) from multiple data sources by constructing tensors or using SVD-based projections. It is particularly effective for datasets with small sample sizes and large feature sets.

Key capabilities include:
- Integrating datasets sharing features (e.g., drug-treated vs. disease cell lines).
- Integrating datasets sharing samples (e.g., mRNA, methylation, and mutation data for the same patients).
- Memory-efficient analysis using partial summation and SVD.
- Projection-based integration for multiple omics layers.

## Core Workflow

### 1. Data Preparation and Tensor Construction

Depending on whether features or samples are shared, use specific preparation functions.

```r
library(TDbasedUFEadv)
library(TDbasedUFE)

# Case A: Features are shared (e.g., two expression matrices)
# Z will be a tensor of dimension Features x Samples1 x Samples2
Z <- prepareTensorfromMatrix(matrix1, matrix2)

# Case B: Multiple datasets sharing samples
# Z will be a bundle of top singular value vectors
Z_list <- prepareTensorfromList(list_of_matrices, n_components = 10)

# Wrap in SummarizedExperiment container for the package
Z_se <- PrepareSummarizedExperimentTensor(
    feature = rownames(matrix1),
    sample = colnames(matrix1),
    value = Z
)
```

### 2. Decomposition

Apply Higher-Order Singular Value Decomposition (HOSVD) to the constructed tensor.

```r
HOSVD <- computeHosvd(Z_se)
```

### 3. Feature Selection

Feature selection involves identifying singular value vectors that represent the biological signal of interest (e.g., treatment effect or disease state).

**Interactive Mode (Recommended for discovery):**
```r
# Define conditions for the modes (e.g., treatment vs control)
cond <- list(NULL, treatment_vector, class_vector)

# Interactively select vectors and optimize standard deviation (de)
index <- selectFeature(HOSVD, cond) 
```

**Batch Mode (For reproducible scripts):**
```r
# input_all specifies which singular value vectors to use
index <- selectFeatureProj(HOSVD, Multi_list, cond, de = 1e-3, input_all = 3)
```

### 4. Results Extraction

```r
# View top selected features
head(tableFeatures(Z_se, index))

# Extract gene symbols for downstream analysis
selected_genes <- unlist(lapply(strsplit(tableFeatures(Z_se, index)[,1], "|", fixed=TRUE), "[", 1))
```

## Advanced Integration Strategies

### Memory-Efficient SVD (Partial Summation)
When tensors are too large for memory, use `computeSVD` on the product of matrices.
```r
SVD_res <- computeSVD(exprs(data1), exprs(data2))
# Follow with selectFeatureRect()
```

### Multi-Omics Projection
To integrate multiple omics layers (mRNA, Methylation, etc.) sharing the same samples:
1. Use `prepareTensorfromList` to bundle SVD components.
2. Apply `computeHosvd`.
3. Use `selectFeatureSquare` to map back to original features in each omics layer.

```r
index_all <- selectFeatureSquare(HOSVD, input_all, original_data_list, de = c(0.5, 0.1, 0.1, 1))
```

## Enrichment Analysis

Selected features can be validated using standard enrichment tools.

```r
# Using enrichR
library(enrichR)
dbs <- c("GO_Biological_Process_2021", "KEGG_2021_Human")
enriched <- enrichr(selected_genes, dbs)

# Using STRINGdb for PPI networks
library(STRINGdb)
string_db <- STRINGdb$new(version="11.5", species=9606)
mapped <- string_db$map(data.frame(genes=selected_genes), "genes")
string_db$plot_network(mapped$STRING_id)
```

## Reference documentation

- [Enrichment Analysis Guide](./references/Enrichment.md)
- [Theoretical Explanation of TDbasedUFEadv](./references/Explanation_of_TDbasedUFEadv.md)
- [Main User Guide](./references/How_to_use_TDbasedUFEadv.md)
- [Quick Start: Two Omics Integration](./references/QuickStart.md)
- [Quick Start 2: Multi-Omics and Shared Features](./references/QuickStart2.md)