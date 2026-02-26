---
name: bioconductor-exomecopy
description: This tool detects copy number variants in exome sequencing data using a hidden Markov model. Use when user asks to identify CNVs, normalize read counts using positional covariates, or segment genomic regions into copy counts without paired control samples.
homepage: https://bioconductor.org/packages/3.5/bioc/html/exomeCopy.html
---


# bioconductor-exomecopy

name: bioconductor-exomecopy
description: Detect copy number variants (CNVs) in exome sequencing data using a hidden Markov model (HMM). Use this skill when you need to normalize read counts using positional covariates (GC-content, background read depth) and segment genomic regions into constant copy counts without requiring paired tumor/normal samples.

# bioconductor-exomecopy

## Overview

The `exomeCopy` package implements a Hidden Markov Model (HMM) to identify CNVs in targeted sequencing data (like exome-seq). It is particularly useful when paired control samples are unavailable. The model uses negative binomial emission distributions and accounts for positional covariates such as GC-content, range width, and background read depth (calculated from a pool of samples) to simultaneously normalize and segment the genome.

## Core Workflow

### 1. Data Preparation
Store genomic ranges, read counts, and covariates in a `GRanges` or `RangedData` object.

```R
library(exomeCopy)
library(Rsamtools)

# 1. Define target regions (from BED)
target.df <- read.delim("targets.bed", header = FALSE)
target <- GRanges(seqnames = target.df[,1], 
                  ranges = IRanges(start = target.df[,2] + 1, end = target.df[,3]))

# 2. Subdivide large ranges (optional but recommended for HMM)
target.sub <- subdivideGRanges(target, s = 100)

# 3. Count reads from BAM files
counts <- countBamInGRanges(bam.file, target.sub)
```

### 2. Covariate Generation
The model requires covariates to account for technical biases.

```R
# GC Content
counts$GC <- getGCcontent(target.sub, reference.fasta)
counts$GC.sq <- counts$GC^2

# Background Read Depth (using a vector of sample names)
counts$bg <- generateBackground(sample.names, counts, median)
counts$log.bg <- log(counts$bg + 0.1)
counts$width <- width(counts)
```

### 3. Running the HMM
Run `exomeCopy` on a per-chromosome basis for a specific sample.

```R
# S: possible copy states (e.g., 0 to 4)
# d: expected copy number (2 for autosomes)
fit <- exomeCopy(counts[seqnames(counts) == "chr1"], 
                 sample.name = "sample1", 
                 X.names = c("log.bg", "GC", "GC.sq", "width"), 
                 S = 0:4, d = 2)
```

### 4. Result Extraction and Visualization
Compile segments and filter for potential CNVs.

```R
# Get segments
segments <- copyCountSegments(fit)

# Filter for non-diploid regions (where d=2)
cnvs <- segments[segments$copy.count != 2, ]

# Plotting the fit
plot(fit, col = c("red", "orange", "black", "deepskyblue", "blue"))
```

## Key Functions

- `subdivideGRanges()`: Breaks long exons into smaller, uniform bins (default ~100bp) to improve HMM resolution.
- `countBamInGRanges()`: Efficiently counts read starts in targets; requires indexed BAMs.
- `generateBackground()`: Creates a baseline by normalizing and averaging (median) read depths across multiple control samples.
- `exomeCopy()`: The main HMM fitting function. Returns an `ExomeCopy` object.
- `compileCopyCountSegments()`: Helper to aggregate results from a list of `ExomeCopy` objects (e.g., across multiple chromosomes or samples).

## Tips for Success

- **Chromosome Handling**: Always run `exomeCopy` on one chromosome at a time. Use `lapply` or loops to process the whole genome.
- **Sex Chromosomes**: For male samples on ChrX/ChrY, set the expected copy number `d = 1`.
- **Filtering**: Use the `nranges` (number of bins in a segment) and `log.odds` columns from `copyCountSegments` to filter out noisy, short-range calls. A common threshold is `nranges > 5`.
- **Input Sorting**: Ensure your `GRanges` objects are sorted and reduced (`reduce(target)`) before counting to avoid overlapping ranges.

## Reference documentation
- [exomeCopy](./references/exomeCopy.md)