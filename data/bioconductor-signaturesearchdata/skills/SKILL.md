---
name: bioconductor-signaturesearchdata
description: This package provides preprocessed gene expression signatures from CMap and LINCS for use in Gene Expression Signature Search (GESS) workflows. Use when user asks to retrieve reference datasets from ExperimentHub, load HDF5-based signature data, or process LINCS metadata for drug-target discovery.
homepage: https://bioconductor.org/packages/release/data/experiment/html/signatureSearchData.html
---

# bioconductor-signaturesearchdata

## Overview

The `signatureSearchData` package serves as the primary data repository for the `signatureSearch` ecosystem. It provides high-quality, preprocessed gene expression signatures from the Connectivity Map (CMap) and Library of Network-Based Cellular Signatures (LINCS) projects. These datasets are formatted specifically for compatibility with various GESS algorithms (e.g., CMAP, LINCS, gCMAP, Fisher, and correlation-based methods). The package utilizes `ExperimentHub` for efficient, on-demand downloading of large HDF5-based datasets.

## Data Exploration and Retrieval

Reference datasets are stored in `ExperimentHub`. Use the following workflow to identify and load specific records.

```r
library(signatureSearchData)
library(ExperimentHub)

# Query available records
eh <- ExperimentHub()
ssd <- query(eh, "signatureSearchData")

# View available titles (e.g., "cmap", "lincs", "lincs2", "cmap_rank")
ssd$title

# Retrieve a specific dataset by its EH ID
# Example: Loading LINCS Z-scores (EH3226)
lincs_path <- eh[['EH3226']] 
```

### Key Datasets
- **lincs / lincs2**: Moderated Z-scores (Level 5) for drug treatments across multiple cell lines.
- **lincs_expr**: Normalized intensity values (Level 3) for correlation-based searches.
- **cmap**: Log fold change (LFC) scores from CMap2.
- **cmap_rank**: Rank-transformed gene expression profiles for CMap-style searches.
- **cmap_expr**: MAS5 normalized intensities for CMap2.

## Workflows

### Using Data with signatureSearch
The paths retrieved from `ExperimentHub` are passed directly to `signatureSearch` functions as the `refdb` argument.

```r
library(signatureSearch)
library(HDF5Array)

# 1. Load a reference database as a SummarizedExperiment (optional)
se <- SummarizedExperiment(HDF5Array(lincs_path, name="assay"))
rownames(se) <- HDF5Array(lincs_path, name="rownames")
colnames(se) <- HDF5Array(lincs_path, name="colnames")

# 2. Define a query signature from the reference database
# Example: Get top 150 up/down genes for vorinostat in SKB cell line
degs <- getDEGSig(cmp="vorinostat", cell="SKB", refdb="lincs", Nup=150, Ndown=150)

# 3. Run a GESS method using the reference data path
qsig_fisher <- qSig(query = degs, gess_method = "Fisher", refdb = "lincs")
fisher_res <- gess_fisher(qSig=qsig_fisher, higher=2, lower=-2)
```

### Filtering and Custom HDF5 Creation
If working with raw GEO data (GSE92742) instead of ExperimentHub, use the package's utility functions to process and store data in HDF5 format.

- `sig_filter()`: Filter LINCS metadata by perturbation type, dose, and time.
- `gctx2h5()`: Convert .gctx files to .h5 files for memory-efficient access.
- `meanExpr2h5()`: Calculate mean expression across replicates and save to HDF5.
- `probe2gene()`: Transform probe-set level data to gene-level data using annotation maps.

## Tips for Large Datasets
- **Memory Management**: Do not attempt to load the entire LINCS dataset into RAM. Always use the HDF5 paths or `SummarizedExperiment` objects backed by `HDF5Array`.
- **ID Mapping**: Ensure gene identifiers (typically Entrez IDs) match between your query and the reference database.
- **Column Naming**: Reference databases use a specific naming convention: `(drug)__(cell)__(factor)`. Use this format when querying specific signatures via `getSig` or `getDEGSig`.

## Reference documentation
- [signatureSearchData](./references/signatureSearchData.md)