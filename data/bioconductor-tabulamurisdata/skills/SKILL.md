---
name: bioconductor-tabulamurisdata
description: This package provides streamlined access to single-cell RNA-seq datasets from the Tabula Muris project as SingleCellExperiment objects. Use when user asks to retrieve 10x droplet or Smart-seq2 mouse tissue data, access cell-level metadata for mouse organs, or download benchmarking datasets for single-cell analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/TabulaMurisData.html
---

# bioconductor-tabulamurisdata

name: bioconductor-tabulamurisdata
description: Access and process single-cell RNA-seq data from the Tabula Muris project. Use this skill to retrieve 10x (droplet) and SmartSeq2 datasets as SingleCellExperiment objects for mouse tissue analysis and benchmarking.

# bioconductor-tabulamurisdata

## Overview
TabulaMurisData is a Bioconductor data package that provides streamlined access to the Tabula Muris Consortium's single-cell RNA-seq datasets. It contains data from 20 mouse organs and tissues, collected using two different methods: microfluidic droplets (10x Genomics) and FACS-sorted cells (Smart-seq2). All data is returned as `SingleCellExperiment` objects, making them compatible with standard Bioconductor analysis pipelines.

## Loading Data
The package provides two primary convenience functions to download and cache the data via ExperimentHub.

To load the 10x Genomics (droplet) data:
library(TabulaMurisData)
sce_droplet <- TabulaMurisDroplet()

To load the Smart-seq2 (FACS) data:
sce_smartseq2 <- TabulaMurisSmartSeq2()

Alternatively, use ExperimentHub directly to search for specific versions or metadata:
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, "TabulaMurisData")
sce <- eh[["EH1617"]] # Example for Droplet data

## Data Structure and Metadata
The returned `SingleCellExperiment` objects contain:
- Assays: Raw counts (accessible via `counts(sce)`).
- colData: Extensive cell-level metadata including `cell_ontology_class`, `free_annotation`, `tissue`, and `mouse.id`.
- rowData: Gene-level information including `ID` (Ensembl) and `Symbol`.

## Typical Workflow

### 1. Subsampling for Testing
Because these datasets are large (e.g., >70,000 cells for droplets), it is often useful to subsample during script development:
set.seed(123)
sce_sub <- sce_droplet[, sample(ncol(sce_droplet), 500)]

### 2. Normalization and Processing
Use the `scran` and `scater` packages to process the data for downstream analysis:
library(scater)
library(scran)
sce_sub <- computeSumFactors(sce_sub)
sce_sub <- logNormCounts(sce_sub)
sce_sub <- runPCA(sce_sub)
sce_sub <- runTSNE(sce_sub)

### 3. Interactive Exploration
The data is optimized for use with `iSEE` for interactive visualization:
library(iSEE)
iSEE(sce_sub)

## Tips and Best Practices
- Cache Management: The first call to the data functions will download large files. Ensure you have sufficient disk space in your Bioconductor cache directory.
- Memory Usage: The full datasets can be memory-intensive. Use sparse matrix representations (default) and consider processing tissues individually by filtering the `colData(sce)$tissue` column.
- Cell Ontology: Use the `cell_ontology_id` and `cell_ontology_class` columns for standardized cell type comparisons across different tissues or datasets.

## Reference documentation
- [Tabula Muris data](./references/TabulaMurisData.md)