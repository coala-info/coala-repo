---
name: scran-cli
description: The scran-cli toolset provides a command-line interface for performing low-level analysis of single-cell transcriptomics data using the scran Bioconductor package. Use when user asks to normalize single-cell data, model gene variance, denoise PCA results, build SNN graphs for clustering, or identify marker genes.
homepage: https://github.com/ebi-gene-expression-group/scran-cli
---

# scran-cli

## Overview

The `scran-cli` toolset provides a command-line interface for the Bioconductor `scran` package, which is essential for the low-level analysis of single-cell transcriptomics data. It allows users to perform complex R-based workflows—such as deconvolution-based normalization, technical noise removal, and SNN graph construction—directly from the terminal. This is particularly useful for building reproducible bioinformatics pipelines where data is passed between steps as serialized R objects (.rds).

## Core Workflow Patterns

### 1. Normalization
Normalization removes cell-specific biases. Use `scran-compute-sum-factors.R` for standard scaling normalization or `scran-compute-spike-factors.R` if using spike-in transcripts.

```bash
# Scaling normalization by deconvolving size factors
scran-compute-sum-factors.R -i input_sce.rds -a counts -o normalized_sce.rds

# Normalization based on spike-ins (e.g., ERCC)
scran-compute-spike-factors.R -i input_sce.rds -s "ERCC" -o normalized_sce.rds
```

### 2. Variance Modeling and Denoising
Identify highly variable genes (HVGs) and reduce dimensionality by removing technical noise.

*   **Note on Versions**: Use `scran-model-gene-var.R` for modern workflows (scran 1.14+). `scran-trend-var.R` is deprecated.

```bash
# Model gene variance
scran-model-gene-var.R -i normalized_sce.rds -o variance_stats.rds

# Denoise PCA based on the variance model
scran-denoise-pca.R -i normalized_sce.rds -t variance_stats.rds -o denoised_sce.rds
```

### 3. Clustering
Clustering in `scran` typically involves building a Shared Nearest Neighbor (SNN) graph and then extracting clusters.

```bash
# Build SNN graph (outputs an igraph object)
scran-build-snn-graph.R -i denoised_sce.rds -s TRUE -o snn_graph.rds

# Extract clusters and add them back to the SCE object
igraph_extract_clusters.R -i snn_graph.rds -s denoised_sce.rds -o final_clustered_sce.rds
```

### 4. Marker Detection and Correlation
Identify genes that define your clusters or find significantly correlated gene pairs.

```bash
# Find marker genes for clusters
scran-find-markers.R -i final_clustered_sce.rds -c "cluster" -o markers_list.rds

# Identify significantly correlated gene pairs
scran-correlate-pairs.R -i final_clustered_sce.rds -o pairwise_correlations.txt
```

## Expert Tips and Best Practices

*   **Input Format**: All scripts expect the input to be a serialized R `SingleCellExperiment` object in `.rds` format.
*   **Assay Selection**: When using `scran-compute-sum-factors.R`, ensure the `-a` flag points to the correct assay (usually `counts`).
*   **Downstream Compatibility**: Use `scran-convert-to.R` to export your SCE object to other popular frameworks like `edgeR`, `DESeq2`, or `monocle`.
    ```bash
    scran-convert-to.R -i final_sce.rds -o "DESeq2"
    ```
*   **Cluster Extraction**: The `igraph_extract_clusters.R` script uses the Walktrap community detection algorithm by default to define clusters from the SNN graph.
*   **Memory Management**: Single-cell objects can be large. Ensure your environment has sufficient RAM, especially during the `scran-build-snn-graph.R` and `scran-correlate-pairs.R` steps.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/igraph_extract_clusters.R | Extracts cluster annotations from an igraph object and adds them to a SingleCellExperiment object. |
| scran-build-snn-graph.R | Builds a Shared Nearest Neighbor (SNN) graph or a k-Nearest Neighbor (kNN) graph from a Single-Cell Experiment (SCE) object. |
| scran-cli_scran-denoise-pca.R | Performs PCA-based denoising on a SingleCellExperiment object. |
| scran-compute-spike-factors.R | Compute spike-in size factors for SingleCellExperiment objects. |
| scran-compute-sum-factors.R | Computes size factors for single-cell RNA-seq data. |
| scran-find-markers.R | Finds marker genes for each cluster/group in a SingleCellExperiment object. |
| scran-model-gene-var.R | Model gene variance using scran |

## Reference documentation
- [Wrapper scripts for components of the scran package](./references/github_com_ebi-gene-expression-group_scran-cli_blob_develop_README.md)
- [Extract clustering annotation from igraph class object](./references/github_com_ebi-gene-expression-group_scran-cli_blob_develop_igraph_extract_clusters.R.md)