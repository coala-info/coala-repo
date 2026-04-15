---
name: cnmf
description: Consensus Non-negative Matrix Factorization decomposes single-cell gene expression matrices into gene expression programs and cell usage matrices to identify overlapping biological processes. Use when user asks to decompose expression matrices, identify gene expression programs, find overlapping biological states, or perform consensus NMF.
homepage: https://github.com/dylkot/cNMF
metadata:
  docker_image: "quay.io/biocontainers/cnmf:1.7.0--pyhdfd78af_0"
---

# cnmf

## Overview

Consensus Non-negative Matrix Factorization (cNMF) is a specialized pipeline designed to decompose single-cell gene expression matrices into two primary components: a matrix of Gene Expression Programs (GEPs) and a matrix of "usages" that describes how much each program contributes to each individual cell. Unlike standard clustering, cNMF allows cells to express multiple programs simultaneously, making it ideal for identifying continuous biological processes like the cell cycle, metabolic states, or differentiation gradients. The "Consensus" aspect ensures results are robust by running NMF multiple times and clustering the most stable solutions.

## Core Workflow

The cNMF pipeline follows a strict five-step sequence. All commands require `--output-dir` and `--name` to maintain project structure.

### 1. Prepare
Normalize the input and define the range of components ($K$) to test.
```bash
cnmf prepare --output-dir ./results --name project_alpha -c counts.h5ad -k 5 10 15 20 --n-iter 100 --numgenes 2000
```
- **Input formats**: Supports `.h5ad` (Scanpy), tab-delimited `.txt`, or 10x `.mtx` directories.
- **Tip**: Use `--numgenes` (default 2000) to select high-variance genes for factorization; all genes are re-fit in the final step.

### 2. Factorize
Run the actual NMF replicates. This is the most computationally intensive step.
```bash
# Run all iterations locally
cnmf factorize --output-dir ./results --name project_alpha --worker-index 0 --total-workers 1
```
- **Parallelization**: To speed up, split tasks across workers. For 3 workers, run three separate commands with `--worker-index` 0, 1, and 2, and `--total-workers 3`.

### 3. Combine
Merge the results from all workers and iterations.
```bash
cnmf combine --output-dir ./results --name project_alpha
```

### 4. K-Selection
Generate a diagnostic plot to choose the optimal number of programs ($K$).
```bash
cnmf k_selection_plot --output-dir ./results --name project_alpha
```
- **Decision Criteria**: Look for the $K$ value that maximizes stability (high silhouette score) while minimizing error. Local maxima in stability are often the best choice.

### 5. Consensus
Generate the final GEP and usage matrices for a specific $K$.
```bash
cnmf consensus --output-dir ./results --name project_alpha --components 12 --local-density-threshold 0.1 --show-clustering
```
- **Thresholding**: `--local-density-threshold` (default 0.1) filters out outlier NMF runs. Lower values are more stringent.

## Batch Correction

If your data has technical batch effects, use the `Preprocess` class in Python before running the CLI pipeline. This uses a Harmony-based correction on the count matrix itself.

```python
from cnmf import Preprocess
p = Preprocess()
# harmony_vars should match columns in adata.obs
(adata_c, adata_tpm, hvgs) = p.preprocess_for_cnmf(adata, harmony_vars=['Batch', 'Donor'])
```

## Expert Tips

- **Data Cleaning**: Ensure the input matrix has no cells or genes with zero total counts. Filter low-quality cells *before* the `prepare` step.
- **Memory Management**: For large datasets, use `.h5ad` files. They utilize sparse matrices and load significantly faster than text files.
- **Stability**: If the clustergram in the `consensus` step looks messy, it indicates the chosen $K$ is unstable. Consider a lower $K$ or increasing `--n-iter` in the `prepare` step.
- **Output Interpretation**: 
    - `gene_spectra_score`: Z-score units, best for identifying marker genes for a program.
    - `gene_spectra_tpm`: TPM units, representing the absolute expression contribution.
    - `usages`: Normalized so each cell sums to 1, representing the proportion of a cell's transcriptome dedicated to each GEP.



## Subcommands

| Command | Description |
|---------|-------------|
| cnmf combine | Combine NMF iterations into a single file as part of the cNMF pipeline. |
| cnmf consensus | Consensus clustering and analysis for cNMF |
| cnmf factorize | Factorize the counts matrix into gene expression programs using NMF as part of the cNMF pipeline. |
| cnmf k_selection_plot | Generate k-selection plots for cNMF analysis to help determine the optimal number of components. |
| cnmf prepare | Prepare data for cNMF analysis, including specifying input counts, components, and iterations. |

## Reference documentation
- [Consensus NMF (cNMF) README](./references/github_com_dylkot_cNMF_blob_main_README.md)
- [Stepwise Guide to cNMF](./references/github_com_dylkot_cNMF_blob_main_Stepwise_Guide.md)
- [R Vignette for cNMF](./references/github_com_dylkot_cNMF_blob_main_Tutorials_R_vignette.Rmd.md)