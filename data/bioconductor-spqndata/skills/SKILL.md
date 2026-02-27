---
name: bioconductor-spqndata
description: This package provides a processed subset of GTEx RNA-seq data for testing spatial quantile normalization. Use when user asks to access example co-expression data, load the gtex.4k dataset, or demonstrate the spqn method.
homepage: https://bioconductor.org/packages/release/data/experiment/html/spqnData.html
---


# bioconductor-spqndata

name: bioconductor-spqndata
description: Access and use the spqnData experiment data package from Bioconductor. This skill should be used when a user needs example RNA-seq co-expression data (GTEx v6p Adipose Subcutaneous tissue) for testing or demonstrating the spatial quantile normalization (spqn) method.

# bioconductor-spqndata

## Overview
The `spqnData` package provides a processed subset of bulk RNA-seq data from the GTEx project (v6p, Adipose Subcutaneous tissue). It contains expression data for 4,000 randomly selected genes (protein-coding and lincRNAs) that have been filtered for expression, mean-centered, variance-scaled, and adjusted for the first four principal components. This dataset is specifically designed to demonstrate and test the `spqn` (Spatial Quantile Normalization) package for co-expression analysis.

## Data Loading and Exploration
The primary dataset in this package is `gtex.4k`, provided as a `SummarizedExperiment` object.

### Loading the Data
To use the data in an R session:
```r
library(spqnData)
data("gtex.4k")
```

### Inspecting the Object
The data contains 4,000 genes and 350 samples.
```r
# View the SummarizedExperiment object
gtex.4k

# Access the processed expression matrix (normalized/scaled)
expr_matrix <- assay(gtex.4k)

# View gene metadata (gene type and average log2 RPKM)
gene_info <- rowData(gtex.4k)
head(gene_info)
```

## Key Data Characteristics
- **Genes**: 4,000 (randomly sampled from 12,267 expressed genes).
- **Samples**: 350 (Adipose Subcutaneous tissue).
- **Preprocessing**: 
    - Genes filtered for median log2(RPKM) > 0.
    - Mean-centered and variance-scaled (mean 0, variance 1).
    - 4 Principal Components removed using `WGCNA::removePrincipalComponents`.
- **Metadata**:
    - `gene_type`: Indicates if the gene is "protein_coding" or "lincRNA".
    - `ave_logrpkm`: The average expression value on the log2(RPKM) scale prior to PC removal. This is a critical covariate for spatial quantile normalization.

## Typical Workflow
The data is intended to be used with the `spqn` package to correct for the correlation between gene expression levels and co-expression measurements.

```r
library(spqnData)
library(spqn)

data("gtex.4k")

# 1. Calculate a correlation matrix (e.g., Pearson)
cor_mat <- cor(t(assay(gtex.4k)))

# 2. Get the covariate (average expression)
ave_exp <- rowData(gtex.4k)$ave_logrpkm

# 3. Apply spatial quantile normalization (requires spqn package)
# normalized_cor <- spqn(cor_mat, ave_exp, ave_exp)
```

## Reference documentation
- [spqnData Reference Manual](./references/reference_manual.md)