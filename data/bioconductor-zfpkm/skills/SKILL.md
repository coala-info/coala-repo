---
name: bioconductor-zfpkm
description: This tool performs zFPKM transformation on RNA-seq FPKM or TPM data to identify actively expressed genes based on a bimodal distribution model. Use when user asks to normalize gene expression data using the Hart algorithm, visualize the distribution of expression levels, or filter for active genes in transcriptomics datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/zFPKM.html
---


# bioconductor-zfpkm

name: bioconductor-zfpkm
description: Perform zFPKM transformation on RNA-seq FPKM or TPM data to identify active gene expression. Use this skill when you need to normalize gene expression data using the Hart et al. (2013) algorithm, visualize the bimodal distribution of expression, or filter for "active" genes (typically zFPKM > -3) in gene-level transcriptomics datasets.

# bioconductor-zfpkm

## Overview

The `zFPKM` package implements a transformation method for RNA-seq data (FPKM or TPM) to facilitate the identification of actively expressed genes. It is based on the observation that gene expression levels in deep RNA-seq experiments typically follow a bimodal distribution: one peak representing "background" or "noise" (non-expressed genes) and another representing "active" expression. The zFPKM transform normalizes the data relative to the active peak, providing a standardized score where a threshold (recommended > -3) can be used to define expressed genes.

## Core Workflow

### 1. Data Preparation
The package works best with gene-level FPKM or TPM data. It can accept a simple numeric matrix, a data frame, or a `SummarizedExperiment` object.

```r
library(zFPKM)
library(SummarizedExperiment)

# Assuming 'se' is a SummarizedExperiment with an assay named 'fpkm'
# Or 'fpkm_matrix' is a matrix of FPKM values
```

### 2. Calculating zFPKM
The primary function is `zFPKM()`.

```r
# For a SummarizedExperiment
zfpkm_scores <- zFPKM(se)

# For a matrix or data frame
zfpkm_matrix <- zFPKM(as.data.frame(fpkm_matrix))
```

### 3. Visualizing the Distribution
Use `zFPKMPlot()` to visualize the Gaussian fit used for the transformation. This helps confirm if the bimodal distribution assumption holds for your dataset.

```r
# Plotting from a SummarizedExperiment or matrix
zFPKMPlot(se)
```

### 4. Identifying Active Genes
The standard threshold for an "active" gene is a zFPKM value greater than -3. In multi-sample experiments, it is common practice to calculate the median zFPKM per condition and filter genes that meet the threshold in at least one condition.

```r
library(dplyr)
library(tidyr)

# Example: Filtering a SummarizedExperiment for active genes
z_assay <- as.data.frame(zFPKM(se))
z_assay$gene <- rownames(z_assay)

active_genes <- z_assay %>%
  pivot_longer(-gene, names_to = "sample_id", values_to = "zfpkm") %>%
  group_by(gene) %>%
  summarize(max_z = max(zfpkm)) %>%
  filter(max_z > -3) %>%
  pull(gene)

se_filtered <- se[active_genes, ]
```

## Usage Tips
- **Gene Level Only**: This method is validated for gene-level data. It does not calibrate well for transcript-level (isoform) data.
- **Input Types**: While named "zFPKM", the algorithm works identically and effectively on TPM (Transcripts Per Million) values.
- **Downstream Analysis**: Filtering for active genes using zFPKM is an excellent preprocessing step before Differential Expression (DE) analysis (e.g., using `limma` or `edgeR`) to reduce the multiple testing burden and remove low-confidence noise.

## Reference documentation
- [Introduction to zFPKM Transformation](./references/zFPKM.md)
- [zFPKM Vignette Source](./references/zFPKM.Rmd)