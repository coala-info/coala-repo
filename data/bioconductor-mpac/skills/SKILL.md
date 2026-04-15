---
name: bioconductor-mpac
description: bioconductor-mpac integrates multi-omic data with biological pathways to infer pathway entity activities using the PARADIGM algorithm. Use when user asks to integrate CNA and RNA-seq data, infer integrated pathway levels, filter activities against permuted backgrounds, or cluster samples based on pathway sub-networks.
homepage: https://bioconductor.org/packages/release/bioc/html/MPAC.html
---

# bioconductor-mpac

## Overview

MPAC (Multi-omic Pathway Analysis of Cells) is a Bioconductor package designed to integrate Copy Number Alteration (CNA) and RNA-seq data with pre-defined biological pathway networks. It utilizes the PARADIGM algorithm to infer pathway entity activities (IPLs), filters these against permuted background distributions to ensure statistical robustness, and provides tools for sample clustering and visualization of altered sub-pathways.

## Core Workflow

### 1. Input Preparation
MPAC requires tumor CNA data and RNA-seq data (both tumor and normal).

```r
library(MPAC)
library(SummarizedExperiment)

# Prepare CNA states (1: activated, 0: normal, -1: repressed)
cn_se <- ppCnInp(cn_tumor_matrix)

# Prepare RNA states (requires normal samples for baseline)
rna_se <- ppRnaInp(rna_tumor_matrix, rna_normal_matrix, threads = 2)

# Combined input for PARADIGM
real_se <- ppRealInp(cn_tumor_matrix, rna_tumor_matrix, rna_normal_matrix)
```

### 2. Permutation for Background Distribution
To filter out noise, generate permuted datasets to establish a background distribution of IPLs.

```r
# Generate permuted inputs (e.g., 100 permutations recommended for production)
perm_list <- ppPermInp(real_se, n_perms = 100)
```

### 3. Running PARADIGM
MPAC acts as a wrapper for the PARADIGM binary. You must provide the path to the local PARADIGM executable.

```r
paradigm_bin <- "/path/to/PARADIGM"
out_dir <- "paradigm_results"

# Run on real data
runPrd(real_se, pathway_file, out_dir, paradigm_bin)

# Run on permuted data
runPermPrd(perm_list, pathway_file, out_dir, paradigm_bin)
```

### 4. Collecting and Filtering IPLs
Collect the results from the output directory and filter real IPLs against the permuted background.

```r
# Collect
real_ipl <- colRealIPL(file.path(out_dir, "real"))
perm_ipl <- colPermIPL(file.path(out_dir, "perm"), n_perms = 100)

# Filter: Entities observed by chance are set to NA
filtered_mat <- fltByPerm(real_ipl, perm_ipl)
```

### 5. Network Analysis and Clustering
Identify the largest active sub-pathways and cluster samples based on GO term over-representation.

```r
# Find largest sub-pathway per sample
sub_networks <- subNtw(filtered_mat, pathway_file, gmt_file)

# Gene set over-representation
ovr_mat <- ovrGMT(sub_networks, gmt_file, omic_genes)

# Cluster samples (run multiple times to ensure stability)
clusters <- clSamp(ovr_mat, n_random_runs = 10)
```

## Visualization and Diagnostics

*   **pltOvrHm**: Heatmap of samples clustered by over-represented GO terms.
*   **pltConMtf**: Visualize consensus pathway submodules shared within a cluster.
*   **pltMtfPrtIPL**: Heatmap of IPLs for specific proteins across clusters.
*   **pltSttKM**: Kaplan-Meier survival analysis stratified by pathway states (e.g., `strat_func = ">0"` for activated).
*   **pltNeiStt**: Diagnostic heatmap showing a protein's omic state alongside its pathway neighbors to identify upstream determinants.

## Tips for Success
*   **PARADIGM Binary**: Ensure the PARADIGM binary is compatible with your OS (Linux/MacOS).
*   **Pathway Files**: The `pathway_file` should be in the format expected by PARADIGM (typically a tab-delimited interaction file).
*   **Memory Management**: For large cohorts, `runPermPrd` can be computationally intensive; utilize the `threads` argument where available.

## Reference documentation
- [MPAC: Multi-omic Pathway Analysis of Cells](./references/MPAC.md)
- [MPAC Vignette Source](./references/MPAC.Rmd)