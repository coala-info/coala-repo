---
name: bioconductor-rgenometracksdata
description: This package provides access to sample genomic and epigenomic datasets including BigWig, BED, GTF, and Hi-C files via AnnotationHub. Use when user asks to retrieve example genomic data, download sample files for rGenomeTracks, or access test datasets for genomic visualization.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rGenomeTracksData.html
---

# bioconductor-rgenometracksdata

name: bioconductor-rgenometracksdata
description: Access and retrieve sample genomic and epigenomic data from the rGenomeTracksData package. Use this skill when you need example datasets (BigWig, BED, GTF, Hi-C/Cool, etc.) for demonstrating or testing the rGenomeTracks R package or other genomic visualization tools.

# bioconductor-rgenometracksdata

## Overview
`rGenomeTracksData` is an ExperimentHub-based data package providing a collection of sample genomic files. These datasets are primarily sourced from the `pyGenomeTracks` project and are intended for use with the `rGenomeTracks` visualization package. The package allows users to programmatically download and cache various genomic file formats including BigWig, BED, GTF, and HDF5/Cool files.

## Installation
To use this data, ensure `AnnotationHub` and `rGenomeTracksData` are installed:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("rGenomeTracksData")
```

## Workflow: Accessing Data
The data is managed via `AnnotationHub`. Follow these steps to locate and retrieve specific files.

### 1. Initialize and Query
Load the libraries and query the hub for the package records.

```r
library(AnnotationHub)
library(rGenomeTracksData)

ah <- AnnotationHub()
records <- query(ah, "rGenomeTracksData")
```

### 2. Identify Available Files
The package contains 16 records. You can view the titles and IDs:

```r
mcols(records)[, "title", drop = FALSE]
```

Commonly used files include:
- **BigWig**: `bigwig2_X_2.5e6_3.5e6.bw` (AH95891)
- **BED**: `dm3_genes.bed.gz` (AH95893), `tad_classification.bed` (AH95903)
- **GTF**: `dm3_subset_BDGP5.78.gtf.gz` (AH95895)
- **Hi-C/Cool**: `Li_et_al_2015.cool` (AH95900), `Li_et_al_2015.h5` (AH95901)
- **Links/Arcs**: `links2.links` (AH95902), `test.arcs` (AH95904)

### 3. Fetch the File Path
Retrieving a record returns the **local file path** to the cached resource. This path can then be passed directly to `rGenomeTracks` or other R functions that read genomic files.

```r
# Example: Fetching a BigWig file
bw_path <- ah[["AH95891"]]

# The object 'bw_path' is a character string pointing to the local file
print(bw_path)
```

## Usage Tips
- **Caching**: Files are downloaded once and stored in the local BiocFileCache. Subsequent calls will load from the cache.
- **Integration**: Use these paths as inputs for `rGenomeTracks` track configuration files or as arguments to functions like `rtracklayer::import()`.
- **File Types**: The package covers a wide range of formats (bedGraph, narrowPeak, qcat, etc.), making it ideal for testing multi-track genomic plots.

## Reference documentation
- [rGenomeTracks](./references/rGenomeTracks.md)