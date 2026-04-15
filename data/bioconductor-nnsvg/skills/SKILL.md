---
name: bioconductor-nnsvg
description: This tool identifies spatially variable genes in spatially-resolved transcriptomics data using scalable nearest-neighbor Gaussian processes. Use when user asks to identify genes with spatial expression patterns, rank spatially variable genes, or account for covariates like cell types and tissue domains in spatial transcriptomics datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/nnSVG.html
---

# bioconductor-nnsvg

name: bioconductor-nnsvg
description: Scalable identification of spatially variable genes (SVGs) in spatially-resolved transcriptomics data using nearest-neighbor Gaussian processes. Use this skill when analyzing SpatialExperiment objects to identify genes with spatial expression patterns, including analyses with covariates (spatial domains/cell types) or across multiple biological samples.

# bioconductor-nnsvg

## Overview

`nnSVG` is a Bioconductor package designed for the scalable identification of spatially variable genes (SVGs). It utilizes nearest-neighbor Gaussian processes and the BRISC algorithm to provide linear scaling with the number of spatial locations. Key features include the ability to rank SVGs by likelihood ratio statistics, account for known covariates (like cell types or tissue domains), and handle large-scale datasets with thousands of locations.

## Installation

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("nnSVG")
```

## Standard Workflow

The typical workflow involves a `SpatialExperiment` (SPE) object.

### 1. Data Preprocessing
Before running `nnSVG`, you must filter low-expressed genes and normalize the data.

```R
library(nnSVG)
library(SpatialExperiment)
library(scran)

# 1. Filter genes (removes mito and low-expressed genes)
spe <- filter_genes(spe, filter_genes_ncounts = 3, filter_genes_pcspots = 0.5)

# 2. Calculate logcounts (required for nnSVG)
spe <- computeLibraryFactors(spe)
spe <- logNormCounts(spe)
```

### 2. Running nnSVG
Run the main function. For large datasets, `nnSVG` supports parallelization via `BiocParallel`.

```R
set.seed(123)
spe <- nnSVG(spe)
```

### 3. Interpreting Results
Results are stored in `rowData(spe)`. Key columns include:
- `LR_stat`: Likelihood ratio statistic (higher = stronger spatial pattern).
- `rank`: Ranking of genes from most to least spatially variable.
- `pval` / `padj`: P-values and Benjamini-Hochberg adjusted p-values.
- `prop_sv`: Proportion of spatial variance (effect size).

```R
# Identify significant SVGs (e.g., padj <= 0.05)
significant_genes <- rowData(spe)[rowData(spe)$padj <= 0.05, ]

# View top 10 ranked genes
top_genes <- rowData(spe)[order(rowData(spe)$rank)[1:10], ]
```

## Advanced Workflows

### Analysis with Covariates
To identify SVGs within specific spatial domains or after accounting for cell-type composition, provide a model matrix `X`.

```R
# Create model matrix for cell types
X <- model.matrix(~ colData(spe)$celltype)

# Run nnSVG with covariates
spe <- nnSVG(spe, X = X)
```

### Multiple Samples
For datasets with multiple capture areas or biological replicates:
1. Run `nnSVG` on each sample individually.
2. Combine results by averaging the ranks of the genes across samples.
3. Filter for "replicated" SVGs that appear in the top ranks of multiple samples.

## Troubleshooting and Tips

- **Zero Counts**: `nnSVG` will throw an error (`dpotrf failed`) if genes or spots contain only zeros. Always use `filter_genes()` and check for empty rows/cols after subsetting.
- **Minimum Spots**: A minimum of 100 spatial locations (spots) per sample/domain is recommended for reliable model fitting.
- **Logcounts**: Ensure the input SPE object contains a `logcounts` assay; `nnSVG` operates on transformed data, not raw counts.
- **Mitochondrial Genes**: By default, `filter_genes` removes mitochondrial genes. Set `filter_mito = FALSE` only if they are of specific biological interest for your spatial analysis.

## Reference documentation

- [nnSVG Tutorial](./references/nnSVG.md)