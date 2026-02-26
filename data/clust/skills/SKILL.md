---
name: clust
description: clust identifies groups of genes with consistent co-expression profiles across multiple heterogeneous datasets. Use when user asks to cluster gene expression data, identify co-expressed gene groups, or perform automated normalization and clustering across different sequencing technologies.
homepage: https://github.com/baselabujamous/clust
---


# clust

## Overview

`clust` is a specialized tool for bioinformatics that identifies groups of genes with consistent co-expression profiles across multiple datasets. It is designed to handle the "noise" and "heterogeneity" typical of biological data, such as varying sample sizes, different sequencing technologies (RNA-seq vs. Microarray), and cross-species comparisons. Its primary advantage is full automation: it determines the optimal number of clusters and applies necessary normalization steps without extensive user configuration.

## CLI Usage and Best Practices

### Basic Execution
The simplest way to run `clust` is by providing a path to a single TSV file or a directory containing multiple TSV files.
```bash
# Run on a single dataset
clust path/to/data.txt

# Run on all datasets within a directory
clust path/to/data_directory/ -o output_results/
```

### Data Format Requirements
*   **File Type**: TAB-delimited (TSV).
*   **Structure**: First column must be Gene IDs; first row must be unique sample labels.
*   **Gene IDs**: To link genes across multiple datasets, the IDs must be identical. `clust` automatically summarizes rows with duplicate IDs by summing their values.
*   **Naming**: Avoid spaces, commas, or semicolons in gene names.

### Key Parameters and Tuning
*   **Tightness (`-t`)**: This is the primary parameter for controlling cluster granularity. 
    *   Increase `-t` to get larger, looser clusters.
    *   Decrease `-t` to get smaller, more tightly correlated clusters.
*   **Normalization (`-n`)**: While `clust` (v1.7.0+) automatically detects the best normalization, you can manually override it using specific codes.
    *   `101`: Log-base-10 transformation (common for TPM/FPKM).
    *   `3`: Log-base-2 transformation.
    *   `4`: Quantile normalization.
    *   Example: `clust data_path -n 101 3` (applies log10 then log2).
*   **Replicates (`-r`)**: If your data contains replicates, provide a replicate file to ensure `clust` summarizes them correctly rather than treating them as independent conditions.

### Handling Heterogeneous Data
*   **Multiple Species**: When clustering data from different species, ensure Gene IDs are mapped to a common orthology (e.g., using Ensembl IDs) before running the tool.
*   **Mixed Technologies**: `clust` can process a directory containing both RNA-seq (TPM) and Microarray data simultaneously; it will normalize each file according to its specific distribution.

## Expert Tips
*   **Output Inspection**: Always check the `Normalisation_actual` file in the output directory to verify which normalization techniques `clust` automatically selected for your datasets.
*   **Noisy Data**: If you obtain too many small clusters or "noisy" results, try decreasing the `-t` parameter or filtering out genes with very low expression values before running `clust`.
*   **Missing Values**: `clust` can handle datasets where some genes are missing from certain files, provided there is enough overlap across the majority of the datasets to establish a consensus.

## Reference documentation
- [Clust GitHub Repository](./references/github_com_baselabujamous_clust.md)
- [Bioconda Clust Overview](./references/anaconda_org_channels_bioconda_packages_clust_overview.md)