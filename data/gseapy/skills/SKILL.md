---
name: gseapy
description: GSEApy performs gene set enrichment analysis and functional annotation to identify overrepresented biological pathways in genomic data. Use when user asks to perform GSEA, run preranked analysis, calculate single-sample enrichment scores, or access the Enrichr API for gene list annotation.
homepage: https://github.com/zqfang/gseapy
metadata:
  docker_image: "quay.io/biocontainers/gseapy:1.1.11--py311h5e00ca1_1"
---

# gseapy

## Overview

GSEApy is a high-performance Python/Rust implementation of Gene Set Enrichment Analysis (GSEA) tools. It serves as a versatile bridge between genomic data (like differential expression results) and biological knowledge bases. You should use this skill to identify overrepresented biological pathways in gene lists, calculate single-sample enrichment scores, or programmatically access the Enrichr web service for rapid functional annotation.

## Core Workflows

### 1. GSEA (Standard)
Use when you have a full expression matrix and two distinct biological groups (e.g., Control vs. Treatment).
- **Input**: Expression matrix (.txt/CSV), Phenotype labels (.cls), and Gene sets (.gmt).
- **Command**: `gseapy gsea -d data.txt -c test.cls -g gene_sets.gmt -o output_dir`

### 2. Prerank
Use when you have a pre-calculated list of genes ranked by a statistic (e.g., fold change, p-value, or signal-to-noise ratio). This is the most common entry point for RNA-seq workflows.
- **Input**: Ranked gene list (.rnk) and Gene sets (.gmt).
- **Command**: `gseapy prerank -r genes.rnk -g KEGG_2016 -o output_dir`

### 3. Single-Sample Analysis (ssGSEA & GSVA)
Use to calculate enrichment scores for each individual sample in a dataset, transforming a gene-level matrix into a pathway-level matrix.
- **ssGSEA**: `gseapy ssgsea -d expression.txt -g gene_sets.gmt -o output_dir`
- **GSVA**: `gseapy gsva -d expression.txt -g gene_sets.gmt -o output_dir`

### 4. Enrichr API
Use for quick enrichment analysis of a simple gene list (e.g., "top 100 up-regulated genes") without needing a background expression matrix.
- **Command**: `gseapy enrichr -i gene_list.txt -g GO_Biological_Process_2021 -o output_dir`

## Expert Tips & Best Practices

- **Gene Set Libraries**: Instead of providing a local `.gmt` file, you can often use Enrichr library names directly (e.g., `KEGG_2021_Human`, `MSigDB_Transcript_Hallmark_Info_V7.4`).
- **ID Conversion**: Use the `biomart` module to convert gene IDs (e.g., Ensembl to Gene Symbol) before running enrichment, as most gene sets use Gene Symbols.
- **Plotting**: GSEApy automatically generates publication-quality GSEA plots and dot plots. Use the `replot` module to recreate figures from GSEA Desktop output.
- **Performance**: For large datasets, ensure the Rust compiler is installed during setup, as GSEApy uses a Rust backend for significant speed improvements in permutation testing.
- **Input Formatting**: 
    - `.rnk` files should be tab-separated with two columns: Gene Symbol and Rank Statistic.
    - `.cls` files must follow the standard Broad Institute format (3 lines defining sample count, group names, and sample assignments).



## Subcommands

| Command | Description |
|---------|-------------|
| gseapy biomart | Query Ensembl biomart database. |
| gseapy enrichr | Enrichr uses a list of gene names as input. |
| gseapy gsea | Run Gene Set Enrichment Analysis |
| gseapy gsva | Performs Gene Set Variation Analysis (GSVA) |
| gseapy prerank | GSEA prerank module |
| gseapy replot | Reproduce GSEA figures from GSEA desktop results directory. |
| gseapy ssgsea | Single Sample GSEA |

## Reference documentation

- [GSEApy GitHub Repository](./references/github_com_zqfang_gseapy.md)
- [GSEApy Documentation Overview](./references/github_com_zqfang_gseapy_tree_master_docs.md)