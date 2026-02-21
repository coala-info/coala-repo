---
name: sc3-scripts
description: The sc3-scripts package provides a suite of R-based CLI wrappers for the Single-Cell Consensus Clustering (SC3) framework.
homepage: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts
---

# sc3-scripts

## Overview

The sc3-scripts package provides a suite of R-based CLI wrappers for the Single-Cell Consensus Clustering (SC3) framework. It is designed for bioinformaticians building workflows outside of the R environment who need to perform unsupervised clustering on single-cell RNA-seq data. The tool decomposes the SC3 workflow into discrete, executable steps that communicate via serialized R objects (.rds), allowing for fine-grained control over the clustering process and easier integration into general-purpose pipeline managers.

## Core Workflow and CLI Usage

The SC3 process follows a specific linear sequence. Each script typically takes an RDS file as input (`-i`) and produces an RDS file as output (`-o`).

### 1. Data Preparation
Initialize the `SingleCellExperiment` object with filtering and SVM parameters.
```bash
sc3-sc3-prepare.R -i input.rds -f 1 -t <n_cores> -s <seed> -o prepared.rds
```
*   **Key Flags**: `-f` (gene filter toggle), `-p`/`-q` (dropout limits), `-t` (number of cores for parallel processing).

### 2. Estimating K
Estimate the optimal number of clusters (k) for the dataset.
```bash
sc3-sc3-estimate-k.R -i prepared.rds -t k_estimate.txt -o estimated_k.rds
```
*   **Tip**: The estimated k is written to a text file (`-t`) for easy inspection in downstream logic.

### 3. Distance and Transformation
Calculate distance matrices and their transformations (PCA/Laplacian).
```bash
# Calculate distances
sc3-sc3-calc-dists.R -i estimated_k.rds -o dists.rds

# Calculate transformations
sc3-sc3-calc-transfs.R -i dists.rds -o transfs.rds
```

### 4. Clustering and Consensus
Perform k-means clustering on the transformed matrices and calculate the consensus matrix.
```bash
# K-means clustering (provide k values as comma-separated list)
sc3-sc3-kmeans.R -i transfs.rds -k 2,3,4,5 -o kmeans.rds

# Consensus calculation
sc3-sc3-calc-consens.R -i kmeans.rds -t clusters.txt -o final_consensus.rds
```
*   **Expert Tip**: Use the `-k` flag in `sc3-sc3-kmeans.R` to test a range of cluster numbers simultaneously.

## Best Practices

-   **Input Format**: Ensure your starting data is a valid `SingleCellExperiment` object saved as an RDS file.
-   **Parallelization**: Always specify `-t` (n_cores) in the `prepare` step to speed up the computationally expensive parts of the SC3 algorithm.
-   **Deterministic Results**: Use the `-s` (rand_seed) flag in `sc3-sc3-prepare.R` to ensure clustering results are reproducible across different runs.
-   **Memory Management**: SC3 can be memory-intensive for very large datasets. If the cell count is high, utilize the SVM parameters (`-n` for `svm_num_cells`) in the preparation step to use the hybrid SVM approach.

## Reference documentation
- [SC3 Scripts GitHub Repository](./references/github_com_ebi-gene-expression-group_bioconductor-sc3-scripts.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_sc3-scripts_overview.md)