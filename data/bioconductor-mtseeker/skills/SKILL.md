---
name: bioconductor-mtseeker
description: MTseeker analyzes mitochondrial genomes by extracting reads from sequencing data, calling variants with high sensitivity to heteroplasmy, and estimating copy number. Use when user asks to extract mitochondrial reads from BAM files, call mitochondrial variants, filter nuclear mitochondrial sequences, or visualize the functional impact of mutations on the electron transport chain.
homepage: https://bioconductor.org/packages/3.8/bioc/html/MTseeker.html
---


# bioconductor-mtseeker

## Overview

MTseeker is a Bioconductor package designed for the specialized analysis of mitochondrial genomes. It provides tools for extracting mitochondrial reads from whole-exome or whole-genome sequencing BAM files, calling variants with high sensitivity to heteroplasmy, and performing functional annotation. It is particularly effective for studying mitochondrial enrichment or depletion (copy number) and the metabolic implications of mtDNA mutations.

## Core Workflows

### 1. Data Loading and Preprocessing
MTseeker typically starts with BAM files aligned to a reference genome containing the mitochondrial contig (rCRS/chrM).

```r
library(MTseeker)
library(MTseekerData)

# Extract mitochondrial reads from BAM files
# filter=FALSE preserves all reads for manual inspection
MTreads <- getMT(BAMdf, filter=FALSE) 

# MTseekerData provides example objects:
# RONKSreads: MAlignments object (aligned reads)
# RONKSvariants: MVRangesList object (called variants)
data(RONKSreads, package="MTseekerData")
```

### 2. Mitochondrial Copy Number Analysis
Calculate the ratio of mitochondrial reads to nuclear reads to estimate relative copy number changes between samples (e.g., Tumor vs. Normal).

```r
# Summarize read counts
stats <- Summary(RONKSreads)
mVn <- stats$mitoVsNuclear

# Calculate Tumor/Normal ratio
# Assuming interleaved samples (Normal1, Tumor1, Normal2, Tumor2...)
CN_ratio <- mVn[seq(2,22,2)] / mVn[seq(1,21,2)]
```

### 3. Variant Calling
MTseeker uses `gmapR` for sensitive variant calling. Note that this requires the original BAM files and a compatible genome GmapGenome object.

```r
# Call variants from MAlignments
# This produces an MVRangesList object
variants <- callMT(MTreads)

# For a simpler example without full BAMs:
# ?callMT
```

### 4. Filtering and Annotation
Mitochondrial analysis requires specific filters to remove Nuclear Mitochondrial sequences (NuMTs) and artifacts in homopolymeric regions.

```r
# filterMT performs several key tasks:
# 1. Drops low depth samples (<20x)
# 2. fpFilter=TRUE: removes variants in homopolymeric regions
# 3. NuMT=TRUE: filters variants with VAF < 0.03 (likely nuclear inserts)
filtered_vars <- filterMT(variants, fpFilter=TRUE, NuMT=TRUE)

# Aggregate variants into GenomicRanges for overlap analysis
gr_vars <- granges(filtered_vars)

# Subset to coding regions only
coding_vars <- encoding(filtered_vars)
```

### 5. Visualization
MTseeker provides circular plots for variant distribution and functional diagrams for the Electron Transport Chain (ETC).

```r
# Circular plot of variants across samples
plot(coding_vars)

# Functional impact diagram (SVG)
# Visualizes which complexes (I-V) are affected by nonsynonymous variants
MTseeker::MTcomplex(variants[[1]])
```

## Key Data Structures

- **MAlignments**: A container for mitochondrial read alignments.
- **MVRanges / MVRangesList**: Specialized GenomicRanges objects for mitochondrial variants, containing metadata for heteroplasmy (VAF), read depth, and filter status.

## Tips for Success

- **Reference Genomes**: Ensure your BAMs are aligned to rCRS (canonical mitochondrial reference). MTseeker is designed to handle hg19/GRCh37/GRCh38 contig naming conventions.
- **Heteroplasmy**: Pay close attention to the Variant Allele Frequency (VAF). Low VAF variants (<3%) are often NuMTs unless sequencing depth is extremely high and the sample is highly purified.
- **Functional Impact**: Use `MTcomplex()` to generate SVG representations of the mitochondria's respiratory chain to identify if specific complexes (like Complex I) are preferentially hit by mutations.

## Reference documentation

- [MTseeker example: Renal Oncocytomas](./references/oncocytomas.md)