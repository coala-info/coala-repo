---
name: bioconductor-hicontactsdata
description: This package provides programmatic access to processed Hi-C and Micro-C datasets for testing and demonstration. Use when user asks to download sample genomic interaction data, access example Hi-C files, or retrieve datasets for benchmarking Hi-C analysis workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/HiContactsData.html
---

# bioconductor-hicontactsdata

name: bioconductor-hicontactsdata
description: Access and download processed Hi-C and Micro-C data files (cool, mcool, hic, pairs, fastq) for demonstration and testing. Use when needing sample genomic interaction data for Hi-C analysis workflows, particularly when working with the HiContacts or HiCExperiment packages.

# bioconductor-hicontactsdata

## Overview

`HiContactsData` is an ExperimentHub-based data package that provides programmatic access to a variety of processed Hi-C datasets. It serves as a companion to the `HiContacts` package, offering standardized files (e.g., `.cool`, `.mcool`, `.hic`, `.pairs`) from yeast, mouse, and human studies. These datasets are ideal for vignettes, benchmarking, and testing Hi-C analysis pipelines.

## Loading the Package

```r
library(HiContactsData)
```

## Accessing Data

The package provides a single primary function: `HiContactsData()`.

### Listing Available Datasets

To view the metadata for all available files, call the function without arguments:

```r
available_files <- HiContactsData()
print(available_files)
```

The metadata includes:
- `sample`: The identifier for the biological sample (e.g., `yeast_wt`, `mESCs`, `microC`).
- `format`: The file format (e.g., `cool`, `mcool`, `hic`, `pairs.gz`, `fastq_R1`).
- `genome`: The reference genome (e.g., `S288C`, `mm10`, `GRCh38`).
- `EHID`: The ExperimentHub unique identifier.

### Downloading Specific Files

To retrieve a local path to a specific file, provide the `sample` and `format` arguments. The file will be downloaded to the local ExperimentHub cache if not already present.

```r
# Download a yeast Hi-C file in .cool format
cool_path <- HiContactsData(sample = 'yeast_wt', format = 'cool')

# Download a mouse ESC file in .mcool format
mcool_path <- HiContactsData(sample = 'mESCs', format = 'mcool')

# Download human Micro-C data (chr17 only)
microc_path <- HiContactsData(sample = 'microC', format = 'mcool')
```

## Typical Workflow

Once the file path is retrieved, it is typically passed to interaction data importers like those found in `HiCExperiment` or `HiContacts`.

```r
library(HiCExperiment)

# Get path
mcool_file <- HiContactsData(sample = 'yeast_wt', format = 'mcool')

# Import into a HiCExperiment object (requires HiCExperiment package)
# hic_exp <- import(mcool_file, resolution = 1000)
```

## Available Samples and Formats

- **Yeast (S288C):** Wild-type, G1, G2M, and Eco1-AID conditions. Available as `fastq`, `cool`, `mcool`, `hic`, `pairs`, and `HiC-Pro` formats.
- **Mouse (mESCs):** mm10 data available as `mcool` and `pairs.gz` (chr13).
- **Human (microC):** GRCh38 HFFc6 data available as `mcool` (chr17).

## Reference documentation

- [HiContactsData](./references/HiContactsData.md)