---
name: bioconductor-circseqaligntk
description: This tool performs end-to-end analysis of RNA-Seq data from circular genomes such as viroids. Use when user asks to align short reads to circular references, calculate genome-wide coverage, or generate synthetic circular RNA-Seq data for benchmarking.
homepage: https://bioconductor.org/packages/release/bioc/html/CircSeqAlignTk.html
---


# bioconductor-circseqaligntk

name: bioconductor-circseqaligntk
description: End-to-end analysis of RNA-Seq data from circular genomes (e.g., viroids). Use when needing to align short reads to circular references using a two-stage process, calculate genome-wide coverage, or generate synthetic circular RNA-Seq data for benchmarking.

## Overview
CircSeqAlignTk addresses the challenge of aligning linear sequencing reads to circular genomes, where reads may span the artificial "junction" created by linearizing a circular sequence. It implements a two-stage alignment workflow using Bowtie2 or HISAT2 and provides tools for coverage visualization and synthetic data generation.

## Core Workflow

### 1. Preparation and Indexing
Generate two types of reference sequences (Type 1: standard linear; Type 2: shifted/rotated) to ensure reads spanning the junction are captured.

```r
library(CircSeqAlignTk)
ws <- tempdir()
genome_seq <- system.file(package = 'CircSeqAlignTk', 'extdata', 'FR851463.fa')

# Build indices for two-stage alignment
ref_index <- build_index(input = genome_seq, 
                         output = file.path(ws, 'index'),
                         aligner = 'hisat2') # or 'bowtie2'
```

### 2. Read Alignment
Align reads in two stages: first to the standard reference, then unaligned reads to the shifted reference.

```r
# input can be a FASTQ file path
aln <- align_reads(input = "path/to/reads.fq.gz", 
                   index = ref_index,
                   output = file.path(ws, 'align_results'),
                   n_mismatch = 1,
                   n_threads = 4)

# Check alignment statistics
aln@stats
```

### 3. Coverage Calculation and Visualization
Summarize results into strand-specific coverage data frames.

```r
# Calculate coverage
alncov <- calc_coverage(aln)

# Access data
fwd_data <- alncov@forward
rev_data <- alncov@reverse

# Plot coverage (returns a ggplot2 object)
plot(alncov)

# Plot specific read lengths (e.g., 21-22nt for viroid sRNAs)
plot(alncov, read_lengths = c(21, 22))
```

## Synthetic Data Generation
Generate simulated RNA-Seq data to benchmark alignment tools or validate workflows.

```r
# Generate 10,000 synthetic reads with default viroid parameters
sim <- generate_reads(n = 10000, 
                      output = file.path(ws, 'sim.fq.gz'),
                      mismatch_prob = 0.05)

# Generate reads with specific peak distributions
peaks <- data.frame(
    mean = c(100, 250), std = c(5, 5), 
    strand = c('+', '-'), prob = c(0.7, 0.3)
)
sim_custom <- generate_reads(peaks = peaks, output = "custom_sim.fq.gz")

# Merge multiple simulation objects to create complex datasets
sim_merged <- merge(sim1, sim2, output = "merged.fq.gz")
```

## Tips and Best Practices
- **Working Directory**: Always specify a dedicated output directory as the package generates multiple intermediate BAM and index files.
- **Pre-processing**: For small RNA (sRNA) analysis, use `Rbowtie2::remove_adapters` to trim adapters and filter for 21-24nt lengths before running `align_reads`.
- **Alignment Tools**: The package defaults to HISAT2. If not installed on the system, it uses the Bioconductor `Rhisat2` or `Rbowtie2` wrappers.
- **Two-Stage Logic**: Type 1 BAMs contain reads aligned to the standard linear reference. Type 2 BAMs contain reads that only aligned after the reference was "rotated," effectively capturing junction-spanning reads.

## Reference documentation
- [CircSeqAlignTk Documentation](./references/CircSeqAlignTk.md)