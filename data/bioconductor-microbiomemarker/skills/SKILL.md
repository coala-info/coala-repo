---
name: bioconductor-microbiomemarker
description: The microbiomeMarker package provides a unified framework for identifying microbiome biomarkers using various differential analysis methods and visualization tools. Use when user asks to identify microbiome biomarkers, perform differential abundance analysis using methods like LEfSe or ANCOM-BC, normalize microbiome count data, or generate biomarker visualizations like cladograms and effect size plots.
homepage: https://bioconductor.org/packages/3.14/bioc/html/microbiomeMarker.html
---

# bioconductor-microbiomemarker

## Overview

The `microbiomeMarker` package is an all-in-one R/Bioconductor tool designed to identify microbiome biomarkers. It integrates a wide array of differential analysis (DA) methods—ranging from simple statistical tests to complex RNA-seq-based models and specialized metagenomic tools—into a unified framework. It primarily operates on `phyloseq` objects and outputs a specialized `microbiomeMarker` class object that simplifies downstream visualization and result extraction.

## Core Workflow

### 1. Data Import
The package uses `phyloseq` objects as the standard input.
```r
library(microbiomeMarker)

# Import from dada2
ps <- import_dada2(seq_tab = seq_tab, tax_tab = tax_tab, sam_tab = sam_tab)

# Import from qiime2
ps <- import_qiime2(otu_qza = "table.qza", taxa_qza = "taxonomy.qza", sam_tab = "metadata.tsv")
```

### 2. Normalization
While DA functions have built-in normalization, you can normalize manually using the `norm_*` family or the `normalize()` wrapper.
- Methods: `TSS` (Relative Abundance), `CSS`, `RLE`, `TMM`, `CLR`, `CPM`, `rarefy`.
- **Tip:** If you normalize manually before running a DA function, set `norm = "none"` in the DA function to avoid double-normalization.

### 3. Running Differential Analysis
All DA functions follow the `run_*` naming convention.

| Method Category | Function | Key Parameters |
| :--- | :--- | :--- |
| **LEfSe** | `run_lefse()` | `wilcoxon_cutoff`, `lda_cutoff`, `multigrp_strat` |
| **RNA-seq based** | `run_deseq2()`, `run_edger()` | `pvalue_cutoff`, `p_adjust` |
| **Metagenomic** | `run_ancombc()`, `run_metagenomeseq()` | `group`, `taxa_rank` |
| **Simple Stats** | `run_simple_stat()` | `method` ("t.test", "anova", "kruskal") |
| **Machine Learning**| `run_sl()` | `method` ("RF", "LR", "SVM"), `top_n` |

Example:
```r
# Identify markers using LEfSe
mm_res <- run_lefse(
    ps,
    group = "DIAGNOSIS",
    taxa_rank = "Genus",
    lda_cutoff = 2
)
```

### 4. Extracting Results
The output is a `microbiomeMarker` object. Use `marker_table()` to see the results.
```r
res_table <- marker_table(mm_res)
# Columns: feature, enrich_group, ef_lda (or other effect size), pvalue, padj
```

### 5. Visualization
The package provides high-level plotting functions that return `ggplot2` objects.

- **Abundance:** `plot_abundance(mm_res, group = "DIAGNOSIS")`
- **Effect Size:** `plot_ef_bar(mm_res)` or `plot_ef_dot(mm_res)`
- **Cladogram:** `plot_cladogram(mm_res, color = c(GroupA = "blue", GroupB = "red"))`
- **Heatmap:** `plot_heatmap(mm_res, group = "DIAGNOSIS")`

## Key Tips
- **Taxonomic Rank:** By default, many functions run on all levels (`taxa_rank = "all"`). To reduce multiple testing burden, specify a rank like `taxa_rank = "Genus"`.
- **Multiple Groups:** For comparisons with >2 groups, use `run_posthoc_test()` to identify specific pairwise differences after a global test.
- **Machine Learning:** When using `run_sl()`, always set a seed (`set.seed()`) for reproducibility, as these methods involve stochastic processes.

## Reference documentation
- [Tools for microbiome marker identification](./references/microbiomeMarker-vignette.md)