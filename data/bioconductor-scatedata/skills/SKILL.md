---
name: bioconductor-scatedata
description: This tool provides genomic data resources, including region bins and bulk DNase-seq signals, for Single-cell ATAC-seq Signal Extraction and Enhancement. Use when user asks to retrieve hg19 or mm10 genomic bins, access bulk DNase-seq priors, or load example scATAC-seq BAM files for the SCATE pipeline.
homepage: https://bioconductor.org/packages/3.12/data/experiment/html/SCATEData.html
---

# bioconductor-scatedata

name: bioconductor-scatedata
description: Access and utilize genomic data resources for Single-cell ATAC-seq Signal Extraction and Enhancement (SCATE). Use this skill when needing to retrieve hg19/mm10 genomic region bins, bulk DNase-seq signals, or example scATAC-seq BAM files hosted on ExperimentHub for use with the SCATE algorithm.

# bioconductor-scatedata

## Overview

`SCATEData` is a Bioconductor ExperimentData package that provides essential data resources for the `SCATE` (Single-cell ATAC-seq Signal Extraction and Enhancement) pipeline. It contains genomic region bins, normalized bulk DNase-seq signals (mean and standard deviation) across ENCODE samples, and clustering information for genomic bins. These resources allow `SCATE` to enhance sparse and discrete single-cell ATAC-seq signals by leveraging bulk DNase-seq priors.

## Data Retrieval and Usage

The datasets in `SCATEData` are primarily intended to be consumed by the `SCATE` package functions, but they can be accessed manually via `ExperimentHub`.

### Loading Genomic Bins and DNase-seq Signals
The package provides pre-processed `GenomicRanges` objects for human (hg19) and mouse (mm10) genomes.

```r
library(ExperimentHub)
eh <- ExperimentHub()

# Query for SCATEData resources
scate_resources <- query(eh, "SCATEData")

# Load specific genome resources (e.g., hg19)
# Replace 'EHXXXX' with the specific ID found in the query results
hg19_data <- eh[["EH3494"]] 
```

### Accessing Example BAM Files
The package includes 20 example scATAC-seq BAM files and their corresponding indices (.bai). These are useful for testing the `SCATE` workflow or benchmarking.

```r
# List available BAM files in the package
list.files(system.file("extdata", package = "SCATEData"), pattern = "\\.bam$")

# Get the path to a specific example BAM file
bam_path <- system.file("extdata", "GSM1596831.bam", package = "SCATEData")
```

## Typical Workflow with SCATE

`SCATEData` is typically used as a backend for the `SCATE` package. When running `SCATE`, you point the tool to these data resources to perform signal enhancement.

1. **Identify Genome**: Determine if your data is `hg19` or `mm10`.
2. **Signal Extraction**: Use the BAM files (either your own or the examples provided in `SCATEData`) to count reads in the genomic bins provided by the package.
3. **Enhancement**: `SCATE` uses the bulk DNase-seq statistics from `SCATEData` to transform sparse scATAC-seq counts into enhanced signals.

## Tips
- **ExperimentHub**: Always use `ExperimentHub` to download the `.rds` files (hg19.rds, mm10.rds) rather than looking for them in the local package installation directory, as they are hosted remotely to save space.
- **Genome Versions**: Ensure your scATAC-seq reads are aligned to the same genome build (hg19 or mm10) provided by the package.

## Reference documentation
- [SCATEData package](./references/SCATEData_package.md)
- [SCATEData package Rmd](./references/SCATEData_package.Rmd)