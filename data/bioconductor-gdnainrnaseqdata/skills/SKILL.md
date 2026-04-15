---
name: bioconductor-gdnainrnaseqdata
description: This package provides access to RNA-seq BAM files with specific levels of genomic DNA contamination for benchmarking and analysis. Use when user asks to download experimental datasets for gDNA detection, retrieve RNA-seq files with known contamination levels, or access Li et al. (2022) subsetted BAM files.
homepage: https://bioconductor.org/packages/release/data/experiment/html/gDNAinRNAseqData.html
---

# bioconductor-gdnainrnaseqdata

name: bioconductor-gdnainrnaseqdata
description: Access and retrieve RNA-seq BAM files with varying levels of genomic DNA (gDNA) contamination (0%, 1%, and 10%). Use this skill when you need to download experimental datasets for benchmarking gDNA detection methods or studying the impact of gDNA contamination on RNA-seq analysis.

# bioconductor-gdnainrnaseqdata

## Overview

The `gDNAinRNAseqData` package is a Bioconductor ExperimentData package that provides access to a subset of RNA-seq data from Li et al. (2022). The dataset consists of BAM files derived from total RNA libraries mixed with specific concentrations of gDNA. These files are useful for developing and testing bioinformatics pipelines designed to identify or mitigate genomic DNA contamination in transcriptomic data.

## Data Retrieval Workflow

The package uses `ExperimentHub` to manage and download the data files.

### 1. Download BAM Files
Use `LiYu22subsetBAMfiles()` to download the subsetted BAM files and their corresponding indices (.bai).

```r
library(gDNAinRNAseqData)

# Download to a temporary directory (default)
bam_paths <- LiYu22subsetBAMfiles()

# Or specify a custom download path
# bam_paths <- LiYu22subsetBAMfiles(path = "path/to/data")

print(bam_paths)
```

### 2. Retrieve Metadata (Phenotype Data)
To map the downloaded files to their respective gDNA contamination levels (0, 1, or 10), use `LiYu22phenoData()`.

```r
# Get a data frame of gDNA concentrations
pdata <- LiYu22phenoData(bam_paths)
print(pdata)
```

## Dataset Details

- **Source**: Li et al. (2022), BMC Genomics.
- **Content**: BAM files containing approximately 100,000 alignments sampled uniformly from the original full-size libraries.
- **Conditions**: 
    - `0`: No contamination (control).
    - `1`: 1% gDNA contamination.
    - `10`: 10% gDNA contamination.
- **Format**: Standard BAM format, compatible with `Rsamtools`, `GenomicAlignments`, and other Bioconductor sequence analysis tools.

## Usage Tips

- **Caching**: Files are cached via `ExperimentHub`. Subsequent calls to `LiYu22subsetBAMfiles()` will load the local copies unless the cache is cleared.
- **Downstream Analysis**: Since these are standard BAM files, you can use them immediately with `Rsamtools::scanBam()` or `GenomicAlignments::readGAlignments()` to inspect read distributions across exons and introns.

## Reference documentation

- [gDNAinRNAseqData](./references/gDNAinRNAseqData.md)