---
name: bioconductor-rbowtie2
description: This tool provides R wrappers for Bowtie2 and AdapterRemoval to perform genomic sequence alignment and adapter trimming. Use when user asks to index reference genomes, identify or remove sequencing adapters from FASTQ files, and align reads to a reference to produce SAM or BAM files.
homepage: https://bioconductor.org/packages/release/bioc/html/Rbowtie2.html
---

# bioconductor-rbowtie2

name: bioconductor-rbowtie2
description: Genomic sequence alignment and adapter trimming using R wrappers for Bowtie2 and AdapterRemoval. Use this skill when you need to index reference genomes, identify or remove sequencing adapters from FASTQ files, and align reads to a reference to produce SAM or BAM files within an R environment.

# bioconductor-rbowtie2

## Overview
The `Rbowtie2` package provides R interfaces for two powerful C++ tools: **Bowtie2** for genomic alignment and **AdapterRemoval** for preprocessing sequencing reads. It allows users to perform the entire pipeline from raw FASTQ trimming to genome alignment and SAM/BAM generation without leaving the R session.

## Installation and Loading
```R
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("Rbowtie2")
library(Rbowtie2)
```

## Preprocessing with AdapterRemoval
AdapterRemoval handles adapter trimming, read merging, and identification.

### 1. Identify Adapters
For paired-end data where adapter sequences are unknown:
```R
adapters <- identify_adapters(file1 = "reads_1.fq", file2 = "reads_2.fq",
                              basename = "output_prefix")
# Returns a character vector: [1] adapter1, [2] adapter2
```

### 2. Remove Adapters
Trim known or identified adapters from FASTQ files:
```R
remove_adapters(file1 = "reads_1.fq", file2 = "reads_2.fq",
                adapter1 = adapters[1], adapter2 = adapters[2],
                output1 = "trimmed_1.fq", output2 = "trimmed_2.fq",
                basename = "trimmed_base")
```

## Alignment with Bowtie2
Bowtie2 requires a genome index before alignment can occur.

### 1. Build Index
Create a Bowtie2 index from FASTA reference files:
```R
refs <- c("genome_chr1.fa", "genome_chr2.fa")
bowtie2_build(references = refs, bt2Index = "my_index_prefix", overwrite = TRUE)
```

### 2. Align Reads
Align single-end or paired-end reads to the created index.
```R
# Paired-end alignment to SAM
bowtie2_samtools(bt2Index = "my_index_prefix",
                 output = "alignment_results",
                 outputType = "sam",
                 seq1 = "trimmed_1.fq",
                 seq2 = "trimmed_2.fq",
                 overwrite = TRUE)
```

## Key Functions and Utilities
- `adapterremoval_usage()` / `bowtie2_usage()`: Print all available command-line arguments that can be passed as a string to the main functions.
- `adapterremoval_version()` / `bowtie2_version()`: Check the underlying tool versions.
- `bowtie2_build_usage()`: View options for index building (e.g., `--threads`, `--quiet`).

## Workflow Tips
- **Additional Arguments**: Most functions accept a trailing string for extra parameters (e.g., `"--threads 4 --local"`).
- **File Paths**: Use absolute paths or ensure the working directory is correctly set, as these functions call external binaries.
- **BAM Conversion**: While `bowtie2_samtools` can output SAM, you can integrate with `Rsamtools` for further BAM processing and indexing.
- **Memory**: Bowtie2 indexing and alignment can be memory-intensive; use the `--threads` argument to speed up processing on compatible systems.

## Reference documentation
- [An Introduction to Rbowtie2](./references/Rbowtie2-Introduction.md)