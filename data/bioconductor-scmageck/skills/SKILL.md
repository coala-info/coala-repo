---
name: bioconductor-scmageck
description: scMAGeCK analyzes single-cell CRISPR screens by linking guide RNA perturbations to changes in gene expression. Use when user asks to identify how gene knockouts affect a specific marker gene using RRA or model the global regulatory impact of multiple perturbations using linear regression.
homepage: https://bioconductor.org/packages/3.11/bioc/html/scMAGeCK.html
---

# bioconductor-scmageck

## Overview
scMAGeCK is designed to analyze high-throughput CRISPR screens where the readout is single-cell RNA-seq. It bridges the gap between pooled CRISPR screening and single-cell transcriptomics by linking guide RNA (sgRNA) perturbations to changes in gene expression. It provides two primary algorithms:
1. **scMAGeCK-RRA**: Best for detecting how perturbations affect a single target marker gene.
2. **scMAGeCK-LR**: A linear regression approach for modeling the effects of multiple perturbations on a broad transcriptome.

## Core Workflows

### Data Preparation
Both methods require two main inputs:
- **BARCODE File**: A text file mapping cell identities to their respective sgRNAs/perturbed genes.
- **RDS Object**: A Seurat object or a path to an RDS file containing the scRNA-seq expression matrix.

### 1. Single Marker Analysis (scMAGeCK-RRA)
Use this when you want to see which gene knockouts significantly increase or decrease the expression of one specific gene (e.g., a proliferation marker like MKI67).

```r
library(scMAGeCK)

# Define paths and target
barcode_file <- "path/to/barcode_rec.txt"
rds_object <- "path/to/sc_data.RDS" # Can be Seurat object
target_gene <- "MKI67"
rra_path <- "/path/to/bin/RRA" # Path to the RRA executable

# Run RRA
rra_result <- scmageck_rra(
  BARCODE = barcode_file,
  RDS = rds_object,
  GENE = target_gene,
  RRAPATH = rra_path,
  LABEL = 'output_prefix',
  NEGCTRL = NULL # Optional: name of negative control gene
)
```

**Interpreting RRA Results:**
- **lo_value.low/high**: The RRA score. Smaller scores indicate stronger selection/impact.
- **p.low/high**: Permutation-based p-values for negative (decreased expression) and positive (increased expression) selection.
- **FDR**: Adjusted p-values for multiple testing.

### 2. Multi-Gene Perturbation Analysis (scMAGeCK-LR)
Use this for complex screens where cells may have multiple perturbations or when you want to observe the global regulatory impact of knockouts.

```r
library(scMAGeCK)

lr_result <- scmageck_lr(
  BARCODE = barcode_file,
  RDS = rds_object,
  LABEL = 'output_lr',
  NEGCTRL = 'NonTargetingControl',
  PERMUTATION = 1000,
  LAMBDA = 0.01
)

# Extract scores and p-values
lr_score <- lr_result[[1]]      # Matrix of effect sizes (Log Fold Change-like)
lr_score_pval <- lr_result[[2]] # Matrix of p-values
```

**Interpreting LR Results:**
- The output is a matrix where **Rows** are perturbed genes and **Columns** are marker genes.
- A positive value in `lr_score` indicates that perturbing the row-gene increases the expression of the column-gene.

## Tips for Success
- **Cell Name Matching**: Ensure cell names in the BARCODE file match the column names in the RDS expression matrix. scMAGeCK attempts to strip trailing "-1"s automatically if a mismatch is detected.
- **RRA Executable**: `scmageck_rra` requires the compiled RRA binary from the MAGeCK distribution. Ensure this is compiled and the path is correctly passed to `RRAPATH`.
- **Negative Controls**: Always specify a `NEGCTRL` (e.g., Non-Targeting Guides) to provide a baseline for the regression model in `scmageck_lr`.
- **Memory Management**: For large scRNA-seq datasets, ensure the R session has sufficient RAM, as the LR model performs permutations across thousands of genes.

## Reference documentation
- [scMAGeCK](./references/scMAGeCK.md)