---
name: bioconductor-cohcapanno
description: This package provides annotation data for Illumina 27k and 450k methylation arrays formatted for the City of Hope CpG Island Analysis Pipeline. Use when user asks to load COHCAP-compatible site and island mappings, perform differential methylation analysis on Illumina array data, or integrate methylation results with gene expression.
homepage: https://bioconductor.org/packages/release/data/experiment/html/COHCAPanno.html
---


# bioconductor-cohcapanno

name: bioconductor-cohcapanno
description: Provides annotation data for Illumina Methylation Arrays (27k and 450k) specifically formatted for use with the City of Hope CpG Island Analysis Pipeline (COHCAP). Use this skill when performing differential methylation analysis, QC, or visualization of Illumina array data where COHCAP-compatible site and island mappings are required.

## Overview

COHCAPanno is a data experiment package that provides pre-defined annotation files for Illumina 27k and 450k methylation arrays. These annotations are structured to support the COHCAP (City of Hope CpG Island Analysis Pipeline) workflow, which facilitates the analysis of single-nucleotide resolution methylation data, including CpG site/island differential methylation and integration with gene expression.

## Loading Annotation Data

The package primarily serves as a container for coordinate and mapping data. Load the specific annotation set required for your array type and island definition using the `data()` function.

```r
library(COHCAPanno)

# For Illumina 450k array using UCSC CpG Island definitions
data(COHCAP.450k.UCSC)

# For Illumina 450k array using HMM (Hidden Markov Model) CpG Island definitions
data(COHCAP.450k.HMM)

# For Illumina 27k array (UCSC CpG Islands)
data(COHCAP.27k)
```

## Typical Workflow Integration

These datasets are intended to be passed into COHCAP functions for site-to-island mapping and genomic localization.

1. **Identify Array Type**: Determine if your data is from the 27k or 450k platform.
2. **Select Island Definition**: For 450k data, choose between standard UCSC islands or HMM-derived islands.
3. **Pass to COHCAP**: Use the loaded data frames as the annotation source in COHCAP analysis functions (e.g., `COHCAP.site()`).

## Usage Tips

- **Custom Data**: If using Targeted BS-Seq or non-standard arrays, do not use COHCAPanno; instead, create a custom annotation file as defined in the main COHCAP package documentation.
- **Data Structure**: Once loaded, the objects are standard R data frames containing genomic coordinates (CHR, Start, End) and associated gene symbols/island names.
- **Memory Management**: Only load the specific annotation version you need for your current analysis to save memory, as these objects can be large.

## Reference documentation

- [COHCAPanno: Illumina Methylation Array Annotations for COHCAP](./references/COHCAPanno.md)