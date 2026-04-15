---
name: bioconductor-linnorm
description: Linnorm performs normalization, transformation, and downstream analysis for scRNA-seq, RNA-seq, and ChIP-seq count data. Use when user asks to normalize count data, perform differential expression analysis, identify highly variable genes, or cluster cell subpopulations using t-SNE and PCA.
homepage: https://bioconductor.org/packages/release/bioc/html/Linnorm.html
---

# bioconductor-linnorm

name: bioconductor-linnorm
description: Normalization, transformation, and analysis of scRNA-seq, RNA-seq, and ChIP-seq count data using the Linnorm R package. Use this skill for data normalization, imputation, differential expression analysis (Linnorm-limma), gene co-expression networks, highly variable gene discovery, and cell subpopulation clustering (t-SNE/PCA).

# bioconductor-linnorm

## Overview
Linnorm is an R package designed for the analysis of single-cell RNA-seq (scRNA-seq) and other large-scale count data. Its primary strength is a normalizing transformation that prepares data for parametric tests. It handles various input types (Raw counts, CPM, RPKM, FPKM, TPM) and provides a suite of tools for downstream analysis including differential expression, clustering, and network analysis.

## Core Workflows

### Data Input Requirements
*   **Format**: Matrix or Data Frame (rows = genes, columns = samples).
*   **Data Types**: Raw counts, CPM, RPKM, FPKM, or TPM.
*   **Constraint**: Do NOT use log-transformed data as input.
*   **Constraint**: Minimum of 3 samples required for transformation.
*   **Constraint**: No NA, NaN, or INF values allowed.

### Normalization and Transformation
Linnorm provides two main ways to process data:
1.  **Linnorm()**: Performs normalizing transformation (log-style output). Use this for most downstream Linnorm functions.
2.  **Linnorm.Norm()**: Performs normalization without log transformation. Use this if downstream tools require CPM/TPM-like scales.

```r
library(Linnorm)
data(Islam2011)

# Normalizing Transformation (for parametric tests)
transformed_data <- Linnorm(Islam2011, Filter = TRUE)

# Normalization only (output as XPM/TPM)
normalized_data <- Linnorm.Norm(Islam2011, output = "XPM")
```

### Differential Expression (Linnorm-limma)
This pipeline combines Linnorm transformation with the `limma` package.
```r
# 1. Create design matrix
design <- model.matrix(~ 0 + factor(c(rep(1, 48), rep(2, 44))))
colnames(design) <- c("group1", "group2")

# 2. Run analysis
deg_results <- Linnorm.limma(Islam2011[,1:92], design)

# Access results: logFC, P.Value, adj.P.Val (FDR)
top_genes <- deg_results[order(deg_results$adj.P.Val), ][1:10, ]
```

### Cell Subpopulation Analysis (Clustering)
Linnorm supports t-SNE (recommended), PCA, and Hierarchical clustering.
```r
# t-SNE K-means (automatically determines clusters if num_center is NULL)
tsne_res <- Linnorm.tSNE(Islam2011[,1:92])
print(tsne_res$plot$plot)

# Hierarchical Clustering
hclust_res <- Linnorm.HClust(Islam2011[,1:92], num_Clust = 2)
```

### Gene Co-expression and Variable Genes
*   **Linnorm.Cor**: Identifies gene correlation networks.
*   **Linnorm.HVar**: Identifies highly variable genes (HVGs).
*   **Linnorm.SGenes**: Selects stable genes (useful when spike-ins are unavailable).

```r
# Co-expression
cor_results <- Linnorm.Cor(Islam2011[,1:48], plotNetwork = FALSE)

# Highly Variable Genes
hvg_results <- Linnorm.HVar(Islam2011[,1:48])
```

### Data Simulation (RnaXSim)
Simulate RNA-seq data with specific distributions (Negative Binomial, Poisson, Gamma, or LogNormal).
```r
# Default simulation (Negative Binomial)
sim_data <- RnaXSim(SEQC)
exp_matrix <- sim_data[[1]]
de_indices <- sim_data[[2]]
```

## Key Tips
*   **Normalization Strength**: Adjust `BE_strength` (default 0.5) in `Linnorm()` or `Linnorm.Norm()` to control the strength of batch effect/noise correction. Higher values increase strength but risk overfitting.
*   **Fold Change**: Do not calculate fold change directly from `Linnorm()` output (it is log-transformed). Use `Linnorm.limma` or see the manual for the `log((rowMeans(set1)+1)/(rowMeans(set2)+1), 2)` pattern on `Linnorm.Norm` output.
*   **Reusing Transformation**: Many functions accept `input = "Linnorm"` to use previously transformed data, saving computation time.

## Reference documentation
- [Linnorm User Manual](./references/Linnorm_User_Manual.md)