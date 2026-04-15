---
name: bioconductor-illuminahumanmethylation27kanno.ilmn12.hg19
description: This package provides annotation data and metadata for the Illumina HumanMethylation27k platform using the hg19 genome build. Use when user asks to access genomic coordinates, probe design information, or SNP annotations for 27k methylation arrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/IlluminaHumanMethylation27kanno.ilmn12.hg19.html
---

# bioconductor-illuminahumanmethylation27kanno.ilmn12.hg19

## Overview

The `IlluminaHumanMethylation27kanno.ilmn12.hg19` package is a Bioconductor annotation resource for the Illumina 27k methylation platform. It provides essential metadata for interpreting methylation signals, including genomic coordinates (hg19), probe design information, and comprehensive SNP annotation from various dbSNP versions (e.g., 132 through 147). This package is typically used in conjunction with the `minfi` or `methylumi` packages for epigenome-wide association studies (EWAS).

## Loading Annotation Data

To use the annotations, load the library and use the `data()` function to bring specific annotation objects into the environment.

```r
library(IlluminaHumanMethylation27kanno.ilmn12.hg19)

# Load the primary annotation object
data("IlluminaHumanMethylation27kanno.ilmn12.hg19")

# Load specific components
data(Locations)  # Genomic coordinates
data(Manifest)   # Probe design and type information
data(Other)      # Additional metadata
```

## Working with SNP Annotations

A critical feature of this package is the identification of SNPs that may interfere with methylation measurements. The package provides multiple versions of dbSNP "Common" tables (MAF > 1%).

### Accessing SNP Data
You can load SNP data for specific dbSNP versions:

```r
# Load SNP data from dbSNP 147
data(SNPs.147CommonSingle)

# View the structure (rows are CpG IDs)
head(SNPs.147CommonSingle)
```

### Interpreting SNP Columns
The SNP dataframes contain six key columns for each CpG site:
- `Probe_rs` / `Probe_maf`: SNP ID and Minor Allele Frequency for SNPs within the probe body.
- `CpG_rs` / `CpG_maf`: SNPs directly overlapping the CpG site.
- `SBE_rs` / `SBE_maf`: SNPs at the Single Base Extension site.

## Typical Workflow in minfi

When using the `minfi` package, you often specify this annotation package when creating or processing a `MethylSet` or `GenomicRatioSet`.

```r
# Example of setting the annotation manually if not automatically detected
annotation(myMethylSet) <- c(array = "IlluminaHumanMethylation27k", 
                             annotation = "ilmn12.hg19")

# Get annotation information directly from a minfi object
ann <- getAnnotation(IlluminaHumanMethylation27kanno.ilmn12.hg19)
```

## Tips
- **Genome Build**: Ensure your analysis pipeline is using **hg19/GRCh37**. If you are working with hg38, you will need to lift over these coordinates.
- **SNP Filtering**: It is standard practice to filter out probes where a SNP overlaps the CpG site or the SBE site with a high MAF (e.g., > 0.01) to avoid genetic variation confounding methylation measurements.

## Reference documentation
- [IlluminaHumanMethylation27kanno.ilmn12.hg19 Reference Manual](./references/reference_manual.md)