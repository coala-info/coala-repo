---
name: bioconductor-wgsmapp
description: This tool provides pre-computed whole-genome mappability tracks and genomic blacklist regions for the human hg19 and hg38 assemblies. Use when user asks to access ENCODE mappability scores, filter genomic bins for copy number variation analysis, or normalize sequencing depth based on genomic accessibility.
homepage: https://bioconductor.org/packages/release/data/experiment/html/WGSmapp.html
---


# bioconductor-wgsmapp

name: bioconductor-wgsmapp
description: Access and utilize whole-genome mappability tracks for human hg19 and hg38 assemblies. Use this skill when performing copy number variation (CNV) analysis, filtering genomic bins, or normalizing sequencing depth based on ENCODE mappability scores and genomic "blacklist" regions (telomeres, centromeres, heterochromatin).

# bioconductor-wgsmapp

## Overview

The `WGSmapp` package provides pre-computed mappability tracks for the human genome (hg19 and hg38) derived from the ENCODE Project. It is specifically designed to facilitate the normalization of Whole-Genome Sequencing (WGS) data, particularly for single-cell analysis. The package includes weighted average mappability scores for 100-mers and identifies "blacklist" bins that should typically be excluded from downstream analysis due to segmental duplications or assembly gaps.

## Data Access and Usage

The package primarily serves as a data container. The tracks are stored as `GRanges` objects.

### Loading the Data

To use the mappability tracks, load the library and use the `data()` function to bring the objects into your R environment.

```r
library(WGSmapp)

# For hg19 (GRCh37)
data(mapp_hg19)
mapp_hg19

# For hg38 (GRCh38)
data(mapp_hg38)
mapp_hg38
```

### Object Structure

The objects are `GRanges` where the metadata columns contain the mappability scores.
- **Ranges**: Genomic coordinates of the bins.
- **Score**: Mappability value (typically between 0 and 1).
- **Blacklist**: Bins overlapping with known problematic regions (telomeres, centromeres, etc.) are often assigned a score of 0 or specifically flagged.

### Common Workflows

#### 1. Filtering Low Mappability Regions
Use these tracks to filter out genomic regions where short reads cannot be uniquely aligned, which often causes artifacts in CNV calling.

```r
# Example: Keep only regions with mappability score > 0.9
high_mapp_regions <- mapp_hg19[mapp_hg19$score > 0.9]
```

#### 2. Overlapping with Experimental Data
To annotate your own sequencing bins with mappability scores, use `findOverlaps` or `subsetByOverlaps` from the `GenomicRanges` package.

```r
library(GenomicRanges)

# Assume 'my_bins' is a GRanges object of your sequencing windows
hits <- findOverlaps(my_bins, mapp_hg19)
# Calculate average mappability per bin if necessary
```

#### 3. GC and Mappability Normalization
In WGS pipelines (like `WGScopy` or `GIGSEA`), these scores are used as covariates to correct the read counts per bin.

## Tips
- **Memory Management**: These `GRanges` objects are quite large (over 21 million ranges). Ensure your R session has sufficient memory allocated when loading these datasets.
- **Assembly Version**: Always verify whether your alignment was performed against hg19 or hg38 before choosing the corresponding dataset. `mapp_hg38` was generated via `liftOver` from the hg19 coordinates.

## Reference documentation
- [WGSmapp Reference Manual](./references/reference_manual.md)