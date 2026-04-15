---
name: bioconductor-seqcna.annot
description: This package provides GC content, mappability, and genomic feature annotation data for copy number analysis of deep sequencing cancer data. Use when user asks to load reference data for human genome builds hg18 or hg19, perform read count correction, or filter genomic windows based on mappability and common variations.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/seqCNA.annot.html
---

# bioconductor-seqcna.annot

name: bioconductor-seqcna.annot
description: Provides annotation data (GC content, mappability, and genomic features) for copy number analysis of deep sequencing cancer data using the seqCNA package. Use this skill when performing copy number variation (CNV) analysis in R that requires reference data for human genome builds hg18 or hg19, specifically for read count correction and window filtering.

# bioconductor-seqcna.annot

## Overview
The `seqCNA.annot` package is a data support package for the `seqCNA` workflow. It provides essential genomic annotations—specifically GC content, mappability scores, and known common CNV regions—partitioned into 1000bp windows. This data is critical for correcting biases in deep sequencing data and filtering out unreliable genomic regions during copy number estimation.

## Core Workflows

### Checking Supported Builds
Before starting an analysis, verify which genome builds are available in the current version of the package.
```r
library(seqCNA.annot)
supported.builds()
# Returns a vector of strings, e.g., c("hg18", "hg19")
```

### Loading Annotation Data
The package provides two types of data for each build: genomic features (GC, Mappability, CNV) and chromosome lengths.

#### For hg19 (Human Build 37):
```r
# Load 1000bp window annotations
data(hg19)
head(hg19)
# Columns:
# GC: Proportion of G/C bases per 1000bp
# Mapp: Mean mappability of 35-mers
# CNV: Proportion of window overlapping common CNVs (>0.01 frequency)

# Load chromosome lengths
data(hg19_len)
```

#### For hg18 (Human Build 36):
```r
data(hg18)
data(hg18_len)
```

### Integration with seqCNA
While this package contains the data, it is typically consumed by functions within the `seqCNA` package. The `hgX_len` data frames are used to define the genomic windows, while the `hgX` data frames provide the values used for:
1. **Read Count Correction**: Using the `GC` column to normalize for sequencing bias.
2. **Window Filtering**: Using the `Mapp` (mappability) and `CNV` columns to exclude regions that might produce false positives or unreliable counts.

## Data Structures

### Annotation Tables (hg18, hg19)
- **GC**: Numeric. Used to correct the "GC bias" where certain regions are over- or under-represented due to PCR amplification preferences.
- **Mapp**: Numeric. Values closer to 1 indicate unique mappability. Low values suggest repetitive regions where read alignment is ambiguous.
- **CNV**: Numeric. Indicates the presence of germline variations. Windows with high CNV values are often filtered out to focus on somatic alterations in cancer studies.

### Length Tables (hg18_len, hg19_len)
- **chr**: Factor levels for chromosomes (1-22, X, Y).
- **length**: Numeric total base pairs for each chromosome.

## Reference documentation
- [seqCNA.annot Reference Manual](./references/reference_manual.md)