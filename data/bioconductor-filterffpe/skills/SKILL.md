---
name: bioconductor-filterffpe
description: This tool filters artifact chimeric reads from Formalin-Fixed Paraffin-Embedded (FFPE) NGS data to reduce false positive structural variation calls. Use when user asks to identify technical artifacts in FFPE samples, remove chimeric reads from BAM files, or clean NGS data for structural variation analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/FilterFFPE.html
---

# bioconductor-filterffpe

name: bioconductor-filterffpe
description: Filter artifact chimeric reads from Formalin-Fixed Paraffin-Embedded (FFPE) NGS data. Use this skill when processing BAM files from FFPE samples to reduce false positive structural variation (SV) calls by identifying and removing technical artifacts.

# bioconductor-filterffpe

## Overview

The `FilterFFPE` package addresses a specific challenge in NGS bioinformatics: the high prevalence of artifact chimeric reads in FFPE samples. These artifacts often mimic structural variations, leading to high false-discovery rates. The package provides a streamlined workflow to identify these reads and generate a "clean" BAM file suitable for downstream SV calling.

## Core Workflow

The package can be used either through a single wrapper function or a step-by-step approach for more control.

### 1. Preparation
Input must be an indexed BAM file. PCR or optical duplicates should be marked or removed prior to using this package. 
**Note:** Do not filter by mapping quality or target regions before running `FilterFFPE`, as the algorithm requires the full context of alignments to correctly identify artifacts.

### 2. Single-Step Filtration
The `FFPEReadFilter` function combines artifact detection and BAM reconstruction.

```r
library(FilterFFPE)

# Define paths
bam_file <- "path/to/your/sample.bam"
out_bam <- "path/to/filtered_sample.bam"
ffpe_txt <- "ffpe_read_names.txt"
dup_txt <- "duplicate_chimeric_names.txt"

# Run complete filter
FFPEReadFilter(
  file = bam_file,
  threads = 2,
  destination = out_bam,
  overwrite = TRUE,
  FFPEReadsFile = ffpe_txt,
  dup_txt = dup_txt
)
```

### 3. Multi-Step Filtration
Use this approach if you need to inspect the list of artifact reads before modifying the BAM file.

**Step A: Find Artifacts**
```r
artifactReads <- findArtifactChimericReads(
  file = bam_file, 
  threads = 2,
  FFPEReadsFile = "artifacts.txt",
  dupChimFile = "dups.txt"
)
# Returns a character vector of read names
head(artifactReads)
```

**Step B: Filter the BAM**
```r
# Combine artifact reads and their duplicates
dupChim <- readLines("dups.txt")
readsToFilter <- c(artifactReads, dupChim)

# Generate new BAM
filterBamByReadNames(
  file = bam_file, 
  readsToFilter = readsToFilter,
  destination = "filtered.bam", 
  overwrite = TRUE
)
```

## Tips and Best Practices

- **Threading:** Use the `threads` argument in `findArtifactChimericReads` or `FFPEReadFilter` to speed up processing on multi-core systems.
- **Downstream Analysis:** After filtration, you can proceed with standard quality filtering (e.g., `MAPQ` filtering) or subsetting to target regions.
- **Verification:** You can verify the resulting BAM using `Rsamtools::scanBam()` to ensure the expected reads have been removed.
- **Memory:** For very large BAM files, ensure sufficient RAM is available as the package processes chimeric read candidates.

## Reference documentation

- [An Introduction to FilterFFPE](./references/FilterFFPE.md)