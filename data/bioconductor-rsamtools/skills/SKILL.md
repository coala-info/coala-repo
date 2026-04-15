---
name: bioconductor-rsamtools
description: This package provides an R interface for manipulating and importing BAM, FASTA, BCF, and Tabix files. Use when user asks to read BAM files with fine-grained control, filter alignments, index genomic files, or manage multiple datasets via BamViews.
homepage: https://bioconductor.org/packages/release/bioc/html/Rsamtools.html
---

# bioconductor-rsamtools

name: bioconductor-rsamtools
description: Interface to BAM, FASTA, BCF, and Tabix files. Use when you need to manipulate, filter, or import high-throughput sequencing data in R, specifically for reading BAM files with fine-grained control, counting records, or managing multiple BAM files via BamViews.

# bioconductor-rsamtools

## Overview

The `Rsamtools` package provides an R interface to the `samtools`, `bcftools`, and `tabix` utilities. It is primarily used for importing and manipulating binary alignment (BAM) files, though it also supports FASTA, BCF, and Tabix-indexed files. While `GenomicAlignments` is often preferred for high-level RNA-seq analysis, `Rsamtools` is the foundational package for low-level data access, filtering, and indexing.

## Core Workflows

### 1. Reading BAM Files with `scanBam`

The primary function for data import is `scanBam`. It returns a list where each element corresponds to a genomic range.

```r
library(Rsamtools)

# Define what to extract and where
which <- GRanges("seq1:1000-2000")
what <- c("rname", "strand", "pos", "qwidth", "seq")
param <- ScanBamParam(which=which, what=what)

# Execute scan
bamFile <- "path/to/file.bam"
bam_data <- scanBam(bamFile, param=param)

# Access data (returns a list of lists)
reads <- bam_data[[1]]
```

### 2. Filtering BAM Files

Use `filterBam` to create a new, smaller BAM file based on specific criteria (e.g., mapping quality, flags, or regions).

```r
param <- ScanBamParam(flag = scanBamFlag(isUnmappedQuery = FALSE))
filterBam("input.bam", destination = "filtered.bam", param = param)
```

### 3. Managing Large Files with `BamViews`

`BamViews` allows you to manage a collection of BAM files (columns) and genomic ranges (rows) without loading everything into memory.

```r
# Setup views
bamPaths <- c("sample1.bam", "sample2.bam")
bamRanges <- GRanges(c("chr1:100-200", "chr2:500-600"))
bv <- BamViews(bamPaths, bamRanges = bamRanges)

# Query the view (requires GenomicAlignments for readGAlignments)
library(GenomicAlignments)
alignments <- readGAlignments(bv)
```

### 4. Utility Functions

- `countBam()`: Quickly count records matching a `ScanBamParam`.
- `indexBam()`: Create a `.bai` index for a sorted BAM file.
- `sortBam()`: Sort a BAM file by coordinates or name.
- `scanBamHeader()`: Retrieve header information (e.g., @SQ lines).
- `faidx()`: Index and query FASTA files.

## Key Parameters: `ScanBamParam`

The `ScanBamParam` object controls exactly what is loaded:
- `which`: A `GRanges` object specifying genomic regions.
- `what`: Character vector of fields (e.g., `qname`, `flag`, `mapq`, `seq`). Use `scanBamWhat()` to see all options.
- `flag`: Use `scanBamFlag()` to filter by SAM flags (e.g., `isDuplicate`, `isPaired`).
- `tag`: Character vector of custom tags (e.g., `NM`, `AS`).

## Tips for Efficiency

- **Indexing**: Always ensure your BAM files have a corresponding `.bai` file. Use `indexBam()` if missing.
- **Memory**: For very large files, process by chromosome or use `BamViews` to iterate through chunks.
- **Remote Access**: `Rsamtools` supports remote URLs (HTTP/FTP). If you have a local index file, you can query specific regions of a remote BAM without downloading the whole file.
- **Integration**: Use `Rsamtools` to prepare data for `ShortRead` (quality assessment) or `GenomicAlignments` (overlap analysis).

## Reference documentation

- [An Introduction to Rsamtools](./references/Rsamtools-Overview.md)