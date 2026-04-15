---
name: xtail
description: xtail identifies genes with differential translation by analyzing RNA-seq and Ribo-seq data. Use when user asks to identify genes with differential translation, analyze RNA-seq and Ribo-seq data, distinguish transcriptional from translational regulation, or plot fold changes.
homepage: https://github.com/xryanglab/xtail
metadata:
  docker_image: "quay.io/biocontainers/xtail:1.1.5--r40_4"
---

# xtail

## Overview
xtail is a statistical framework designed to identify genes exhibiting differential translation. It works by simultaneously analyzing read count data from RNA-seq and Ribo-seq experiments. By leveraging the DESeq2 package for count modeling, xtail provides a robust estimation of translation efficiency changes, allowing researchers to distinguish between genes regulated at the transcriptional level versus those specifically regulated at the translational level.

## Installation and Environment
The most reliable way to deploy xtail is via the Bioconda channel.

```bash
# Install via conda
conda install bioconda::xtail

# Requirements
# R >= 3.2, DESeq2, Rcpp, parallel
```

## Core Workflow Patterns
xtail is primarily an R-based tool. The standard workflow involves preparing count matrices for both RNA-seq and Ribo-seq across two conditions (e.g., control vs. treatment).

### 1. Data Preparation
Ensure your input data consists of four matrices or data frames:
- RNA-seq counts for Condition 1
- RNA-seq counts for Condition 2
- Ribo-seq counts for Condition 1
- Ribo-seq counts for Condition 2

### 2. Basic R Usage
```r
library(xtail)

# Run the differential translation analysis
# rna_cond1, rna_cond2, ribo_cond1, ribo_cond2 are count matrices
results <- xtail(rna_cond1, rna_cond2, ribo_cond1, ribo_cond2, 
                 condition = c("control", "treated"))

# Access the results
final_table <- results$xtail_results
```

### 3. Visualization
Use the built-in plotting functions to assess the Fold Change (FC) distributions.
```r
# Plot Fold Changes
plotFCs(results)
```

## Expert Tips and Best Practices
- **Input Normalization**: xtail utilizes DESeq2 internally for count estimation. Provide raw, non-normalized integer counts as input to allow the internal statistical models to handle library size normalization correctly.
- **Replicate Handling**: Ensure that the column names or order in your RNA-seq and Ribo-seq matrices match perfectly so that replicates are correctly paired during the estimation of translation efficiency.
- **Parallel Processing**: For large datasets, ensure the `parallel` package is available, as xtail can utilize multiple cores to speed up the DESeq2-based estimations.
- **Version Compatibility**: If running on macOS or newer R versions (4.0+), ensure you are using xtail version 1.2.0 or higher to avoid installation and compatibility errors related to Rcpp and build headers.

## Reference documentation
- [xtail Overview](./references/anaconda_org_channels_bioconda_packages_xtail_overview.md)
- [xtail GitHub Repository](./references/github_com_xryanglab_xtail.md)