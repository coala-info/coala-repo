---
name: bioconductor-gse103322
description: This package provides access to single-cell RNA-seq data from human head and neck squamous cell carcinoma patients via ExperimentHub. Use when user asks to retrieve the GSE103322 dataset, extract TPM expression matrices, or analyze cell-type metadata for HNSC samples.
homepage: https://bioconductor.org/packages/release/data/experiment/html/GSE103322.html
---

# bioconductor-gse103322

name: bioconductor-gse103322
description: Access and analyze single-cell RNA-seq data from human head and neck squamous cell carcinoma (HNSC) patients (GEO GSE103322). Use this skill to retrieve the SingleCellExperiment object from ExperimentHub, extract TPM expression matrices, and explore cell-type metadata for 5,902 cells.

# bioconductor-gse103322

## Overview
The `GSE103322` package provides access to a large-scale single-cell RNA-seq dataset of 5,902 cells from 18 patients with oral cavity head and neck squamous cell carcinoma. The data is stored as a `SingleCellExperiment` object, containing Transcripts Per Million (TPM) values and detailed metadata regarding cell classification (cancer vs. non-cancer) and specific non-cancer cell types (e.g., T cells, B cells, Fibroblasts).

## Data Retrieval
The dataset is hosted on Bioconductor's ExperimentHub.

```R
library(ExperimentHub)
library(SingleCellExperiment)

# Initialize ExperimentHub and query for the dataset
eh <- ExperimentHub()
query_results <- query(eh, "GSE103322")

# Load the SingleCellExperiment object (EH5419)
sce <- query_results[[1]]
```

## Exploring Metadata
The object contains sample-level information in the `colData` slot, which is essential for identifying cell populations.

```R
# View available metadata columns
head(colData(sce))

# Identify cell types in the dataset
# Common types: Fibroblast, T cell, B cell, Macrophage, Endothelial, etc.
table(sce$non.cancer.cell.type)

# Check cancer vs non-cancer classification
table(sce$classified..as.cancer.cell)
```

## Extracting Expression Data
The primary assay in this dataset is TPM (Transcripts Per Million).

```R
# Extract the TPM matrix
tpm_matrix <- assays(sce)$TPM

# Check dimensions (Rows: Genes, Columns: Cells)
dim(tpm_matrix)

# Preview expression for the first few genes and cells
tpm_matrix[1:5, 1:5]
```

## Typical Workflow
1. **Load**: Retrieve the `sce` object via `ExperimentHub`.
2. **Filter**: Subset the object based on metadata (e.g., only analyzing "T cell" populations).
3. **Analyze**: Use standard Bioconductor tools (like `scater` or `scran`) for downstream analysis, as the data is already in the standard `SingleCellExperiment` format.

## Reference documentation
- [scRNASeq HNSC data using Bioconductor’s ExperimentHub](./references/GSE103322.md)