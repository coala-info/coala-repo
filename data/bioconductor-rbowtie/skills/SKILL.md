---
name: bioconductor-rbowtie
description: This tool provides an R interface for building genome indices and performing short-read or spliced alignments using bowtie and SpliceMap. Use when user asks to build a bowtie index, perform short-read DNA alignment, or conduct de novo splice junction discovery with SpliceMap.
homepage: https://bioconductor.org/packages/release/bioc/html/Rbowtie.html
---


# bioconductor-rbowtie

name: bioconductor-rbowtie
description: Use the Rbowtie package to build genome indices and perform short-read alignments (bowtie) or spliced alignments (SpliceMap) within R. This skill should be used for bioinformatics workflows involving DNA or RNA sequence alignment, specifically when wrapping the bowtie aligner or using SpliceMap for de novo splice junction discovery.

# bioconductor-rbowtie

## Overview
The `Rbowtie` package provides an R interface for the popular `bowtie` short-read aligner and the `SpliceMap` tool for spliced alignments. While it is the engine behind the `QuasR` package (which is recommended for full analysis workflows), `Rbowtie` can be used directly for fine-grained control over indexing and alignment tasks.

## Core Workflow

### 1. Building a Reference Index
Before alignment, you must create a bowtie index from FASTA reference files.

```r
library(Rbowtie)

# Define reference files and output directory
refFiles <- c("path/to/chr1.fa", "path/to/chr2.fa")
indexDir <- file.path(tempdir(), "refsIndex")

# Build the index
bowtie_build(references = refFiles, 
             outdir = indexDir, 
             prefix = "my_index", 
             force = TRUE)
```

### 2. Standard Alignment with `bowtie`
Use the `bowtie` function for ungapped alignment of short reads.

```r
readsFile <- "path/to/reads.fastq"
samFile <- "path/to/output.sam"

bowtie(sequences = readsFile,
       index = file.path(indexDir, "my_index"),
       outfile = samFile, 
       sam = TRUE,
       best = TRUE, 
       force = TRUE)
```

### 3. Spliced Alignment with `SpliceMap`
For RNA-seq data where reads may span splice junctions, use `SpliceMap`. Note: Reads must be at least 50bp long.

```r
# Configuration is passed as a named list
cfg <- list(genome_dir = "path/to/genome_fasta_dir",
            reads_list1 = "path/to/reads.fastq",
            read_format = "FASTQ",
            quality_format = "phred-33",
            outfile = "spliced_alignments.sam",
            temp_path = tempdir(),
            max_intron = 400000,
            min_intron = 20000,
            bowtie_base_dir = file.path(indexDir, "my_index"),
            num_threads = 4,
            selectSingleHit = TRUE)

SpliceMap(cfg)
```

## Usage Tips
- **QuasR Recommendation**: If you are performing a standard RNA-seq or ChIP-seq analysis, consider using the `QuasR` package instead, as it provides a higher-level interface for the entire pipeline.
- **Argument Discovery**: Use `bowtie_usage()` and `bowtie_build_usage()` to see all available command-line arguments that can be passed to the underlying tools.
- **Memory Management**: For large genomes, ensure your system has sufficient RAM. `SpliceMap` is particularly resource-intensive as it splits reads into 25-mers for initial alignment.
- **SAM Output**: Always set `sam = TRUE` in the `bowtie()` function if you require standard SAM format for downstream Bioconductor tools like `Rsamtools`.

## Reference documentation
- [Rbowtie Overview](./references/Rbowtie-Overview.md)