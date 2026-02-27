---
name: bioconductor-rnaseqdata.hnrnpc.bam.chr14
description: This package provides access to BAM files containing paired-end RNA-seq reads from HNRNPC knockdown and control HeLa cells subsetted to human chromosome 14. Use when user asks to access example BAM files for genomic analysis, practice with GenomicAlignments, or test RNA-seq workflows using real-world data restricted to chromosome 14.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RNAseqData.HNRNPC.bam.chr14.html
---


# bioconductor-rnaseqdata.hnrnpc.bam.chr14

name: bioconductor-rnaseqdata.hnrnpc.bam.chr14
description: Access and use aligned RNA-seq reads (BAM files) from HNRNPC knockdown and control HeLa cells (chr14 subset). Use this skill when a user needs to perform genomic analysis, read alignment exploration, or benchmarking using real-world paired-end RNA-seq data restricted to human chromosome 14.

## Overview

The `RNAseqData.HNRNPC.bam.chr14` package is a Bioconductor ExperimentData package providing 8 BAM files from a specific RNA-seq experiment (Zarnack et al., 2012). The data consists of paired-end reads aligned to the hg19 genome using TopHat2, subsetted to chromosome 14. It is primarily used for demonstrating high-throughput sequencing workflows, testing alignment processing functions, and practicing with `GenomicAlignments`.

## Data Access

The package provides two main global variables to access the data:

- `RNAseqData.HNRNPC.bam.chr14_RUNNAMES`: A character vector of the 8 ENA accession numbers (e.g., "ERR127306").
- `RNAseqData.HNRNPC.bam.chr14_BAMFILES`: A named character vector containing the local file paths to the BAM files.

```r
library(RNAseqData.HNRNPC.bam.chr14)

# List all BAM file paths
bam_paths <- RNAseqData.HNRNPC.bam.chr14_BAMFILES

# View run names
run_names <- RNAseqData.HNRNPC.bam.chr14_RUNNAMES
```

## Typical Workflows

### Loading Alignments
Use the `GenomicAlignments` package to read the data into R. Since these are paired-end reads, `readGAlignmentPairs` is the preferred function.

```r
library(GenomicAlignments)

# Load the first BAM file
bam_file <- RNAseqData.HNRNPC.bam.chr14_BAMFILES[1]

# Optional: Define parameters to extract specific tags (e.g., NM for edit distance)
param <- ScanBamParam(tag="NM")

# Read paired-end alignments
galp <- readGAlignmentPairs(bam_file, use.names=TRUE, param=param)
```

### Inspecting Pairs
Once loaded as a `GAlignmentPairs` object, you can inspect the first and last segments of the pairs:

```r
# Access segments
f_reads <- first(galp)
l_reads <- last(galp)

# Check CIGAR strings for junctions (N), insertions (I), or deletions (D)
cigar_stats <- colSums(cigarOpTable(cigar(f_reads)))
```

### Analyzing Junctions
The data contains many split-read alignments (junctions). You can count them using `njunc()`:

```r
# Table of junction counts per pair
table(njunc(f_reads) + njunc(l_reads))
```

## Tips and Best Practices

- **Chromosome Restriction**: Remember that this data only contains alignments for **chr14**. If you attempt to overlap these reads with genomic features on other chromosomes, you will get zero results.
- **Memory Management**: While subsetted to chr14, loading all 8 BAM files simultaneously can be memory-intensive. Process files one by one or use `GenomicFiles` for larger iterations.
- **Reference Genome**: This data is aligned to **hg19**. Ensure any `TxDb` or `GRanges` objects used for annotation are also based on the hg19/GRCh37 coordinate system.
- **Edit Distance**: Use the `NM` tag (if loaded via `ScanBamParam`) to filter reads based on their edit distance to the reference genome.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)