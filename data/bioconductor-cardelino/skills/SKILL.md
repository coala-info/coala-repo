---
name: bioconductor-cardelino
description: This tool infers the clonal identity of single cells from scRNA-seq data by integrating somatic mutation information with clonal trees. Use when user asks to assign single cells to clones, perform de-novo clustering of cells based on mutations, or load variant count matrices from VCF files.
homepage: https://bioconductor.org/packages/release/bioc/html/cardelino.html
---


# bioconductor-cardelino

name: bioconductor-cardelino
description: Infer clonal identity of single cells from scRNA-seq data using somatic mutations and clonal trees. Use this skill when you need to assign single cells to clones, work with variant count matrices (A and D), or integrate clonal structures (e.g., from Canopy) with single-cell transcriptomic data.

# bioconductor-cardelino

## Overview
The `cardelino` package provides a Bayesian mixture model to probabilistically assign single cells to clones based on somatic mutation information extracted from scRNA-seq reads. It accounts for the inherent sparsity of scRNA-seq data and sequencing errors using a beta-binomial model. It can function in a "supervised" mode using a known clonal tree (configuration matrix) or a "de-novo" mode to cluster cells into a specified number of clones.

## Core Workflow

### 1. Data Preparation
The model requires two primary matrices and an optional configuration matrix:
- **A**: Variant x Cell matrix of integer counts (reads supporting the alternative/mutant allele).
- **D**: Variant x Cell matrix of integer counts (total read coverage at the mutation site).
- **Config** (Optional): Variant x Clone binary matrix (1 if mutation is present in clone, 0 otherwise).

### 2. Loading Data from VCF
You can extract the A and D matrices directly from VCF files (e.g., from `cellsnp-lite` or `mpileup`):

```r
library(cardelino)

# Load from cellSNP VCF
vcf_file <- "path/to/cellSNP.cells.vcf.gz"
input_data <- load_cellSNP_vcf(vcf_file)
# Access matrices via input_data$A and input_data$D

# Alternatively, use generic VCF reader
vcf <- read_vcf("path/to/file.vcf.gz")
input_data <- get_snp_matrices(vcf)
```

### 3. Clonal Assignment (With Tree)
If you have a clonal tree (e.g., from the `Canopy` package), use the `Z` matrix as the `Config`:

```r
# Run clone ID inference
# Note: Increase min_iter/max_iter for production (default is usually sufficient)
assignments <- clone_id(input_data$A, input_data$D, Config = tree$Z)

# Assign cells to clones based on a posterior probability threshold (default > 0.5)
df_assignments <- assign_cells_to_clones(assignments$prob)
table(df_assignments$clone)
```

### 4. De-novo Clustering (Without Tree)
If no clonal tree is available, or for mitochondrial variation analysis:

```r
# Cluster into 3 clones de-novo
assignments <- clone_id(input_data$A, input_data$D, Config = NULL, n_clone = 3)
```

## Visualization and Interpretation
- **Probability Heatmap**: Visualize the confidence of cell assignments.
  ```r
  prob_heatmap(assignments$prob)
  ```
- **Variant-Cell Heatmap**: Show raw allele frequencies alongside assignments.
  ```r
  AF <- as.matrix(input_data$A / input_data$D)
  vc_heatmap(AF, assignments$prob, Config)
  ```
- **Tree Plotting**: Visualize the input clonal structure.
  ```r
  plot_tree(tree, orient = "v")
  ```

## Tips for Success
- **ID Matching**: Ensure the row names (variant IDs) of your `Config` matrix exactly match the row names of your `A` and `D` matrices.
- **Convergence**: `clone_id` uses Gibbs sampling. Check the output for convergence messages. If it fails to converge, increase `max_iter`.
- **Base Clone**: By default, `cardelino` assumes "clone1" is the base clone (no mutations). If using de-novo mode without a base clone, set `keep_base_clone = FALSE`.
- **Mitochondrial Data**: For mtDNA, coverage is typically higher. Use `clone_id` on mtDNA variant matrices to identify sub-populations without nuclear somatic mutations.

## Reference documentation
- [Clone ID with cardelino](./references/vignette-cloneid.Rmd)
- [Clone ID with cardelino (Markdown)](./references/vignette-cloneid.md)