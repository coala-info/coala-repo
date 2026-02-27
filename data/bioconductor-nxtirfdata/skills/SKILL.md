---
name: bioconductor-nxtirfdata
description: This package provides reference data, example BAM files, and mappability exclusion files to support SpliceWiz alternative splicing analysis pipelines. Use when user asks to access synthetic genome references, download example BAM files for testing, or retrieve mappability exclusion data for intron retention quantification.
homepage: https://bioconductor.org/packages/release/data/experiment/html/NxtIRFdata.html
---


# bioconductor-nxtirfdata

## Overview

`NxtIRFdata` is a specialized data package designed to support the `SpliceWiz` (and legacy `NxtIRF`) ecosystem. It provides the necessary infrastructure for testing and running alternative splicing pipelines, including a synthetic "Chromosome Z" reference, example BAM files for demonstration, and critical Mappability Exclusion BED files used to filter out non-unique genomic regions during splicing quantification.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("NxtIRFdata")
library(NxtIRFdata)
```

## Typical Workflows

### 1. Accessing Synthetic Reference Data
For testing pipelines or running SpliceWiz vignettes, use the artificial "Chromosome Z" (chrZ) genome based on SRSF and TP53 genes.

```r
# Get path to the synthetic FASTA file
example_fasta <- chrZ_genome()

# Get path to the synthetic GTF annotation file
example_gtf <- chrZ_gtf()
```

### 2. Retrieving Example BAM Files
Download a set of 6 example BAM files to a local directory for analysis practice.

```r
# Downloads BAMs to a temporary directory (or specify your own path)
bam_paths <- example_bams(path = tempdir())
```
*Note: SpliceWiz reads these BAMs natively; BAI indices are not required for SpliceWiz but are available via ExperimentHub if needed for RSamtools.*

### 3. Obtaining Mappability Exclusion Data
Mappability exclusion files are essential for accurate Intron Retention (IR) analysis. These functions retrieve records from AnnotationHub.

```r
# Retrieve as a GRanges object (for R-based analysis)
gr_hg38 <- get_mappability_exclusion(genome_type = "hg38", as_type = "GRanges")

# Retrieve and save as a local gzipped BED file (for pipeline configuration)
bed_path <- get_mappability_exclusion(
    genome_type = "mm10", 
    as_type = "bed.gz",
    path = tempdir()
)
```
Supported `genome_type` values: `"hg38"`, `"hg19"`, `"mm10"`, and `"mm9"`.

### 4. Manual ExperimentHub Access
If specific versions or metadata are required, access the data directly via `ExperimentHub`.

```r
library(ExperimentHub)
eh <- ExperimentHub()
nxt_query <- query(eh, "NxtIRF")

# Access specific entries by ID
# EH6792: Example BAMs
# EH6787: Mappability exclusion data
data_obj <- eh[["EH6792"]]
```

## Tips
- **SpliceWiz Transition**: `NxtIRFdata` is the data provider for `SpliceWiz`. If you are looking for the analysis engine, use the `SpliceWiz` package.
- **Internal Usage**: `get_mappability_exclusion` is often called internally by SpliceWiz functions, but manual calls are useful for inspecting the regions being excluded from your analysis.

## Reference documentation
- [NxtIRFdata: a data package for SpliceWiz](./references/NxtIRFdata.Rmd)
- [NxtIRFdata Vignette](./references/NxtIRFdata.md)