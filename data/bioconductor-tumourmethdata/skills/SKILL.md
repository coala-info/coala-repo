---
name: bioconductor-tumourmethdata
description: This tool provides access to curated whole-genome bisulfite sequencing and RNA-seq datasets for various cancer types via the TumourMethData Bioconductor package. Use when user asks to explore available cancer methylation datasets, download WGBS data as RangedSummarizedExperiment objects, or retrieve matched transcript counts for epigenetic analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/TumourMethData.html
---

# bioconductor-tumourmethdata

name: bioconductor-tumourmethdata
description: Access and download whole-genome bisulfite sequencing (WGBS) and RNA-seq data for various cancer types (prostate, esophageal, rhabdoid) from the TumourMethData Bioconductor package. Use this skill when you need to retrieve high-resolution DNA methylation datasets provided as RangedSummarizedExperiment objects for cancer research and epigenetic analysis.

# bioconductor-tumourmethdata

## Overview

The `TumourMethData` package provides a curated collection of whole-genome DNA methylation (WGBS) datasets for several cancer types, including primary and metastatic prostate cancer, esophageal cancer, and rhabdoid tumors. Unlike microarray-based resources, this package offers near-complete coverage of CpG sites across the genome. Many datasets also include matched normal samples and corresponding RNA-seq transcript counts, enabling integrated analysis of the methylome and transcriptome.

Data is delivered as `RangedSummarizedExperiment` objects, which integrate genomic coordinates, methylation values (beta values), coverage information, and sample metadata.

## Typical Workflow

### 1. Explore Available Datasets
Before downloading, check the available datasets and their metadata (cancer type, technology, genome build, and sample counts).

```r
library(TumourMethData)

# Load the metadata table
data("TumourMethDatasets", package = "TumourMethData")

# View available datasets
print(TumourMethDatasets)
```

### 2. Download a Dataset
Use the `download_meth_dataset` function with a specific `dataset_name` from the metadata table.

```r
# Example: Download a subset of metastatic castration-resistant prostate cancer data (chr11)
mcrpc_data <- download_meth_dataset(dataset = "mcrpc_wgbs_hg38_chr11")

# Inspect the object
print(mcrpc_data)
```

### 3. Access Data Components
Since the data is a `RangedSummarizedExperiment`, use standard Bioconductor accessors:

```r
# Access methylation beta values
beta_values <- assay(mcrpc_data, "beta")

# Access read coverage (if available)
coverage_values <- assay(mcrpc_data, "cov")

# Access sample metadata
sample_info <- colData(mcrpc_data)

# Access genomic coordinates of the CpG sites
cpg_ranges <- rowRanges(mcrpc_data)
```

## Key Functions and Data

- `TumourMethDatasets`: A data frame containing details on all available datasets.
- `download_meth_dataset(dataset)`: Downloads the specified dataset from ExperimentHub and caches it locally.
- **Assays**: Most objects contain "beta" (methylation level 0-1) and "cov" (read depth) assays.
- **Transcript Counts**: Many datasets include `transcript_counts_available = TRUE` in the metadata, allowing for correlation studies with gene expression.

## Tips for Large Datasets
- **Memory Management**: Full WGBS datasets can be very large (up to 40GB). Ensure your environment has sufficient RAM or work with chromosome-specific subsets (e.g., `mcrpc_wgbs_hg38_chr11`) for testing.
- **Caching**: The package uses `ExperimentHub`. Once a dataset is downloaded, it is stored in your local BiocFileCache, making subsequent loads much faster.

## Reference documentation

- [Getting Tumour Methylation Data with TumourMethData](./references/getting_tumour_methylation_from_TumourMethData.md)
- [Getting Tumour Methylation Data with TumourMethData (Rmd)](./references/getting_tumour_methylation_from_TumourMethData.Rmd)