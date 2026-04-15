---
name: bioconductor-seqtools
description: The bioconductor-seqtools package provides high-speed analysis and quality control of FASTQ files to extract sequence statistics and Phred score distributions. Use when user asks to perform k-mer counting, analyze nucleotide compositions, calculate GC content, or generate quality control plots from high-throughput sequencing data.
homepage: https://bioconductor.org/packages/release/bioc/html/seqTools.html
---

# bioconductor-seqtools

name: bioconductor-seqtools
description: Fast analysis and quality control of FASTQ files. Use this skill when you need to perform k-mer counting, calculate Phred score distributions, analyze nucleotide compositions, or generate quality control metrics from high-throughput sequencing data in R.

# bioconductor-seqtools

## Overview
The `seqTools` package is designed for high-speed processing of FASTQ files to extract quality control metrics and sequence statistics. It is particularly efficient at handling multiple files simultaneously and provides specialized data structures for storing k-mer counts, Phred quality scores, and nucleotide frequencies.

## Core Workflow

### 1. Data Import and Initial Analysis
The primary function is `fastqq`, which reads FASTQ files (including gzipped files) and calculates summary statistics in a single pass.

```r
library(seqTools)

# Analyze one or more FASTQ files
filenames <- c("sample1.fastq.gz", "sample2.fastq.gz")
fq <- fastqq(filenames)

# Basic file information
nReads(fq)
nLines(fq)
maxSeqLen(fq)
```

### 2. Quality Control and Visualization
`seqTools` provides built-in plotting functions to visualize the distribution of quality scores and nucleotide compositions.

```r
# Plot average Phred quality scores per position
plotQualities(fq)

# Plot nucleotide frequencies (A, C, G, T, N) per position
plotNucleotides(fq)

# Get Phred score distribution table
pd <- phredDist(fq)
```

### 3. K-mer Analysis
The package efficiently counts k-mers (default k=6) during the initial file reading.

```r
# Get k-mer counts (returns a matrix where rows are k-mers and columns are files)
km <- getKmerCount(fq)

# Calculate GC content from k-mer counts
gc <- getGCcontent(fq)
```

### 4. Nucleotide Composition
You can extract detailed position-specific nucleotide distributions.

```r
# Get count of nucleotides by position
cb <- cbDist(fq)

# Access specific file results (e.g., first file)
# cb is a list of matrices
file1_dist <- cb[[1]]
```

## Key Functions Reference

- `fastqq(filenames)`: Main entry point. Reads files and returns a `Fastqq` object.
- `nReads(object)`: Returns the number of reads in each file.
- `getKmerCount(object)`: Returns a matrix of k-mer frequencies.
- `phredDist(object)`: Returns the distribution of Phred quality scores.
- `plotQualities(object)`: Generates a line plot of mean quality scores per position.
- `plotNucleotides(object)`: Generates a plot showing the proportion of each nucleotide at each position.
- `gcContent(object)`: Returns the GC content percentage for the sequences.

## Tips for Large Datasets
- `fastqq` is optimized for speed. When processing many files, ensure the `filenames` vector is correctly named to keep track of samples in the resulting plots and matrices.
- The `Fastqq` object stores data in a compressed format, making it memory-efficient for large-scale QC across hundreds of samples.

## Reference documentation
- [seqTools Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/seqTools.html)