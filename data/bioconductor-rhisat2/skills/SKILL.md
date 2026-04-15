---
name: bioconductor-rhisat2
description: This tool provides an R interface to the HISAT2 aligner for genome indexing and sequence alignment. Use when user asks to build genome indices from FASTA files, extract splice sites from genomic annotations, or align single-end and paired-end reads to a reference.
homepage: https://bioconductor.org/packages/release/bioc/html/Rhisat2.html
---

# bioconductor-rhisat2

name: bioconductor-rhisat2
description: Interface to the HISAT2 short-read aligner for genome indexing and read alignment. Use this skill when you need to perform sequence alignment tasks within R, specifically for building HISAT2 indices from FASTA files, extracting splice sites from genomic annotations, and aligning single-end or paired-end reads to a reference.

## Overview
The `Rhisat2` package provides an R interface to the HISAT2 (Hierarchical Indexing for Spliced Alignment of Transcripts 2) software. It allows users to manage the entire alignment workflow—from index generation to SAM file output—without leaving the R environment. It is particularly effective for RNA-seq data due to its ability to handle spliced alignments.

## Core Workflow

### 1. Building a Genome Index
Before alignment, you must create a genome index from one or more FASTA files.

```r
library(Rhisat2)

# Identify reference FASTA files
refs <- c("chr1.fa", "chr2.fa")

# Build the index
hisat2_build(references = refs, 
             outdir = "path/to/index_dir", 
             prefix = "genome_index",
             force = TRUE, 
             execute = TRUE)
```
*   **Note**: Set `execute = FALSE` to return the shell command string without running it, which is useful for debugging.

### 2. Extracting Splice Sites (Optional for RNA-seq)
To improve alignment across known junctions, extract splice sites from a GTF, GFF3, or TxDb object.

```r
spsfile <- "splice_sites.txt"
gtf_path <- "genes.gtf"

extract_splice_sites(features = gtf_path, outfile = spsfile)
```

### 3. Aligning Reads
Align FASTQ files to the generated index.

**Paired-end alignment:**
```r
reads <- list("sample_R1.fastq", "sample_R2.fastq")

hisat2(sequences = reads, 
       index = "path/to/index_dir/genome_index",
       type = "paired", 
       outfile = "aligned_reads.sam",
       `known-splicesite-infile` = spsfile, # Optional
       execute = TRUE)
```

**Single-end alignment:**
```r
reads <- "sample.fastq"

hisat2(sequences = reads, 
       index = "path/to/index_dir/genome_index",
       type = "single", 
       outfile = "aligned_reads.sam",
       execute = TRUE)
```

## Key Function Parameters
*   `sequences`: A vector (single-end) or a list of length 2 (paired-end) containing paths to FASTQ files.
*   `index`: The full path to the index including the prefix (e.g., `dir/prefix`).
*   `force`: If `TRUE`, overwrites existing files.
*   `strict`: If `TRUE`, stops execution on any error.
*   `...`: Additional arguments are passed directly to the HISAT2 binary (e.g., `threads = 8`, `phred64 = TRUE`).

## Helper Functions
*   `hisat2_version()`: Returns the version of the HISAT2 binary being used.
*   `hisat2_usage()`: Displays all available command-line options for the alignment tool.
*   `hisat2_build_usage()`: Displays all available options for the index builder.

## Best Practices
*   **Memory Management**: For large genomes, ensure the system has sufficient RAM for the indexing process.
*   **Argument Naming**: When passing HISAT2-specific flags through `...`, use the exact flag name. If the flag contains hyphens, wrap it in backticks (e.g., `` `known-splicesite-infile` ``).
*   **Path Handling**: Always use `file.path()` to construct paths to ensure cross-platform compatibility between the R session and the underlying HISAT2 binary.

## Reference documentation
- [Aligning reads with Rhisat2](./references/Rhisat2.md)