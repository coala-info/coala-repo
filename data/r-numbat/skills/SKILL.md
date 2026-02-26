---
name: r-numbat
description: r-numbat performs haplotype-aware copy number variation analysis and clonal phylogeny reconstruction from single-cell RNA-seq or spatial transcriptomics data. Use when user asks to infer allele-specific CNVs, differentiate tumor from normal cells, or reconstruct tumor clonal architecture.
homepage: https://cran.r-project.org/web/packages/numbat/index.html
---


# r-numbat

name: r-numbat
description: Haplotype-aware CNV analysis from single-cell RNA-seq (scRNA-seq) and spatial transcriptomics. Use this skill to infer allele-specific copy number variations, differentiate tumor vs. normal cells, and reconstruct tumor phylogeny/clonal architecture. It integrates gene expression, allelic ratio, and population-derived haplotype information.

# r-numbat

## Overview
Numbat is a computational method for inferring copy number variations (CNVs) from scRNA-seq and spatial transcriptomics data. It integrates signals from gene expression, allelic ratio, and population-derived haplotype structures to accurately infer allele-specific CNVs in single cells and reconstruct their lineage relationship. It does not require paired DNA or genotype data, operating solely on donor scRNA-seq data (e.g., 10x Cell Ranger output).

## Installation
```R
# Install from CRAN
install.packages('numbat', dependencies = TRUE)

# Or install the development version from GitHub
# devtools::install_github("kharchenkolab/numbat")
```

## Core Workflow

### 1. Prepare Input Data
Numbat requires three main inputs:
- **Count Matrix**: Gene x cell integer UMI count matrix.
- **Allele Dataframe**: Phased allele counts (typically generated via the `pileup_and_phase.R` script provided with the package).
- **Expression Reference**: Gene x cell type matrix of normalized expression values.

```R
library(numbat)

# Create a reference from internal normal cells if available
# count_mat: gene x cell raw counts; cell_annot: df with "cell" and "group"
ref_internal = aggregate_counts(count_mat, cell_annot)

# Or use the built-in HCA reference
# data("ref_hca")
```

### 2. Run Numbat Inference
The primary interface is `run_numbat()`.

```R
out = run_numbat(
    count_mat,      # gene x cell integer UMI count matrix 
    ref_hca,        # reference expression profile
    df_allele,      # allele dataframe
    genome = "hg38",
    t = 1e-5,       # transition probability
    ncores = 4,
    plot = TRUE,
    out_dir = './numbat_out'
)
```

### 3. Key Parameters
- `t`: Transition probability (lower `t` for complex landscapes/subclonal events; higher `t` to reduce false positives).
- `gamma`: Overdispersion in allele counts (default 20 for 10x; use ~5 for noisier data like SMART-Seq).
- `min_LLR`: Minimum log-likelihood ratio to filter CNVs (default 5).
- `max_entropy`: Filter for single-cell CNV uncertainty (default 0.5).
- `call_clonal_loh`: Set to `TRUE` for high-purity samples without matched normal cells.

## Analysis and Visualization
Use the `Numbat` R6 class to interact with results.

```R
nb = Numbat$new(out_dir = './numbat_out')

# Integrated phylogeny and CNV heatmap
nb$plot_phylo_heatmap(clone_bar = TRUE, p_min = 0.9)

# Plot pseudobulk CNV profiles by clone
nb$bulk_clones %>% plot_bulks(min_LLR = 10)

# Refine subclones by cutting the tree
nb$cutree(n_cut = 3)

# Plot mutation history (clone level)
nb$plot_mut_history()
```

## Specialized Workflows

### Spatial Transcriptomics (Visium)
Numbat treats spatial spots as "cells."
- Set `max_entropy` higher (e.g., 0.8) due to sparser allele coverage.
- Use `nb$clone_post$p_cnv` to delineate tumor/normal boundaries in spatial coordinates.

### Mouse Data (F1 Hybrids)
For F1 hybrid mice (e.g., C57BL/6 x Sv129):
- Set `genome = "mm10"`.
- Set `nu = 0` to disable phase switching (since haplotypes are perfectly known).

### Numbat-multiome
Supports joint RNA and ATAC CNV analysis using binned inputs.
- Requires a `binGR` (GRanges object of genomic bins).
- Use `run_numbat_multiome.R` logic for combined modality inference.

## Reference documentation
- [Output descriptions](./references/descriptions.md)
- [Mouse tutorial](./references/mouse.md)
- [Numbat-multiome guide](./references/numbat-multiome.md)
- [Main User Guide](./references/numbat.md)
- [Interpreting results](./references/results.md)
- [Spatial transcriptomics](./references/spatial-rna.md)