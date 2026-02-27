---
name: bioconductor-rbwa
description: This tool provides an R interface for the Burrows-Wheeler Aligner to perform genome indexing and sequence alignment. Use when user asks to build a reference index, align short reads using BWA-backtrack, or perform sequence mapping with BWA-MEM.
homepage: https://bioconductor.org/packages/release/bioc/html/Rbwa.html
---


# bioconductor-rbwa

name: bioconductor-rbwa
description: R wrapper for BWA (Burrows-Wheeler Aligner). Use this skill to perform genome indexing and sequence alignment using BWA-backtrack (short reads <100bp) or BWA-MEM (longer reads 70bp-1Mbp) directly within R.

# bioconductor-rbwa

## Overview

The `Rbwa` package provides an R interface to the popular BWA alignment suite. It allows users to build genome indices and align sequencing reads (FASTQ) to a reference genome (FASTA) without leaving the R environment. It supports two primary algorithms:
- **BWA-backtrack (`bwa_aln`)**: Optimized for short Illumina reads up to 100bp.
- **BWA-MEM (`bwa_mem`)**: Optimized for longer sequences (70bp to 1Mbp), supporting split alignments and high-quality mappings.

## Core Workflow

### 1. Build a Reference Index
Before alignment, you must create an index from your reference FASTA file. This is a one-time operation per genome.

```r
library(Rbwa)

fasta_file <- "path/to/genome.fa"
index_base <- "idx/human_chr12"

bwa_build_index(fasta_file, index_prefix = index_base)
```

### 2. Aligning Short Reads (BWA-backtrack)
This is a two-step process: generating an intermediate `.sai` file and then converting it to SAM.

```r
# Step A: Generate .sai file
bwa_aln(
  index_prefix = index_base,
  fastq_files = "reads.fastq",
  sai_files = "output.sai",
  n = 3 # Optional: max edit distance
)

# Step B: Convert to SAM
bwa_sam(
  index_prefix = index_base,
  fastq_files = "reads.fastq",
  sai_files = "output.sai",
  sam_file = "output.sam"
)
```

### 3. Aligning Long Reads (BWA-MEM)
BWA-MEM is simpler as it outputs a SAM file directly in one step.

```r
bwa_mem(
  index_prefix = index_base,
  fastq_files = "reads.fastq",
  sam_file = "output.sam"
)
```

### 4. Handling Secondary Alignments
By default, secondary alignments are stored in the `XA` tag of the SAM file. To expand these into individual rows (multi-line SAM format), use `xa2multi`.

```r
xa2multi("output.sam", "output.multi.sam")
```

## Tips and Parameters

- **Argument Passing**: Both `bwa_aln` and `bwa_mem` accept standard BWA command-line arguments as R parameters (e.g., `n`, `k`, `l`, `t` for threads).
- **Memory**: Genome indexing and alignment are memory-intensive. Ensure the R session has sufficient RAM for the size of the reference genome.
- **File Paths**: Always ensure the `index_prefix` matches the base name used during `bwa_build_index`. BWA looks for multiple files (e.g., `.amb`, `.ann`, `.bwt`) sharing that prefix.

## Reference documentation

- [An introduction to Rbwa](./references/Rbwa.md)