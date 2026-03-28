---
name: sc3-scripts
description: sc3-scripts provides a suite of command-line tools for performing modular, step-by-step SC3 clustering on single-cell RNA-seq data. Use when user asks to prepare SingleCellExperiment objects, estimate the number of clusters, calculate distance matrices, perform k-means clustering, or generate consensus matrices.
homepage: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts
---

# sc3-scripts

## Overview

The `sc3-scripts` package provides a suite of R-based command-line tools that wrap the internal functions of the SC3 Bioconductor package. It enables a modular, step-by-step execution of the SC3 clustering pipeline, allowing users to process `SingleCellExperiment` objects stored as `.rds` files. This is ideal for high-throughput bioinformatics pipelines where individual stages of the clustering process need to be executed, monitored, or parallelized independently.

## Core Workflow and CLI Usage

The SC3 pipeline follows a specific sequence. Each script typically takes an `.rds` file as input (`-i`) and produces an updated `.rds` file as output (`-o`).

### 1. Preparation
Prepare the `SingleCellExperiment` object by filtering genes and setting up parameters.
```bash
sc3-sc3-prepare.R -i input.rds -f TRUE -t <n_cores> -s <seed> -o prepared.rds
```
*   **Key Flags**: `-f` (gene filter), `-t` (cores for parallel processing), `-s` (random seed for reproducibility).

### 2. Estimating K
Estimate the optimal number of clusters (k) for the dataset.
```bash
sc3-sc3-estimate-k.R -i prepared.rds -t k_estimate.txt -o estimated_k.rds
```
*   **Key Flags**: `-t` (path to a text file where the estimated k value will be written).

### 3. Distance Calculation
Calculate distance matrices (Euclidean, Pearson, Spearman).
```bash
sc3-sc3-calc-dists.R -i estimated_k.rds -o dists.rds
```

### 4. Transformations
Calculate transformations (PCA, Laplacian) of the distance matrices.
```bash
sc3-sc3-calc-transfs.R -i dists.rds -o transfs.rds
```

### 5. K-Means Clustering
Perform k-means clustering on the transformed matrices for a range of k values.
```bash
sc3-sc3-kmeans.R -i transfs.rds -k 2,3,4,5 -o kmeans.rds
```
*   **Key Flags**: `-k` (comma-separated list of k values to try).

### 6. Consensus Clustering
Calculate the consensus matrix and identify stable clusters.
```bash
sc3-sc3-calc-consens.R -i kmeans.rds -o consensus.rds
```

## Expert Tips and Best Practices

- **Reproducibility**: Always provide a fixed random seed using the `-s` flag in `sc3-sc3-prepare.R` to ensure clustering results are consistent across runs.
- **Parallelization**: Use the `-t` flag in the preparation and calculation steps to utilize multiple CPU cores, as SC3 can be computationally intensive on large datasets.
- **Memory Management**: Since these scripts pass large `SingleCellExperiment` objects via `.rds` files, ensure your environment has sufficient disk I/O speed and RAM to load and save these objects at each step.
- **Validation**: Use `sc3-sc3-validate.R` (if available in your installation) to check the integrity of the `SingleCellExperiment` object between steps if you encounter unexpected errors.
- **Gene Filtering**: The `-f` flag in the prepare step is enabled by default in the underlying R package; ensure you explicitly set it based on whether your input data is already filtered.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/sc3-sc3-calc-consens.R | Calculates the consensus matrix for SC3. |
| /usr/local/bin/sc3-sc3-calc-transfs.R | Calculates transformations for SC3. |
| /usr/local/bin/sc3-sc3-estimate-k.R | Estimate the number of clusters (k) for SC3. |
| /usr/local/bin/sc3-sc3-kmeans.R | Performs k-means clustering on a SC3 SingleCellExperiment object. |
| sc3-sc3-calc-dists.R | Calculates distances between cells. |
| sc3-sc3-prepare.R | Prepare SingleCellExperiment object for SC3 clustering. |

## Reference documentation
- [SC3 Scripts README](./references/github_com_ebi-gene-expression-group_bioconductor-sc3-scripts_blob_develop_README.md)
- [Post-Install Test Workflow](./references/github_com_ebi-gene-expression-group_bioconductor-sc3-scripts_blob_develop_bioconductor-sc3-scripts-post-install-tests.sh.md)