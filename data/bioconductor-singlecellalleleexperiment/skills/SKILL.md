---
name: bioconductor-singlecellalleleexperiment
description: This package extends the SingleCellExperiment class to support multi-layer quantification and analysis of immune genes at the allele, gene, and functional group levels. Use when user asks to create a SingleCellAlleleExperiment object, process multi-layer immune gene count matrices, or subset single-cell data by immune quantification levels.
homepage: https://bioconductor.org/packages/release/bioc/html/SingleCellAlleleExperiment.html
---

# bioconductor-singlecellalleleexperiment

## Overview

The `SingleCellAlleleExperiment` package extends the standard `SingleCellExperiment` (SCE) class to support multi-layer quantification of immune genes. It allows researchers to simultaneously analyze data at three levels of granularity:
1. **Alleles**: Specific variants (e.g., `A*02:01:01:01`).
2. **Immune Genes**: Aggregated allele counts (e.g., `HLA-A`).
3. **Functional Classes**: Groups of similar genes (e.g., `HLA-class I`).

This structure is particularly useful for immunogenomic studies where donor-specific allelic diversity impacts gene expression analysis and inter-donor comparability.

## Core Workflow

### 1. Data Loading and Object Creation

The primary entry point is `read_allele_counts()`. It processes raw count matrices and integrates them with a lookup table to build the multi-layer object.

```r
library(SingleCellAlleleExperiment)

# Required files: barcodes.txt, features.txt, matrix.mtx, and lookup_table.csv
scae <- read_allele_counts(
  sample_dir = "path/to/data",
  sample_names = "my_sample",
  lookup_file = "lookup_table.csv",
  filter_mode = "yes", # Options: "yes" (knee-plot), "no" (threshold 0), "custom"
  log = TRUE           # Automatically compute logcounts
)
```

### 2. Accessing Data Layers

SCAE provides specific getter functions to extract subsets of the experiment based on the quantification level.

```r
# Extract specific layers
ni_genes <- scae_subset(scae, "nonimmune")
alleles  <- scae_subset(scae, "alleles")
i_genes  <- scae_subset(scae, "immune_genes")
func_grp <- scae_subset(scae, "functional_groups")

# Check row metadata for layer identification
rowData(scae) # Contains 'NI_I' (Non-Immune/Immune) and 'Quant_type' (G/A/F)
```

### 3. Downstream Analysis

Because SCAE inherits from `SingleCellExperiment`, it is compatible with `scater` and `scran`. A common pattern is to create subsets combining non-immune genes with a specific immune layer for dimensionality reduction.

```r
library(scran)
library(scater)

# Combine non-immune genes with immune genes for PCA
target_rows <- c(rownames(scae_subset(scae, "nonimmune")), 
                 rownames(scae_subset(scae, "immune_genes")))
scae_sub <- scae[target_rows, ]

# Standard Bioconductor workflow
dec <- modelGeneVar(scae_sub)
top_hvgs <- getTopHVGs(dec, prop = 0.1)
scae <- runPCA(scae, subset_row = top_hvgs, name = "PCA_immune_genes")
scae <- runTSNE(scae, dimred = "PCA_immune_genes", name = "TSNE_immune_genes")
```

### 4. Visualization

Use `plotExpression` to compare expression across different layers (e.g., comparing a gene to its constituent alleles).

```r
# Visualize a gene and its alleles
plotExpression(scae, features = c("HLA-A", "A*02:01:01:01", "A*24:02:01:01"))

# Plot reduced dimensions colored by allele expression
plotReducedDim(scae, dimred = "TSNE_immune_genes", colour_by = "A*02:01:01:01")
```

## Usage Tips

- **Filtering**: If using `filter_mode = "yes"`, you can inspect the knee plot data in `metadata(scae)[["knee_info"]]`.
- **Normalization**: When manually normalizing, ensure scaling factors are calculated only on the raw data layers (non-immune and alleles) to avoid double-counting the aggregated layers (genes/functional groups). `read_allele_counts(log=TRUE)` handles this correctly by default.
- **Interactive Exploration**: The object is fully compatible with `iSEE` for interactive visualization.
- **Gene Symbols**: If your input uses Ensembl IDs, set `gene_symbols = TRUE` in `read_allele_counts()` to map them to symbols using `org.Hs.eg.db`.

## Reference documentation

- [An introduction to the SingleCellAlleleExperiment class](./references/intro.Rmd)
- [SingleCellAlleleExperiment Workflow Overview](./references/scae_intro.md)