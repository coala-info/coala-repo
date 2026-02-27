---
name: bioconductor-coseq
description: The coseq package performs co-expression analysis of RNA-seq data by clustering transformed normalized profiles using K-means or Gaussian Mixture Models. Use when user asks to cluster differentially expressed genes, identify co-expression patterns in transcriptomic data, or perform model selection for gene clusters using ICL or slope heuristics.
homepage: https://bioconductor.org/packages/release/bioc/html/coseq.html
---


# bioconductor-coseq

## Overview

The `coseq` package is designed for the co-expression analysis of RNA-seq data. Unlike methods that cluster raw counts, `coseq` clusters **transformed normalized profiles**. It supports two primary clustering strategies:
1. **K-means**: Fast, assumes diagonal covariance, uses slope heuristics for model selection.
2. **Gaussian Mixture Models (GMM)**: More computationally intensive, allows for complex correlation structures, uses Integrated Completed Likelihood (ICL) for model selection.

The package integrates directly with `DESeq2` and `edgeR` objects, making it easy to cluster genes identified as differentially expressed.

## Typical Workflow

### 1. Basic Clustering (K-means)
The default approach uses K-means with a log-centered log ratio (logCLR) transformation and TMM normalization.

```r
library(coseq)

# counts: matrix or data.frame of gene-level counts (genes x samples)
# K: range of clusters to test
run <- coseq(counts, K=2:25, seed=12345)

# Summary of selected model
summary(run)

# Get cluster assignments
gene_clusters <- clusters(run)

# Get conditional probabilities (for GMM) or membership
prob_membership <- assay(run)
```

### 2. Gaussian Mixture Model (GMM)
Use GMM when you need to estimate correlation structures between samples within clusters. The arcsine transformation is recommended for this approach.

```r
run_gmm <- coseq(counts, K=2:20, 
                 model="Normal", 
                 transformation="arcsin", 
                 meanFilterCutoff=200, 
                 iter=10, 
                 seed=12345)

# Compare transformations (e.g., arcsin vs logit) using ICL
# compareICL(list(run_arcsin, run_logit))
```

### 3. Integration with DESeq2/edgeR
`coseq` can be run directly on results from differential expression (DE) pipelines. It will automatically use the normalization factors from the object and subset genes based on significance.

```r
# DESeq2 Example
library(DESeq2)
dds <- DESeq(DESeqDataSetFromMatrix(counts, colData, ~condition))
# Clusters genes with adjusted p-value < 0.1 by default
run_de <- coseq(dds, K=2:15)

# edgeR Example
library(edgeR)
# ... (standard edgeR pipeline to create 'qlf' or 'lrt' object)
run_edgeR <- coseq(counts, K=2:15, subset=qlf, alpha=0.05)
```

## Visualization and Exploration

The `plot` function for `coseqResults` objects provides several diagnostic and exploratory views.

```r
# Plot specific graph types
plot(run, graphs="boxplots")
plot(run, graphs="profiles")

# Customize with condition labels and collapsing replicates
plot(run, graphs="boxplots", conds=conds, collapse_reps="average")

# Diagnostic plots for model selection
plot(run, graphs=c("logLike", "ICL"))

# Probability of membership diagnostics
plot(run, graphs="probapost_histogram")
```

## Tips and Best Practices

- **Reproducibility**: Always use the `seed` argument in the `coseq()` function, as initialization is random.
- **Transformation Choice**: 
    - **logCLR**: Best for highlighting highly specific profiles (e.g., tissue-specific genes).
    - **CLR**: Best for distinguishing fine differences among genes with similar expression levels.
    - **arcsin**: Recommended for Gaussian Mixture Models.
- **Filtering**: Use `meanFilterCutoff` to remove lowly expressed genes, which improves both speed and cluster quality.
- **Parallelization**: For large datasets or GMM, use `parallel=TRUE` (requires `BiocParallel`).
- **Convergence**: Check `metadata(run)$nbClusterError` to see if any models failed to converge.
- **Custom Plots**: The `plot()` function returns a list of `ggplot2` objects. You can modify them by accessing the list element (e.g., `p$boxplots + theme_bw()`).

## Reference documentation

- [coseq](./references/coseq.md)