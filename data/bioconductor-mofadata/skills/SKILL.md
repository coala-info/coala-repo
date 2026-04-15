---
name: bioconductor-mofadata
description: This package provides access to multi-omic datasets and gene set information for Multi-Omics Factor Analysis. Use when user asks to load example CLL data, access single-cell methylation and transcriptome datasets, or retrieve REACTOME gene sets for enrichment analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MOFAdata.html
---

# bioconductor-mofadata

name: bioconductor-mofadata
description: A specialized skill for using the MOFAdata R package to access multi-omic data sets for Multi-Omics Factor Analysis (MOFA). Use this skill when you need to load example data for CLL patients (mRNA, methylation, drug response, mutations), single-cell methylation and transcriptome (scMT) data, or gene set information (REACTOME) for enrichment analysis in MOFA workflows.

# bioconductor-mofadata

## Overview
The `MOFAdata` package is a companion data package for the `MOFA` (Multi-Omics Factor Analysis) framework. It provides preprocessed multi-omic datasets used in the original MOFA publications, serving as the standard benchmarking and tutorial data for unsupervised integration of multi-omics data.

## Loading the Package
```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MOFAdata")
library(MOFAdata)
```

## Accessing Datasets

### 1. Chronic Lymphocytic Leukemia (CLL) Data
This is a bulk multi-omics dataset containing profiles for 200 patients across four modalities.

*   **Data matrices**: A list of matrices (Drugs, Methylation, mRNA, Mutations).
*   **Covariates**: Sample metadata including Gender and Diagnosis.

```r
# Load the multi-omic list
data("CLL_data")
# Check dimensions of each assay
lapply(CLL_data, dim)

# Load patient metadata
data("CLL_covariates")
head(CLL_covariates)
```

### 2. Single-Cell Methylation and Transcriptome (scMT) Data
Preprocessed data for 87 single cells, stored as a `MultiAssayExperiment` object.

```r
library(MultiAssayExperiment)
data("scMT_data")

# View object summary
print(scMT_data)

# Access specific experiments
experiments(scMT_data)
```

### 3. Gene Set Information (REACTOME)
Used for Gene Set Enrichment Analysis (GSEA) within the MOFA framework to interpret latent factors.

```r
data("reactomeGS")
# This typically results in a binary matrix where rows are gene sets and columns are genes
```

### 4. Pre-trained MOFA Models
The package also contains trained `MOFAmodel` objects which can be used to skip the training step during exploration or visualization tutorials.

```r
# Example for loading a pre-trained CLL model
data("CLL_model")
```

## Typical Workflow with MOFA
1.  **Load Data**: Use `data("CLL_data")`.
2.  **Create MOFA Object**: Pass the loaded list to `create_mofa` (from the `MOFA2` or `MOFA` package).
3.  **Downstream Analysis**: Use `reactomeGS` for functional annotation of the discovered factors.

## Reference documentation
- [MOFAdata Overview](./references/MOFAdata.md)