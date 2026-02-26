---
name: bioconductor-celarefdata
description: This package provides pre-processed differential expression reference datasets for automated cell type annotation. Use when user asks to load reference profiles for celaref, access pre-computed DE results from ExperimentHub, or retrieve cell-type-specific gene expression data for 10X PBMCs and mouse tissues.
homepage: https://bioconductor.org/packages/release/data/experiment/html/celarefData.html
---


# bioconductor-celarefdata

name: bioconductor-celarefdata
description: Access and load pre-processed reference datasets for cell type labeling using the celaref package. Use this skill when you need differential expression (DE) results from public datasets (e.g., 10X PBMCs, Mouse Brain, Lacrimal Gland) formatted specifically for the celaref workflow.

## Overview

The `celarefData` package is an ExperimentHub-based data package providing pre-computed differential expression results. These datasets serve as "reference" profiles for the `celaref` package to facilitate automated cell type annotation. Each dataset contains results from comparing each cell cluster against all other cells in that experiment (one-vs-rest), typically calculated using the MAST or limma frameworks.

## Data Access Workflow

Datasets are hosted on Bioconductor's `ExperimentHub`. To use them, you must initialize an ExperimentHub client and filter for the `celarefData` package.

### 1. List Available Datasets

```r
library(ExperimentHub)
eh <- ExperimentHub()
# List all resources associated with this package
datasets <- ExperimentHub::listResources(eh, "celarefData")
print(datasets)
```

### 2. Load a Specific Dataset

Resources are loaded by their name or ExperimentHub ID. The result is typically a `data.frame` containing DE statistics.

```r
# Example: Loading the 10X PBMC 4k dataset (k=7 clusters)
de_table_pbmc <- ExperimentHub::loadResources(eh, "celarefData", "de_table_10X_pbmc4k_k7")[[1]]

# View the structure
head(de_table_pbmc)
```

## Available Datasets

The package includes the following reference tables:

*   **de_table_10X_pbmc4k_k7**: 10X Genomics healthy PBMC (4,000 cells), clustered at k=7.
*   **de_table_Watkins2009_pbmcs**: "HaemAtlas" microarray data of purified PBMC cell types.
*   **de_table_Zeisel2015_cortex** / **de_table_Zeisel2015_hc**: Mouse somatosensory cortex and hippocampus (Zeisel et al. 2015).
*   **de_table_Farmer2017_lacrimalP4**: Mouse lacrimal gland at postnatal day 4.
*   **de_table_Zheng2017purePBMC**: Bead-purified PBMC sub-populations (Zheng et al. 2017) using Gene Symbols.
*   **de_table_Zheng2017purePBMC_ensembl**: Same as above, but using Ensembl IDs.

## Data Structure

The loaded data frames contain columns required by `celaref` functions:
- `ID` / `GeneSymbol` / `ensembl_ID`: Gene identifiers.
- `log2FC`: Log2 fold change of the cluster vs rest.
- `fdr` / `pval`: Significance metrics.
- `group`: The cluster or cell-type label.
- `sig_up`: Boolean indicating if the gene is significantly up-regulated (used for enrichment).

## Usage Tips

- **Matching IDs**: Ensure your query dataset uses the same ID type (Gene Symbol vs Ensembl) as the reference you load. Use `de_table_Zheng2017purePBMC_ensembl` if your data uses Ensembl IDs.
- **Integration with celaref**: These tables are designed to be passed directly into `celaref` functions like `make_ref_similarity_names` or used as the `ref_group_stats` parameter in comparison workflows.
- **Caching**: ExperimentHub downloads files to a local cache. Subsequent loads will be much faster.

## Reference documentation

- [celarefData](./references/celarefData.md)