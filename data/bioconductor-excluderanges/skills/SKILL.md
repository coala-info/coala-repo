---
name: bioconductor-excluderanges
description: This tool provides access to genomic exclusion sets and blacklists for various genome assemblies via AnnotationHub in R. Use when user asks to identify problematic genomic regions, filter out artifacts from sequencing data, or retrieve centromere and telomere coordinates.
homepage: https://bioconductor.org/packages/release/data/annotation/html/excluderanges.html
---

# bioconductor-excluderanges

name: bioconductor-excluderanges
description: Provides access to genomic exclusion sets (blacklists) for various genome assemblies (hg38, T2T-CHM13, mm39, etc.) via AnnotationHub. Use this skill when you need to identify or filter out problematic genomic regions, centromeres, telomeres, or mitochondrial homologs (NUMTs) in R.

# bioconductor-excluderanges

## Overview
The `excluderanges` package provides a unified interface to retrieve "exclusion sets"—genomic regions that are known to produce artifacts or problematic signals in high-throughput sequencing experiments (e.g., ChIP-seq, ATAC-seq, CUT&RUN). It aggregates data from multiple sources including ENCODE, the Boyle Lab, and the Kundaje Lab, covering human, mouse, and other model organisms.

## Typical Workflow

### 1. Discovering Available Datasets
Datasets are hosted on Bioconductor's `AnnotationHub`. You must first initialize the hub and query for the `excluderanges` preparer class.

```r
library(AnnotationHub)
library(GenomicRanges)

ah <- AnnotationHub()
# Filter for excluderanges datasets
query_data <- subset(ah, preparerclass == "excluderanges")

# Search for specific assemblies or labs
hg38_sets <- query(ah, c("excluderanges", "hg38"))
```

### 2. Loading and Preparing Ranges
Once a specific AnnotationHub ID (e.g., `AH107305`) is identified, load it as a `GRanges` object. It is standard practice to sort the ranges and prune non-standard chromosomes.

```r
library(GenomeInfoDb)

# Load the recommended hg38 unified exclusion list
excludeGR <- ah[["AH107305"]]

# Standardize the GRanges object
excludeGR <- excludeGR %>% 
  sort() %>% 
  keepStandardChromosomes(pruning.mode = "tidy")
```

### 3. Filtering Experimental Data
To remove problematic regions from your experimental data (e.g., peaks), use `subsetByOverlaps` with `invert = TRUE` or `plyranges::filter_by_non_overlaps`.

```r
# Assuming 'my_peaks' is a GRanges object of your experimental results
filtered_peaks <- subsetByOverlaps(my_peaks, excludeGR, invert = TRUE)
```

## Key Data Categories
- **Unified Blacklists**: Recommended sets (e.g., `hg38.Kundaje.GRCh38_unified_Excludable`) that combine multiple sources.
- **NUMTs**: Regions of high homology to mitochondrial DNA in the nuclear genome (e.g., `hg38.Lareau.hg38_peaks`).
- **UCSC Gaps**: Centromeres, telomeres, and heterochromatin regions (e.g., `hg38.UCSC.centromere`).
- **Technology Specific**: Sets specifically for CUT&RUN or eCLIP.

## Tips and Best Practices
- **Coordinate Systems**: When exporting to BED files, be aware that `rtracklayer` may perform coordinate conversions. For maximum control, convert the `GRanges` to a data frame and write as a tab-separated file.
- **Assembly Matching**: Ensure the exclusion set matches your alignment assembly (e.g., do not use hg19 ranges on hg38 data).
- **Combining Sets**: You can combine multiple exclusion types (e.g., Blacklist + NUMTs + Centromeres) using `reduce(c(gr1, gr2, gr3))`.

## Reference documentation
- [Introduction to excluderanges](./references/excluderanges.Rmd)
- [excluderanges Vignette](./references/excluderanges.md)