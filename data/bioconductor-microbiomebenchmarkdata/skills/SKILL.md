---
name: bioconductor-microbiomebenchmarkdata
description: This package provides a collection of microbiome datasets with known biological ground truth for benchmarking bioinformatics tools. Use when user asks to access 16S or WMS benchmark data, load TreeSummarizedExperiment objects, or recalibrate spike-in data to absolute microbial loads.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MicrobiomeBenchmarkData.html
---

# bioconductor-microbiomebenchmarkdata

## Overview

The `MicrobiomeBenchmarkData` package provides a collection of microbiome datasets (16S and WMS) where the biological "ground truth" is known (e.g., specific taxa enrichment or known spike-in loads). These datasets are primarily delivered as `TreeSummarizedExperiment` objects, making them compatible with modern Bioconductor microbiome analysis workflows.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MicrobiomeBenchmarkData")
```

## Typical Workflow

### 1. Explore Available Datasets
Use `getBenchmarkData()` without arguments to list available datasets and their metadata (dimensions, body site, contrasts, and ground truth).

```r
library(MicrobiomeBenchmarkData)

# List available datasets
available_datasets <- getBenchmarkData()
print(available_datasets)
```

### 2. Load Specific Datasets
To download and load data, set `dryrun = FALSE`. The function returns a named list of `TreeSummarizedExperiment` objects.

```r
# Load a single dataset
tse_list <- getBenchmarkData("HMP_2012_16S_gingival_V35_subset", dryrun = FALSE)
tse <- tse_list[[1]]

# Load multiple datasets
multiple_tse <- getBenchmarkData(c("Ravel_2011_16S_BV", "HMP_2012_WMS_gingival"), dryrun = FALSE)
```

### 3. Access Unified Metadata
The package provides a merged metadata object for all samples across all datasets.

```r
data("sampleMetadata", package = "MicrobiomeBenchmarkData")
head(sampleMetadata)
```

### 4. Spike-in-based Calibration (SCML)
For datasets containing spike-ins (like `Stammler_2016_16S_spikein`), you can recalibrate raw counts to absolute microbial loads using the `scml()` function.

```r
# Load the spike-in dataset
tse_spike <- getBenchmarkData("Stammler_2016_16S_spikein", dryrun = FALSE)[[1]]

# Recalibrate using Salinibacter ruber ("s"), Rhizobium radiobacter ("r"), 
# or Alicyclobacillus acidiphilus ("a")
tse_calibrated <- scml(tse_spike, bac = "s")
```

## Data Structure Tips

- **Assays**: Counts are stored in the `counts` assay. Access via `assay(tse)`.
- **Taxonomy**: Taxonomic information and biological ground truth annotations are stored in `rowData(tse)`. Look for the `taxon_annotation` column.
- **Sample Data**: Experimental conditions and library sizes are in `colData(tse)`.
- **Phylogeny**: Most datasets include a phylogenetic tree accessible via `rowTree(tse)`.

## Cache Management
Datasets are cached locally via `BiocFileCache`. To clear the cache and free disk space:

```r
removeCache()
```

## Reference documentation

- [MicrobiomeBenchmarkData](./references/MicrobiomeBenchmarkData.md)
- [Datasets in MicrobiomeBenchmarkData](./references/datasets.md)
- [Recalibration of Spike-in Data](./references/recalibrare_spikein_data.md)