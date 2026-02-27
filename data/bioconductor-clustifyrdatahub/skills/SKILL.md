---
name: bioconductor-clustifyrdatahub
description: This package provides a collection of curated reference gene expression datasets for human and mouse samples via ExperimentHub. Use when user asks to access reference matrices for cell type annotation, retrieve Mouse Cell Atlas data, or load annotated datasets for use with clustifyr.
homepage: https://bioconductor.org/packages/release/data/experiment/html/clustifyrdatahub.html
---


# bioconductor-clustifyrdatahub

## Overview

`clustifyrdatahub` is a Bioconductor ExperimentHub package that provides a collection of external reference datasets. These datasets are specifically formatted as gene expression matrices (often averaged by cell type) for use with the `clustifyr` package. It simplifies the process of obtaining high-quality, annotated references for both human and mouse samples, covering various tissues, developmental stages, and sequencing technologies (10x, Smart-seq2, Microarray).

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("clustifyrdatahub")
```

## Workflow: Accessing Reference Data

There are two primary ways to access the data: using the `ExperimentHub` interface or using package-specific wrapper functions.

### Method 1: Using ExperimentHub (Recommended for Discovery)

Use this method to search for specific species or datasets.

```r
library(ExperimentHub)
eh <- ExperimentHub()

# Query for all clustifyrdatahub resources
refs <- query(eh, "clustifyrdatahub")

# View available titles and IDs (e.g., EH3444, EH3450)
listResources(eh, "clustifyrdatahub")

# Load a specific resource by ID
ref_mat <- eh[["EH3450"]] # Human hematopoietic microarray
```

### Method 2: Using Wrapper Functions

If the package is loaded, you can call the dataset name as a function.

```r
library(clustifyrdatahub)

# Load data directly
ref_hema <- ref_hema_microarray()

# View metadata only
meta <- ref_hema_microarray(metadata = TRUE)
```

## Available Reference Datasets

| Function/Title | Species | Description |
| --- | --- | --- |
| `ref_MCA` | M. musculus | Mouse Cell Atlas |
| `ref_tabula_muris_drop` | M. musculus | Tabula Muris (10X) |
| `ref_tabula_muris_facs` | M. musculus | Tabula Muris (SmartSeq2) |
| `ref_mouse.rnaseq` | M. musculus | Mouse RNA-seq (28 cell types) |
| `ref_moca_main` | M. musculus | Mouse Organogenesis Cell Atlas |
| `ref_immgen` | M. musculus | Mouse sorted immune cells |
| `ref_hema_microarray` | H. sapiens | Human hematopoietic microarray |
| `ref_cortex_dev` | H. sapiens | Human cortex development scRNA-seq |
| `ref_pan_indrop` | H. sapiens | Human pancreatic (inDrop) |
| `ref_pan_smartseq2` | H. sapiens | Human pancreatic (SmartSeq2) |
| `ref_mouse_atlas` | M. musculus | Mouse Atlas (321 cell types) |

## Integration with clustifyr

Once a reference matrix is loaded, it can be passed directly to `clustifyr::clustify()`.

```r
library(clustifyr)
library(clustifyrdatahub)

# 1. Load reference
human_ref <- ref_hema_microarray()

# 2. Run classification on a query matrix (e.g., pbmc_matrix_small)
res <- clustify(
    input = pbmc_matrix_small,      # Query expression matrix
    metadata = pbmc_meta$cluster,   # Query cluster labels
    ref_mat = human_ref,            # Reference from clustifyrdatahub
    query_genes = pbmc_vargenes     # Genes to use for correlation
)

# 3. View results
# res is a correlation matrix; use cor_to_call() to get assignments
calls <- cor_to_call(res)
```

## Tips for Success

1.  **Gene Symbol Matching**: Ensure that the gene symbols in your query data match the nomenclature used in the reference (typically Gene Symbols like "CD3D").
2.  **Species Check**: Always verify that the reference species matches your query data.
3.  **Data Class**: Most resources are returned as `data.frame` or `matrix` objects containing average expression values per cell type.
4.  **Caching**: `ExperimentHub` caches data locally after the first download, making subsequent loads much faster.

## Reference documentation
- [clustifyrdatahub](./references/clustifyrdatahub.md)