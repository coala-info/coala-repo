---
name: cnmf
description: "Consensus Non-negative Matrix Factorization (cNMF) is a specialized pipeline for decomposing single-cell expression matrices into two components: a \"usage\" matrix (mapping cells to programs) and a \"spectra\" matrix (mapping programs to genes)."
homepage: https://github.com/dylkot/cNMF
---

# cnmf

## Overview

Consensus Non-negative Matrix Factorization (cNMF) is a specialized pipeline for decomposing single-cell expression matrices into two components: a "usage" matrix (mapping cells to programs) and a "spectra" matrix (mapping programs to genes). Unlike standard NMF, cNMF executes multiple factorization trials to ensure that the resulting programs are stable and reproducible. This skill facilitates the execution of the cNMF command-line interface (CLI) to process count matrices, handle batch effects via Harmony integration, and determine the optimal number of biological programs (K) through stability-error trade-off analysis.

## Core Workflow

The cNMF pipeline follows a strict sequential order. All commands require the `--output-dir` and `--name` parameters to maintain project consistency.

### 1. Preparation
Initialize the project and define the range of components (K) to test.
```bash
cnmf prepare --output-dir ./results --name project_alpha -c ./data/counts.h5ad -k 10 15 20 25 --n-iter 100 --seed 42
```
*   **Input formats**: Supports `.h5ad` (Scanpy), tab-delimited `.txt`, or 10x Genomics `.mtx` directories.
*   **Recommendation**: Use `.h5ad` for significantly faster loading and lower memory footprint.

### 2. Factorization
This is the most computationally intensive step. It performs the NMF iterations for all specified K values.
```bash
# Single worker execution
cnmf factorize --output-dir ./results --name project_alpha --worker-index 0 --total-workers 1
```
*   **Parallelization**: To run on a cluster, submit multiple jobs with incrementing `--worker-index` (starting at 0) up to `--total-workers`.

### 3. Combination
Merge the results from all factorization workers.
```bash
cnmf combine --output-dir ./results --name project_alpha
```

### 4. K-Selection
Generate a diagnostic plot to determine the optimal number of programs.
```bash
cnmf k_selection_plot --output-dir ./results --name project_alpha
```
*   **Decision Logic**: Look for a K value where "Stability" (silhouette score) is high and "Error" (Frobenius loss) is low. Usually, this is a "knee" in the plot.

### 5. Consensus
Finalize the GEPs and cell usages for a specific K.
```bash
cnmf consensus --output-dir ./results --name project_alpha --components 15 --local-density-threshold 0.1 --show-clustering
```
*   **Density Threshold**: Lowering this (e.g., 0.01) includes more outliers; increasing it (e.g., 0.2) ensures only the most robustly clustered iterations contribute to the final programs.

## Expert Tips and Best Practices

*   **Batch Correction**: If your data has technical batches, use the `Preprocess` class in a Python script before running the CLI. cNMF uses a modified Harmony algorithm that corrects the count matrix directly rather than just the PCA space.
*   **High-Variance Genes (HVGs)**: cNMF is typically run on the top 2,000–3,000 HVGs to reduce noise and computation time. Ensure these are correctly identified during the `prepare` step or provided via a `--genes-file`.
*   **Memory Management**: Version 1.7+ includes more efficient sparse matrix operations. If encountering OOM (Out of Memory) errors, ensure you are using the latest version and that your input is a sparse `.h5ad` file.
*   **Interpreting Results**:
    *   `*.gene_spectra_score.*.txt`: Z-score unit gene expression programs (best for identifying marker genes).
    *   `*.gene_spectra_tpm.*.txt`: GEPs in TPM units (best for comparing expression levels).
    *   `*.usages.*.txt`: The proportion of each program active in each cell (normalized to sum to 1).

## Reference documentation
- [cNMF GitHub Repository](./references/github_com_dylkot_cNMF.md)
- [Bioconda cNMF Overview](./references/anaconda_org_channels_bioconda_packages_cnmf_overview.md)