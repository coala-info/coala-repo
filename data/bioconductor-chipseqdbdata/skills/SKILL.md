---
name: bioconductor-chipseqdbdata
description: This package provides curated ChIP-seq datasets as BAM files and metadata for differential binding analysis. Use when user asks to retrieve H3K9ac, H3K4me3, CBP, NF-YA, or H3K27me3 mouse datasets for genomic workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/chipseqDBData.html
---

# bioconductor-chipseqdbdata

name: bioconductor-chipseqdbdata
description: Access and use ChIP-seq datasets from the chipseqDBData package for differential binding (DB) analyses. Use this skill when you need to retrieve BAM files and sample metadata for H3K9ac, H3K4me3, CBP, NF-YA, or H3K27me3 experiments in mouse cell lines.

# bioconductor-chipseqdbdata

## Overview

The `chipseqDBData` package provides a collection of curated ChIP-seq datasets stored as sorted and indexed BAM files. These datasets are primarily designed for use with the `csaw` and `chipseqDB` workflows to demonstrate differential binding (DB) analysis. The package utilizes `ExperimentHub` for data delivery, ensuring that large genomic files are cached locally after the initial download.

## Data Retrieval

The package provides specific functions for each dataset. Each function returns a `DataFrame` containing sample names, descriptions, and paths to the BAM files (as `BamFile` objects from `Rsamtools`).

### Available Datasets

- `H3K9acData()`: H3K9ac and H3K4me3 in murine pro-B and mature B cells.
- `CBPData()`: CREB binding protein (CBP) in wild-type and knockout mouse embryonic fibroblasts.
- `NFYAData()`: NF-YA in mouse terminal neurons and embryonic stem cells.
- `H3K27me3Data()`: H3K27me3 in mouse wild-type and Ezh2-knockout lung epithelium.

### Basic Workflow

```r
library(chipseqDBData)

# 1. Download/Load the dataset metadata and file paths
h3k9ac.paths <- H3K9acData()

# 2. Inspect the metadata
print(h3k9ac.paths)

# 3. Access specific BAM paths for downstream analysis (e.g., with csaw)
bam.files <- h3k9ac.paths$Path
```

## Quality Control and Statistics

Once the data paths are retrieved, you can use `Rsamtools` to calculate mapping statistics.

### Calculating Mapping Diagnostics

```r
library(Rsamtools)

# Example: Get stats for the first sample
stats <- scanBam(h3k9ac.paths$Path[[1]], 
                 param=ScanBamParam(what=c("mapq", "flag")))

flag <- stats[[1]]$flag
mapq <- stats[[1]]$mapq

# Calculate metrics
total_reads <- length(flag)
mapped_reads <- sum(bitwAnd(flag, 0x4) == 0)
high_qual <- sum(mapq >= 10 & (bitwAnd(flag, 0x4) == 0))
duplicates <- sum(bitwAnd(flag, 0x400) != 0)
```

## Usage Tips

- **Caching**: The first time you call a data function, it will download large BAM files. Subsequent calls will use the local `ExperimentHub` cache.
- **Index Files**: The package automatically handles the associated `.bai` index files. The paths returned in the `DataFrame` are often symlinks to ensure the BAM and index files share the same prefix in a temporary directory, which is required by many R genomic packages.
- **Downstream Analysis**: These datasets are formatted specifically for the `windowCounts` function in the `csaw` package.

## Reference documentation

- [Processing statistics for ChIP-seq datasets](./references/chipseqDBData.md)