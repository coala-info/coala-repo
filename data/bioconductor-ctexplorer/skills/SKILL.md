---
name: bioconductor-ctexplorer
description: CTexploreR identifies and characterizes Cancer-Testis genes by providing tools to visualize their expression and promoter methylation across healthy and tumoral datasets. Use when user asks to identify Cancer-Testis genes, visualize gene expression in GTEx or TCGA datasets, analyze promoter methylation, or find genes with correlated expression patterns in cancer cell lines.
homepage: https://bioconductor.org/packages/release/bioc/html/CTexploreR.html
---


# bioconductor-ctexplorer

## Overview

CTexploreR is a Bioconductor package designed to identify and characterize Cancer-Testis (CT) genes. These genes are typically restricted to the germline but aberrantly activated in cancers, making them prime targets for immunotherapy and biomarkers. The package provides a curated list of CT genes and tools to visualize their expression and promoter methylation across various healthy and tumoral datasets.

## Core Data and Setup

The package relies on a companion data package, `CTdata`.

```r
library(CTexploreR)

# Access the curated list of 280 CT and CTP genes
data("CT_genes")
head(CT_genes)

# List available datasets from the companion package
CTdata()
```

## Gene Selection Categories

When using functions, you can filter genes based on the `CT_genes` metadata:
- **CT_gene**: Strict Cancer-Testis genes (testis-specific).
- **CTP_gene**: Cancer-Testis Preferential genes (low expression in some somatic tissues).
- **regulated_by_methylation**: Genes induced by demethylating agents or highly methylated in somatic tissues.

## Visualizing Expression

Most visualization functions return a heatmap. Use `values_only = TRUE` to return the raw data matrix instead.

### Normal Tissues (GTEx)
```r
# Compare expression in normal tissues
GTEX_expression(genes = c("MAGEA1", "SSX2"), units = "log_TPM")

# Include CTP genes in default plots
GTEX_expression(include_CTP = TRUE)
```

### Specialized Cell Types
- `testis_expression()`: Adult human testis transcriptional cell atlas (germ vs. somatic cells).
- `oocytes_expression()`: Expression across oocyte developmental stages.
- `HPA_cell_type_expression()`: Human Protein Atlas single-cell type classification.
- `embryo_expression()`: Preimplantation embryo datasets (Petropoulos or Zhu).

### Cancer Datasets
```r
# CCLE Cell Lines
CCLE_expression(genes = "MAGEA3", type = c("lung", "skin", "breast"))

# TCGA Tumors
TCGA_expression(genes = "MAGEA3", tumor = "LUAD") # Lung Adenocarcinoma
TCGA_expression(genes = "MAGEA3", tumor = "all")  # Pan-cancer overview
```

## Methylation Analysis

CTexploreR provides tools to investigate the epigenetic regulation of these genes.

### Promoter Methylation
```r
# Mean methylation in normal tissues (1000bp upstream to 200bp downstream of TSS)
normal_tissues_mean_methylation(genes = "MAGEB2")

# Detailed CpG-level methylation for a specific gene
normal_tissues_methylation("MAGEB2")
```

### Functional Regulation
```r
# Induction after DAC (5-Aza-2′-Deoxycytidine) treatment
DAC_induction(genes = c("MAGEA1", "LIN28A"))

# Correlation between methylation and expression in TCGA
TCGA_methylation_expression_correlation(gene = "TDRD1", tumor = "all")
```

## Advanced Workflows

### Finding Correlated Genes
Identify genes (CT or otherwise) that share expression patterns with a specific CT gene in CCLE data.
```r
# Find genes correlated with MAGEA3 (coefficient > 0.3)
CT_correlated_genes("MAGEA3", cor_thr = 0.3)
```

### Interactive Exploration
The heatmaps are compatible with `InteractiveComplexHeatmap`.
```r
library(InteractiveComplexHeatmap)
GTEX_expression(include_CTP = FALSE)
htShiny() # Opens interactive browser for the last plot
```

## Reference documentation

- [Cancer Testis explorer](./references/CTexploreR.md)
- [Cancer Testis explorer (RMarkdown Source)](./references/CTexploreR.Rmd)