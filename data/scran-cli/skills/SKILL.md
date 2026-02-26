---
name: scran-cli
description: "scran-cli provides a command-line interface for performing single-cell RNA-seq normalization, variance modeling, and clustering using the scran R package. Use when user asks to normalize single-cell data, model gene variance, denoise PCA results, build SNN graphs, or identify marker genes."
homepage: https://github.com/ebi-gene-expression-group/scran-cli
---


# scran-cli

## Overview

The `scran-cli` toolset provides a bridge between the specialized single-cell analysis functions of the `scran` R package and standard shell-based bioinformatics pipelines. It is particularly useful for researchers who need to integrate robust R-based normalization and clustering methods into automated workflows. The tool operates primarily on `SingleCellExperiment` (SCE) objects stored in `.rds` format, allowing for a modular approach to scRNA-seq processing.

## Core Workflows and Commands

### 1. Normalization
Normalization is essential to remove cell-specific biases.

*   **Deconvolution (Sum Factors):** Use when you assume most genes are not differentially expressed.
    ```bash
    scran-compute-sum-factors.R -i input.rds -a counts -o normalized.rds
    ```
*   **Spike-in Normalization:** Use when you have ERCC or other spike-ins and want to preserve differences in total RNA content.
    ```bash
    scran-compute-spike-factors.R -i input.rds -s "ERCC" -o spike_normalized.rds
    ```

### 2. Variance Modeling and Denoising
Identify highly variable genes and reduce technical noise.

*   **Modeling Variance:** Note that `scran-trend-var.R` is for older versions (v1.12). For newer versions (v1.14+), use `scran-model-gene-var.R`.
    ```bash
    scran-model-gene-var.R -i normalized.rds -o var_model.rds
    ```
*   **PCA Denoising:** Remove principal components that represent technical noise based on the variance model.
    ```bash
    scran-denoise-pca.R -i normalized.rds -t var_model.rds -o denoised_pca.rds
    ```

### 3. Clustering and Graph Building
`scran-cli` uses a two-step process for clustering: building a graph and then extracting clusters.

*   **Build SNN Graph:** Creates a shared nearest-neighbor graph.
    ```bash
    scran-build-snn-graph.R -i denoised_pca.rds -s TRUE -o snn_graph.rds
    ```
*   **Extract Clusters:** Converts the igraph object back into cluster annotations within the SCE object.
    ```bash
    igraph_extract_clusters.R -i snn_graph.rds -s denoised_pca.rds -o clustered_sce.rds
    ```

### 4. Marker Gene Identification
Find genes that define your clusters.

```bash
scran-find-markers.R -i clustered_sce.rds -c "cluster" -o markers.rds
```
*   **Tip:** If using raw counts, ensure you use `test.type="binom"`. For log-normalized data, "wilcox" or "t" tests are standard.

## Expert Tips and Best Practices

*   **Assay Selection:** Always verify which assay you are targeting (e.g., `counts`, `logcounts`) using the `-a` flag. Most downstream tools expect log-normalized data.
*   **Version Awareness:** The transition from `scran` 1.12 to 1.14 introduced significant changes. If `scran-trend-var.R` fails or is unavailable, switch to `scran-model-gene-var.R`.
*   **File Formats:** All inputs and outputs are typically `.rds` files. Ensure your upstream tools (like `Seurat` or `Scanpy`) have converted data to `SingleCellExperiment` format before using this CLI.
*   **Memory Management:** Single-cell objects can be large. When running these scripts in a high-performance computing (HPC) environment, ensure you allocate sufficient RAM for R to load the entire SCE object into memory.

## Reference documentation
- [scran-cli Overview](./references/anaconda_org_channels_bioconda_packages_scran-cli_overview.md)
- [scran-cli GitHub Repository](./references/github_com_ebi-gene-expression-group_scran-cli.md)